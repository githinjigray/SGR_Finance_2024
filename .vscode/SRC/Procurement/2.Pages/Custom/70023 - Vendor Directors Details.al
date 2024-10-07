page 70023 "Vendor Directors Details"
{
    PageType = ListPart;
    SourceTable = "Vendor Directors Details";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Director Name"; rec."Director Name")
                {
                    ApplicationArea = All;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("ID/Passport No."; rec."ID/Passport No.")
                {
                    ApplicationArea = All;
                }
                field(Nationality; rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field("If Other, Nationality"; rec."If Other, Nationality")
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

