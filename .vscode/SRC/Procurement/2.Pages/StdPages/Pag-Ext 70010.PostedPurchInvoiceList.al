pageextension 70010 PostedPurchInvoiceList extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {
            field("Pre-Assigned No."; Rec."Pre-Assigned No.")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Pre-Assigned No. of the invoice';
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                Caption = 'User ID';
                ToolTip = 'Shows the User ID of the person who created the invoice';
            }
        }
    }
}
