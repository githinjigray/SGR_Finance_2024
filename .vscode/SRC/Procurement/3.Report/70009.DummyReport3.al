report 70009 "Dummy Report 3"
{
    ApplicationArea = All;
    Caption = 'Takeon Unit Cost Update';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            //DataItemTableView = where("Journal Batch Name" = filter('TAKEON'));
            trigger OnAfterGetRecord()
            begin
                "Sales Invoice Header".CalcFields(Amount, "Amount Including VAT");
                if ("Sales Invoice Header"."Currency Factor" <> 0) and ("Sales Invoice Header"."Currency Code" <> '') then begin
                    "Sales Invoice Header"."Amount (LCY)" := "Sales Invoice Header".Amount / "Sales Invoice Header"."Currency Factor";
                    "Sales Invoice Header"."Amount Inc. VAT (LCY)" := "Sales Invoice Header"."Amount Including VAT" / "Sales Invoice Header"."Currency Factor";

                end else begin
                    "Sales Invoice Header"."Amount (LCY)" := "Sales Invoice Header".Amount;
                    "Sales Invoice Header"."Amount Inc. VAT (LCY)" := "Sales Invoice Header"."Amount Including VAT";
                end;
                "Sales Invoice Header".Modify();
            end;
        }

    }
}
