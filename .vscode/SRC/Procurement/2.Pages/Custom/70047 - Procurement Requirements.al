page 70047 "Procurement Requirements"
{
    PageType = ListPart;
    SourceTable = "Procurement Requirements";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description field';
                }
            }
        }
    }

    actions
    {
    }
}

