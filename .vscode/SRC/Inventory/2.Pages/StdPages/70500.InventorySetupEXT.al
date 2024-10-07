pageextension 70500 "Inventory Setup EXT" extends "Inventory Setup"
{
    layout
    {
        addafter("Item Nos.")
        {
            field("Stores Requisition Nos."; rec."Stores Requisition Nos.")
            {
                ApplicationArea = all;
                ToolTip = 'Stores Requisition Nos.';
            }
        }
    }
}
