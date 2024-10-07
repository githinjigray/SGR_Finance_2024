pageextension 70001 "PurchaseQuotes-EXT" extends "Purchase Quote"
{
    layout
    {
    
        addafter("Buy-from Vendor Name")
        {
            field("Request for Quotation Code"; rec."Request for Quotation Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
