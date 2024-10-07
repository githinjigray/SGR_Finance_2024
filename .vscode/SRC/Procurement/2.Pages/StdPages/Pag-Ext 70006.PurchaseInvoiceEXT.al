pageextension 70006 "Purchase Invoice EXT" extends "Purchase Invoice"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Global Dimension 2 Code';
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 3 Code';
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 4 Code';
            }
            field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 5 Code';
            }
            field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 6 Code';
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                ToolTip = 'User ID';
            }
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = true;
            ShowMandatory = true;
        }

    }
    actions
    {
        addbefore(SendApprovalRequest)
        {
            action(GetPurchaseRequisitionLines)
            {
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'Get Requition Lines';
                Caption = 'Get Requition Lines';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //rec.TestField("Shortcut Dimension 1 Code");
                    CurrPage.UPDATE(TRUE);
                    InsertPurchaseLinesFromPurchaseRequisitionLines;
                end;
            }
        }
    }
    procedure InsertPurchaseLinesFromPurchaseRequisitionLines();
    var
        PurchaseLine2: Record "Purchase Line";
        "LineNo.": Integer;
        RequisitionLines: page "Submitted Requisition Lines";
        Counter: Integer;
        PurchaseLine: Record "Purchase Line";
        SelectedPurchaseRequisitionLine: Record "Purchase Requisition Line";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
    begin
        //Get Last Line No.
        PurchaseLine2.RESET;
        PurchaseLine2.SETRANGE(PurchaseLine2."Document No.", rec."No.");
        PurchaseLine2.SETCURRENTKEY(PurchaseLine2."Document No.", PurchaseLine2."Line No.");
        IF PurchaseLine2.FINDLAST THEN BEGIN
            "LineNo." := PurchaseLine2."Line No.";
        END ELSE BEGIN
            "LineNo." := 1000;
        END;
        //End Get Last Line No.

        //Sysre NextGen Addon
        RequisitionLines.LOOKUPMODE(TRUE);
        IF RequisitionLines.RUNMODAL = ACTION::LookupOK THEN BEGIN
            RequisitionLines.SetSelection(SelectedPurchaseRequisitionLine);
            Counter := SelectedPurchaseRequisitionLine.COUNT;
            IF Counter > 0 THEN BEGIN
                IF SelectedPurchaseRequisitionLine.FINDSET THEN
                    REPEAT
                        "LineNo." := "LineNo." + 1;
                        PurchaseLine.INIT;
                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice;
                        PurchaseLine."Document No." := rec."No.";
                        PurchaseLine."Line No." := "LineNo.";
                        PurchaseLine."Buy-from Vendor No." := rec."Buy-from Vendor No.";
                        IF SelectedPurchaseRequisitionLine."Requisition Type" = SelectedPurchaseRequisitionLine."Requisition Type"::Service THEN BEGIN
                            PurchaseLine.Type := PurchaseLine.Type::"G/L Account";
                        END;
                        IF SelectedPurchaseRequisitionLine."Requisition Type" = SelectedPurchaseRequisitionLine."Requisition Type"::Item THEN BEGIN
                            PurchaseLine.Type := PurchaseLine.Type::Item;
                        END;
                        IF SelectedPurchaseRequisitionLine."Requisition Type" = SelectedPurchaseRequisitionLine."Requisition Type"::"Fixed Asset" THEN BEGIN
                            PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
                        END;
                        PurchaseLine.VALIDATE(PurchaseLine.Type);
                        IF SelectedPurchaseRequisitionLine."No." <> '' THEN BEGIN
                            PurchaseLine."No." := SelectedPurchaseRequisitionLine."No.";
                            PurchaseLine.VALIDATE(PurchaseLine."No.");
                        END;
                        IF SelectedPurchaseRequisitionLine."Requisition Type" = SelectedPurchaseRequisitionLine."Requisition Type"::Service THEN BEGIN
                            PurchaseLine."Gen. Bus. Posting Group" := 'LOCAL';
                            PurchaseLine."Gen. Prod. Posting Group" := 'GENERAL';
                        END;
                        PurchaseLine."Location Code" := SelectedPurchaseRequisitionLine."Location Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Location Code");
                        //PurchaseLine.Remarks := UPPERCASE(COPYSTR(SelectedPurchaseRequisitionLine.Name, 1, 250));
                        PurchaseLine.Description := UPPERCASE(COPYSTR(SelectedPurchaseRequisitionLine.Name, 1, 50));
                        PurchaseLine."Description 2" := UPPERCASE(COPYSTR(SelectedPurchaseRequisitionLine.Description, 1, 50));
                        PurchaseLine.Quantity := SelectedPurchaseRequisitionLine.Quantity;
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                        PurchaseLine."Direct Unit Cost" := SelectedPurchaseRequisitionLine."Estimated Unit Cost";
                        PurchaseLine.VALIDATE(PurchaseLine."Direct Unit Cost");
                        PurchaseLine."Shortcut Dimension 1 Code" := SelectedPurchaseRequisitionLine."Global Dimension 1 Code";
                        PurchaseLine."Shortcut Dimension 2 Code" := SelectedPurchaseRequisitionLine."Global Dimension 2 Code";
                        PurchaseLine."Shortcut Dimension 3 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 3 Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 3 Code");
                        PurchaseLine."Shortcut Dimension 4 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 4 Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 4 Code");
                        PurchaseLine."Shortcut Dimension 5 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 5 Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 5 Code");
                        PurchaseLine."Shortcut Dimension 6 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 6 Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 6 Code");
                        PurchaseLine."Shortcut Dimension 7 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 7 Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 7 Code");
                        PurchaseLine."Shortcut Dimension 8 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 8 Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 8 Code");
                        PurchaseLine."VAT Prod. Posting Group" := SelectedPurchaseRequisitionLine."VAT Prod. Posting Group";
                        PurchaseLine.VALIDATE(PurchaseLine."VAT Prod. Posting Group");
                        PurchaseLine.Remarks := SelectedPurchaseRequisitionLine.Description;
                        PurchaseLine."Responsibility Center" := SelectedPurchaseRequisitionLine."Responsibility Center";
                        PurchaseLine."Purchase Requisition Line" := SelectedPurchaseRequisitionLine."Line No.";
                        PurchaseLine."Purchase Requisition No." := SelectedPurchaseRequisitionLine."Document No.";
                        IF PurchaseLine.INSERT THEN BEGIN
                            PurchaseRequisitionLines.RESET;
                            PurchaseRequisitionLines.SETRANGE(PurchaseRequisitionLines."Line No.", SelectedPurchaseRequisitionLine."Line No.");
                            PurchaseRequisitionLines.SETRANGE(PurchaseRequisitionLines."Document No.", SelectedPurchaseRequisitionLine."Document No.");
                            PurchaseRequisitionLines.SETRANGE(PurchaseRequisitionLines."Requisition Code", SelectedPurchaseRequisitionLine."Requisition Code");
                            IF PurchaseRequisitionLines.FINDFIRST THEN BEGIN
                                PurchaseRequisitionLines.Closed := TRUE;
                                PurchaseRequisitionLines."Purchase Order No." := rec."No.";
                                PurchaseRequisitionLines."Purchase Order Line" := "LineNo.";
                                PurchaseRequisitionLines.MODIFY;
                            END;
                        END;
                    UNTIL SelectedPurchaseRequisitionLine.NEXT = 0;
            END;
        END;
    end;
}
