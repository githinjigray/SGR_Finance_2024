pageextension 70018 "365 Purch. Receipt Lines" extends "Purch. Receipt Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }

        }
        modify("Buy-from Vendor No.")
        {
            Visible = true;
        }
    }
}
