page 70021 "Specifications Attributes"
{
    PageType = List;
    SourceTable = "Specification Attributes";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Specification; rec.Specification)
                {
                    ApplicationArea = All;
                }
                field(Requirement; rec.Requirement)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

