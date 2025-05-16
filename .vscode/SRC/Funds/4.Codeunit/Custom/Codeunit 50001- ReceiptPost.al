codeunit 50001 ReceiptPost
{
    procedure PostReceipt(var DocumentNo: Code[20]; var JournalTemplate: Code[50]; var JournalBatch: code[50]; var Preview: Boolean)
    begin
        ReceiptHeader.get(DocumentNo);
        SourceCode := 'RECEIPTJNL';

        BankLedgerEntry.RESET;
        BankLedgerEntry.SETRANGE(BankLedgerEntry."Document No.", ReceiptHeader."No.");
        IF BankLedgerEntry.FINDFIRST THEN BEGIN
            ERROR('Document already posted, Document No. exists in bank Account!');
        END;

        //Delete Journal Lines if Exist
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
        IF GenJnlLine.FINDSET THEN BEGIN
            GenJnlLine.DELETEALL;
        END;
        //End Delete

        //Add to Bank**************************************************************
        ReceiptHeader.CALCFIELDS("Total Line Amount", "Total Line Amount(LCY)");
        LineNo := 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
        GenJnlLine."Document No." := ReceiptHeader."No.";
        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
        //IF ReceiptHeader.Type = ReceiptHeader.Type::Bank THEN BEGIN
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := ReceiptHeader."Account No.";
        // END ;
        //IF ReceiptHeader.Type = ReceiptHeader.Type:: THEN BEGIN
        // GenJnlLine."Account Type":=GenJnlLine."Account Type"::Vendor;
        // GenJnlLine."Account No.":=ReceiptHeader."Account No.";
        //END ;
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
        GenJnlLine.Amount := ReceiptHeader."Total Line Amount";  //Debit Amount
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := COPYSTR(ReceiptHeader.Description, 1, 100);
        GenJnlLine.Description2 := COPYSTR(ReceiptHeader.Description, 1, 249);
        GenJnlLine.VALIDATE(GenJnlLine.Description);
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;
        //End Add to Bank***************************************************************

        //Add Receipt Lines**************************************************************
        ReceiptLine.RESET;
        ReceiptLine.SETRANGE(ReceiptLine."Document No.", ReceiptHeader."No.");
        ReceiptLine.SETFILTER(ReceiptLine.Amount, '<>%1', 0);
        IF ReceiptLine.FINDSET THEN BEGIN
            ReceiptLine.CALCSUMS("Management Fees Amount");
            REPEAT
                //Add Line NetAmounts*******************************************************
                LineNo := LineNo + 10;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JournalTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JournalBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                GenJnlLine."Document No." := ReceiptLine."Document No.";
                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                GenJnlLine."Account No." := ReceiptLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Posting Group" := ReceiptLine."Posting Group";
                GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine.Amount := -(ReceiptLine.Amount);  //Credit Amount
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Global Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ReceiptLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ReceiptLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ReceiptLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ReceiptLine."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := COPYSTR(ReceiptLine.Description, 1, 100);
                GenJnlLine.Description2 := COPYSTR(ReceiptLine.Description, 1, 249);
                GenJnlLine.VALIDATE(GenJnlLine.Description);
                //IF ReceiptLine."Applies-to Doc. Type"=ReceiptLine."Applies-to Doc. Type"::" " THEN
                //GenJnlLine."Applies-to Doc. Type":=ReceiptLine."Applies-to Doc. Type";
                IF ReceiptLine."Applies-to Doc. Type" = ReceiptLine."Applies-to Doc. Type"::Invoice THEN
                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                //GenJnlLine."Applies-to ID":=ReceiptLine."Applies-to ID";
                GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                IF ReceiptLine."Applies-to Doc. No." <> '' THEN BEGIN

                END;
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
                //*************************************End add Line NetAmounts**********************************************************//
                //****************************************Add VAT Amounts***************************************************************//
                IF ReceiptLine."VAT Code" <> '' THEN BEGIN
                    TaxCodes.RESET;
                    TaxCodes.SETRANGE(TaxCodes."Tax Code", ReceiptLine."VAT Code");
                    IF TaxCodes.FINDFIRST THEN BEGIN
                        TaxCodes.TESTFIELD(TaxCodes."Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JournalBatch;
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := ReceiptHeader."Posting Date";
                        GenJnlLine."Document No." := ReceiptLine."Document No.";
                        GenJnlLine."External Document No." := ReceiptHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(ReceiptLine."VAT Amount");   //Credit Amount
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := COPYSTR('VAT:' + FORMAT(ReceiptLine."Account Type") + '::' + FORMAT(ReceiptLine."Account Name"), 1, 100);
                        GenJnlLine.Description2 := COPYSTR('VAT:' + FORMAT(ReceiptLine."Account Type") + '::' + FORMAT(ReceiptLine."Account Name"), 1, 249);
                        IF ReceiptLine."Applies-to Doc. No." <> '' THEN BEGIN

                        END;
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                    END;
                END;
            //End Add VAT Amounts*********************************************************

            UNTIL ReceiptLine.NEXT = 0;
        END;
        //End Add Payment Lines************************************************************
        COMMIT;

        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
        AdjustGenJnl.RUN(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        IF NOT Preview THEN BEGIN
            //Now Post the Journal Lines
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //End Posting****************************************************************
            COMMIT;
            //Update Document**************************************************************
            GLEntry.RESET;
            GLEntry.SETRANGE("Document No.", ReceiptHeader."No.");
            IF GLEntry.FINDFIRST THEN BEGIN //1
                ReceiptHeader2.RESET;
                ReceiptHeader2.SETRANGE(ReceiptHeader2."No.", ReceiptHeader."No.");
                IF ReceiptHeader2.FINDFIRST THEN BEGIN //2
                    ReceiptHeader2.Status := ReceiptHeader2.Status::Posted;
                    ReceiptHeader2.Posted := TRUE;
                    ReceiptHeader2."Posted By" := USERID;
                    ReceiptHeader2."Date Posted" := TODAY;
                    ReceiptHeader2."Time Posted" := TIME;
                    ReceiptHeader2.MODIFY;

                    ReceiptLine2.RESET;
                    ReceiptLine2.SETRANGE(ReceiptLine2."Document No.", ReceiptHeader2."No.");
                    IF ReceiptLine2.FINDSET THEN BEGIN //4
                        REPEAT
                            ReceiptLine2.Status := ReceiptLine2.Status::Posted;
                            ReceiptLine2.Posted := TRUE;
                            ReceiptLine2."Posted By" := USERID;
                            ReceiptLine2."Date Posted" := TODAY;
                            ReceiptLine2."Time Posted" := TIME;
                            ReceiptLine2.VALIDATE(Amount);
                            ReceiptLine2.MODIFY;
                        UNTIL ReceiptLine2.NEXT = 0;
                    END;

                END;
            END;
            COMMIT;
            //End Update Document************************************************************
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

    procedure CheckReceiptMandatoryFields(DocumentNo: code[20])
    begin
        ReceiptHeader.get(DocumentNo);
        ReceiptHeader.TESTFIELD("Posting Date");
        ReceiptHeader.TESTFIELD("Payment Mode");
        ReceiptHeader.TESTFIELD("Account No.");
        ReceiptHeader.TESTFIELD("Received From");
        ReceiptHeader.TESTFIELD(Description);

        IF ReceiptHeader."Payment Mode" <> ReceiptHeader."Payment Mode"::Cash THEN
            ReceiptHeader.TESTFIELD("Reference No.");
        //ReceiptHeader.TESTFIELD("Global Dimension 1 Code");

        //Check Receipt Lines
        ReceiptLine.RESET;
        ReceiptLine.SETRANGE("Document No.", ReceiptHeader."No.");
        IF ReceiptLine.FINDSET THEN BEGIN
            REPEAT
                ReceiptLine.TESTFIELD("Account No.");
                ReceiptLine.TESTFIELD(Amount);
                ReceiptLine.TESTFIELD(Description);
            UNTIL ReceiptLine.NEXT = 0;
        END ELSE BEGIN
            ERROR('One or more receipt lines is empty');
        END;

        ReceiptHeader.CALCFIELDS("Total Line Amount", "Total Line Amount(LCY)");
        IF ReceiptHeader."Amount Received" <> ReceiptHeader."Total Line Amount" THEN
            ERROR('Amount received is not equal to total line amounts!');
    end;

    var
        ReceiptHeader: Record "Receipt Header";
        ReceiptHeader2: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        ReceiptLine2: Record "Receipt Line";
        TaxCodes: Record "Funds Tax Code";
        GLEntry: Record "G/L Entry";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        SourceCode: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
}
