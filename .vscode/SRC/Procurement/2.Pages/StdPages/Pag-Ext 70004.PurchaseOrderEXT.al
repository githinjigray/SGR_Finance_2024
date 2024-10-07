pageextension 70004 "Purchase Order EXT" extends "Purchase Order"
{
    layout
    {
        addafter("Document Date")
        {
            field("Purchase Order Type"; Rec."Purchase Order Type")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Order Type';
            }
            field("Purchase Type"; Rec."Purchase Type")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Type';
            }
            field("Order From"; Rec."Order From")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Type';
            }
            field("Expense Period"; rec."Expense Period")
            {
                ApplicationArea = all;
                ToolTip = 'Bid Analysis No.';
            }
            field("PRF No."; Rec."PRF No.")
            {
                ApplicationArea = all;
                ToolTip = 'PRF No.';
            }
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = all;
                ToolTip = 'RFQ No.';
            }
            field(Comments; rec.Comments)
            {
                ApplicationArea = all;
                ToolTip = 'Comments';
            }
        }
        addbefore("Shortcut Dimension 2 Code")
        {
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Global Dimension 2 Code';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
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
        }
        addafter("Vendor Cr. Memo No.")
        {
            field(ApprovalStatus; rec.Status)
            {
                ApplicationArea = all;
                ToolTip = 'Approval Status';
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
        modify("Assigned User ID")
        {
            Visible = false;
        }

        addlast("Invoice Details")
        {
            group("Archive Details")
            {
                field("Archive Reason"; Rec."Archive Reason")
                {
                    ApplicationArea = all;
                    Caption = 'Archive Reason';
                    ShowMandatory = true;
                }
                field(Archive; Rec.Archive)
                {
                    ApplicationArea = all;
                    Caption = 'Archived';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        // modify(Release)
        // {
        //     //Visible = false;
        // }
        // modify(Reopen)
        // {
        //    // Visible = false;
        // }
        modify("Archive Document")
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                PurchaseLines: Record "Purchase Line";
            begin
                PurchaseLines.reset;
                PurchaseLines.SetRange("Document No.", Rec."No.");
                PurchaseLines.SetRange(Type, PurchaseLines.Type::"G/L Account");
                if PurchaseLines.FindSet() then begin
                    PurchaseLines.TestField(PurchaseLines."Gen. Prod. Posting Group");
                    //PurchaseLines.TestField(PurchaseLines."Shortcut Dimension 1 Code");
                    // PurchaseLines.TestField(PurchaseLines."Shortcut Dimension 2 Code");
                    // PurchaseLines.TestField(PurchaseLines."Shortcut Dimension 3 Code");
                    // PurchaseLines.TestField(PurchaseLines."Shortcut Dimension 4 Code");
                    // PurchaseLines.TestField(PurchaseLines."Shortcut Dimension 5 Code");
                end;

            end;
        }
        addbefore("Request Approval")
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
            action("Check Budget")
            {
                Caption = 'Check Budget';
                Image = CheckLedger;
                Promoted = true;
                Visible = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'This is for checking budget availablity and commit funds';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    rec.TestField(Status, rec.Status::Open);
                    if not Confirm(Text001) then exit;
                    BudgetCommitment.Reset;
                    BudgetCommitment.SetRange(BudgetCommitment."Document No.", rec."No.");
                    BudgetCommitment.SetRange("Document Type", BudgetCommitment."Document Type"::"Purchase Order");
                    if BudgetCommitment.FindSet then
                        BudgetCommitment.DeleteAll;
                    ProcurementManagement.CheckBudgetPurchaseOrder(rec."No.");
                end;
            }

            action("Cancel Budget Committment")
            {
                Caption = 'Cancel Budget Committment';
                Image = CancelAllLines;
                Promoted = true;
                Visible = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'This action is for cancelling budget committment';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    ProcurementManagement.CancelBudgetCommitmentPurchaseOrder(Rec."No.");
                    //update lines
                    PurchLine.Reset;
                    PurchLine.SetRange(PurchLine."Document No.", Rec."No.");
                    if PurchLine.FindFirst() then begin
                        repeat
                            PurchLine.Committed := false;
                            PurchLine.Modify;
                        until PurchLine.Next = 0;
                    end;
                    //end update
                end;
            }
        }
        addbefore(Dimensions)
        {
            action("View Attached Requisition")
            {
                ToolTip = 'View Attached Requisition';
                Image = GetActionMessages;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "All Purchase Requisition Lines";
                RunPageLink = "Purchase Order No." = field("No.");
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // PurchaseRequisitionLineAPP.RESET;
                    // PurchaseRequisitionLineAPP.SETRANGE("Purchase Order No.", "No.");
                    // IF PurchaseRequisitionLineAPP.FINDFIRST THEN BEGIN
                    //     PurchaseRequisitionsHEADER.RESET;
                    //     PurchaseRequisitionsHEADER.SETRANGE(PurchaseRequisitionsHEADER."No.", PurchaseRequisitionLineAPP."Document No.");

                    //     PurchaseRequisitionCard.SETTABLEVIEW(PurchaseRequisitionsHEADER);
                    //     PurchaseRequisitionCard.RUN;
                    // END;
                end;
            }
            action("View Attached Bid Analysis")
            {
                ToolTip = 'View Attached Bid Analysis';
                Image = GetActionMessages;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()

                begin
                    BidAnalysisHeader.RESET;
                    BidAnalysisHeader.SETRANGE(BidAnalysisHeader."No.", rec."Expense Period");

                    BidAnalysisCard.SETTABLEVIEW(BidAnalysisHeader);
                    BidAnalysisCard.RUN;
                end;
            }
        }
        addafter(CopyDocument)
        {
            action("Archive Documents")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Archi&ve Document';
                Image = Archive;
                ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';
                ApplicationArea = All;

                trigger OnAction()
                var

                begin
                    Rec.TestField("Archive Reason");
                    ArchiveManagement.ArchivePurchDocument(Rec);
                    Rec.Archive := true;
                    rec.Modify();
                    CurrPage.Update(false);
                    CurrPage.Close();
                end;
            }
        }
        addlast("O&rder")
        {
            action(AttachDocument)
            {
                Caption = 'Attach Document';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    DocumentAttachmentMgmt: Codeunit "Document Attachment Mgmt.";
                    DocumentAttachmentHeader: Record "Document Attachment Header";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    if Rec."Document Attachment Entry No." = 0 then begin
                        DocumentAttachmentHeader.INIT;
                        DocumentAttachmentHeader."Record Id" := Rec.RecordId;
                        DocumentAttachmentHeader."Table Id" := RecRef.Number;
                        DocumentAttachmentHeader."Document Type" := 'Purchase Order';
                        DocumentAttachmentHeader."Document No." := Rec."No.";
                        if DocumentAttachmentHeader.Insert(true) then begin
                            Rec."Document Attachment Entry No." := DocumentAttachmentHeader."Entry No.";
                            Rec.Modify(true);
                        end;
                    end;
                    //   DocumentAttachmentMgmt.UploadFileOnD365('Upload File(PDF Files Only)', '', 'PurchaseOrderDocs', Rec."Document Attachment Entry No.", RecRef);
                end;
            }
        }
    }

    var
        ArchiveManagement: Codeunit ArchiveManagement;
        ProcurementManagement: Codeunit "Procurement Management";
        BudgetCommitment: Record "Budget Committment";
        PurchLine: Record "Purchase Line";
        PurchaseRequisitionLineAPP: Record "Purchase Requisition Line";
        PurchaseRequisitionsHEADER: Record "Purchase Requisitions";
        PurchaseRequisitionCard: Page "Purchase Requisition Card";
        BidAnalysisCard: Page "Bid Analysis Card";
        BidAnalysisHeader: Record "Bid Analysis Header";
        Text001: Label 'This action will commit funds, continue?';

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
        PurchaseLine2.SETRANGE(PurchaseLine2."Document No.", Rec."No.");
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
                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                        PurchaseLine."Document No." := rec."No.";
                        PurchaseLine."Line No." := "LineNo.";
                        PurchaseLine."Buy-from Vendor No." := Rec."Buy-from Vendor No.";
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
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 1 Code");
                        PurchaseLine."Shortcut Dimension 2 Code" := SelectedPurchaseRequisitionLine."Global Dimension 2 Code";
                        PurchaseLine.VALIDATE(PurchaseLine."Shortcut Dimension 2 Code");
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
                                PurchaseRequisitionLines."Purchase Order No." := Rec."No.";
                                PurchaseRequisitionLines."Purchase Order Line" := "LineNo.";
                                PurchaseRequisitionLines.MODIFY;
                            END;
                        END;
                    UNTIL SelectedPurchaseRequisitionLine.NEXT = 0;
            END;
        END;
    end;
}