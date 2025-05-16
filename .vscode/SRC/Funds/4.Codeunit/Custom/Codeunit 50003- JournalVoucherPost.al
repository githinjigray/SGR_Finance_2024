codeunit 50003 JournalVoucherPost
{
    procedure PostJournalVoucher(var DocumentNo: Code[20]; var JournalTemplate: Code[50]; var JournalBatch: code[50]; var Preview: Boolean)
    begin
        JournalVoucherHeader.GET(DocumentNo);

        //Delete Journal Lines if Exist
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
        IF GenJnlLine.FINDSET THEN BEGIN
            GenJnlLine.DELETEALL;
        END;
        //End Delete


        //***********************************************Add Receipt Lines**************************************************************//
        JournalVoucherLines.RESET;
        JournalVoucherLines.SETRANGE(JournalVoucherLines."JV No.", JournalVoucherHeader."JV No.");
        JournalVoucherLines.SETFILTER(JournalVoucherLines.Amount, '<>%1', 0);
        IF JournalVoucherLines.FINDSET THEN BEGIN
            REPEAT
                //****************************************Add Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JournalTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JournalBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := JournalVoucherLines."Posting Date";
                GenJnlLine."Document No." := JournalVoucherLines."JV No.";
                // IF (JournalVoucherLines."Account Type"=JournalVoucherLines."Account Type"::Customer) AND (JournalVoucherLines.Amount>0) THEN BEGIN 
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
                // GenJnlLine.Document_Type:=GenJnlLine.Document_Type::Invoice;
                // END;
                // IF (JournalVoucherLines."Account Type"=JournalVoucherLines."Account Type"::Customer) AND (JournalVoucherLines.Amount<0) THEN BEGIN 
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::"Credit Memo";
                //GenJnlLine.Document_Type:=GenJnlLine.Document_Type::CreditMemo;
                // END;

                GenJnlLine."Account Type" := JournalVoucherLines."Account Type";
                GenJnlLine."Account No." := JournalVoucherLines."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Posting Group" := JournalVoucherLines."Posting Group";
                GenJnlLine."External Document No." := JournalVoucherLines."External Document No.";
                GenJnlLine."Currency Code" := JournalVoucherLines."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := JournalVoucherLines."Currency Factor";
                GenJnlLine.Amount := JournalVoucherLines.Amount;
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := JournalVoucherLines."Bal. Account Type";
                GenJnlLine."Bal. Account No." := JournalVoucherLines."Bal. Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                IF JournalVoucherLines."Account Type" = JournalVoucherLines."Account Type"::"Fixed Asset" THEN BEGIN
                    GenJnlLine."FA Posting Date" := JournalVoucherLines."Posting Date";
                    GenJnlLine."FA Posting Type" := JournalVoucherLines."FA Posting Type";
                    GenJnlLine."Depreciation Book Code" := JournalVoucherLines."Depreciation Book Code";
                END;
                GenJnlLine."Shortcut Dimension 1 Code" := JournalVoucherLines."Shortcut Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := JournalVoucherLines."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, JournalVoucherLines."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, JournalVoucherLines."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, JournalVoucherLines."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, JournalVoucherLines."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, JournalVoucherLines."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, JournalVoucherLines."Shortcut Dimension 8 Code");
                GenJnlLine.Description := COPYSTR(JournalVoucherLines.Description, 1, 100);
                GenJnlLine.Description2 := COPYSTR(JournalVoucherLines.Description, 1, 249);
                GenJnlLine.VALIDATE(GenJnlLine.Description);
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
            //End add Line NetAmounts**************************************************

            UNTIL JournalVoucherLines.NEXT = 0;
        END;

        COMMIT;
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
        AdjustGenJnl.RUN(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        IF NOT Preview THEN BEGIN
            //Now Post the Journal Lines
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
            //End Posting****************************************************************
            COMMIT;
            //Update Document************************************************************
            GLEntry.RESET;
            GLEntry.SETRANGE("Document No.", JournalVoucherHeader."JV No.");
            IF GLEntry.FINDFIRST THEN BEGIN
                JournalVoucherHeader2.RESET;
                JournalVoucherHeader2.SETRANGE(JournalVoucherHeader2."JV No.", JournalVoucherHeader."JV No.");
                IF JournalVoucherHeader2.FINDFIRST THEN BEGIN
                    JournalVoucherHeader2.Posted := TRUE;
                    JournalVoucherHeader2."Posted By" := JournalVoucherHeader2."User ID";
                    JournalVoucherHeader2."Time Posted" := TIME;
                    // JournalVoucherHeader2.Status:=JournalVoucherHeader2.Status::;
                    JournalVoucherHeader2.MODIFY;
                    JournalVoucherLines2.RESET;
                    JournalVoucherLines2.SETRANGE(JournalVoucherLines2."JV No.", JournalVoucherHeader2."JV No.");
                    IF JournalVoucherLines2.FINDSET THEN BEGIN
                        REPEAT
                            JournalVoucherLines2.Posted := TRUE;
                            JournalVoucherLines2."Posted By" := USERID;
                            JournalVoucherLines2."Date Posted" := TODAY;
                            JournalVoucherLines2."Time Posted" := TIME;
                            JournalVoucherLines2.MODIFY;
                        UNTIL JournalVoucherLines2.NEXT = 0;
                    END;
                END;
            END;
            COMMIT;
            //End Update Document******************************************************
        END ELSE BEGIN
            //Preview Posting***************************************************************
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
            IF GenJnlLine.FINDSET THEN BEGIN
                GenJnlPost.Preview(GenJnlLine);
            END;
            //End Preview Posting*************************************************************
        END;
    end;

    procedure CheckJournalVoucherMandatoryFields(DocumentNo: code[20])
    begin
        JournalVoucherHeader.get(DocumentNo);
        JournalVoucherHeader.TESTFIELD("Global Dimension 1 Code");
        JournalVoucherHeader.TESTFIELD(Description);

        //IF Posting THEN
        //JournalVoucherHeader.TESTFIELD(Status,JournalVoucherHeader.Status::Approved);

        //Check Lines
        JournalVoucherLines.RESET;
        JournalVoucherLines.SETRANGE("JV No.", JournalVoucherHeader."JV No.");
        IF JournalVoucherLines.FINDSET THEN BEGIN
            REPEAT
                JournalVoucherLines.TESTFIELD("Account No.");
                JournalVoucherLines.TESTFIELD(Amount);
                JournalVoucherLines.TESTFIELD(Description);
                JournalVoucherLines.TESTFIELD("Posting Date");
            UNTIL JournalVoucherLines.NEXT = 0;
        END ELSE BEGIN
            ERROR('One or more payment lines are empty');
        END;
    end;

    procedure ReOpenJournalVoucher(VAR "Journal Voucher": Record "Journal Voucher Header")
    begin
        JournalVoucherHeader.RESET;
        JournalVoucherHeader.SETRANGE(JournalVoucherHeader."JV No.", "Journal Voucher"."JV No.");
        IF JournalVoucherHeader.FINDFIRST THEN BEGIN
            JournalVoucherHeader.Status := JournalVoucherHeader.Status::Open;
            JournalVoucherHeader.VALIDATE(JournalVoucherHeader.Status);
            JournalVoucherHeader.MODIFY;
        END;
    end;

    var
        JournalVoucherHeader: Record "Journal Voucher Header";
        JournalVoucherHeader2: Record "Journal Voucher Header";
        JournalVoucherLines: Record "Journal Voucher Lines";
        JournalVoucherLines2: Record "Journal Voucher Lines";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        GLEntry: Record "G/L Entry";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        SourceCode: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
}
