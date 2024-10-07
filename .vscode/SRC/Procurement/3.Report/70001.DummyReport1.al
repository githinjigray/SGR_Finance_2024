report 70001 "Dummy Report 1"
{
    ApplicationArea = All;
    Caption = 'Bank Ledger Update';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = false;
    Permissions = TableData "Bank Account Ledger Entry" = rm, tabledata "Cust. Ledger Entry" = rm;
    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Payee Name/Received From" = filter(''));
            trigger OnAfterGetRecord()
            begin
                PayeeName := '';

                ReceiptHeader.Reset();
                ReceiptHeader.SetRange("No.", "Bank Account Ledger Entry"."Document No.");
                if ReceiptHeader.FindFirst() then
                    "Bank Account Ledger Entry"."Payee Name/Received From" := ReceiptHeader."Received From";


                PaymentHeader.Reset();
                PaymentHeader.SetRange("No.", "Bank Account Ledger Entry"."Document No.");
                if PaymentHeader.FindFirst() then
                    "Bank Account Ledger Entry"."Payee Name/Received From" := PaymentHeader."Payee Name";

                "Bank Account Ledger Entry".Modify();
            end;

        }
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Global Dimension 2 Code" = filter(''));
            trigger OnAfterGetRecord()
            var
                CustList: Record Customer;
            begin
                CustList.Reset();
                CustList.SetRange("No.", "Cust. Ledger Entry"."Customer No.");
                if CustList.FindFirst() then begin
                    "Cust. Ledger Entry"."Global Dimension 2 Code" := CustList."Global Dimension 2 Code";
                    "Cust. Ledger Entry".Modify();
                end;
            end;
        }

    }
    var

        ReceiptHeader: Record "Receipt Header";
        PaymentHeader: Record "Payment Header";
        PayeeName: text[250];
}