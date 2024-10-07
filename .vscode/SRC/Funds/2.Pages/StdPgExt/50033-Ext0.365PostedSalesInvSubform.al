pageextension 50033 "365Posted Sales Inv. Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addbefore(Type)
        {
            field("Service Code"; Rec."Service Code")
            {
                ApplicationArea = all;
                ToolTip = 'Service Code';
                Editable = false;
            }
            field("Service Description"; Rec."Service Description")
            {
                ApplicationArea = all;
                ToolTip = 'Service Description';
                Editable = false;
            }
            field("Date Of Flight"; Rec."Date Of Flight")
            {
                ApplicationArea = all;
                ToolTip = 'Service Description';
                Editable = false;
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
