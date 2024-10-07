pageextension 70017 "365 Posted Purchase Credit Mem" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = all;
                ToolTip = 'Posting Description';
                ShowMandatory = true;
            }
        }
    }
}
