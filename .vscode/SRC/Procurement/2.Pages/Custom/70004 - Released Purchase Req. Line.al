page 70004 "Released Purchase Req. Line"
{
    Caption = 'Released Purchase Requisition Line';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    ShowFilter = false;
    SourceTable = "Purchase Requisition Line";
    SourceTableView = SORTING("Document No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Approved),
                            Closed = CONST(false),
                            "Purchase Order No." = CONST(''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase requisition unique number';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee Number")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Names")
                {
                    ApplicationArea = All;
                }

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase type, G/L Account/Item/Fixed Asset/Charge(Item)';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item/service/fixed asset being requisitioned';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location for the item on the purchase requisition line';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase unit of measure for the item selected on the purchase requisition line';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the quantity of item/service/fixed asset to be purchased';
                }
                field("Unit Cost"; Rec."Estimated Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Cost';
                    ToolTip = 'Specifies the cost of one unit of the item/service/fixed asset';
                }
                field("Unit Cost(LCY)"; Rec."Estimated Unit Cost(LCY)")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Cost(LCY)';
                    ToolTip = 'Specifies the cost of one unit of the item/service/fixed asset in the company''s local currency';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total cost of all the quantity of the item/service/fixed asset, i.e. unit cost * quantity';
                }
                field("Total Cost(LCY)"; Rec."Total Cost(LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total cost of all the quantity of the item/service/fixed asset in the company''s local currency, i.e. unit cost(LCY)* quantity';
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Part No. of an item';
                    ShowMandatory = true;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }                
                
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 3, which is one of six shortcut dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 4, which is one of six shortcut dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 5, which is one of six shortcut dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of six shortcut dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase requisition line approval status, i.e. Open/Pending Approval/Released/Rejected/Closed';
                }
                field("Request for Quotation No."; Rec."Request for Quotation No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    procedure SetSelection(var PurchaseRequisitionLine: Record "Purchase Requisition Line")
    begin
        CurrPage.SetSelectionFilter(PurchaseRequisitionLine);
    end;
}

