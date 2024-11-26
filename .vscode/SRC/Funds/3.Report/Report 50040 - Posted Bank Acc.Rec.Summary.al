report 50040 "Posted Bank Acc.Rec.Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Posted Bank Acc.Rec.Summary.rdlc';
    Caption = 'Posted Bank Account Reconciliation Report';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Statement No.";
            // column(BankCode;BankCode)
            // {
            // }
            column(BankAccountNo_BankAccReconciliation; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Account Statement"."Statement Date")
            {
            }
            // column(TotalBalanceonBankAccount_BankAccReconciliation;"Bank Account Statement"."Total Balance on Bank Account")
            // {
            // }
            // column(TotalAppliedAmount_BankAccReconciliation;"Bank Account Statement"."Total Applied Amount")
            // {
            // }
            // column(TotalTransactionAmount_BankAccReconciliation;"Bank Account Statement"."Total Transaction Amount")
            // {
            // }
            // column(CashBookBalance;"Bank Account Statement"."Cash Book Balance")
            // {
            // }
            // column(BankAccountNo;BankAccountNo)
            // {
            // }
            // column(StatementEndingBalance_BankAccReconciliation;"Bank Account Statement"."Statement Ending Balance")
            // {
            // }
            // column(BankName;BankName)
            // {
            // }
            // column(BankAccountBalanceasperCashBook;BankAccountBalanceasperCashBook)
            // {
            // }
            // column(UnpresentedChequesTotal;UnpresentedChequesTotal)
            // {
            // }
            // column(UncreditedBanking;UncreditedBanking)
            // {
            // }
            // column(ReconciliationStatement;ReconciliationStatement)
            // {
            // }
            // column(CompanyName;CompanyInfo.Name)
            // {
            // }
            // column(CompanyAddress;CompanyInfo.Address)
            // {
            // }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            // column(CompanyInfoPic;CompanyInfo.Picture)
            // {
            // }
            // column(ReconCashBookBal;ReconCashBookBal)
            // {
            // }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                // DataItemLink = Bank Account No.=FIELD(Bank Account No.), Statement No.=FIELD(Statement No.);
                column(CheckNo_BankAccReconciliationLine; "Bank Account Statement Line"."Check No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Bank Account Statement Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Bank Account Statement Line"."Transaction Date")
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Bank Account Statement Line"."Statement Line No.")
                {
                }
                column(Description_BankAccReconciliationLine; "Bank Account Statement Line".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Bank Account Statement Line"."Statement Amount")
                {
                }
                // column(OpenType_BankAccReconciliationLine;"Bank Account Statement Line"."Open Type")
                // {
                // }
                // column(Reconciled_BankAccReconciliationLine;"Bank Account Statement Line".Reconciled)
                // {
                // }
                // column(Difference_BankAccReconciliationLine;"Bank Account Statement Line".Difference)
                // {
                // }

                trigger OnAfterGetRecord()
                begin
                    IF "Bank Account Statement Line"."Applied Amount" <> 0 THEN BEGIN
                        // "Bank Account Statement Line".Reconciled:=TRUE;
                        //"Bank Account Statement Line".MODIFY;
                    END;
                end;
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

                Bank.RESET;
                Bank.SETRANGE(Bank."No.", "Bank Account No.");
                IF Bank.FIND('-') THEN BEGIN
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SETRANGE(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CALCFIELDS(Bank."Net Change");
                    //BankAccountBalanceasperCashBook:=Bank."Net Change";
                    // BankAccountBalanceasperCashBook:="Bank Account Statement"."Cash Book Balance";

                    BankStatementLine.RESET;
                    BankStatementLine.SETRANGE(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SETRANGE(BankStatementLine."Statement No.", "Statement No.");
                    //BankStatementLine.SETRANGE(BankStatementLine.Reconciled,FALSE);
                    IF BankStatementLine.FIND('-') THEN
                        REPEAT
                            IF BankStatementLine."Statement Amount" < 0 THEN
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            ELSE
                                IF BankStatementLine."Statement Amount" > 0 THEN
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        UNTIL BankStatementLine.NEXT = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    BankStatBalance := "Bank Account Statement"."Statement Ending Balance";


                    //Sysre
                    CLEAR(RecAmt);
                    BankAccReconLine.RESET;
                    BankAccReconLine.SETRANGE(BankAccReconLine."Bank Account No.", "Bank Account No.");
                    BankAccReconLine.SETRANGE(BankAccReconLine."Statement No.", "Statement No.");
                    IF BankAccReconLine.FIND('-') THEN BEGIN
                        REPEAT
                        //IF BankAccReconLine.Reconciled=TRUE THEN
                        //RecAmt:=RecAmt+BankAccReconLine."Applied Amount"
                        UNTIL BankAccReconLine.NEXT = 0;
                    END;
                    BankDiff := 0;
                    BankDiff := ("Statement Ending Balance" - "Balance Last Statement");

                    //IF  BankDiff <> RecAmt THEN ERROR ('The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts');


                    //IF (UnpresentedChequesTotal+TotalDifference) =(BankAccountBalanceasperCashBook-BankStatBalance) THEN
                    IF BankDiff = RecAmt THEN
                        ReconciliationStatement := 'The bank reconciliation is complete!'
                    ELSE
                        ReconciliationStatement := ' The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
                END;


                ReconCashBookBal := BankAccountBalanceasperCashBook + UnpresentedChequesTotal - UncreditedBanking;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);

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

    trigger OnPreReport()
    begin
        BankStatementLine.RESET;
        BankStatementLine.SETFILTER(BankStatementLine.Difference, '=%1', 0);
        IF BankStatementLine.FINDSET THEN BEGIN
            REPEAT
            // BankStatementLine.Reconciled:=TRUE;
            //BankStatementLine.MODIFY;
            UNTIL BankStatementLine.NEXT = 0;
        END;
    end;

    var
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Account Statement Line";
        CompanyInfo: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "Bank Acc. Reconciliation Line";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        ReconCashBookBal: Decimal;

    procedure TotalDiffFunc()
    begin
        BankRecPresented.RESET;
        BankRecPresented.SETRANGE(BankRecPresented."Bank Account No.", "Bank Account Statement"."Bank Account No.");
        BankRecPresented.SETRANGE(BankRecPresented."Statement No.", "Bank Account Statement"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        IF BankRecPresented.FIND('-') THEN BEGIN
            REPEAT
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            //MESSAGE('%1',TotalDifference);
            UNTIL BankRecPresented.NEXT = 0;
        END;
    end;
}

