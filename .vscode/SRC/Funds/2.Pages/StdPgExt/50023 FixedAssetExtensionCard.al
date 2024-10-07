pageextension 50023 "Fixed Asset Extension Card" extends "Fixed Asset Card"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            Importance = Promoted;
        }
        addafter("FA Location Code")
        {
            field("FA Tag No."; Rec."FA Tag No.")
            {
                ApplicationArea = All;
                ToolTip = 'FA Tag No.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Global Dimension 1 Code';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Global Dimension 2 Code';
            }
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

        addafter("Last Date Modified")
        {

            field("FA Creation Date"; Rec."FA Creation Date")
            {
                ApplicationArea = all;
                ToolTip = 'FA Creation Date';
            }
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = all;
                ToolTip = 'Created By';
            }

        }

    }

}


