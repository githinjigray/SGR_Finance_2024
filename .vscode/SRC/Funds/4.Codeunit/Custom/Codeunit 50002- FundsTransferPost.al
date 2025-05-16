codeunit 50002 FundsTransferPost
{
    procedure PostFundsTransfer(var DocumentNo: Code[20]; var JournalTemplate: Code[50]; var JournalBatch: code[50]; var Preview: Boolean)
    begin
        FundsTransferHeader.get(DocumentNo);
        SourceCode := 'TRANJNL';
        BankLedgerEntries.RESET;
        BankLedgerEntries.SETRANGE("Document No.", FundsTransferHeader."No.");
        BankLedgerEntries.SetRange(Reversed, false);
        IF BankLedgerEntries.FINDFIRST THEN BEGIN
            ERROR('Document already posted, Document No. exists in bank Account!');
        END;

        //Delete Journal Lines if Exist
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
        IF GenJnlLine.FINDSET THEN BEGIN
            GenJnlLine.DELETEALL;
        END;
        //End Delete

        LineNo := 1000;
        //Add to Paying Bank***************************************************************
        IF FundsTransferHeader."Post Lumpsum" THEN BEGIN
            FundsTransferHeader.CALCFIELDS("Line Amount");
            GenJnlLine.INIT;
            GenJnlLine."Journal Template Name" := JournalTemplate;
            GenJnlLine.VALIDATE("Journal Template Name");
            GenJnlLine."Journal Batch Name" := JournalBatch;
            GenJnlLine.VALIDATE("Journal Batch Name");
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Source Code" := SourceCode;
            GenJnlLine."Posting Date" := FundsTransferHeader."Posting Date";
            GenJnlLine."Document No." := FundsTransferHeader."No.";
            GenJnlLine."External Document No." := FundsTransferHeader."Reference No.";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := FundsTransferHeader."Bank Account No.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Currency Code" := FundsTransferHeader."Currency Code";
            GenJnlLine.VALIDATE("Currency Code");
            GenJnlLine."Currency Factor" := FundsTransferHeader."Currency Factor";
            IF FundsTransferHeader."Posting Type" = FundsTransferHeader."Posting Type"::"Paying Bank" THEN
                GenJnlLine.Amount := -(FundsTransferHeader."Amount To Transfer")
            ELSE
                GenJnlLine.Amount := FundsTransferHeader."Amount To Transfer";
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := '';
            GenJnlLine.VALIDATE("Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code" := FundsTransferHeader."Global Dimension 1 Code";
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := FundsTransferHeader."Global Dimension 2 Code";
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, FundsTransferHeader."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, FundsTransferHeader."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5, FundsTransferHeader."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6, FundsTransferHeader."Shortcut Dimension 6 Code");
            GenJnlLine.Description := UPPERCASE(COPYSTR(FundsTransferHeader.Description, 1, 249));
            GenJnlLine.VALIDATE(Description);
            IF GenJnlLine.Amount <> 0 THEN
                GenJnlLine.INSERT;
        END ELSE BEGIN
            FundsTransferLine.RESET;
            FundsTransferLine.SETRANGE("Document No.", FundsTransferHeader."No.");
            FundsTransferLine.SETFILTER(Amount, '<>%1', 0);
            IF FundsTransferLine.FINDSET THEN BEGIN
                REPEAT
                    LineNo := LineNo + 1;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JournalTemplate;
                    GenJnlLine.VALIDATE("Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JournalBatch;
                    GenJnlLine.VALIDATE("Journal Batch Name");
                    GenJnlLine."Source Code" := SourceCode;
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := FundsTransferHeader."Posting Date";
                    GenJnlLine."Document No." := FundsTransferLine."Document No.";
                    if FundsTransferLine."Transaction Type" = FundsTransferLine."Transaction Type"::"Bank Account" then
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account"
                    else
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := FundsTransferHeader."Bank Account No.";
                    GenJnlLine.VALIDATE("Account No.");
                    GenJnlLine."External Document No." := FundsTransferHeader."Reference No.";
                    GenJnlLine."Currency Code" := FundsTransferHeader."Currency Code";
                    GenJnlLine.VALIDATE("Currency Code");
                    GenJnlLine."Currency Factor" := FundsTransferHeader."Currency Factor";
                    IF FundsTransferHeader."Posting Type" = FundsTransferHeader."Posting Type"::"Paying Bank" THEN
                        GenJnlLine.Amount := -FundsTransferLine.Amount
                    ELSE
                        GenJnlLine.Amount := (FundsTransferLine.Amount);
                    GenJnlLine.VALIDATE(Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.VALIDATE("Bal. Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := FundsTransferHeader."Global Dimension 1 Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                    GenJnlLine."Shortcut Dimension 2 Code" := FundsTransferHeader."Global Dimension 2 Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, FundsTransferHeader."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, FundsTransferHeader."Shortcut Dimension 4 Code");
                    GenJnlLine.ValidateShortcutDimCode(5, FundsTransferHeader."Shortcut Dimension 5 Code");
                    GenJnlLine.ValidateShortcutDimCode(6, FundsTransferHeader."Shortcut Dimension 6 Code");
                    GenJnlLine.Description := UPPERCASE(COPYSTR(FundsTransferHeader.Description, 1, 100));
                    GenJnlLine.Description2 := UPPERCASE(COPYSTR(FundsTransferHeader.Description, 1, 249));
                    GenJnlLine.VALIDATE(GenJnlLine.Description);
                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                //***************************************End Add Line Amounts************************************************************//
                UNTIL FundsTransferLine.NEXT = 0;
            END;
        END;
        //End Add to Paying Bank*********************************************************

        //Add Receiving Bank Lines******************************************************
        FundsTransferLine.RESET;
        FundsTransferLine.SETRANGE("Document No.", FundsTransferHeader."No.");
        FundsTransferLine.SETFILTER(Amount, '<>%1', 0);
        IF FundsTransferLine.FINDSET THEN BEGIN
            REPEAT
                //****************************************Add Line NetAmounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JournalTemplate;
                GenJnlLine.VALIDATE("Journal Template Name");
                GenJnlLine."Journal Batch Name" := JournalBatch;
                GenJnlLine.VALIDATE("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := FundsTransferHeader."Posting Date";
                GenJnlLine."Document No." := FundsTransferLine."Document No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                GenJnlLine."Account No." := FundsTransferLine."Account No.";
                GenJnlLine.VALIDATE("Account No.");
                GenJnlLine."External Document No." := FundsTransferHeader."Reference No.";
                GenJnlLine."Currency Code" := FundsTransferHeader."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := FundsTransferHeader."Currency Factor";
                IF FundsTransferHeader."Posting Type" = FundsTransferHeader."Posting Type"::"Paying Bank" THEN
                    GenJnlLine.Amount := FundsTransferLine.Amount
                ELSE
                    GenJnlLine.Amount := -(FundsTransferLine.Amount);
                GenJnlLine.VALIDATE(Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.VALIDATE("Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := FundsTransferHeader."Global Dimension 1 Code";
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := FundsTransferHeader."Global Dimension 2 Code";
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, FundsTransferHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, FundsTransferHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, FundsTransferHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, FundsTransferHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, FundsTransferHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, FundsTransferHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UPPERCASE(COPYSTR(FundsTransferHeader.Description, 1, 100));
                GenJnlLine.Description2 := UPPERCASE(COPYSTR(FundsTransferHeader.Description, 1, 249));
                GenJnlLine.VALIDATE(GenJnlLine.Description);
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
            //End Add Line Amounts******************************************************
            UNTIL FundsTransferLine.NEXT = 0;
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
            //End Posting***************************************************************
            COMMIT;
            //Update Document***********************************************************
            BankLedgerEntries.RESET;
            BankLedgerEntries.SETRANGE("Document No.", FundsTransferHeader."No.");
            IF BankLedgerEntries.FINDFIRST THEN BEGIN
                FundsTransferHeader2.RESET;
                FundsTransferHeader2.SETRANGE("No.", FundsTransferHeader."No.");
                IF FundsTransferHeader2.FINDFIRST THEN BEGIN
                    FundsTransferHeader2.Status := FundsTransferHeader2.Status::Posted;
                    FundsTransferHeader2.Posted := TRUE;
                    FundsTransferHeader2."Posted By" := USERID;
                    FundsTransferHeader2."Date Posted" := TODAY;
                    FundsTransferHeader2."Time Posted" := TIME;
                    FundsTransferHeader2.MODIFY;
                    FundsTransferLine2.RESET;
                    FundsTransferLine2.SETRANGE("Document No.", FundsTransferHeader2."No.");
                    IF FundsTransferLine2.FINDSET THEN BEGIN
                        REPEAT
                            FundsTransferLine2.Status := FundsTransferLine2.Status::Posted;
                            FundsTransferLine2.Posted := TRUE;
                            FundsTransferLine2."Posted By" := USERID;
                            FundsTransferLine2."Date Posted" := TODAY;
                            FundsTransferLine2."Time Posted" := TIME;
                            FundsTransferLine2.MODIFY;
                        UNTIL FundsTransferLine2.NEXT = 0;
                    END;
                END;
            END;
            COMMIT;
            //End Update Document*********************************************************
        END ELSE BEGIN
            //Preview Posting************************************************************
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
            GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
            IF GenJnlLine.FINDSET THEN BEGIN
                GenJnlPost.Preview(GenJnlLine);
            END;
            //End Preview Posting*************************************************************
        END;

    end;

    procedure CheckFundsTransferMandatoryFields(DocumentNo: Code[20])
    begin
        FundsTransferHeader.Get(DocumentNo);
        FundsTransferHeader.TESTFIELD("Posting Date");
        FundsTransferHeader.TESTFIELD("Bank Account No.");
        FundsTransferHeader.TESTFIELD(Description);
        FundsTransferHeader.TESTFIELD("Posting Type");
        FundsTransferHeader.TESTFIELD("Amount To Transfer");

        FundsTransferLine.RESET;
        FundsTransferLine.SETRANGE("Document No.", FundsTransferHeader."No.");
        IF FundsTransferLine.FINDSET THEN BEGIN
            REPEAT
                FundsTransferLine.TESTFIELD("Account No.");
                FundsTransferLine.TESTFIELD(Amount);
            //FundsTransferLine.TESTFIELD(Description);
            UNTIL FundsTransferLine.NEXT = 0;
        END ELSE BEGIN
            ERROR('One or more lines is empty');
        END;
        FundsTransferHeader.CALCFIELDS("Line Amount", "Line Amount(LCY)");
        IF FundsTransferHeader."Amount To Transfer" <> FundsTransferHeader."Line Amount" THEN
            ERROR('Amount to transfer is not equal to total line amounts');
    end;

    var
        FundsTransferHeader: Record "Funds Transfer Header";
        FundsTransferHeader2: Record "Funds Transfer Header";

        FundsTransferLine: Record "Funds Transfer Line";
        FundsTransferLine2: Record "Funds Transfer Line";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        SourceCode: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
}
