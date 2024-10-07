pageextension 70009 PurchaseInvoiceList extends "Purchase Invoices"
{
    layout
    {
        addafter("Document Date")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                Caption='User ID';
                ToolTip = 'Shows the User ID of the person who created the invoice';
            }
        }
        modify("Assigned User ID")
        {
            Visible=false;
        }
    }
}
