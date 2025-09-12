page 70008 "Request for Quotation Line"
{
    PageType = ListPart;
    SourceTable = "Request for Quotation Line";
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
                    ToolTip = 'Specifies the field name';
                }
                field("Requisition Code"; Rec."Requisition Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                }
                field("Total Cost"; rec."Total Cost")
                {
                    ApplicationArea = All;
                }
                //
                field("Total Cost(LCY)"; rec."Total Cost(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Part No. of an item';
                    ShowMandatory = true;
                }                
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
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
                field("Purchase Requisition No."; rec."Purchase Requisition No.")
                {
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

