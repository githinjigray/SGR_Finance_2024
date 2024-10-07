pageextension 70501 "Inventory Posting Group EXT" extends "Inventory Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field("Budget G/L Account"; rec."Budget G/L Account")
            {
                ApplicationArea = all;
                ToolTip = 'Budget G/L Account';
            }
        }
    }
}
