pageextension 50022 "Sales Invoice Subform EXT" extends "Sales Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
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
        addafter("Line Amount")
        {
            field("Date Of Flight"; Rec."Date Of Flight")
            {
                ApplicationArea = all;
                ToolTip = 'Date Of Flight';
                ShowMandatory = true;
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
