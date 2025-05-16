codeunit 50016 "Funds Management"
{
    trigger OnRun()
    begin

    end;

    var
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        // ReversalHeader: Record "Document Reversal Header";
        // ReversalLine: Record "Document Reversal Line";
        // ReversalHeader2: Record "Document Reversal Header";
        PaymentHeader: Record "Payment Header";
        GLEntry: Record "G/L Entry";
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CustEntry: Record "Cust. Ledger Entry";
        FundsTransferHeader: Record "Funds Transfer Header";
        ReceiptHeader: Record "Receipt Header";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        TaxCodes: Record "Funds Tax Code";
        FundsClaimHeader: Record "Funds Claim Header";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        SourceCode: code[20];
        IMPJNL: code[20];
        LineNo: Integer;



    // procedure PostDocumentReversal("Reversal Header": Record "Document Reversal Header"; "Journal Template": Code[20]; "Journal Batch": Code[20]; Preview: Boolean)
    // begin
    //     ReversalHeader.TRANSFERFIELDS("Reversal Header", TRUE);
    //     SourceCode := IMPJNL;

    //     //Delete Journal Lines if Exist
    //     GenJnlLine.RESET;
    //     GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", "Journal Template");
    //     GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", "Journal Batch");
    //     IF GenJnlLine.FINDSET THEN BEGIN
    //         GenJnlLine.DELETEALL;
    //     END;
    //     //End Delete

    //     LineNo := 1000;
    //     //********************************************Add Imprest Header*******************************************************//
    //     GenJnlLine.INIT;
    //     GenJnlLine."Journal Template Name" := "Journal Template";
    //     GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
    //     GenJnlLine."Journal Batch Name" := "Journal Batch";
    //     GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
    //     GenJnlLine."Line No." := LineNo;
    //     GenJnlLine."Source Code" := SourceCode;
    //     GenJnlLine."Posting Date" := ReversalHeader."Posting Date";
    //     GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
    //     GenJnlLine."Document No." := ReversalHeader."Document No.";
    //     GenJnlLine."Account Type" := ReversalHeader."Account Type";
    //     GenJnlLine."Account No." := ReversalHeader."Account No.";
    //     GenJnlLine.VALIDATE(GenJnlLine."Account No.");
    //     //GenJnlLine."Posting Group":=ReversalHeader."Employee Posting Group";
    //     //GenJnlLine.VALIDATE("Posting Group");
    //     //GenJnlLine."Currency Code":=ReversalHeader."Currency Code";
    //     //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
    //     IF (ReversalHeader."Document Type" = ReversalHeader."Document Type"::Payment) OR (ReversalHeader."Document Type" = ReversalHeader."Document Type"::"Funds Transfer") THEN BEGIN
    //         GenJnlLine.Amount := ReversalHeader.Amount;
    //     END ELSE BEGIN
    //         GenJnlLine.Amount := ReversalHeader.Amount * -1;
    //     END;
    //     GenJnlLine.VALIDATE(GenJnlLine.Amount);
    //     GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
    //     GenJnlLine."Bal. Account No." := '';
    //     GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
    //     GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
    //     GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
    //     GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
    //     GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
    //     GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
    //     GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
    //     GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
    //     GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
    //     //GenJnlLine.ValidateShortcutDimCode(7,ReversalHeader."Shortcut Dimension 7 Code");
    //     //GenJnlLine.ValidateShortcutDimCode(8,ReversalHeader."Shortcut Dimension 8 Code");
    //     GenJnlLine.Description := UPPERCASE(COPYSTR(ReversalHeader.Description, 1, 249));
    //     GenJnlLine.Description2 := UPPERCASE(COPYSTR(ReversalHeader.Description + ' Reversal', 1, 249));
    //     GenJnlLine.VALIDATE(GenJnlLine.Description);
    //     //GenJnlLine."Employee Transaction Type":=GenJnlLine."Employee Transaction Type"::"2";
    //     IF GenJnlLine.Amount <> 0 THEN
    //         GenJnlLine.INSERT;

    //     ReversalLine.RESET;
    //     ReversalLine.SETRANGE(ReversalLine."No.", ReversalHeader."No.");
    //     ReversalLine.SETFILTER(ReversalLine.Amount, '<>%1', 0);
    //     IF ReversalLine.FINDSET THEN BEGIN
    //         REPEAT
    //             //****************************************Add Line NetAmounts***********************************************************//
    //             LineNo := LineNo + 1;
    //             GenJnlLine.INIT;
    //             GenJnlLine."Journal Template Name" := "Journal Template";
    //             GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
    //             GenJnlLine."Journal Batch Name" := "Journal Batch";
    //             GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
    //             GenJnlLine."Source Code" := SourceCode;
    //             GenJnlLine."Line No." := LineNo;
    //             GenJnlLine."Posting Date" := ReversalHeader."Posting Date";
    //             ;
    //             GenJnlLine."Document No." := ReversalLine."Document No.";
    //             GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
    //             GenJnlLine."Account Type" := ReversalLine."Account Type";
    //             GenJnlLine."Account No." := ReversalLine."Account No.";
    //             GenJnlLine.VALIDATE(GenJnlLine."Account No.");
    //             //GenJnlLine."External Document No." := ReversalHeader."Reference No.";
    //             // GenJnlLine."Currency Code" := ReversalHeader."Currency Code";
    //             // GenJnlLine.VALIDATE("Currency Code");
    //             IF (ReversalHeader."Document Type" = ReversalHeader."Document Type"::Payment) OR (ReversalHeader."Document Type" = ReversalHeader."Document Type"::"Funds Transfer") THEN BEGIN
    //                 GenJnlLine.Amount := ReversalLine.Amount * -1;
    //             END ELSE BEGIN
    //                 GenJnlLine.Amount := ReversalLine.Amount;
    //             END;
    //             GenJnlLine.VALIDATE(GenJnlLine.Amount);
    //             GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
    //             GenJnlLine."Bal. Account No." := '';
    //             GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
    //             GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
    //             GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
    //             GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
    //             GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
    //             GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
    //             GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
    //             GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
    //             GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
    //             GenJnlLine.ValidateShortcutDimCode(7, ReversalHeader."Shortcut Dimension 7 Code");
    //             GenJnlLine.ValidateShortcutDimCode(8, ReversalHeader."Shortcut Dimension 8 Code");
    //             GenJnlLine.Description := COPYSTR(ReversalHeader.Description, 1, 249);
    //             GenJnlLine.Description2 := UPPERCASE(COPYSTR("Reversal Header".Description + ' Reversal', 1, 249));
    //             GenJnlLine.VALIDATE(GenJnlLine.Description);
    //             //GenJnlLine."Applies-to Doc. Type" := ReversalLine."Applies-to Doc. Type";
    //             GenJnlLine."Applies-to ID" := ReversalLine."Applies-to ID";
    //             GenJnlLine."Applies-to Doc. No." := ReversalLine."Applies-to Doc. No.";
    //             IF GenJnlLine.Amount <> 0 THEN
    //                 GenJnlLine.INSERT;

    //             IF ReversalLine."Withholding Tax Code" <> '' THEN BEGIN
    //                 TaxCodes.RESET;
    //                 TaxCodes.SETRANGE("Tax Code", ReversalLine."Withholding Tax Code");
    //                 IF TaxCodes.FINDFIRST THEN BEGIN
    //                     TaxCodes.TESTFIELD("Account No.");
    //                     LineNo := LineNo + 1;
    //                     GenJnlLine.INIT;
    //                     GenJnlLine."Journal Template Name" := "Journal Template";
    //                     GenJnlLine.VALIDATE("Journal Template Name");
    //                     GenJnlLine."Journal Batch Name" := "Journal Batch";
    //                     GenJnlLine.VALIDATE("Journal Batch Name");
    //                     GenJnlLine."Line No." := LineNo;
    //                     GenJnlLine."Source Code" := SourceCode;
    //                     GenJnlLine."Posting Date" := TODAY;
    //                     GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
    //                     GenJnlLine."Document No." := ReversalLine."Document No.";
    //                     //GenJnlLine."External Document No.":=ReversalHeader."Reference No.";
    //                     GenJnlLine."Account Type" := TaxCodes."Account Type";
    //                     GenJnlLine."Account No." := TaxCodes."Account No.";
    //                     GenJnlLine.VALIDATE("Account No.");
    //                     // GenJnlLine."Currency Code":=ReversalHeader."Currency Code";
    //                     //  GenJnlLine.VALIDATE("Currency Code");
    //                     GenJnlLine.Amount := ReversalLine."Withholding Tax Amount";   //Credit Amount
    //                     GenJnlLine.VALIDATE(Amount);
    //                     GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
    //                     GenJnlLine."Bal. Account No." := '';
    //                     GenJnlLine.VALIDATE("Bal. Account No.");
    //                     GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
    //                     GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
    //                     // GenJnlLine.ValidateShortcutDimCode(7,ReversalHeader."Shortcut Dimension 7 Code");
    //                     // GenJnlLine.ValidateShortcutDimCode(8,ReversalHeader."Shortcut Dimension 8 Code");
    //                     GenJnlLine.Description := UPPERCASE(COPYSTR('Reversal of W/TAX:' + FORMAT(ReversalLine."Document No.") + '::' + FORMAT(ReversalLine."Account Name"), 1, 249));
    //                     GenJnlLine.Description2 := UPPERCASE(COPYSTR(ReversalHeader.Description, 1, 249));
    //                     IF GenJnlLine.Amount <> 0 THEN
    //                         GenJnlLine.INSERT;

    //                     //W/TAX Balancing
    //                     LineNo := LineNo + 1;
    //                     GenJnlLine.INIT;
    //                     GenJnlLine."Journal Template Name" := "Journal Template";
    //                     GenJnlLine.VALIDATE("Journal Template Name");
    //                     GenJnlLine."Journal Batch Name" := "Journal Batch";
    //                     GenJnlLine.VALIDATE("Journal Batch Name");
    //                     GenJnlLine."Line No." := LineNo;
    //                     GenJnlLine."Source Code" := SourceCode;
    //                     GenJnlLine."Posting Date" := TODAY;
    //                     GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
    //                     GenJnlLine."Document No." := ReversalLine."Document No.";
    //                     //GenJnlLine."External Document No.":=ReversalHeader."Reference No.";
    //                     GenJnlLine."Account Type" := ReversalLine."Account Type";
    //                     GenJnlLine."Account No." := ReversalLine."Account No.";
    //                     GenJnlLine.VALIDATE("Account No.");
    //                     // GenJnlLine."Posting Group":=ReversalLine."Posting Group";
    //                     //  GenJnlLine."Currency Code":=ReversalHeader."Currency Code";
    //                     //  GenJnlLine.VALIDATE("Currency Code");
    //                     GenJnlLine.Amount := ReversalLine."Withholding Tax Amount" * -1;   //Debit Amount
    //                     GenJnlLine.VALIDATE(Amount);
    //                     GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
    //                     GenJnlLine."Bal. Account No." := '';
    //                     GenJnlLine.VALIDATE("Bal. Account No.");
    //                     GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
    //                     GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
    //                     // GenJnlLine.ValidateShortcutDimCode(7,ReversalHeader."Shortcut Dimension 7 Code");
    //                     // GenJnlLine.ValidateShortcutDimCode(8,ReversalHeader."Shortcut Dimension 8 Code");
    //                     GenJnlLine.Description := UPPERCASE(COPYSTR('Reversal of W/TAX:' + FORMAT(ReversalLine."Document No.") + '::' + FORMAT(ReversalLine."Account Name"), 1, 249));
    //                     GenJnlLine.Description2 := UPPERCASE(COPYSTR(ReversalHeader.Description, 1, 249));
    //                     //GenJnlLine."Applies-to Doc. Type" := ReversalLine."Applies-to Doc. Type";
    //                     GenJnlLine."Applies-to Doc. No." := ReversalLine."Applies-to Doc. No.";
    //                     GenJnlLine.VALIDATE("Applies-to Doc. No.");
    //                     GenJnlLine."Applies-to ID" := ReversalLine."Applies-to ID";
    //                     //GenJnlLine."Employee Transaction Type":=ReversalLine."Employee Transaction Type";
    //                     IF GenJnlLine.Amount <> 0 THEN
    //                         GenJnlLine.INSERT;
    //                 END;
    //             END;
    //             //****************************************End Add W/TAX Amounts************************************************************//

    //             //****************************************Add W/VAT Amounts***************************************************************//
    //             IF ReversalLine."Withholding VAT Code" <> '' THEN BEGIN
    //                 TaxCodes.RESET;
    //                 TaxCodes.SETRANGE("Tax Code", ReversalLine."Withholding VAT Code");
    //                 IF TaxCodes.FINDFIRST THEN BEGIN
    //                     TaxCodes.TESTFIELD("Account No.");
    //                     LineNo := LineNo + 1;
    //                     GenJnlLine.INIT;
    //                     GenJnlLine."Journal Template Name" := "Journal Template";
    //                     GenJnlLine.VALIDATE("Journal Template Name");
    //                     GenJnlLine."Journal Batch Name" := "Journal Batch";
    //                     GenJnlLine.VALIDATE("Journal Batch Name");
    //                     GenJnlLine."Line No." := LineNo;
    //                     GenJnlLine."Source Code" := SourceCode;
    //                     GenJnlLine."Posting Date" := TODAY;
    //                     GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
    //                     GenJnlLine."Document No." := ReversalLine."Document No.";
    //                     //  GenJnlLine."External Document No.":=ReversalHeader."Reference No.";
    //                     GenJnlLine."Account Type" := TaxCodes."Account Type";
    //                     GenJnlLine."Account No." := TaxCodes."Account No.";
    //                     GenJnlLine.VALIDATE("Account No.");
    //                     //GenJnlLine."Currency Code":=ReversalHeader."Currency Code";
    //                     // GenJnlLine.VALIDATE("Currency Code");
    //                     GenJnlLine.Amount := ReversalLine."Withholding VAT Amount";   //Credit Amount
    //                     GenJnlLine.VALIDATE(Amount);
    //                     GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
    //                     GenJnlLine."Bal. Account No." := '';
    //                     GenJnlLine.VALIDATE("Bal. Account No.");
    //                     GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
    //                     GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
    //                     //GenJnlLine.ValidateShortcutDimCode(7,ReversalHeader."Shortcut Dimension 7 Code");
    //                     // GenJnlLine.ValidateShortcutDimCode(8,ReversalHeader."Shortcut Dimension 8 Code");
    //                     GenJnlLine.Description := UPPERCASE(COPYSTR('Reversal of W/VAT:' + FORMAT(ReversalLine."Document No.") + '::' + FORMAT(ReversalLine."Account Name"), 1, 249));
    //                     GenJnlLine.Description2 := UPPERCASE(COPYSTR(ReversalHeader.Description, 1, 249));
    //                     IF GenJnlLine.Amount <> 0 THEN
    //                         GenJnlLine.INSERT;

    //                     //W/VAT Balancing
    //                     LineNo := LineNo + 1;
    //                     GenJnlLine.INIT;
    //                     GenJnlLine."Journal Template Name" := "Journal Template";
    //                     GenJnlLine.VALIDATE("Journal Template Name");
    //                     GenJnlLine."Journal Batch Name" := "Journal Batch";
    //                     GenJnlLine.VALIDATE("Journal Batch Name");
    //                     GenJnlLine."Line No." := LineNo;
    //                     GenJnlLine."Source Code" := SourceCode;
    //                     GenJnlLine."Posting Date" := TODAY;
    //                     GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
    //                     GenJnlLine."Document No." := ReversalLine."Document No.";
    //                     //  GenJnlLine."External Document No.":=ReversalHeader."Reference No.";
    //                     GenJnlLine."Account Type" := ReversalLine."Account Type";
    //                     GenJnlLine."Account No." := ReversalLine."Account No.";
    //                     GenJnlLine.VALIDATE("Account No.");
    //                     //GenJnlLine."Posting Group":=ReversalLine."Posting Group";
    //                     // GenJnlLine."Currency Code":=ReversalHeader."Currency Code";
    //                     // GenJnlLine.VALIDATE("Currency Code");
    //                     GenJnlLine.Amount := ReversalLine."Withholding VAT Amount" * -1;   //Debit Amount
    //                     GenJnlLine.VALIDATE(Amount);
    //                     GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
    //                     GenJnlLine."Bal. Account No." := '';
    //                     GenJnlLine.VALIDATE("Bal. Account No.");
    //                     GenJnlLine."Shortcut Dimension 1 Code" := ReversalHeader."Shortcut Dimension 1 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 1 Code");
    //                     GenJnlLine."Shortcut Dimension 2 Code" := ReversalHeader."Shortcut Dimension 2 Code";
    //                     GenJnlLine.VALIDATE("Shortcut Dimension 2 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(3, ReversalHeader."Shortcut Dimension 3 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(4, ReversalHeader."Shortcut Dimension 4 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(5, ReversalHeader."Shortcut Dimension 5 Code");
    //                     GenJnlLine.ValidateShortcutDimCode(6, ReversalHeader."Shortcut Dimension 6 Code");
    //                     //GenJnlLine.ValidateShortcutDimCode(7,ReversalHeader."Shortcut Dimension 7 Code");
    //                     // GenJnlLine.ValidateShortcutDimCode(8,ReversalHeader."Shortcut Dimension 8 Code");
    //                     GenJnlLine.Description := UPPERCASE(COPYSTR('Reversal of W/VAT:' + FORMAT(ReversalLine."Document No.") + '::' + FORMAT(ReversalLine."Account Name"), 1, 249));
    //                     GenJnlLine.Description2 := UPPERCASE(COPYSTR(ReversalHeader.Description, 1, 249));
    //                     //GenJnlLine."Applies-to Doc. Type" := ReversalLine."Applies-to Doc. Type";
    //                     GenJnlLine."Applies-to Doc. No." := ReversalLine."Applies-to Doc. No.";
    //                     GenJnlLine.VALIDATE("Applies-to Doc. No.");
    //                     GenJnlLine."Applies-to ID" := ReversalLine."Applies-to ID";
    //                     // GenJnlLine."Employee Transaction Type":=ReversalLine."Employee Transaction Type";
    //                     IF GenJnlLine.Amount <> 0 THEN
    //                         GenJnlLine.INSERT;
    //                 END;
    //             END;
    //         UNTIL ReversalLine.NEXT = 0;
    //     END;

    //     COMMIT;

    //     //********************************************Post the Journal Lines************************************************************//
    //     //Adjust GenJnlLine Exchange Rate Rounding Balances
    //     GenJnlLine.RESET;
    //     GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", "Journal Template");
    //     GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", "Journal Batch");
    //     AdjustGenJnl.RUN(GenJnlLine);
    //     //End Adjust GenJnlLine Exchange Rate Rounding Balances
    //     IF NOT Preview THEN BEGIN
    //         //Now Post the Journal Lines
    //         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
    //         //***************************************************End Posting****************************************************************//
    //         COMMIT;
    //         //*************************************************Update Document**************************************************************//
    //         ReversalHeader2.RESET;
    //         ReversalHeader2.SETRANGE(ReversalHeader2."No.", ReversalHeader."No.");
    //         IF ReversalHeader2.FINDFIRST THEN BEGIN
    //             ReversalHeader2."Reversal Posted" := TRUE;
    //             ReversalHeader2."Reversal Posted By" := USERID;
    //             ReversalHeader2."Reversal Posting Date" := TODAY;
    //             ReversalHeader2.MODIFY;
    //             IF ReversalHeader2."Document Type" = ReversalHeader2."Document Type"::Payment THEN BEGIN
    //                 PaymentHeader.RESET;
    //                 PaymentHeader.SETRANGE(PaymentHeader."No.", ReversalHeader2."Document No.");
    //                 IF PaymentHeader.FINDFIRST THEN BEGIN
    //                     PaymentHeader.Reversed := TRUE;
    //                     PaymentHeader.MODIFY;
    //                 END;
    //             END ELSE
    //                 IF ReversalHeader2."Document Type" = ReversalHeader2."Document Type"::Receipt THEN BEGIN
    //                     ReceiptHeader.RESET;
    //                     ReceiptHeader.SETRANGE(ReceiptHeader."No.", ReversalHeader2."Document No.");
    //                     IF ReceiptHeader.FINDFIRST THEN BEGIN
    //                         ReceiptHeader.Reversed := TRUE;
    //                         ReceiptHeader.MODIFY;
    //                     END;
    //                 END ELSE
    //                     IF ReversalHeader2."Document Type" = ReversalHeader2."Document Type"::"Funds Transfer" THEN BEGIN
    //                         FundsTransferHeader.RESET;
    //                         FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", ReversalHeader2."Document No.");
    //                         IF FundsTransferHeader.FINDFIRST THEN BEGIN
    //                             FundsTransferHeader.Reversed := TRUE;
    //                             FundsTransferHeader.MODIFY;
    //                         END;
    //                     END;
    //             GLEntry.RESET;
    //             GLEntry.SETRANGE(GLEntry."Document No.", "Reversal Header"."Document No.");
    //             GLEntry.SETRANGE(GLEntry.Reversed, FALSE);
    //             IF GLEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     GLEntry.Reversed := TRUE;
    //                     GLEntry.MODIFY;
    //                 UNTIL GLEntry.NEXT = 0;
    //             END;
    //             CustEntry.RESET;
    //             CustEntry.SETRANGE(CustEntry."Document No.", "Reversal Header"."Document No.");
    //             CustEntry.SETRANGE(CustEntry.Reversed, FALSE);
    //             IF CustEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     CustEntry.Reversed := TRUE;
    //                     CustEntry.MODIFY;
    //                 UNTIL CustEntry.NEXT = 0;
    //             END;
    //             BankAccountLedgerEntry.RESET;
    //             BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry."Document No.", "Reversal Header"."Document No.");
    //             BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry.Reversed, FALSE);
    //             IF BankAccountLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     BankAccountLedgerEntry.Reversed := TRUE;
    //                     BankAccountLedgerEntry.MODIFY;
    //                 UNTIL BankAccountLedgerEntry.NEXT = 0;
    //             END;
    //             VendorLedgerEntry.RESET;
    //             VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Document No.", "Reversal Header"."Document No.");
    //             VendorLedgerEntry.SETRANGE(VendorLedgerEntry.Reversed, FALSE);
    //             IF VendorLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     VendorLedgerEntry.Reversed := TRUE;
    //                     VendorLedgerEntry.MODIFY;
    //                 UNTIL VendorLedgerEntry.NEXT = 0;
    //             END;

    //             EmployeeLedgerEntry.RESET;
    //             EmployeeLedgerEntry.SETRANGE(EmployeeLedgerEntry."Document No.", "Reversal Header"."Document No.");
    //             EmployeeLedgerEntry.SETRANGE(EmployeeLedgerEntry.Reversed, FALSE);
    //             IF EmployeeLedgerEntry.FINDSET THEN BEGIN
    //                 REPEAT
    //                     EmployeeLedgerEntry.Reversed := TRUE;
    //                     EmployeeLedgerEntry.MODIFY;
    //                 UNTIL EmployeeLedgerEntry.NEXT = 0;
    //             END;
    //         END;



    //         //**********************************************End Update Document***************************************************************//
    //     END ELSE BEGIN
    //         //************************************************Preview Posting***************************************************************//
    //         GenJnlLine.RESET;
    //         GenJnlLine.SETRANGE("Journal Template Name", "Journal Template");
    //         GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch");
    //         IF GenJnlLine.FINDSET THEN BEGIN
    //             GenJnlPost.Preview(GenJnlLine);
    //         END;
    //         //**********************************************End Preview Posting*************************************************************//
    //     END;
    // end;

    procedure ReopenImprestDocument(VAR "Imprest Header": Record "Imprest Header")
    begin

        ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.", "Imprest Header"."No.");
        IF ImprestHeader.FINDFIRST THEN BEGIN
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader.VALIDATE(ImprestHeader.Status);
            ImprestHeader.MODIFY;
        END;
    end;

    procedure ReopenImprestSurrender(VAR "Imprest Surrender Header": Record "Imprest Surrender Header")
    begin

        ImprestSurrenderHeader.RESET;
        ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Imprest Surrender Header"."No.");
        IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
            ImprestSurrenderHeader.Status := ImprestSurrenderHeader.Status::Open;
            ImprestSurrenderHeader.VALIDATE(ImprestSurrenderHeader.Status);
            ImprestSurrenderHeader.MODIFY;
        END;

    end;

    procedure ReOpenFundsClaim(VAR "Funds Claim Header": Record "Funds Claim Header")
    begin

        FundsClaimHeader.RESET;
        FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Funds Claim Header"."No.");
        IF FundsClaimHeader.FINDFIRST THEN BEGIN
            FundsClaimHeader.Status := FundsClaimHeader.Status::Open;
            FundsClaimHeader.VALIDATE(FundsClaimHeader.Status);
            FundsClaimHeader.MODIFY;
        END;

    end;

    procedure MatchAuutmattiically("Bank Reconciliation": Record "Bank Acc. Reconciliation")
    begin

    end;

    var
        recon: Record "Bank Acc. Reconciliation";
}
