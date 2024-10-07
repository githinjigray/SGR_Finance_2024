page 70013 "Bid Analysis Line"
{
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Bid Analysis Vendors";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meets Specifications"; rec."Meets Specifications")
                {
                    ApplicationArea = All;
                }
                field("Delivery/Lead Time"; rec."Delivery/Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; rec."Payment Terms")
                {
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
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

