pageextension 70013 "365 Item List" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Part No. of an item';
                ShowMandatory = true;
            }
            field("Alternative Part No. 1"; Rec."Alternative Part No. 1")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Alternative Part No. of an item';
                ShowMandatory = true;
            }
            field("Alternative Part No. 2"; Rec."Alternative Part No. 2")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Alternative Part No. of an item';
                ShowMandatory = true;
            }
            field("Alternative Part No. 3"; Rec."Alternative Part No. 3")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Alternative Part No. of an item';
                ShowMandatory = true;
            }
            field("Alternative Part No. 4"; Rec."Alternative Part No. 4")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Alternative Part No. of an item';
                ShowMandatory = true;
            }
            field("Reorder Point"; Rec."Reorder Point")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.';
                ShowMandatory = true;
            }
        }
    }
}
