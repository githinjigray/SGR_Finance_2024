pageextension 50034 "365 Possted Sales Inv." extends "Posted Sales Invoice"
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
                Visible = false;
            }
        }
    }
    actions
    {
        addafter(Print)
        {
            action("Print Invoice")
            {
                ApplicationArea = All;
                Caption = 'Print Invoice', comment = 'ENU=Print Invoice';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report2;
                Ellipsis = true;

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
        }

    }
}
