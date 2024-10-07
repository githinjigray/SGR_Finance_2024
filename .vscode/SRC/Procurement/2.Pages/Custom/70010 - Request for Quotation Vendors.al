page 70010 "Request for Quotation Vendors"
{
    PageType = List;
    SourceTable = "Request for Quotation Vendors";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor Code"; rec."Vendor Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Not listed Vendor"; rec."Not listed Vendor")
                {
                    ApplicationArea = All;
                }
                field("Vendor Email Address"; rec."Vendor Email Address")
                {
                    ApplicationArea = All;
                }
                field("Send Email"; rec."Send Email")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Mail: Record "Request for Quotation Vendors";
}

