pageextension 70011 "Item Card EXT" extends "Item Card"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
            Visible = true;
        }

        addafter(Description)
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Location Code of an item';
            }
            field("Item G/L Budget Account"; Rec."Item G/L Budget Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item G/L Budget Account field.', Comment = '%';
            }
            
        }
    }

}
