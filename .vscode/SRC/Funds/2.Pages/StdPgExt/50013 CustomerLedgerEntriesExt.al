pageextension 50013 "Customer Ledger Entries Ext " extends "Customer Ledger Entries"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;

        }
        addafter(Description)
        {
            field(Description2; rec.Description2)
            {
                ApplicationArea = all;
                ToolTip = 'Description 2';
            }
        }
        addafter("Reversed Entry No.")
        {
            field(Document_Type; rec.Document_Type)
            {
                ApplicationArea = all;
                ToolTip = 'Document_Type';
            }
            field("Transaction Code"; rec."Transaction Code")
            {
                ApplicationArea = all;
                ToolTip = 'Transaction Code';
            }

        }
    }
}
