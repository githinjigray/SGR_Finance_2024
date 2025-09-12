page 70000 "Purchase Requisition Card"
{
    PageType = Card;
    SourceTable = "Purchase Requisitions";
    DeleteAllowed = false;
    ApplicationArea = all;
    PromotedActionCategoriesML = ENU = 'New,Process,Reports,Details,Budgeting,Attachments,Category7_caption,Approvals,Category9_caption,Category10_caption,Category11_caption,Category12_caption,Category13_caption,Category14_caption,Category15_caption,Category16_caption,Category17_caption,Category18_caption,Category19_caption,Category20_caption';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = RequisitionEditableG;
                field("No."; rec."No.")
                {
                    ToolTip = 'Specifies the unique document number for the purchase requisition';
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the date when the purchase requisition was created';
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date when the user expects to receive the items on the purchase requisition';
                    ApplicationArea = All;
                }
                field("Employee No."; rec."Employee No.")
                {
                    ToolTip = 'Specifies the Employee number of the requester';
                    ApplicationArea = All;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ToolTip = 'Specifies the Employee name of the requester';
                    ApplicationArea = All;
                }
                field("Requisition Type"; rec."Requisition Type")
                {
                    ToolTip = 'Specifies the Requisition Type';
                    ApplicationArea = All;
                }
                field("Purchase Type"; rec."Purchase Type")
                {
                    ToolTip = 'Specifies the Purchase Type';
                    ApplicationArea = All;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency used for the amounts on the purchase requisition';
                    ApplicationArea = All;
                }
                field("Reference Document No."; rec."Reference Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
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
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; rec."Amount(LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT Amount"; rec."VAT Amount")
                {
                    ApplicationArea = All;

                }
                field("VAT Amount(LCY)"; rec."VAT Amount(LCY)")
                {
                    ApplicationArea = All;

                }
                field("Total Amount"; rec."Total Amount")
                {
                    Editable = false;

                    ApplicationArea = All;
                }
                field("Total Amount(LCY)"; rec."Total Amount(LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the description for the purchase requisition';
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the approval status for the purchase requisition';
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the user who created the purchase requisition';
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the user who has been assigned the purchase requisition';
                }

            }
            part("Purchase Requisition Line"; "Purchase Requisition Line")
            {
                ApplicationArea = All;
                Caption = 'Purchase Requisition Line';
                SubPageLink = "Document No." = FIELD("No.");
                Editable = RequisitionEditableG;
            }

            part("Purchase Req. Assignments"; "Purchase Req. Assignments")
            {
                ApplicationArea = All;
                Caption = 'Purchase Requisition Assignments';
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control52; Links)
            {
                ApplicationArea = RecordLinks;
            }

            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusG;
            }
        }
    }

    actions
    {
        area(processing)
        {
            /*   action("Portal Document Attachments")
              {
                  Image = MakeDiskette;
                  Promoted = true;
                  PromotedCategory = Category6;
                  PromotedIsBig = true;
                  RunObject = Page PortalDocuments;
                  RunPageLink = "DocumentNo." = FIELD("No.");
              } */
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetailsL: Page "Document Attachment Details";
                    RecRefL: RecordRef;
                begin
                    RecRefL.GetTable(Rec);
                    DocumentAttachmentDetailsL.OpenForRecRef(RecRefL);
                    DocumentAttachmentDetailsL.RunModal();
                end;
            }
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                begin
                    REC.TestField(Status, REC.Status::Approved);
                    if Confirm(Txt_003, false, rec."No.") then begin
                        REC.Status := REC.Status::Open;
                        rec.Modify;
                    end;

                end;
            }
            action("Requisition Lines Specifications")
            {
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Requisition Line";
                RunPageLink = "Document No." = FIELD("No.");
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = page "Approval Entries-Modified";
                    RunPageLink = "Document No." = field("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBufferL: Record "Workflows Entries Buffer";
                        DocTypeL: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Purchase Requisitions", DocType::" ", "No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExistG AND CanRequestApprovalForFlowG;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        REC.TestField(Status, rec.Status::Open);
                        ProcurementManagementG.CheckPurchaseRequisitionMandatoryFields(Rec);

                        if PurchaseRequisitionApprovalG.CheckPurchaseRequisitionApprovalWorkflowEnabled(Rec) then
                            PurchaseRequisitionApprovalG.OnSendPurchaseRequisitionForApproval(Rec);
                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        PurchaseRequisitionHeaderG.Reset;
                        PurchaseRequisitionHeaderG.SetRange(PurchaseRequisitionHeaderG."No.", Rec."No.");
                        if PurchaseRequisitionHeaderG.FindFirst then begin
                            REPORT.RunModal(REPORT::"Dummy Report 3", false, false, PurchaseRequisitionHeaderG);
                        end;

                        Commit();

                        PurchaseRequisitionApprovalG.OnCancelPurchaseRequisitionForApproval(Rec);
                        WorkflowWebhookMgtG.FindAndCancel(Rec.RecordId);

                        //CanCancelApprovalForRecord OR CanCancelApprovalForFlow
                    end;
                }
                action("Budget Committment Lines")
                {
                    Image = BinJournal;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Budget Committment Lines";
                    RunPageLink = "Document No." = FIELD("No.");
                    Visible = false;
                }
                group(Budgets)
                {
                    Caption = 'Budgets';
                    action("Check Budget Availability")
                    {
                        Caption = 'Check Budget Availability';
                        Image = CheckLedger;
                        Promoted = true;
                        PromotedCategory = Category5;
                        PromotedIsBig = true;
                        Visible = true;
                        trigger OnAction()
                        begin
                            BudgetarySetupG.reset;
                            BudgetarySetupG.FindFirst;

                            if not BudgetarySetupG.Mandatory then
                                exit;

                            if REC.Status = REC.Status::Approved then
                                Error(Text001);

                            if not Confirm(Text002) then
                                exit;

                            BudgetCommitmentG.Reset;
                            BudgetCommitmentG.SetRange(BudgetCommitmentG."Document No.", Rec."No.");
                            if BudgetCommitmentG.FindSet then
                                BudgetCommitmentG.DeleteAll;

                            ProcurementManagementG.CheckBudgetPurchaseRequisition(Rec."No.");
                            Message(Text004);
                        end;
                    }
                    action("Cancel Budget Commitment")
                    {
                        Caption = 'Cancel Budget Commitment';
                        Image = CancelAllLines;
                        Promoted = true;
                        PromotedCategory = Category5;
                        PromotedIsBig = true;
                        Visible = true;

                        trigger OnAction()
                        begin
                            if not Confirm(Text005) then
                                Error(Text006);

                            ProcurementManagementG.CancelBudgetCommitmentPurchaseRequisition(Rec."No.");

                            PurchLineG.Reset;
                            PurchLineG.SetRange(PurchLineG."Document No.", Rec."No.");
                            if PurchLineG.Find('-') then begin
                                repeat
                                    PurchLineG.Committed := false;
                                    PurchLineG.Modify;
                                until PurchLineG.Next = 0;
                            end;

                            Message(Text007, Rec."No.");
                        end;
                    }
                    action("Budget Commitment")
                    {
                        Caption = 'View Budget Commitment';
                        Image = LedgerBudget;
                        RunObject = page "Budget Committment Lines";
                        Promoted = true;
                        PromotedCategory = Category5;
                        PromotedIsBig = true;
                        Visible = true;
                    }

                }
                action("Archive Requisition")
                {
                    Caption = 'Archive Requisition';
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm(Text009) then begin
                            rec.Status := rec.Status::Closed;

                            if rec.Modify then begin
                                PurchaseRequisitionLineG.Reset;
                                PurchaseRequisitionLineG.SetRange(PurchaseRequisitionLineG."Document No.", Rec."No.");
                                if PurchaseRequisitionLineG.FindSet then begin
                                    repeat
                                        PurchaseRequisitionLineG.Status := PurchaseRequisitionLineG.Status::Closed;
                                        PurchaseRequisitionLineG.Archived := true;
                                        PurchaseRequisitionLineG.Modify;
                                    until PurchaseRequisitionLineG.Next = 0;
                                end;
                            end;
                        end;
                        CurrPage.Close;
                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Purchase Requisition")
                {
                    Caption = 'Print Purchase Requisition';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        PurchaseRequisitionHeaderG.Reset;
                        PurchaseRequisitionHeaderG.SetRange(PurchaseRequisitionHeaderG."No.", Rec."No.");
                        if PurchaseRequisitionHeaderG.FindFirst then begin
                            REPORT.RunModal(REPORT::"Purchase Requisition", true, false, PurchaseRequisitionHeaderG);
                        end;
                    end;
                }
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocumentG;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                    trigger OnAction()
                    var
                        IncomingDocumentL: Record "Incoming Document";
                    begin
                        //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Suite;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocumentL: Record "Incoming Document";
                    begin
                        //VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.",RECORDID));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = CreateIncomingDocumentEnabledG;
                    Image = Attach;
                    ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachmentL: Record "Incoming Document Attachment";
                    begin
                        //IncomingDocumentAttachment.NewAttachmentFromPurchaseRequisitionDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocumentG;
                    Image = RemoveLine;
                    ToolTip = 'Remove any incoming document records and file attachments.';

                    trigger OnAction()
                    var
                        IncomingDocumentL: Record "Incoming Document";
                    begin
                        if IncomingDocumentL.Get(Rec."Incoming Document Entry No.") then
                            IncomingDocumentL.RemoveLinkToRelatedRecord;
                        rec."Incoming Document Entry No." := 0;
                        rec.Modify(true);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUserG;

                    trigger OnAction()
                    var
                        ApprovalsMgmtL: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmtL.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUserG;

                    trigger OnAction()
                    var
                        ApprovalsMgmtL: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmtL.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUserG;

                    trigger OnAction()
                    var
                        ApprovalsMgmtL: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmtL.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        //CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
        //ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);

        IF rec.Status = rec.Status::Approved THEN BEGIN
            RequisitionEditableG := false;
            IsEditableG := true
        END ELSE BEGIN
            IsEditableG := true;
            RequisitionEditableG := true;
        END;
        if rec.Status = rec.Status::Closed then
            IsEditableG := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*PurchaseRequisitionHeader.RESET;
        PurchaseRequisitionHeaderG.SETRANGE("User ID",USERID);
        PurchaseRequisitionHeaderG.SETRANGE(Status,PurchaseRequisitionHeaderG.Status::Open);
        IF PurchaseRequisitionHeaderG.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */

    end;

    trigger OnOpenPage()
    begin
        IF rec.Status = rec.Status::Approved THEN BEGIN
            RequisitionEditableG := false;
            IsEditableG := true
        END ELSE BEGIN
            IsEditableG := true;
            RequisitionEditableG := true;
        END;
        if rec.Status = rec.Status::Closed then
            IsEditableG := false;

    end;

    var
        Txt_002: Label 'There is an open purchase requisition under your name, use it before you create a new one';
        Txt_003: Label 'Reopen Purchase Requisition No.:%1. All approval requests for this document will be cancelled. Continue?';
        Text001: Label 'This document has already been released. This functionality is available for open documents only';
        Text002: Label 'Do you want to continue with the commitment?';
        Text003: Label 'Budget Availability Check and Commitment Aborted';
        Text004: Label 'Budget Availability Checking Complete';
        Text005: Label 'Are you sure you want to Cancel All Commitments Done for this document';
        Text006: Label 'Budget Availability Check and Commitment Aborted';
        Text007: Label 'Commitments Cancelled Successfully for Doc. No %1';
        Text008: Label 'Check Budget Availability Before Sending for Approval.';
        Error0001: Label 'Document is under Approval Process, Cancel Approval instead!';
        ApprovalsMgmtG: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgtG: Codeunit "Workflow Webhook Management";
        ProcurementApprovalWorkflowG: Codeunit "Procurement Approval Manager";
        PurchaseRequisitionHeaderG: Record "Purchase Requisitions";
        DocumentTypeG: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
        OpenApprovalEntriesExistForCurrUserG: Boolean;
        OpenApprovalEntriesExistG: Boolean;
        CanRequestApprovalForFlowG: Boolean;
        RequisitionEditableG: Boolean;
        CanCancelApprovalForRecordG: Boolean;
        CanCancelApprovalForFlowG: Boolean;
        HasIncomingDocumentG: Boolean;
        CreateIncomingDocumentEnabledG: Boolean;
        ShowWorkflowStatusG: Boolean;
        IsEditableG: Boolean;
        BudgetarySetupG: Record "Budget Control Setup";
        BudgetCommitmentG: Record "Budget Committment";
        ProcurementManagementG: Codeunit "Procurement Management";
        SomeLinesCommittedG: Boolean;
        PurchLineG: Record "Purchase Requisition Line";
        PurchaseRequisitionApprovalG: Codeunit "Purchase Requisition Approval";
        PurchaseRequisitionLineG: Record "Purchase Requisition Line";
        Text009: Label 'Are you sure you want to ARCHIVE the requisition?';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmtL: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgtL: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocumentG := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabledG := (not HasIncomingDocumentG) and (Rec."No." <> '');

        OpenApprovalEntriesExistForCurrUserG := ApprovalsMgmtL.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExistG := ApprovalsMgmtL.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecordG := ApprovalsMgmtL.CanCancelApprovalForRecordG(Rec.RecordId);

        WorkflowWebhookMgtL.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlowG, CanCancelApprovalForFlowG);


        IF rec.Status = rec.Status::Approved THEN BEGIN
            RequisitionEditableG := false;
            IsEditableG := true
        END ELSE BEGIN
            IsEditableG := true;
            RequisitionEditableG := true;
        END;
        if rec.Status = rec.Status::Closed then
            IsEditableG := false;

    end;

    procedure CheckIfSomeLinesCommitted(PurchReqNo: Code[20]) SomeLinesCommittedG: Boolean
    begin
        SomeLinesCommittedG := false;
        PurchLineG.Reset;
        PurchLineG.SetRange("Document No.", PurchReqNo);
        if PurchLineG.FindSet then begin
            repeat
                if PurchLineG.Committed = true then
                    SomeLinesCommittedG := true;
            until PurchLineG.Next = 0;
        end;
    end;
}

