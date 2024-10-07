pageextension 50027 "Requests to Approve EXT" extends "Requests to Approve"
{
    layout
    {
        addafter(Details)
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = alll;
                ToolTip = 'Additional detailes on what is to be approved';
            }
        }
    }
}
