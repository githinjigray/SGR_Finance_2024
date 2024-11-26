report 50049 "Bank Acc. Reconciliations"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Acc. Reconciliations.rdlc';
    Caption = 'Bank Account Reconciliation Report';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            RequestFilterFields = "Statement No.";
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Balance on Bank Account")
            {
            }
            column(TotalAppliedAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Applied Amount")
            {
            }
            column(TotalTransactionAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Transaction Amount")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled = CONST(false), "Statement Amount" = FILTER(< 0));
                column(CheckNo_BankAccReconciliationLine; "Check No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Transaction Date")
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Statement Line No.")
                {
                }
                column(Description_BankAccReconciliationLine; Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Statement Amount")
                {
                }
                column(OpenType_BankAccReconciliationLine; "Open Type")
                {
                }
                column(Payee; Payee)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Payee := '';

                    PaymentHeader.Reset;
                    PaymentHeader.SetRange(PaymentHeader."No.", "Bank Acc. Reconciliation Line"."Document No.");
                    if PaymentHeader.FindFirst then
                        Payee := PaymentHeader."Payee Name";

                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.", "Bank Acc. Reconciliation Line"."Document No.");
                    if ReceiptHeader.FindFirst then
                        Payee := ReceiptHeader."Received From";
                end;
            }
            dataitem("<Bank Acc. Reconciliation Ln1>"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled = CONST(false), "Statement Amount" = FILTER(> 0));
                column(CheckNo_BankAccReconciliationLine1; "Check No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn1; "Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; "Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; "Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine1; Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; "Statement Amount")
                {
                }
                column(OpenType_BankAccReconciliationLine1; "Open Type")
                {
                }
                column(Payee2; Payee2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Payee2 := '';

                    PaymentHeader.Reset;
                    PaymentHeader.SetRange(PaymentHeader."No.", "Bank Acc. Reconciliation Line"."Document No.");
                    if PaymentHeader.FindFirst then
                        Payee2 := PaymentHeader."Payee Name";

                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.", "Bank Acc. Reconciliation Line"."Document No.");
                    if ReceiptHeader.FindFirst then
                        Payee2 := ReceiptHeader."Received From";
                end;
            }
            dataitem("<Bank Acc. Reconciliation LN3>"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled = CONST(true));
                column(CheckNo_BankAccReconciliationLine3; "Check No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn3; "Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine3; "Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine3; "Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine3; Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine3; "Statement Amount")
                {
                }
                column(OpenType_BankAccReconciliationLine3; "Open Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                TotalDiffFunc();

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");
                    BankAccountBalanceasperCashBook := Bank."Net Change";

                    BankStatementLine.Reset;
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    BankStatementLine.SetRange(BankStatementLine.Reconciled, false);
                    if BankStatementLine.Find('-') then
                        repeat
                            if BankStatementLine."Statement Amount" < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            else
                                if BankStatementLine."Statement Amount" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        until BankStatementLine.Next = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    BankStatBalance := "Bank Acc. Reconciliation"."Statement Ending Balance";


                    //
                    Clear(RecAmt);
                    BankAccReconLine.Reset;
                    BankAccReconLine.SetRange(BankAccReconLine."Bank Account No.", "Bank Account No.");
                    BankAccReconLine.SetRange(BankAccReconLine."Statement No.", "Statement No.");
                    if BankAccReconLine.Find('-') then begin
                        repeat
                            if BankAccReconLine.Reconciled = true then
                                RecAmt := RecAmt + BankAccReconLine."Applied Amount"
                        until BankAccReconLine.Next = 0;
                    end;
                    BankDiff := 0;
                    BankDiff := ("Statement Ending Balance" - "Balance Last Statement");

                    //IF  BankDiff <> RecAmt THEN ERROR ('The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts');


                    //IF (UnpresentedChequesTotal+TotalDifference) =(BankAccountBalanceasperCashBook-BankStatBalance) THEN
                    if BankDiff = RecAmt then
                        ReconciliationStatement := 'The bank reconciliation is complete!'
                    else
                        ReconciliationStatement := ' The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);

                ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
            end;
        }
    }

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
        BankStatementLine: Record "Bank Acc. Reconciliation Line";
        CompanyInfo: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "Bank Acc. Reconciliation Line";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        Payee: Text;
        PaymentHeader: Record "Payment Header";
        ReceiptHeader: Record "Receipt Header";
        Payee2: Text;

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            //MESSAGE('%1',TotalDifference);
            until BankRecPresented.Next = 0;
        end;
    end;
}

