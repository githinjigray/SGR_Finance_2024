pageextension 50035 "365 Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = all;
                Importance = Promoted;
                ToolTip = 'Posting Description';
            }
        }
        addbefore("Posting Date")
        {
            field("Date Of Flight"; Rec."Date Of Flight")
            {
                ApplicationArea = all;
                ToolTip = 'Date Of Flight';
                ShowMandatory = true;
            }
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = all;
                ToolTip = 'Applies-to Doc. No.';
                ShowMandatory = true;
            }
        }
        addafter("No.")
        {
            field("Pre-Assigned No."; Rec."Pre-Assigned No.")
            {
                ApplicationArea = all;
                ToolTip = 'Pre-Assigned No.';
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = all;
                ToolTip = 'Payment Method Code';
            }
        }
        addafter(Amount)
        {
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Amount (LCY)';
            }
        }
        addafter("Amount Including VAT")
        {
            field("Amount Inc. VAT (LCY)"; Rec."Amount Inc. VAT (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Amount Inc. VAT (LCY)';
            }
        }

    }
    actions
    {
        addafter(Navigate)
        {
            action("Print Invoice")
            {
                ApplicationArea = All;
                Caption = 'Print Invoice', comment = 'ENU=Print Invoice';
                // Promoted = true;
                //PromotedCategory = Report;
                //PromotedIsBig = true;
                Image = Report2;

                trigger OnAction()
                var
                    InvoiceHeader: Record "Sales Invoice Header";
                begin
                    InvoiceHeader.RESET;
                    InvoiceHeader.SETRANGE(InvoiceHeader."No.", Rec."No.");
                    IF InvoiceHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Sales Invoice Posted", TRUE, FALSE, InvoiceHeader);
                    END;
                end;
            }
            action("Sales Invoices Statistics")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoices Statistics', comment = 'ENU=Sales Invoices Statistics';
                Image = Sales;
                RunObject = report "Sales Invoices Statistics";
            }
            action("Sales Statistics")
            {
                ApplicationArea = All;
                Caption = 'Sales Statistics', comment = 'ENU=Sales Statistics';
                Image = Sales;
                RunObject = report "Sales Statistics Report";
            }
        }
    }
}
