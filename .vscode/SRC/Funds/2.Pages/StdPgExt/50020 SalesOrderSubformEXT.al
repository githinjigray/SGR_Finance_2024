pageextension 50020 "Sales Order Subform EXT" extends "Sales Order Subform"
{
    layout
    {
        addbefore(Type)
        {
            field("Service Code"; Rec."Service Code")
            {
                ApplicationArea = all;
                ToolTip = 'Service Code';
            }
            field("Service Description"; Rec."Service Description")
            {
                ApplicationArea = all;
                ToolTip = 'Service Description';
            }
        }
        addafter(Description)
        {

            field("Part No."; Rec."Part No.")
            {
                    ApplicationArea = All;
                }
            field("Alternative Part No. 1"; Rec."Alternative Part No. 1")
            {
                    ApplicationArea = All;
                }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            // field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Shortcut Dimension 3 Code';
            // }
            // field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Shortcut Dimension 4 Code';
            // }
            // field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Shortcut Dimension 5 Code';
            // }
            // field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Shortcut Dimension 6 Code';
            // }
        }
    }
}
