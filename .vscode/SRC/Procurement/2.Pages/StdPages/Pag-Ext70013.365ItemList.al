pageextension 70013 "365 Item List" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Reorder Point"; Rec."Reorder Point")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.';
                ShowMandatory = true;
            }
        }
    }
}
