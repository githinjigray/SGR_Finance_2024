pageextension 50038 "365 Vendor List" extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                Visible = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Visible = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
            }
        }
    }
}
