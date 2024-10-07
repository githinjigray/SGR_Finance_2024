page 70502 "Store Requisition Line"
{
    Caption = 'Store Requisition Line';
    PageType = ListPart;
    SourceTable = "Store Requisition Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("S/No."; Rec."S/No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                    ApplicationArea = All;
                }
                field("Alternative Part No. 3"; Rec."Alternative Part No. 3")
                {
                    ToolTip = 'Specifies the value of the Alternative Part No. 3 field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the value of the Inventory field.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                    ApplicationArea = All;
                }
                field("Quantity to Issue"; Rec."Quantity to Issue")
                {
                    ToolTip = 'Specifies the value of the Quantity to Issue field.';
                    ApplicationArea = All;
                }
                field("Reason for Quantity to issue"; Rec."Reason for Quantity to issue")
                {
                    ToolTip = 'Specifies the value of the Reason for Quantity to issue field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 4 Code field.';
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ToolTip = 'Specifies the value of the Part No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alternative Part No. 1"; Rec."Alternative Part No. 1")
                {
                    ToolTip = 'Specifies the value of the Alternative Part No. 1 field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alternative Part No. 2"; Rec."Alternative Part No. 2")
                {
                    ToolTip = 'Specifies the value of the Alternative Part No. 2 field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alternative Part No. 4"; Rec."Alternative Part No. 4")
                {
                    ToolTip = 'Specifies the value of the Alternative Part No. 4 field.';
                    ApplicationArea = All;
                    Editable = false;
                }

            }

        }
    }
    actions
    {
        area(Processing)
        {
            action(ItemTrackingLines)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Item &Tracking Lines';
                Image = ItemTrackingLines;
                ShortCutKey = 'Ctrl+Alt+I';
                Enabled = rec.Type = rec.Type::Item;
                ToolTip = 'View or edit serial and lot numbers for the selected item. This action is available only for lines that contain an item.';

                trigger OnAction()
                begin
                    //Rec.OpenItemTrackingLines();
                end;
            }
        }
    }
}
