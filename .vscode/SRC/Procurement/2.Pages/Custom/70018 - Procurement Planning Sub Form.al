page 70018 "Procurement Planning Sub Form"
{
    PageType = ListPart;
    SourceTable = "Procurement Planning Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Procurement Method"; rec."Procurement Method")
                {
                    ApplicationArea = All;
                }
                field("Source of Funds"; rec."Source of Funds")
                {
                    ApplicationArea = All;
                }
                field("Expected Date of Delivery"; rec."Expected Date of Delivery")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan Type"; rec."Procurement Plan Type")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan GrouTINg"; rec."Procurement Plan GrouTINg")
                {
                    ApplicationArea = All;
                }
                field("G/L Budget Line A/C"; rec."G/L Budget Line A/C")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Estimated cost"; rec."Estimated cost")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Specification Attributes")
            {
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Specifications Attributes";
                RunPageLink = "RFQ No." = FIELD("Document No."),
                              Type = FIELD("Type (Attributes)"),
                              Item = FIELD("No.");
            }
        }
    }
}

