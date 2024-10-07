report 70005 "Approval Entry Updates"
{
    ApplicationArea = All;
    Caption = 'Update Source Nos.';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "G/L Entry" = rm;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where("Source No." = filter(<> ''), "PAYE Name" = filter(''));
            trigger OnAfterGetRecord()
            begin
                BankLedger.Reset();
                BankLedger.SetRange("No.", "G/L Entry"."Source No.");
                if BankLedger.FindFirst() then begin
                    "G/L Entry"."PAYE Name" := BankLedger.Name;
                    "G/L Entry".Modify();
                end;

                CustomersList.Reset();
                CustomersList.SetRange("No.", "G/L Entry"."Source No.");
                if CustomersList.FindFirst() then begin
                    "G/L Entry"."PAYE Name" := CustomersList.Name;
                    "G/L Entry".Modify();
                end;

                VendorList.Reset();
                VendorList.SetRange("No.", "G/L Entry"."Source No.");
                if VendorList.FindFirst() then begin
                    "G/L Entry"."PAYE Name" := VendorList.Name;
                    "G/L Entry".Modify();
                end;
            end;
        }

    }
    var
        BankLedger: Record "Bank Account";
        CustomersList: Record Customer;
        VendorList: Record Vendor;
}
