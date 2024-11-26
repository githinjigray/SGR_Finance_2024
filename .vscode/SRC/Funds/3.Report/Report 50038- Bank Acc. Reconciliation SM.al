report 50038 "Bank Acc. Reconciliation SM"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Acc. Reconciliation SM.rdlc';
    Caption = 'Posted Bank Account Reconciliation Report';
    ApplicationArea = All;

    // dataset
    // {
    //     dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
    //     {
    //         RequestFilterFields = "Statement No.";
    //         //column(BankCode;BankCode)
    //         //  {
    //         // }
    //         column(BankAccountNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Bank Account No.")
    //         {
    //         }
    //         column(StatementNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement No.")
    //         {
    //         }
    //         column(StatementDate_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Date")
    //         {
    //         }
    //         column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Balance on Bank Account")
    //         {
    //         }
    //         column(TotalAppliedAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Applied Amount")
    //         {
    //         }
    //         column(TotalTransactionAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Transaction Amount")
    //         {
    //         }
    //         // column(BankAccountNo;BankAccountNo)
    //         // {
    //         // }
    //         column(StatementEndingBalance_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Ending Balance")
    //         {
    //         }
    //         // column(BankName;BankName)
    //         // {
    //         // }
    //         // column(BankAccountBalanceasperCashBook;BankAccountBalanceasperCashBook)
    //         // {
    //         // }
    //         // column(UnpresentedChequesTotal;UnpresentedChequesTotal)
    //         // {
    //         // }
    //         // column(UncreditedBanking;UncreditedBanking)
    //         // {
    //         // }
    //         // column(ReconciliationStatement;ReconciliationStatement)
    //         // {
    //         // }
    //         // column(CompanyName;CompanyInfo.Name)
    //         // {
    //         // }
    //         // column(CompanyAddress;CompanyInfo.Address)
    //         // {
    //         // }
    //         dataitem("Bank Acc. Reconciliation Line2"; "Bank Acc. Reconciliation Line2")
    //         {
    //             DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
    //             // DataItemTableView = WHERE(Reconciled=CONST(No), "Statement Amount"=FILTER(<0));
    //             column(CheckNo_BankAccReconciliationLine; "Check No.")
    //             {
    //             }
    //             column(DocumentNo_BankAccReconciliationLine; "Document No.")
    //             {
    //             }
    //             column(TransactionDate_BankAccReconciliationLine; "Transaction Date")
    //             {
    //             }
    //             column(StatementLineNo_BankAccReconciliationLine; "Statement Line No.")
    //             {
    //             }
    //             column(Description_BankAccReconciliationLine; Description)
    //             {
    //             }
    //             // column(PAYEEName_BankAccReconciliationLine;"PAYEE Name")
    //             // {
    //             // }
    //             column(StatementAmount_BankAccReconciliationLine; "Statement Amount")
    //             {
    //             }
    //             column(OpenType_BankAccReconciliationLine; "Open Type")
    //             {
    //             }
    //         }
    //         dataitem("<Bank Acc. Reconciliation Ln1>"; "Bank Acc. Reconciliation Line2")
    //         {
    //             // DataItemLink = Bank Account No.=FIELD(Bank Account No.), Statement No.=FIELD(Statement No.);
    //             //DataItemTableView = WHERE(Reconciled=CONST(No), Statement Amount=FILTER(>0));
    //             column(CheckNo_BankAccReconciliationLine1; "Check No.")
    //             {
    //             }
    //             column(StatementLineNo_BankAccReconciliationLn1; "Statement Line No.")
    //             {
    //             }
    //             column(DocumentNo_BankAccReconciliationLine1; "Document No.")
    //             {
    //             }
    //             column(TransactionDate_BankAccReconciliationLine1; "Transaction Date")
    //             {
    //             }
    //             //column(PAYEEName_BankAccReconciliationLn1;"PAYEE Name")
    //             //{
    //             //}
    //             column(Description_BankAccReconciliationLine1; Description)
    //             {
    //             }
    //             column(StatementAmount_BankAccReconciliationLine1; "Statement Amount")
    //             {
    //             }
    //             column(OpenType_BankAccReconciliationLine1; "Open Type")
    //             {
    //             }
    //         }
    //         dataitem("<Bank Acc. Reconciliation LN3>"; "Bank Acc. Reconciliation Line3")
    //         {
    //             // DataItemLink = Bank Account No.=FIELD(Bank Account No.), Statement No.=FIELD(Statement No.);
    //             // DataItemTableView = WHERE(Reconciled=CONST(Yes));
    //             column(CheckNo_BankAccReconciliationLine3; "Check No.")
    //             {
    //             }
    //             column(StatementLineNo_BankAccReconciliationLn3; "Statement Line No.")
    //             {
    //             }
    //             column(DocumentNo_BankAccReconciliationLine3; "Document No.")
    //             {
    //             }
    //             column(TransactionDate_BankAccReconciliationLine3; "Transaction Date")
    //             {
    //             }
    //             //column(PAYEEName_BankAccReconciliationLN3;"PAYEE Name")
    //             //{
    //             // }
    //             column(Description_BankAccReconciliationLine3; Description)
    //             {
    //             }
    //             column(StatementAmount_BankAccReconciliationLine3; "Statement Amount")
    //             {
    //             }
    //             column(OpenType_BankAccReconciliationLine3; "Open Type")
    //             {
    //             }
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             BankCode := '';
    //             BankAccountNo := '';
    //             BankName := '';
    //             BankAccountBalanceasperCashBook := 0;
    //             UnpresentedChequesTotal := 0;
    //             UncreditedBanking := 0;

    //             TotalDiffFunc();

    //             Bank.RESET;
    //             Bank.SETRANGE(Bank."No.", "Bank Account No.");
    //             IF Bank.FIND('-') THEN BEGIN
    //                 BankCode := Bank."No.";
    //                 BankAccountNo := Bank."Bank Account No.";
    //                 BankName := Bank.Name;
    //                 Bank.SETRANGE(Bank."Date Filter", 0D, "Statement Date");
    //                 Bank.CALCFIELDS(Bank."Net Change");
    //                 BankAccountBalanceasperCashBook := Bank."Net Change";

    //                 BankStatementLine.RESET;
    //                 BankStatementLine.SETRANGE(BankStatementLine."Bank Account No.", Bank."No.");
    //                 BankStatementLine.SETRANGE(BankStatementLine."Statement No.", "Statement No.");
    //                 BankStatementLine.SETRANGE(BankStatementLine.Reconciled, FALSE);
    //                 IF BankStatementLine.FIND('-') THEN
    //                     REPEAT
    //                         IF BankStatementLine."Statement Amount" < 0 THEN
    //                             UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
    //                         ELSE
    //                             IF BankStatementLine."Statement Amount" > 0 THEN
    //                                 UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
    //                     UNTIL BankStatementLine.NEXT = 0;

    //                 UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

    //                 BankStatBalance := "Bank Acc. Reconciliation"."Statement Ending Balance";


    //                 //Sysre
    //                 CLEAR(RecAmt);
    //                 BankAccReconLine.RESET;
    //                 BankAccReconLine.SETRANGE(BankAccReconLine."Bank Account No.", "Bank Account No.");
    //                 BankAccReconLine.SETRANGE(BankAccReconLine."Statement No.", "Statement No.");
    //                 IF BankAccReconLine.FIND('-') THEN BEGIN
    //                     REPEAT
    //                         IF BankAccReconLine.Reconciled = TRUE THEN
    //                             RecAmt := RecAmt + BankAccReconLine."Applied Amount"
    //                     UNTIL BankAccReconLine.NEXT = 0;
    //                 END;
    //                 BankDiff := 0;
    //                 BankDiff := ("Statement Ending Balance" - "Balance Last Statement");

    //                 //IF  BankDiff <> RecAmt THEN ERROR ('The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts');


    //                 //IF (UnpresentedChequesTotal+TotalDifference) =(BankAccountBalanceasperCashBook-BankStatBalance) THEN
    //                 IF BankDiff = RecAmt THEN
    //                     ReconciliationStatement := 'The bank reconciliation is complete!'
    //                 ELSE
    //                     ReconciliationStatement := ' The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
    //             END;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             CompanyInfo.GET;
    //             CompanyInfo.CALCFIELDS(Picture);

    //             ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
    //         end;
    //     }
    // }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Acc. Reconciliation Line2";
        CompanyInfo: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "Bank Acc. Reconciliation Line2";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line2";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line2";

    procedure TotalDiffFunc()
    begin
        // BankRecPresented.RESET;
        // BankRecPresented.SETRANGE(BankRecPresented."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
        // BankRecPresented.SETRANGE(BankRecPresented."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
        // //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        // IF BankRecPresented.FIND('-') THEN BEGIN
        //     REPEAT
        //         TotalDifference := TotalDifference + BankRecPresented.Difference;
        //     //MESSAGE('%1',TotalDifference);
        //     UNTIL BankRecPresented.NEXT = 0;
        // END;
    end;
}

