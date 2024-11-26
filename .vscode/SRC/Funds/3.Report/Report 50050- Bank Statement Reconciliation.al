report 50050 "Bank Statement Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Statement Reconciliation.rdlc';
    Caption = 'Bank Account Statement';
    ApplicationArea = All;

    // dataset
    // {
    //     dataitem("Bank Account Statement"; "Bank Account Statement")
    //     {
    //         DataItemTableView = SORTING("Bank Account No.", "Statement No.");
    //         PrintOnlyIfDetail = true;
    //         RequestFilterFields = "Bank Account No.", "Statement No.";
    //         column(ComanyName; CompanyName)
    //         {
    //         }
    //         column(BankAccStmtTableCaptFltr; TableCaption + ': ' + BankAccStmtFilter)
    //         {
    //         }
    //         column(BankAccStmtFilter; BankAccStmtFilter)
    //         {
    //         }
    //         column(StmtNo_BankAccStmt; "Statement No.")
    //         {
    //             IncludeCaption = true;
    //         }
    //         column(Amt_BankAccStmtLineStmt; "Bank Account Statement Line"."Statement Amount")
    //         {
    //         }
    //         column(AppliedAmt_BankAccStmtLine; "Bank Account Statement Line"."Applied Amount")
    //         {
    //         }
    //         column(BankAccNo_BankAccStmt; "Bank Account No.")
    //         {
    //         }
    //         column(BankAccStmtCapt; BankAccStmtCaptLbl)
    //         {
    //         }
    //         column(CurrReportPAGENOCapt; CurrReportPAGENOCaptLbl)
    //         {
    //         }
    //         column(BnkAccStmtLinTrstnDteCapt; BnkAccStmtLinTrstnDteCaptLbl)
    //         {
    //         }
    //         column(BnkAcStmtLinValDteCapt; BnkAcStmtLinValDteCaptLbl)
    //         {
    //         }
    //         column(BalanceLastStmt; "Bank Account Statement"."Balance Last Statement")
    //         {
    //         }
    //         column(StmtEndingBal; "Bank Account Statement"."Statement Ending Balance")
    //         {
    //         }
    //         column(StatementDate; "Bank Account Statement"."Statement Date")
    //         {
    //         }
    //         column(BankName; BankName)
    //         {
    //         }
    //         column(CashBookBalance; CashBookBalance)
    //         {
    //         }
    //         column(TotalReconcilledItems; TotalReconcilledItems)
    //         {
    //         }
    //         column(TotalUnReconcilledItems; TotalUnReconcilledItems)
    //         {
    //         }
    //         dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
    //         {
    //             DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
    //             // DataItemTableView = SORTING("Bank Account No.","Statement No.","Statement Line No.") WHERE(Reconciled=FILTER(true));
    //             column(StmtDate; Format("Transaction Date"))
    //             {
    //             }
    //             column(Type_BankAccStmtLine; Type)
    //             {
    //                 IncludeCaption = true;
    //             }
    //             column(StmtDocNo; "Document No.")
    //             {
    //                 IncludeCaption = true;
    //             }
    //             column(AppliedEntr_BankAccStmtLine; "Applied Entries")
    //             {
    //                 IncludeCaption = true;
    //             }
    //             column(StmtAmount; "Statement Amount")
    //             {
    //                 IncludeCaption = true;
    //             }
    //             column(StmtAppliedAmount; "Applied Amount")
    //             {
    //                 IncludeCaption = true;
    //             }
    //             column(StmtDescription; Description)
    //             {
    //                 IncludeCaption = true;
    //             }
    //             column(ValueDate_BankAccStmtLine; Format("Value Date"))
    //             {
    //             }
    //             column(CheckNo_A; "Bank Account Statement Line"."Check No.")
    //             {
    //             }

    //             trigger OnPreDataItem()
    //             begin
    //                 // CurrReport.CreateTotals("Statement Amount","Applied Amount");
    //             end;
    //         }
    //         dataitem("Bank Acc. Reconciliation Line3"; "Bank Acc. Reconciliation Line3")
    //         {
    //             DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
    //             column(PostingDate; "Transaction Date")
    //             {
    //             }
    //             column(DocumentType; "Document No.")
    //             {
    //             }
    //             column(DocumentNo; "Document No.")
    //             {
    //             }
    //             column(Description; Description)
    //             {
    //             }
    //             column(Amount; Difference)
    //             {
    //             }
    //             column(CheckNo_B; "Check No.")
    //             {
    //             }
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             if BankAccount.Get("Bank Account Statement"."Bank Account No.") then
    //                 BankName := BankAccount.Name;
    //             //
    //             CashBookBalance := 0;
    //             BankLedgers.Reset;
    //             BankLedgers.SetRange(BankLedgers."Bank Account No.", "Bank Account Statement"."Bank Account No.");
    //             BankLedgers.SetRange(BankLedgers."Posting Date", 0D, "Bank Account Statement"."Statement Date");
    //             if BankLedgers.FindSet then begin
    //                 repeat
    //                     CashBookBalance := CashBookBalance + BankLedgers.Amount;
    //                 until BankLedgers.Next = 0;
    //             end;

    //             TotalReconcilledItems := 0;
    //             BankStmtLine.Reset;
    //             BankStmtLine.SetRange(BankStmtLine."Bank Account No.", "Bank Account Statement"."Bank Account No.");
    //             BankStmtLine.SetRange(BankStmtLine."Statement No.", "Bank Account Statement"."Statement No.");
    //             if BankStmtLine.FindSet then begin
    //                 repeat
    //                     TotalReconcilledItems := TotalReconcilledItems + BankStmtLine."Applied Amount";
    //                 until BankStmtLine.Next = 0;
    //             end;

    //             //Unreconcilled items
    //             UnreconcilledItems.Reset;
    //             UnreconcilledItems.SetRange(UnreconcilledItems."Bank Account No.", "Bank Account Statement"."Bank Account No.");
    //             UnreconcilledItems.SetRange(UnreconcilledItems."Statement No.", "Bank Account Statement"."Statement No.");
    //             if UnreconcilledItems.FindSet then begin
    //                 UnreconcilledItems.DeleteAll;
    //             end;
    //             Commit;

    //             BankLedgers.Reset;
    //             BankLedgers.SetRange(BankLedgers."Bank Account No.", "Bank Account Statement"."Bank Account No.");
    //             BankLedgers.SetRange(BankLedgers."Posting Date", 0D, "Bank Account Statement"."Statement Date");
    //             BankLedgers.SetRange(BankLedgers.Reversed, false);
    //             BankLedgers.SetRange(BankLedgers.Open, true);
    //             if BankLedgers.FindSet then begin
    //                 repeat
    //                     UnreconcilledItems.Reset;
    //                     UnreconcilledItems."Statement Type" := UnreconcilledItems."Statement Type"::"Bank Reconciliation";
    //                     UnreconcilledItems."Bank Account No." := BankLedgers."Bank Account No.";
    //                     UnreconcilledItems."Statement No." := "Statement No.";
    //                     UnreconcilledItems."Statement Line No." := BankLedgers."Entry No.";
    //                     UnreconcilledItems."Document No." := BankLedgers."Document No.";
    //                     UnreconcilledItems."Transaction Date" := BankLedgers."Posting Date";
    //                     UnreconcilledItems.Description := BankLedgers.Description;
    //                     UnreconcilledItems."Check No." := BankLedgers."External Document No.";
    //                     UnreconcilledItems."Statement Amount" := 0;
    //                     UnreconcilledItems.Difference := BankLedgers.Amount;
    //                     UnreconcilledItems."Applied Amount" := 0;
    //                     UnreconcilledItems.Insert;
    //                 until BankLedgers.Next = 0;
    //             end;

    //             BankLedgers.Reset;
    //             BankLedgers.SetRange(BankLedgers."Bank Account No.", "Bank Account No.");
    //             BankLedgers.SetRange(BankLedgers."Posting Date", 0D, "Statement Date");
    //             BankLedgers.SetRange(BankLedgers.Reversed, false);
    //             BankLedgers.SetRange(BankLedgers.Open, false);
    //             if BankLedgers.FindSet then begin
    //                 repeat
    //                     if BankStmt.Get(BankLedgers."Bank Account No.", BankLedgers."Statement No.") then begin
    //                         if BankStmt."Statement Date" > "Statement Date" then begin
    //                             /*UnreconcilledItems.RESET;
    //                             UnreconcilledItems."Statement Type":=UnreconcilledItems."Statement Type"::"Bank Reconciliation";
    //                             UnreconcilledItems."Bank Account No.":=BankLedgers."Bank Account No.";
    //                             UnreconcilledItems."Statement No.":="Statement No.";
    //                             UnreconcilledItems."Statement Line No.":=BankLedgers."Entry No.";
    //                             UnreconcilledItems."Document No.":=BankLedgers."Document No.";
    //                             UnreconcilledItems."Transaction Date":=BankLedgers."Posting Date";
    //                             UnreconcilledItems.Description:=BankLedgers.Description;
    //                             UnreconcilledItems."Statement Amount":=0;
    //                             UnreconcilledItems.Difference:=BankLedgers.Amount;
    //                             UnreconcilledItems."Applied Amount":=0;
    //                             UnreconcilledItems.INSERT;*/
    //                         end;
    //                     end;
    //                 until BankLedgers.Next = 0;
    //             end;
    //             Commit;

    //             TotalUnReconcilledItems := 0;
    //             Unreconciled.Reset;
    //             Unreconciled.SetRange(Unreconciled."Bank Account No.", "Bank Account Statement"."Bank Account No.");
    //             Unreconciled.SetRange(Unreconciled."Statement No.", "Bank Account Statement"."Statement No.");
    //             if Unreconciled.FindSet then begin
    //                 repeat
    //                     TotalUnReconcilledItems := TotalUnReconcilledItems + Unreconciled.Difference;
    //                     ;
    //                 until Unreconciled.Next = 0;
    //             end;
    //             //End Unreconcilled items

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             // CurrReport.CreateTotals(
    //             //"Bank Account Statement Line"."Statement Amount",
    //             // "Bank Account Statement Line"."Applied Amount");
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
        TotalCaption = 'Total';
    }

    trigger OnPreReport()
    begin
        // BankAccStmtFilter := "Bank Account Statement".GetFilters;
    end;

    var
    // BankAccStmtFilter: Text;
    // BankAccStmtCaptLbl: Label 'Bank Account Statement';
    // CurrReportPAGENOCaptLbl: Label 'Page';
    // BnkAccStmtLinTrstnDteCaptLbl: Label 'Transaction Date';
    // BnkAcStmtLinValDteCaptLbl: Label 'Value Date';
    // BankName: Text[250];
    // BankAccount: Record "Bank Account";
    // CashBookBalance: Decimal;
    // BankLedgers: Record "Bank Account Ledger Entry";
    // TotalReconcilledItems: Decimal;
    // TotalUnReconcilledItems: Decimal;
    // BankStmtLine: Record "Bank Account Statement Line";
    // Unreconciled: Record "Bank Acc. Reconciliation Line3";
    // UnreconcilledItems: Record "Bank Acc. Reconciliation Line3";
    // BankStmt: Record "Bank Account Statement";
}

