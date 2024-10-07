report 70003 "Portal Dummy"
{
    ApplicationArea = All;
    Caption = 'Refresh Power BI Data';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            //DataItemTableView = where(Amount = filter(0));
            trigger OnAfterGetRecord()
            begin
                "Purch. Inv. Header".CalcFields("Amount Including VAT(LCY)");
                "Purch. Inv. Header".Amounts := "Purch. Inv. Header"."Amount Including VAT(LCY)";
                "Purch. Inv. Header".Modify();
            end;
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = where(Amount = filter(0));
            trigger OnAfterGetRecord()
            begin
                "Sales Invoice Header".CalcFields(Amount);
                "Sales Invoice Header".Amounts := "Sales Invoice Header".Amount;
                "Sales Invoice Header".Modify();
            end;
        }
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Remaining Amount" = filter(0));
            trigger OnAfterGetRecord()
            begin
                DetCustLedger.Reset();
                DetCustLedger.SetRange("Cust. Ledger Entry No.", "Cust. Ledger Entry"."Entry No.");
                DetCustLedger.SetRange("Entry Type", DetCustLedger."Entry Type"::Application);
                if DetCustLedger.FindLast() then begin
                    //"Cust. Ledger Entry".payme
                end;
            end;
        }
        dataitem(Item; Item)
        {
            //DataItemTableView = where(Amount = filter(0));
            trigger OnAfterGetRecord()
            begin
                Item.CalcFields(Inventory);
                item."Inventory Qty." := Item.Inventory;
                if Item.Inventory <> 0 then
                    Item."Inventory Cost" := item."Inventory Qty." * item."Unit Cost";
                item.Modify();
            end;
        }
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            trigger OnAfterGetRecord()
            begin
                "Fixed Asset".CalcFields("Book Value");
                "Fixed Asset"."FA Book Value" := "Fixed Asset"."Book Value";
                "Fixed Asset".Modify();
            end;
        }
    }
    var
        ContractList: Record "Contract Header2";
        UpdatedContractList: Record "Contract Header2";
        DetVendLedger: Record "Detailed Vendor Ledg. Entry";
        DetCustLedger: Record "Detailed Cust. Ledg. Entry";
        ItemList: Record Item;
}
