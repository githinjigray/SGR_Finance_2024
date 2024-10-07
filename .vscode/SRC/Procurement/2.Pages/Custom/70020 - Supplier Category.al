page 70020 "Supplier Category"
{
    ApplicationArea = all;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Supplier Category";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Category"; rec."Supplier Category")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; rec."Category Description")
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

