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
                GenJnlLine."External Document No." := PaymentLine."Reference No.";
                if PaymentLine."Reference No." = '' then
                    GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                if (PaymentHeader."Reference No." = '') and (PaymentLine."Reference No." = '') then
                    GenJnlLine."External Document No." := PaymentHeader."No.";
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
                        ;
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentLine."Reference No.";
                        if PaymentLine."Reference No." = '' then
                            GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        if (PaymentHeader."Reference No." = '') and (PaymentLine."Reference No." = '') then
                            GenJnlLine."External Document No." := PaymentHeader."No.";
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
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := PaymentLine."Document No.";
                        GenJnlLine."External Document No." := PaymentLine."Reference No.";
                        if PaymentLine."Reference No." = '' then
                            GenJnlLine."External Document No." := PaymentHeader."Reference No.";
                        if (PaymentHeader."Reference No." = '') and (PaymentLine."Reference No." = '') then
                            GenJnlLine."External Document No." := PaymentHeader."No.";
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

        // BankLedgerEntries.RESET;
        // BankLedgerEntries.SETRANGE(BankLedgerEntries."Document Type", BankLedgerEntries."Document Type"::Payment);
        // BankLedgerEntries.SETRANGE(BankLedgerEntries."Document No.", PaymentHeader."No.");
        // IF BankLedgerEntries.FINDFIRST THEN BEGIN
        //     ERROR('Payment Document is already posted, Document No.:%1 already exists in Bank No:%2', PaymentHeader."No.", PaymentHeader."Bank Account No.");
        // END;

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
        //PaymentHeader.TESTFIELD(PaymentHeader."Shortcut Dimension 5 Code");
        if Posting = true then BEGIN
            //PaymentHeader.TESTFIELD(PaymentHeader.Status, PaymentHeader.Status::Approved);
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
            //PaymentLine.TESTFIELD(PaymentLine."Global Dimension 2 Code");
            //PaymentLine.TESTFIELD(PaymentLine."Shortcut Dimension 3 Code");
            //PaymentLine.TESTFIELD(PaymentLine."Shortcut Dimension 4 Code");
            //PaymentLine.TESTFIELD(PaymentLine."Shortcut Dimension 5 Code");
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
                    ImprestHeader."CPV No." := PaymentLine."Document No.";
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
                GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
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
                        GenJnlLine."Currency Factor" := ReceiptHeader."Currency Factor";
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

    procedure SendReceiptToCustomer("RcptNo.": Code[20])
    begin
        ReceiptHeader.Reset;
        ReceiptHeader.SetRange(ReceiptHeader."No.", "RcptNo.");
        ReceiptHeader.SetFilter(ReceiptHeader."Customer Email Address", '<>%1', '');
        if ReceiptHeader.FindSet then begin
            repeat
                CreateCustomerEmailMessage("RcptNo.", ReceiptHeader."Customer Email Address", ReceiptHeader."Customer Name");
            until ReceiptHeader.Next = 0;
        end;
        Message(Text0012);
    end;

    procedure CreateCustomerEmailMessage("RFQNo.": Code[20]; VendorEmail: Text; VendorName: Text)
    var
        RequestforQuotationVendors: Record "Receipt Header";
        Customer: Record Customer;
        //SMTPMail: Record "SMTP Mail Setup";
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        CompanyInformation.Get;

        EmailBody := '';
        EmailBody := 'Dear ' + VendorName + ',<br><br>';
        EmailBody := EmailBody + 'Find attached Receipt.<br>';
        EmailBody := EmailBody + '<br><br>';
        EmailBody := EmailBody + 'Kind Regards<br><br>';
        EmailBody := EmailBody + CompanyInformation.Name;

        //SMTPMail.Get;
        SenderName := CompanyInformation.Name;
        //SenderAddress := SMTPMail."User ID";
        Subject := "RFQNo.";
        Recipients := VendorEmail;
        RecipientsBCC := '';

        InsertReceiptEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, "RFQNo.");
    end;

    local procedure InsertReceiptEmailMessage("Sender Name": Text[100]; "Sender Address": Text[80]; Subject: Text[250]; Recipients: Text[250]; "Recipients CC": Text[250]; "Recipients BCC": Text[250]; Body: Text; "DocumentNo.": Code[20]) EmailMessageInserted: Boolean
    var
        ProcurementEmailMessages: Record "Procurement Email Messages";
        EmailBodyText: BigText;
        EmailBodyOutStream: OutStream;
    begin
        EmailMessageInserted := false;

        ProcurementEmailMessages.Init;
        ProcurementEmailMessages."Entry No." := 0;
        ProcurementEmailMessages."Sender Name" := "Sender Name";
        ProcurementEmailMessages."Sender Address" := "Sender Address";
        ProcurementEmailMessages.Subject := Subject;
        ProcurementEmailMessages.Recipients := Recipients;
        ProcurementEmailMessages."Recipients CC" := "Recipients CC";
        ProcurementEmailMessages."Recipients BCC" := "Recipients BCC";
        EmailBodyText.AddText(Body);
        ProcurementEmailMessages.Body.CreateOutStream(EmailBodyOutStream);
        EmailBodyText.Write(EmailBodyOutStream);
        ProcurementEmailMessages.HtmlFormatted := true;
        ProcurementEmailMessages."Created By" := UserId;
        ProcurementEmailMessages."Date Created" := Today;
        ProcurementEmailMessages."Time Created" := Time;
        ProcurementEmailMessages."Document No." := "DocumentNo.";
        if ProcurementEmailMessages.Insert then
            EmailMessageInserted := true;
    end;

    procedure SendReceipt(ReceiptHeader1: Record "Receipt Header")
    var

        Email2: Text;
        SMTP: Codeunit "Email Message";
        FileName: Text;
        FileLocation: Text;
        Customer: Record Customer;
        RegistrationNo: Code[30];
        FileName1: Text;
        FileLocation1: Text;
        DocLog: Record "Procurement Email Messages";
        Counter: Integer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        InStr: Instream;
        OutStr: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        BodyTxt: Text;
        OutStr2: OutStream;
        InStr2: InStream;

    begin
        CompanyInformation.get;
        Email2 := CompanyInformation."E-Mail";

        ReceiptHeader1.SetRange("No.", ReceiptHeader1."No.");
        RecRef.GetTable(ReceiptHeader1);
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Receipt Header", '', ReportFormat::Pdf, OutStr, RecRef);
        TempBlob.CreateInStream(InStr);
        InStr.ReadText(BodyTxt);

        EmailMessage.Create(ReceiptHeader1."Customer Email Address", 'RECEPT',
       'Dear ' + ReceiptHeader1."Customer Name" + ',<br/><br/>' +
       'Your Receipt  done on <strong>' + ' ' + Format(ReceiptHeader1."Posting Date") + ' ' + '</strong> has been processed.<BR>' +
       'Find attached the Receipt', true);

        // add attachment for with pdf
        TempBlob.CreateOutStream(OutStr2);
        Report.SaveAs(Report::"Receipt Header", '', ReportFormat::Pdf, OutStr, RecRef);
        TempBlob.CreateInStream(InStr2);
        // EmailMessage.AddAttachmentStream(InStr2, 'attachment.pdf');
        // EmailMessage.add
        EmailMessage.AddAttachment('attachment.pdf', 'PDF', InStr2);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


        //SMTP.AddBCC(Email2);
        //SMTP.AddBCC(ExaminationSetup."Student Module EMail BCC");
        //SMTP.AppendToBody('<BR><BR>Kind Regards,' + '<BR><BR>For more details contact the following:<BR>');
        //SMTP.AppendToBody('<BR><BR>EXAMINATION BOOKING<BR><BR>[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]<BR><BR>');
        //SMTP.Send();
        Message('notification sent successfuly');
        //send receipt

        //record sending details


    end;

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

    procedure PostImprestSurrender2(var DocumentNo: Code[20]; var JournalTemplate: Code[50]; var JournalBatch: code[50]; var Preview: Boolean)
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

    procedure CheckImprestSurrenderMandatoryFieldsImpSurrenderpost(DocumentNo: Code[20])
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

    procedure CheckImprestMandatoryFields(DocumentNo: Code[20])
    begin
        ImprestHeader.get(DocumentNo);
        ImprestHeader.CALCFIELDS(Amount);
        ImprestHeader.TESTFIELD("Posting Date");
        ImprestHeader.TESTFIELD(Amount);
        ImprestHeader.TESTFIELD("Employee No.");
        ImprestHeader.TESTFIELD(Description);
        //ImprestHeader.TESTFIELD("Employee Posting Group");
        //ImprestHeader.TESTFIELD("Global Dimension 1 Code");
        //ImprestHeader.TESTFIELD("Global Dimension 2 Code");
        ImprestHeader.TESTFIELD("Date From");
        ImprestHeader.TESTFIELD("Date To");
        //IF Posting THEN
        // ImprestHeader.TESTFIELD(Status,ImprestHeader.Status::Released);

        //Check Imprest Lines
        ImprestLine.RESET;
        ImprestLine.SETRANGE("Document No.", ImprestHeader."No.");
        IF ImprestLine.FINDSET THEN BEGIN
            REPEAT
                //ImprestLine.TESTFIELD("Budget Committed",TRUE);
                ImprestLine.TESTFIELD(Amount);
                IF ImprestLine."Account Type" = ImprestLine."Account Type"::"G/L Account" THEN BEGIN
                    //ImprestLine.TESTFIELD("Global Dimension 1 Code");
                    //ImprestLine.TESTFIELD("Global Dimension 2 Code");
                    // ImprestLine.TESTFIELD("Shortcut Dimension 4 Code");
                    // ImprestLine.TESTFIELD("Shortcut Dimension 5 Code");
                    //ImprestLine.TESTFIELD("Shortcut Dimension 6 Code");
                END;
            UNTIL ImprestLine.NEXT = 0;
        END ELSE BEGIN
            ERROR('One or more Imprest lines are empty');
        END;
    end;

    procedure CheckFundsClaimMandatoryFieldsFundsClaim(DocumentNo: code[20])
    begin
        FundsClaimHeader.get(DocumentNo);
        FundsClaimHeader.TESTFIELD("Posting Date");
        FundsClaimHeader.TESTFIELD("Global Dimension 2 Code");
        FundsClaimHeader.TESTFIELD("Payee No.");
        FundsClaimHeader.TESTFIELD(Description);
        FundsClaimHeader.TESTFIELD("Global Dimension 1 Code");
        // IF Posting THEN BEGIN
        //FundsClaimHeader.TESTFIELD("Bank Account No.");
        // FundsClaimHeader.TESTFIELD(Status,FundsClaimHeader.Status::Approved);
        //END;

        //Check Funds Claim Lines
        FundsClaimLine.RESET;
        FundsClaimLine.SETRANGE("Document No.", FundsClaimHeader."No.");
        IF FundsClaimLine.FINDSET THEN BEGIN
            REPEAT
                FundsClaimLine.TESTFIELD("Account No.");
                FundsClaimLine.TESTFIELD(Amount);
                FundsClaimLine.TESTFIELD(Description);
                FundsClaimLine.TESTFIELD("Global Dimension 1 Code");
                FundsClaimLine.TESTFIELD("Global Dimension 2 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 4 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 3 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 5 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 6 Code");
            UNTIL FundsClaimLine.NEXT = 0;
        END ELSE BEGIN
            ERROR('One or more Funds Claim lines are empty');
        END;
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
        CompanyInformation: Record "Company Information";
        Text0012: Label 'Email Sent';
        PaymentHeader: Record "Payment Header";
        FundsClaimHeader: Record "Funds Claim Header";
        FundsClaimLine: Record "Funds Claim Line";
        PaymentHeader2: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        ActivityRequest: Record "Travel Request Header";
        FundsTransferHeader: Record "Funds Transfer Header";
        FundsTransferHeader2: Record "Funds Transfer Header";
        FundsTransferLine: Record "Funds Transfer Line";
        FundsTransferLine2: Record "Funds Transfer Line";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderHeader2: Record "Imprest Surrender Header";
        ImprestSurrenderLine: Record "Imprest Surrender Line";
        ImprestSurrenderLine2: Record "Imprest Surrender Line";
        FundsGeneralSetup: Record "Funds General Setup";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";

}
