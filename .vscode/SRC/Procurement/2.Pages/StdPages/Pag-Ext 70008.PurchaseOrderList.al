pageextension 70008 "Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        addafter("Document Date")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                Caption = 'User ID';
                ToolTip = 'Shows the User ID of the person who created the order';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = all;
            }
            field("Request for Quotation Code"; rec."Request for Quotation Code")
            {
                ApplicationArea = all;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Archive, false);
    end;
}
