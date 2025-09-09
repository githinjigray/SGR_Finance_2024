codeunit 50000 PaymentPost
{
    procedure PostPayment(var DocumentNo: Code[20]; var JournalTemplate: Code[50]; var JournalBatch: code[50]; var Preview: Boolean)
    begin
        PaymentHeader.Get(DocumentNo);
        SourceCode := 'PAYMENTJNL';

        BankLedgerEntries.RESET;
        BankLedgerEntries.SETRANGE(BankLedgerEntries."Document No.", PaymentHeader."No.");
        BankLedgerEntries.SETRANGE(BankLedgerEntries.Reversed, FALSE);
        IF BankLedgerEntries.FINDFIRST THEN BEGIN
            Error('Document No. already exists!');
        END;

        //Delete Journal Lines if Exist
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
        IF GenJnlLine.FINDSET THEN BEGIN
            GenJnlLine.DeleteAll();
        END;
        //End Delete

        LineNo := 1000;

        //Add Payment Header***************************************************************
        PaymentHeader.CALCFIELDS(PaymentHeader."Net Amount");
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine.VALIDATE("Journal Template Name");
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine.VALIDATE("Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account No.";
        GenJnlLine.VALIDATE("Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
        GenJnlLine.VALIDATE("Currency Code");
        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
        GenJnlLine.Amount := -(PaymentHeader."Net Amount");  //Credit Amount
        GenJnlLine.VALIDATE(Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.VALIDATE("Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UPPERCASE(COPYSTR(PaymentHeader.Description, 1, 100));
        GenJnlLine.Description2 := UPPERCASE(COPYSTR(PaymentHeader.Description, 1, 249));
        GenJnlLine.VALIDATE(Description);
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;
        //End Add to Bank***************************************************************

        //Add Payment Lines**************************************************************
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.", PaymentHeader."No.");
        PaymentLine.SETFILTER(PaymentLine."Total Amount", '<>%1', 0);
        IF PaymentLine.FINDSET THEN BEGIN
            REPEAT
                //Add Line Amounts********************************************************
                LineNo := LineNo + 1;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JournalTemplate;
                GenJnlLine.VALIDATE("Journal Template Name");
                GenJnlLine."Journal Batch Name" := JournalBatch;
                GenJnlLine.VALIDATE("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.VALIDATE("Account No.");
                GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                GenJnlLine.Amount := PaymentLine."Total Amount";  //Debit Amount
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentLine."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, PaymentLine."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, PaymentLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UPPERCASE(COPYSTR(PaymentLine.Description, 1, 100));
                GenJnlLine.Description2 := UPPERCASE(COPYSTR(PaymentLine.Description, 1, 249));
                GenJnlLine.VALIDATE(Description);
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.VALIDATE("Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
                //End Add Line Amounts********************************************************

                //Add W/TAX Amounts***********************************************************
                IF PaymentLine."Withholding Tax Code" <> '' THEN BEGIN
                    TaxCodes.RESET;
                    TaxCodes.SETRANGE(TaxCodes."Tax Code", PaymentLine."Withholding Tax Code");
                    IF TaxCodes.FINDFIRST THEN BEGIN
                        TaxCodes.TESTFIELD(TaxCodes."Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JournalBatch;
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Amount := -(PaymentLine."Withholding Tax Amount");   //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UPPERCASE(COPYSTR('W/TAX:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 100));
                        GenJnlLine.Description2 := UPPERCASE(COPYSTR('W/TAX:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;

                        //W/TAX Balancing
                        // LineNo := LineNo + 1;
                        // GenJnlLine.INIT;
                        // GenJnlLine."Journal Template Name" := JournalTemplate;
                        // GenJnlLine.VALIDATE("Journal Template Name");
                        // GenJnlLine."Journal Batch Name" := JournalBatch;
                        // GenJnlLine.VALIDATE("Journal Batch Name");
                        // GenJnlLine."Line No." := LineNo;
                        // GenJnlLine."Source Code" := SourceCode;
                        // GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        // GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        // GenJnlLine."Document No." := PaymentLine."Document No.";
                        // GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        // GenJnlLine."Account Type" := PaymentLine."Account Type";
                        // GenJnlLine."Account No." := PaymentLine."Account No.";
                        // GenJnlLine.VALIDATE("Account No.");
                        // GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        // GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        // GenJnlLine.VALIDATE("Currency Code");
                        // GenJnlLine.Amount := PaymentLine."Withholding Tax Amount";   //Debit Amount
                        // GenJnlLine.VALIDATE(Amount);
                        // GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        // GenJnlLine."Bal. Account No." := '';
                        // GenJnlLine.VALIDATE("Bal. Account No.");
                        // GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        // GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        // GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        // GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        // GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        // GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        // GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        // GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        // GenJnlLine.Description := UPPERCASE(COPYSTR('W/TAX:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        // //GenJnlLine."Applies-to Doc. Type":=PaymentLine."Applies-to Doc. Type";
                        // GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        // GenJnlLine.VALIDATE("Applies-to Doc. No.");
                        // GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        // IF GenJnlLine.Amount <> 0 THEN
                        //     GenJnlLine.INSERT;
                    END;
                END;
                //End Add W/TAX Amounts****************************************************

                //Add W/VAT Amounts*******************************************************
                IF PaymentLine."Withholding VAT Code" <> '' THEN BEGIN
                    TaxCodes.RESET;
                    TaxCodes.SETRANGE(TaxCodes."Tax Code", PaymentLine."Withholding VAT Code");
                    IF TaxCodes.FINDFIRST THEN BEGIN
                        TaxCodes.TESTFIELD(TaxCodes."Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JournalBatch;
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        ;
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Amount := -(PaymentLine."Withholding VAT Amount");   //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UPPERCASE(COPYSTR('W/VAT:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 100));
                        GenJnlLine.Description2 := UPPERCASE(COPYSTR('W/VAT:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;

                        //W/VAT Balancing
                        // LineNo := LineNo + 1;
                        // GenJnlLine.INIT;
                        // GenJnlLine."Journal Template Name" := JournalTemplate;
                        // GenJnlLine.VALIDATE("Journal Template Name");
                        // GenJnlLine."Journal Batch Name" := JournalBatch;
                        // GenJnlLine.VALIDATE("Journal Batch Name");
                        // GenJnlLine."Line No." := LineNo;
                        // GenJnlLine."Source Code" := SourceCode;
                        // GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        // GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        // GenJnlLine."Document No." := PaymentLine."Document No.";
                        // GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        // GenJnlLine."Account Type" := PaymentLine."Account Type";
                        // GenJnlLine."Account No." := PaymentLine."Account No.";
                        // GenJnlLine.VALIDATE("Account No.");
                        // GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        // GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        // GenJnlLine.VALIDATE("Currency Code");
                        // GenJnlLine.Amount := PaymentLine."Withholding VAT Amount";   //Debit Amount
                        // GenJnlLine.VALIDATE(Amount);
                        // GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        // GenJnlLine."Bal. Account No." := '';
                        // GenJnlLine.VALIDATE("Bal. Account No.");
                        // GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        // GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        // GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        // GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        // GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        // GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        // GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        // GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        // GenJnlLine.Description := UPPERCASE(COPYSTR('W/VAT:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        // //GenJnlLine."Applies-to Doc. Type":=PaymentLine."Applies-to Doc. Type";
                        // GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        // GenJnlLine.VALIDATE("Applies-to Doc. No.");
                        // GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        // IF GenJnlLine.Amount <> 0 THEN
                        //     GenJnlLine.INSERT;
                    END;
                END;
            //***********************************End Add W/VAT Amounts*************************************************************//
            UNTIL PaymentLine.Next() = 0;
        end;
        //End Add Payment Lines***************************************************

        COMMIT;

        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
        AdjustGenJnl.RUN(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        IF NOT Preview THEN BEGIN
            //Post the Journal Lines
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //End Posting**************************************************************
            COMMIT;

            //Update Document***********************************************************
            BankLedgerEntries.RESET;
            BankLedgerEntries.SETRANGE("Document No.", PaymentHeader."No.");
            IF BankLedgerEntries.FINDFIRST THEN BEGIN
                PaymentHeader2.RESET;
                PaymentHeader2.SETRANGE(PaymentHeader2."No.", PaymentHeader."No.");
                IF PaymentHeader2.FINDFIRST THEN BEGIN
                    PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                    PaymentHeader2.VALIDATE(PaymentHeader2.Status);
                    PaymentHeader2.Posted := TRUE;
                    PaymentHeader2."Posted By" := USERID;
                    PaymentHeader2."Date Posted" := TODAY;
                    PaymentHeader2."Time Posted" := TIME;
                    IF PaymentHeader2.MODIFY THEN
                        //mark imprest as posted
                        MarkImprestAsPosted(PaymentHeader."No.");
                    MarkFundsClaimAsPosted(PaymentHeader."No.");
                    MarkActivityRequestAsPosted(PaymentHeader."No.");
                    // IF PaymentHeader."Payee Type" = PaymentHeader."Payee Type": THEN;
                    // MarkBoardMeetingAsPosted(PaymentHeader."No.",PaymentHeader."Payee No.");
                END;
            END;
            COMMIT;
            //End Update Document***********************************************************
        END ELSE BEGIN
            //Preview Posting***************************************************************
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
            GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
            IF GenJnlLine.FINDSET THEN BEGIN
                GenJnlPost.Preview(GenJnlLine);
            END;
            //End Preview Posting*************************************************************
        END;

    end;

    procedure PostPaymentLineByLine(var DocumentNo: Code[20]; var JournalTemplate: Code[50]; var JournalBatch: code[50]; var Preview: Boolean)

    begin
        PaymentHeader.Get(DocumentNo);
        SourceCode := 'PAYMENTJNL';

        BankLedgerEntries.RESET;
        BankLedgerEntries.SETRANGE(BankLedgerEntries."Document Type", BankLedgerEntries."Document Type"::Payment);
        BankLedgerEntries.SETRANGE(BankLedgerEntries."Document No.", PaymentHeader."No.");
        IF BankLedgerEntries.FINDFIRST THEN BEGIN
            ERROR('Payment Document is already posted, Document No.:%1 already exists in Bank No:%2', PaymentHeader."No.", PaymentHeader."Bank Account No.");
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

        //***********************************************Add Payment Lines**************************************************************//
        PaymentLine.RESET;
        PaymentLine.SETRANGE("Document No.", PaymentHeader."No.");
        PaymentLine.SETFILTER("Total Amount", '<>%1', 0);
        IF PaymentLine.FINDSET THEN BEGIN
            REPEAT
                //****************************************Add Line Amounts***********************************************************//
                LineNo := LineNo + 1;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JournalTemplate;
                GenJnlLine.VALIDATE("Journal Template Name");
                GenJnlLine."Journal Batch Name" := JournalBatch;
                GenJnlLine.VALIDATE("Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No.";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.VALIDATE("Account No.");
                GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                GenJnlLine.Amount := PaymentLine."Total Amount";  //Debit Amount
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                GenJnlLine."Bal. Account No." := PaymentHeader."Bank Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentLine."Global Dimension 2 Code";
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PaymentLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentLine."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentLine."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentLine."Shortcut Dimension 6 Code");
                //GenJnlLine.ValidateShortcutDimCode(7,PaymentLine."Shortcut Dimension 7 Code");
                // GenJnlLine.ValidateShortcutDimCode(8,PaymentLine."Shortcut Dimension 8 Code");
                GenJnlLine.Description := UPPERCASE(COPYSTR(PaymentHeader.Description, 1, 249));
                GenJnlLine.Description2 := UPPERCASE(COPYSTR(PaymentHeader."Payee Name", 1, 249));
                GenJnlLine.VALIDATE(Description);
                GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.VALIDATE("Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
                //*************************************End Add Line Amounts**********************************************************//

                //**************************************Add W/TAX Amounts************************************************************//
                IF PaymentLine."Withholding Tax Code" <> '' THEN BEGIN
                    TaxCodes.RESET;
                    TaxCodes.SETRANGE("Tax Code", PaymentLine."Withholding Tax Code");
                    IF TaxCodes.FINDFIRST THEN BEGIN
                        TaxCodes.TESTFIELD("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JournalBatch;
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Amount := -(PaymentLine."Withholding Tax Amount");   //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UPPERCASE(COPYSTR('W/TAX:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UPPERCASE(COPYSTR(PaymentHeader."Payee Name", 1, 249));
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;

                        //W/TAX Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JournalBatch;
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Amount := PaymentLine."Withholding Tax Amount";   //Debit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UPPERCASE(COPYSTR('W/TAX:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UPPERCASE(COPYSTR(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.VALIDATE("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";

                    END;
                END;
                //****************************************End Add W/TAX Amounts************************************************************//

                //****************************************Add W/VAT Amounts***************************************************************//
                IF PaymentLine."Withholding VAT Code" <> '' THEN BEGIN
                    TaxCodes.RESET;
                    TaxCodes.SETRANGE("Tax Code", PaymentLine."Withholding VAT Code");
                    IF TaxCodes.FINDFIRST THEN BEGIN
                        TaxCodes.TESTFIELD("Account No.");
                        LineNo := LineNo + 1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JournalBatch;
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Amount := -(PaymentLine."Withholding VAT Amount");   //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        // GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        // GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UPPERCASE(COPYSTR('W/VAT:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UPPERCASE(COPYSTR(PaymentHeader."Payee Name", 1, 249));
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;

                        //W/VAT Balancing
                        LineNo := LineNo + 1;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := JournalBatch;
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine."Posting Group" := PaymentLine."Posting Group";
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.Amount := PaymentLine."Withholding VAT Amount";   //Debit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := UPPERCASE(COPYSTR('W/VAT:' + FORMAT(PaymentLine."Document No.") + '::' + FORMAT(PaymentLine."Account Name"), 1, 249));
                        GenJnlLine.Description2 := UPPERCASE(COPYSTR(PaymentHeader."Payee Name", 1, 249));
                        GenJnlLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.VALIDATE("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        GenJnlLine."Employee Transaction Type" := PaymentLine."Employee Transaction Type";
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                    END;
                END;
            //***********************************End Add W/VAT Amounts*************************************************************//
            UNTIL PaymentLine.NEXT = 0;
        END;
        //*********************************************End Add Payment Lines************************************************************//
        COMMIT;
        //********************************************Post the Journal Lines************************************************************//
        //Adjust GenJnlLine Exchange Rate Rounding Balances
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
        AdjustGenJnl.RUN(GenJnlLine);
        //End Adjust GenJnlLine Exchange Rate Rounding Balances
        IF NOT Preview THEN BEGIN
            //Post the Journal Lines
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //***************************************************End Posting****************************************************************//
            COMMIT;
            //*************************************************Update Document**************************************************************//
            BankLedgerEntries.RESET;
            BankLedgerEntries.SETRANGE("Document No.", PaymentHeader."No.");
            IF BankLedgerEntries.FINDFIRST THEN BEGIN
                PaymentHeader2.RESET;
                PaymentHeader2.SETRANGE("No.", PaymentHeader."No.");
                IF PaymentHeader2.FINDFIRST THEN BEGIN
                    PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                    PaymentHeader2.VALIDATE(PaymentHeader2.Status);
                    PaymentHeader2.Posted := TRUE;
                    PaymentHeader2."Posted By" := USERID;
                    PaymentHeader2."Date Posted" := TODAY;
                    PaymentHeader2."Time Posted" := TIME;
                    if PaymentHeader2.MODIFY then begin
                        MarkImprestAsPosted(PaymentHeader."No.");
                        MarkFundsClaimAsPosted(PaymentHeader."No.");
                        MarkActivityRequestAsPosted(PaymentHeader."No.");
                    end;
                END;
            END;
            COMMIT;
            //***********************************************End Update Document************************************************************//
        END ELSE BEGIN
            //************************************************Preview Posting***************************************************************//
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
            GenJnlLine.SETRANGE("Journal Batch Name", JournalBatch);
            IF GenJnlLine.FINDSET THEN BEGIN
                GenJnlPost.Preview(GenJnlLine);
            END;
            //**********************************************End Preview Posting*************************************************************//
        END;
    end;
    //check payments mandatory fields
    procedure CheckPaymentsMandatoryFields(DocumentNo: code[20]; Posting: Boolean)
    begin
        PaymentHeader.get(DocumentNo);
        PaymentHeader.TESTFIELD(PaymentHeader."Posting Date");
        PaymentHeader.TESTFIELD(PaymentHeader."Payee Name");
        IF PaymentHeader."Payment Mode" = PaymentHeader."Payment Mode"::Cheque THEN BEGIN
            PaymentHeader.TESTFIELD(PaymentHeader."Cheque No.");
        END;
        PaymentHeader.TESTFIELD(PaymentHeader."Bank Account No.");
        PaymentHeader.TESTFIELD(PaymentHeader.Description);
        //PaymentHeader.TESTFIELD(PaymentHeader."Global Dimension 1 Code");
        //PaymentHeader.TESTFIELD(PaymentHeader."Global Dimension 2 Code");
        //PaymentHeader.TESTFIELD(PaymentHeader."Shortcut Dimension 3 Code");
        //PaymentHeader.TESTFIELD(PaymentHeader."Shortcut Dimension 4 Code");
        // PaymentHeader.TESTFIELD(PaymentHeader."Shortcut Dimension 5 Code");
        if Posting = true then BEGIN
            PaymentHeader.TESTFIELD(PaymentHeader.Status, PaymentHeader.Status::Approved);
            PaymentHeader.TESTFIELD(PaymentHeader."Reference No.");
        END;
        //Check Payment Lines
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.", PaymentHeader."No.");
        IF PaymentLine.FINDSET THEN BEGIN
            REPEAT
                PaymentLine.TESTFIELD(PaymentLine."Account No.");
                PaymentLine.TESTFIELD(PaymentLine.Description);
            // PaymentLine.TESTFIELD(PaymentLine."Global Dimension 1 Code");
            //  PaymentLine.TESTFIELD(PaymentLine."Global Dimension 2 Code");
            // PaymentLine.TESTFIELD(PaymentLine."Shortcut Dimension 3 Code");
            // PaymentLine.TESTFIELD(PaymentLine."Shortcut Dimension 4 Code");
            // PaymentLine.TESTFIELD(PaymentLine."Shortcut Dimension 5 Code");
            UNTIL PaymentLine.NEXT = 0;
        END ELSE BEGIN
            // ERROR('One or more payment lines are empty');
        END;
    end;
    //Mark Imprest As posted
    local procedure MarkImprestAsPosted(DocumentNo: Code[20])
    begin
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.", DocumentNo);
        IF PaymentLine.FindFirst() THEN BEGIN
            REPEAT
                ImprestHeader.RESET;
                ImprestHeader.SETRANGE(ImprestHeader."No.", PaymentLine."Payee No.");
                IF ImprestHeader.FINDFIRST THEN BEGIN
                    ImprestHeader.Status := ImprestHeader.Status::Posted;
                    ImprestHeader.Posted := TRUE;
                    ImprestHeader."Posted By" := USERID;
                    ImprestHeader."Posting Date" := TODAY;
                    ImprestHeader.MODIFY;
                END;
            UNTIL PaymentLine.NEXT = 0;
        END;
    end;

    local procedure MarkFundsClaimAsPosted(DocumentNo: Code[20])
    begin
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.", DocumentNo);
        IF PaymentLine.FindFirst() THEN BEGIN
            REPEAT
                FundsClaimHeader.RESET;
                FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", PaymentLine."Payee No.");
                IF FundsClaimHeader.FINDFIRST THEN BEGIN
                    FundsClaimHeader.Status := FundsClaimHeader.Status::Posted;
                    FundsClaimHeader.Posted := TRUE;
                    FundsClaimHeader."Posted By" := USERID;
                    FundsClaimHeader."Posting Date" := TODAY;
                    FundsClaimHeader.MODIFY;
                END;
            UNTIL PaymentLine.NEXT = 0;
        END;
    end;

    local procedure MarkActivityRequestAsPosted(DocumentNo: Code[20])
    begin
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.", DocumentNo);
        IF PaymentLine.FindFirst() THEN BEGIN
            REPEAT
                ActivityRequest.RESET;
                ActivityRequest.SETRANGE(ActivityRequest."No.", PaymentLine."Payee No.");
                IF ActivityRequest.FINDFIRST THEN BEGIN
                    ActivityRequest.Status := ActivityRequest.Status::Posted;
                    ActivityRequest.Posted := TRUE;
                    ActivityRequest."Posted By" := USERID;
                    ActivityRequest."Posting Date" := TODAY;
                    ActivityRequest.MODIFY;
                END;
            UNTIL PaymentLine.NEXT = 0;
        END;
    end;

    var
        PaymentHeader: Record "Payment Header";
        FundsClaimHeader: Record "Funds Claim Header";
        FundsClaimLine: Record "Funds Claim Line";
        PaymentHeader2: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        TaxCodes: Record "Funds Tax Code";
        ImprestHeader: Record "Imprest Header";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        ActivityRequest: Record "Travel Request Header";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        SourceCode: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
}
