pageextension 50021 "Sales Invoice EXT" extends "Sales Invoice"
{
    layout
    {
        modify("Posting Description")
        {
            Importance = Promoted;
            ShowMandatory = true;
            Visible = true;
            ApplicationArea = all;
        }
        addbefore("Posting Date")
        {
            field("Date Of Flight"; Rec."Date Of Flight")
            {
                ApplicationArea = all;
                ToolTip = 'Date Of Flight';
                ShowMandatory = true;
                Visible = false;

            }
        }

        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 3 Code';
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 4 Code';
            }
            field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 5 Code';
            }
            field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 6 Code';
            }
        }
        modify("Payment Method Code")
        {
            Importance = Promoted;
        }
    }
}
