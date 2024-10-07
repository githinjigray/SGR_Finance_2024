report 70002 "Dummy Report 2"
{
    ApplicationArea = All;
    Caption = 'Currency Amt to GL';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("GL Entry"; "G/L Entry")
        {
            DataItemTableView = where("Currency Code" = filter(''));
            trigger OnAfterGetRecord()
            begin
                FactorAmount := 0;

                BankLedger.Reset();
                BankLedger.SetRange("Transaction No.", "GL Entry"."Transaction No.");
                BankLedger.SetRange("Document No.", "GL Entry"."Document No.");
                BankLedger.SetFilter("Currency Code", '<>%1', '');
                if BankLedger.FindFirst() then begin
                    if (BankLedger.Amount <> 0) and (BankLedger."Amount (LCY)" <> 0) then
                        FactorAmount := BankLedger.Amount / BankLedger."Amount (LCY)";
                    "GL Entry"."Currency Code" := BankLedger."Currency Code";
                    if FactorAmount <> 0 then
                        "GL Entry"."Currency Amount" := "GL Entry".Amount * FactorAmount;
                end;

                FactorAmount := 0;

                CustLedger.Reset();
                CustLedger.SetRange("Transaction No.", "GL Entry"."Transaction No.");
                CustLedger.SetRange("Document No.", "GL Entry"."Document No.");
                CustLedger.SetFilter("Currency Code", '<>%1', '');
                if CustLedger.FindFirst() then begin
                    CustLedger.CalcFields(Amount, "Amount (LCY)");
                    if (CustLedger.Amount <> 0) and (CustLedger."Amount (LCY)" <> 0) then
                        FactorAmount := CustLedger.Amount / CustLedger."Amount (LCY)";
                    "GL Entry"."Currency Code" := CustLedger."Currency Code";
                    if FactorAmount <> 0 then
                        "GL Entry"."Currency Amount" := "GL Entry".Amount * FactorAmount;
                end;
                FactorAmount := 0;

                VendorLedger.Reset();
                VendorLedger.SetRange("Transaction No.", "GL Entry"."Transaction No.");
                VendorLedger.SetRange("Document No.", "GL Entry"."Document No.");
                VendorLedger.SetFilter("Currency Code", '<>%1', '');
                if VendorLedger.FindFirst() then begin
                    VendorLedger.CalcFields(Amount, "Amount (LCY)");
                    if (VendorLedger.Amount <> 0) and (VendorLedger."Amount (LCY)" <> 0) then
                        FactorAmount := VendorLedger.Amount / VendorLedger."Amount (LCY)";
                    "GL Entry"."Currency Code" := VendorLedger."Currency Code";
                    if FactorAmount <> 0 then
                        "GL Entry"."Currency Amount" := "GL Entry".Amount * FactorAmount;
                end;
                "GL Entry".Modify();
            end;
        }
    }
    var
        BankLedger: Record "Bank Account Ledger Entry";
        CustLedger: Record "Cust. Ledger Entry";
        VendorLedger: Record "Vendor Ledger Entry";
        FactorAmount: Decimal;
}
