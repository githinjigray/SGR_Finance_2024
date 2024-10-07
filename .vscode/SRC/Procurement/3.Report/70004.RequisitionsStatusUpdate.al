report 70004 "Requisitions Status Update"
{
    ApplicationArea = All;
    Caption = 'Merge Customers';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")

        {
            DataItemTableView = where("Customer No." = filter('BC0695'));
            trigger OnAfterGetRecord()
            var
                CustList: Record Customer;
            begin
                "Cust. Ledger Entry"."Customer No." := 'BC0678';
                if CustList.get('BC0678') then
                    "Cust. Ledger Entry"."Customer Name" := CustList.Name;
                "Cust. Ledger Entry".Validate("Customer No.");
                "Cust. Ledger Entry".Modify();
            end;
        }
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")

        {
            DataItemTableView = where("Customer No." = filter('BC0695'));
            trigger OnAfterGetRecord()
            var
                CustList: Record Customer;
            begin
                "Detailed Cust. Ledg. Entry"."Customer No." := 'BC0678';
                "Detailed Cust. Ledg. Entry".Validate("Customer No.");
                "Detailed Cust. Ledg. Entry".Modify();
            end;
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")

        {
            DataItemTableView = where("Bill-to Customer No." = filter('BC0695'));
            trigger OnAfterGetRecord()
            var
                CustList: Record Customer;
            begin
                "Sales Invoice Header"."Bill-to Customer No." := 'BC0678';
                "Sales Invoice Header"."Sell-to Customer No." := 'BC0678';
                if CustList.get('BC0678') then begin
                    "Sales Invoice Header"."Bill-to Name" := CustList.Name;
                    "Sales Invoice Header"."Sell-to Customer Name" := CustList.Name;
                end;
                "Sales Invoice Header".Modify();
            end;
        }
    }

}
