page 70048 "Submitted Requisition Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Purchase Requisition Line";
    SourceTableView = SORTING("Document No.") ORDER(Ascending) WHERE(Closed = CONST(false), "Purchase Order No." = CONST(''));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Document No. field';
                }
                field("Document Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
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

                field("Requisition Type"; rec."Requisition Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Requisition Type field';
                }
                field("Requisition Code"; rec."Requisition Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Requisition Code field';
                }
                field("Type"; rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Type field';
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies No. field';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Name field';
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Part No. field';
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Quantity field';
                }                
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Location Code field';
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit of measure field';
                }

                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Currency Code field';
                }
                field("Currency Factor"; rec."Currency Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Currency factor field';
                }
                field("Estimated Unit Cost"; rec."Estimated Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Estimated Unit cost field';
                }
                field("Estimated Unit Cost(LCY)"; rec."Estimated Unit Cost(LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Estimated unit cost(LCY) field';
                }
                field("Total Cost"; rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Total cost field';
                }
                field("Total Cost(LCY)"; rec."Total Cost(LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Total cost(LCY) field';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description field';
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Global Dimesion 2 Code field';
                }
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dimension 3 Code field';
                }
                field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dimension 4 Code field';
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Responsibility Centre field';
                }
                field("Request for Quotation No."; rec."Request for Quotation No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Request for Quotation No. field';
                }
                field("Request for Quotation Line"; rec."Request for Quotation Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Request for Quotation line field';
                }
                field("Purchase Order No."; rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Purchase Order No. field';
                }
                field("Purchase Order Line"; rec."Purchase Order Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Purchase Order Line field';
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Status field';
                }
                field(Closed; rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the closed field';
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User ID field';
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

