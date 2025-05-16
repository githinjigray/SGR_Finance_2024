codeunit 50005 ImprestSurrenderPost
{
    procedure PostImprestSurrender(var DocumentNo: Code[20]; var JournalTemplate: Code[50]; var JournalBatch: code[50]; var Preview: Boolean)
    begin
        ImprestSurrenderHeader.get(DocumentNo);
        SourceCode := 'IMPSURRJNL';
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Document No.", ImprestSurrenderHeader."No.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry.Reversed, false);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            // ERROR('Document Already Posted');
        END;

        //Delete Journal Lines if Exist
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
        IF GenJnlLine.FINDSET THEN BEGIN
            GenJnlLine.DELETEALL;
        END;
        //End Delete

        LineNo := 1000;
        //Add Surrender Header*******************************************************
        ImprestSurrenderHeader.CALCFIELDS(ImprestSurrenderHeader."Actual Spent");
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := ImprestSurrenderHeader."Posting Date";
        GenJnlLine."Document No." := ImprestSurrenderHeader."No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := ImprestSurrenderHeader."Employee No.";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        ImprestHeader.GET(ImprestSurrenderHeader."Imprest No.");
        //GenJnlLine."Posting Group":=ImprestHeader."Employee Posting Group";
        GenJnlLine.VALIDATE(GenJnlLine."Posting Group");
        GenJnlLine."Currency Code" := ImprestSurrenderHeader."Currency Code";
        GenJnlLine.VALIDATE("Currency Code");
        GenJnlLine."Currency Factor" := ImprestSurrenderHeader."Currency Factor";
        GenJnlLine.Amount := -(ImprestSurrenderHeader."Actual Spent");  //Credit Amount
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := ImprestSurrenderHeader."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := ImprestSurrenderHeader."Global Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, ImprestSurrenderHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, ImprestSurrenderHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, ImprestSurrenderHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, ImprestSurrenderHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, ImprestSurrenderHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, ImprestSurrenderHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := COPYSTR(ImprestSurrenderHeader.Description, 1, 100);
        GenJnlLine.Description2 := COPYSTR(ImprestSurrenderHeader.Description, 1, 249);
        GenJnlLine.VALIDATE(GenJnlLine.Description);
        GenJnlLine."External Document No." := ImprestSurrenderHeader."Imprest No.";
        //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Payment;
        //GenJnlLine."Applies-to Doc. No.":=ImprestSurrenderHeader."Imprest No.";
        //GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;
        //End Add Surrender Header*******************************************************

        //Add Surrender Lines**************************************************************
        ImprestSurrenderLine.RESET;
        ImprestSurrenderLine.SETRANGE(ImprestSurrenderLine."Document No.", ImprestSurrenderHeader."No.");
        ImprestSurrenderLine.SETFILTER(ImprestSurrenderLine."Actual Spent", '<>%1', 0);
        IF ImprestSurrenderLine.FINDSET THEN BEGIN
            REPEAT
                LineNo := LineNo + 1;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JournalTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JournalBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := ImprestSurrenderHeader."Posting Date";
                GenJnlLine."Document No." := ImprestSurrenderLine."Document No.";
                GenJnlLine."Account Type" := ImprestSurrenderLine."Expense Account Type";
                GenJnlLine."Account No." := ImprestSurrenderLine."Expense Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                IF ImprestSurrenderLine."Expense Account Type" <> ImprestSurrenderLine."Expense Account Type"::"G/L Account" THEN BEGIN
                    GenJnlLine."Posting Group" := ImprestSurrenderLine."Posting Group";
                    GenJnlLine.VALIDATE("Posting Group");
                END;
                GenJnlLine."Currency Code" := ImprestSurrenderHeader."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine.Amount := ImprestSurrenderLine."Actual Spent";  //Debit Amount
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ImprestSurrenderHeader."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ImprestSurrenderHeader."Global Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, ImprestSurrenderLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, ImprestSurrenderLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, ImprestSurrenderLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, ImprestSurrenderLine."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, ImprestSurrenderLine."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, ImprestSurrenderLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := COPYSTR(ImprestSurrenderLine.Description, 1, 100);
                GenJnlLine.Description2 := COPYSTR(ImprestSurrenderLine.Description, 1, 249);
                GenJnlLine.VALIDATE(GenJnlLine.Description);
                GenJnlLine."External Document No." := ImprestSurrenderHeader."Imprest No.";
                IF ImprestSurrenderLine."Expense Account Type" = ImprestSurrenderLine."Expense Account Type"::"Fixed Asset" THEN BEGIN
                    GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
                    GenJnlLine."FA Posting Date" := ImprestSurrenderHeader."Posting Date";
                    GenJnlLine."Depreciation Book Code" := ImprestSurrenderLine."FA Depreciation Book";
                    GenJnlLine.VALIDATE(GenJnlLine."Depreciation Book Code");
                    GenJnlLine."FA Add.-Currency Factor" := 0;
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                END;
                GenJnlLine.INSERT;

            UNTIL ImprestSurrenderLine.NEXT = 0;
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
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //End Posting****************************************************************
            COMMIT;
            //Update Document************************************************************
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Document No.", ImprestSurrenderHeader."No.");
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                ImprestSurrenderHeader2.RESET;
                ImprestSurrenderHeader2.SETRANGE(ImprestSurrenderHeader2."No.", ImprestSurrenderHeader."No.");
                IF ImprestSurrenderHeader2.FINDFIRST THEN BEGIN
                    ImprestSurrenderHeader2.Status := ImprestSurrenderHeader2.Status::Posted;
                    ImprestSurrenderHeader2.Posted := TRUE;
                    ImprestSurrenderHeader2."Posted By" := USERID;
                    ImprestSurrenderHeader2."Date Posted" := TODAY;
                    ImprestSurrenderHeader2."Time Posted" := TIME;
                    IF ImprestSurrenderHeader2.MODIFY THEN BEGIN
                        ImprestSurrenderLine2.RESET;
                        ImprestSurrenderLine2.SETRANGE(ImprestSurrenderLine2."Document No.", ImprestSurrenderHeader2."No.");
                        IF ImprestSurrenderLine2.FINDSET THEN BEGIN
                            REPEAT
                                ImprestSurrenderLine2."Posting Date" := ImprestSurrenderHeader2."Posting Date";
                                ImprestSurrenderLine2.Posted := ImprestSurrenderHeader2.Posted;
                                ImprestSurrenderLine2."Posted By" := USERID;
                                ImprestSurrenderLine2."Date Posted" := TODAY;
                                ImprestSurrenderLine2."Time Posted" := TIME;
                                ImprestSurrenderLine2.MODIFY;
                            UNTIL ImprestSurrenderLine2.NEXT = 0;
                        END;
                        //Update imprest surrender status
                        ImprestHeader.RESET;
                        ImprestHeader.SETRANGE(ImprestHeader."No.", ImprestSurrenderHeader2."Imprest No.");
                        IF ImprestHeader.FINDSET THEN BEGIN
                            ImprestHeader.CALCFIELDS(Amount);
                            ImprestSurrenderHeader.CALCFIELDS(Amount);

                            IF (ImprestHeader.Amount = ImprestSurrenderHeader.Amount) OR (ImprestSurrenderHeader.Amount > ImprestHeader.Amount) THEN BEGIN
                                ImprestHeader.Surrendered := TRUE;
                                ImprestHeader."Surrender status" := ImprestHeader."Surrender status"::"Fully surrendered";
                                ImprestHeader.MODIFY;
                            END ELSE BEGIN
                                ImprestHeader."Surrender status" := ImprestHeader."Surrender status"::"Partially Surrendered";
                                ImprestHeader.MODIFY;
                            END;
                        END;
                    END;
                END;
                //END;
                //End Update Document*********************************************************
            END ELSE BEGIN
                //Preview Posting***************************************************************
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
                GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
                IF GenJnlLine.FINDSET THEN BEGIN
                    GenJnlPost.Preview(GenJnlLine);
                END;
                //End Preview Posting***********************************************************
            END;
        END;
    end;

    procedure CheckImprestSurrenderMandatoryFields(DocumentNo: Code[20])
    begin
        ImprestSurrenderHeader.get(DocumentNo);
        ImprestSurrenderHeader.TESTFIELD("Posting Date");
        ImprestSurrenderHeader.TESTFIELD("Employee No.");
        ImprestSurrenderHeader.TESTFIELD("Imprest No.");
        ImprestSurrenderHeader.TESTFIELD(Description);

        //IF Posting THEN 
        //ImprestSurrenderHeader.TESTFIELD(Status,ImprestSurrenderHeader.Status::Approved);

        //Check Imprest Lines
        ImprestSurrenderLine.RESET;
        ImprestSurrenderLine.SETRANGE("Document No.", ImprestSurrenderHeader."No.");
        IF ImprestSurrenderLine.FINDSET THEN BEGIN
            REPEAT
                ImprestSurrenderLine.TESTFIELD("Expense Account No.");
                ImprestSurrenderLine.TESTFIELD(Description);
            UNTIL ImprestSurrenderLine.NEXT = 0;
        END ELSE BEGIN
            ERROR('One or more payment lines are empty');
        END;
    end;

    var
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderHeader2: Record "Imprest Surrender Header";
        ImprestSurrenderLine: Record "Imprest Surrender Line";
        ImprestSurrenderLine2: Record "Imprest Surrender Line";
        ImprestHeader: Record "Imprest Header";
        FundsGeneralSetup: Record "Funds General Setup";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        SourceCode: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
}
