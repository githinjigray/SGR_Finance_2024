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
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
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
                field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
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

