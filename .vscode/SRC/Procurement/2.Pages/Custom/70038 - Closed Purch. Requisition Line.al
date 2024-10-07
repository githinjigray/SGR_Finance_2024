page 70038 "Closed Purch. Requisition Line"
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
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the requisition type(Service,Item or Fixed Asset) selection for the purchase requisition line';
                }
                field("Requisition Code"; Rec."Requisition Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the requisition code lookup for the purchase requisition line, based on the requisition type selection';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the description of the item/service/fixed asset being requisitioned';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Additional Remarks';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Specifies the Inventory field';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the quantity of item/service/fixed asset to be purchased';
                    ShowMandatory = true;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the Unit of Measure field';
                }
                field("Estimated Unit Cost"; Rec."Estimated Unit Cost")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the Estimated Unit cost field';
                }
                field("Estimated Unit Cost(LCY)"; Rec."Estimated Unit Cost(LCY)")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the Estimated Unit Cost(LCY) field';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the Total Cost field';
                }
                field("Total Cost(LCY)"; Rec."Total Cost(LCY)")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the Total Cost(LCY) field';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Purchase Order No.';
                }
                field("Request for Quotation No."; Rec."Request for Quotation No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Request for Quotation No.';
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
                // PromotedCategory = Process;
                RunObject = Page "Specifications Attributes";
                RunPageLink = "RFQ No." = FIELD("Document No."),
                              Type = FIELD("Type (Attributes)"),
                              Item = FIELD("No.");
            }
        }
    }
}

