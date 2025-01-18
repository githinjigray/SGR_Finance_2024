pageextension 70613 "365 Company Information" extends "Company Information"
{
    layout
    {
        addbefore("Home Page")
        {

            field(Website; Rec.Website)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Website field.', Comment = '%';
            }
        }
    }
}
