report 70008 "Update Customer External No."
{
    ApplicationArea = All;
    Caption = 'Update Customer External No.';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(CustomerLedger; "Cust. Ledger Entry")
        {
            DataItemTableView = where("External Document No." = filter(''));
            trigger OnAfterGetRecord()
            begin
                PostedSalesInvoices.Reset();
                PostedSalesInvoices.SetRange("No.", CustomerLedger."Document No.");
                if PostedSalesInvoices.FindFirst() then begin
                    CustomerLedger."External Document No." := PostedSalesInvoices."Pre-Assigned No.";
                    CustomerLedger.Modify();
                end;
            end;
        }
    }
    var
        PostedSalesInvoices: Record "Sales Invoice Header";
        CustomerList: Record Customer;
}