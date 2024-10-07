page 70022 "Procurement Lookup Values"
{
    PageType = List;
    SourceTable = "Procurement Lookup Values";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Code"; rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

