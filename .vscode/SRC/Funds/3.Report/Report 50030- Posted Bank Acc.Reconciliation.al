report 50030 "Posted Bank Acc.Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Posted Bank Acc.Reconciliation.rdlc';
    Caption = 'Posted Bank Account Reconciliation Report';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Statement No.";
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Account Statement"."Statement Date")
            {
            }
            column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Account Statement"."Total Neg. Diff. at Posting")
            {
            }
            column(CashBookBalance_BankAccountStatement; "Bank Account Statement"."Total Neg. Diff. at Posting")
            {
            }
            column(TotalAppliedAmount_BankAccReconciliation; "Bank Account Statement"."Total Neg. Diff. at Posting")
            {
            }
            column(TotalTransactionAmount_BankAccReconciliation; "Bank Account Statement"."Total Neg. Diff. at Posting")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Bank Account Statement"."Statement Ending Balance")
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
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(ReconCashBookBal; ReconCashBookBal)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
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
                column(OpenType_BankAccReconciliationLine; "Bank Account Statement Line"."Applied Entries")
                {
                }
                column(Reconciled_BankAccReconciliationLine; "Bank Account Statement Line"."Applied Entries")
                {
                }
                column(Difference_BankAccReconciliationLine; "Bank Account Statement Line".Difference)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Bank Account Statement Line"."Applied Amount" <> 0 then begin
                        //"Bank Account Statement Line".Reconciled:=true;
                        "Bank Account Statement Line".Modify;
                    end;
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

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");
                    //  BankAccountBalanceasperCashBook:=Bank."Net Change";
                    //BankAccountBalanceasperCashBook:="Bank Account Statement"."Cash Book Balance";

                    BankStatementLine.Reset;
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    //BankStatementLine.SetRange(BankStatementLine.Reconciled,false);
                    if BankStatementLine.Find('-') then
                        repeat
                            if BankStatementLine."Statement Amount" < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            else
                                if BankStatementLine."Statement Amount" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        until BankStatementLine.Next = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    BankStatBalance := "Bank Account Statement"."Statement Ending Balance";


                    //Sysre
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


                ReconCashBookBal := BankAccountBalanceasperCashBook + UnpresentedChequesTotal - UncreditedBanking;
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

    trigger OnPreReport()
    begin
        BankStatementLine.Reset;
        BankStatementLine.SetFilter(BankStatementLine.Difference, '=%1', 0);
        if BankStatementLine.FindSet then begin
            repeat
                // BankStatementLine.Reconciled:=true;
                BankStatementLine.Modify;
            until BankStatementLine.Next = 0;
        end;
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
        BankRecPresented: Record "Bank Acc. Reconciliation Line2";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line2";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line2";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        ReconCashBookBal: Decimal;

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Account Statement"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Account Statement"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            //MESSAGE('%1',TotalDifference);
            until BankRecPresented.Next = 0;
        end;
    end;
}

