page 70014 "Bid Analysis Items"
{
    PageType = ListPart;
    SourceTable = "Bid Analysis Items";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request for Quotation No."; REC."Request for Quotation No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Vendor No."; REC."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Vendor No."; Rec."Actual Vendor No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Actual vendor No.';
                    trigger OnValidate()
                    begin
                        REC."Vendor No." := Rec."Actual Vendor No.";
                    end;
                }
                field("Vendor Name"; REC."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Type"; REC.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; REC.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure"; REC."Unit Of Measure")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; REC."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost Incl. VAT"; rec."Unit Cost Incl. VAT")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost (LCY)"; REC."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("VAT Prod. Posting Group"; REC."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Total Cost Exc. VAT"; REC."Total Cost Exc. VAT")
                {
                    ApplicationArea = All;
                }
                field("Total Cost Exc. VAT (LCY)"; REC."Total Cost Exc. VAT (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("VAT Amount"; REC."VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Amount (LCY)"; REC."VAT Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Cost Inc. VAT"; REC."Total Cost Inc. VAT")
                {
                    ApplicationArea = All;
                }
                field("Total Cost Inc. VAT (LCY)"; REC."Total Cost Inc. VAT (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; REC.Remarks)
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

