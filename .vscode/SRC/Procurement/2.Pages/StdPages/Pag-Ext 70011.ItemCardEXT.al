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
        }
    }

}
