page 70002 "Purchase Requisition Line"
{
    PageType = ListPart;
    SourceTable = "Purchase Requisition Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the requisition type(Service,Item or Fixed Asset) selection for the purchase requisition line';
                }
                field("Requisition Code"; Rec."Requisition Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the requisition code lookup for the purchase requisition line, based on the requisition type selection';
                }
                field("Type"; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Name"; rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item/service/fixed asset being requisitioned';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Caption = 'Additional Remarks';
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Part No. of an item';
                    ShowMandatory = true;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the quantity of item/service/fixed asset to be purchased';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Estimated Unit Cost"; Rec."Estimated Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Estimated Unit Cost(LCY)"; Rec."Estimated Unit Cost(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost(LCY)"; Rec."Total Cost(LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {

                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Amount(LCY)"; Rec."VAT Amount(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ApplicationArea = All;
                }

                field("Alternative Part No. 1"; Rec."Alternative Part No. 1")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Alternative Part No. of an item';
                    ShowMandatory = true;
                }
                field("Alternative Part No. 2"; Rec."Alternative Part No. 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Alternative Part No. of an item';
                    ShowMandatory = true;
                }
                field("Alternative Part No. 3"; Rec."Alternative Part No. 3")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Alternative Part No. of an item';
                    ShowMandatory = true;
                }
                field("Alternative Part No. 4"; Rec."Alternative Part No. 4")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Alternative Part No. of an item';
                    ShowMandatory = true;
                }
                field("Purchase Order No."; rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request for Quotation No."; rec."Request for Quotation No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
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

