pageextension 50011 "General journal Line Ext" extends "General Journal"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
            ShowMandatory = true;
        }
        addafter(Description)
        {
            field(Description2; rec.Description2)
            {
                ToolTip = 'Description 2';
                ApplicationArea = all;
            }
        }
        addafter(Comment)
        {
            field(Document_Type; rec.Document_Type)
            {
                ToolTip = 'Document_Type';
                ApplicationArea = all;
            }
            field("PAYE Name"; rec."PAYE Name")
            {
                ToolTip = 'PAYE Name';
                ApplicationArea = all;
            }
            field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
            {
                ToolTip = 'Shortcut Dimension 3 Code';
                ApplicationArea = all;
            }
            field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
            {
                ToolTip = 'Shortcut Dimension 4 Code';
                ApplicationArea = all;
            }
            field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
            {
                ToolTip = 'Shortcut Dimension 5 Code';
                ApplicationArea = all;
            }
            field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
            {
                ToolTip = 'Shortcut Dimension 6 Code';
                ApplicationArea = all;
            }
        }
    }
}
