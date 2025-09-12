page 70005 "All Purchase Requisition Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Purchase Requisition Line";
    SourceTableView = SORTING("Document No.")
                      ORDER(Ascending);
    //
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
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
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                }
                field("Requisition Code"; Rec."Requisition Code")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Factor"; Rec."Currency Factor")
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shows the Part No. of an item';
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 5, which is one of six shortcut dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of six shortcut dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Request for Quotation No."; Rec."Request for Quotation No.")
                {
                    ApplicationArea = All;
                }
                field("Request for Quotation Line"; Rec."Request for Quotation Line")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order Line"; Rec."Purchase Order Line")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Requisition Card")
            {
                ApplicationArea = all;
                Image = PutAwayWorksheet;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Purchase Requisition Card";
                RunPageLink = "No." = field("Document No.");
            }
            action("Un-commit Requisition")
            {
                ApplicationArea = all;
                Image = AbsenceCategories;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PurchaseLine: Record "Purchase Line";
                    RFQLine: Record "Request for Quotation Line";
                begin
                    rec.TestField(Status, rec.Status::Approved);
                    if Confirm('Uncommit Requisition line from LPO/RFQ/Invoice?') then begin
                        Rec.Status := rec.Status::Approved;
                        Rec."Purchase Order Line" := 0;
                        Rec."Purchase Order No." := '';
                        Rec."Request for Quotation Line" := 0;
                        Rec."Request for Quotation No." := '';
                        Rec.Closed := false;
                        Rec.Modify();

                        //Remove from LPO/Invoice
                        // PurchaseLine.Reset();
                        // PurchaseLine.SetRange(PurchaseLine."Purchase Requisition No.", rec."Document No.");
                        // if PurchaseLine.findset() then
                        // begin
                        //     PurchaseLine."Purchase Requisition No." := '';
                        //     PurchaseLine."Purchase Requisition Line" := 0;
                        //     PurchaseLine.Modify();

                        // end;
                        //Remove from RFQ
                        RFQLine.Reset();
                        RFQLine.SetRange(RFQLine."Purchase Requisition No.", rec."Document No.");
                        if RFQLine.FindFirst() then
                            RFQLine.Delete();
                    end;
                end;
            }
            action("Mark Approved")
            {
                ApplicationArea = all;
                Image = ApplyEntries;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PurchaseRequisition: Record "Purchase Requisitions";
                begin
                    PurchaseRequisition.Reset();
                    PurchaseRequisition.SetRange(PurchaseRequisition."No.", Rec."Document No.");
                    PurchaseRequisition.SetRange(PurchaseRequisition.Status, PurchaseRequisition.Status::Approved);
                    if PurchaseRequisition.FindFirst() then begin
                        Rec.Status := PurchaseRequisition.Status::Approved;
                        Rec.Modify();
                    end
                end;
            }
            action("Un-Archive")
            {
                ApplicationArea = all;
                Image = UnLinkAccount;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if rec."Purchase Order No." <> '' then
                        Error('The requisitio has been assigned to LPO no %1', rec."Purchase Order No.");
                    if rec."Request for Quotation No." <> '' then
                        Error('The requisitio has been assigned to RFQ no %1', rec."Request for Quotation No.");
                    rec.TestField(Status, rec.Status::Closed);
                    rec.Status := rec.Status::Approved;
                    rec.Modify();
                    Message('Successfull!');

                end;
            }
        }
    }

    procedure SetSelection(var PurchaseRequisitionLine: Record "Purchase Requisition Line")
    begin
        CurrPage.SetSelectionFilter(PurchaseRequisitionLine);
    end;
}

