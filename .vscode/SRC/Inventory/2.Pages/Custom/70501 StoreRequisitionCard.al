page 70501 "Store Requisition Card"
{
    Caption = 'Store Requisition Card';
    PageType = Card;
    SourceTable = "Store Requisition Header";
    DeleteAllowed = false;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = RequisitionEditable;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ToolTip = 'Specifies the value of the Required Date field.';
                    ApplicationArea = All;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    ToolTip = 'Specifies the value of the Requester ID field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
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
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the value of the Job No. field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
                }

                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
            }
            part(StoreRequisitionLine; "Store Requisition Line")
            {
                Caption = 'Store Requisition Line';
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Post Store Requisition")
            {
                ApplicationArea = All;
                Caption = 'Post Store Requisition';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec, TRUE);
                    rec.TESTFIELD(Status, rec.Status::Approved);
                    IF InventoryUserSetup.GET(USERID) THEN BEGIN
                        InventoryUserSetup.TESTFIELD(InventoryUserSetup."Item Journal Template");
                        InventoryUserSetup.TESTFIELD(InventoryUserSetup."Item Journal Batch");
                        JTemplate := InventoryUserSetup."Item Journal Template";
                        JBatch := InventoryUserSetup."Item Journal Batch";
                        InventoryManagement.PostStoreRequisition(Rec, JTemplate, JBatch);
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }
            action("Portal Document Attachments")
            {
                Image = MakeDiskette;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page PortalDocuments;
                RunPageLink = "DocumentNo." = FIELD("No.");
            }
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
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("Print Store Requisition")
            {
                Caption = 'Print Store Requisition';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    StoreRequest.Reset;
                    StoreRequest.SetRange(StoreRequest."No.", Rec."No.");
                    if StoreRequest.FindFirst then begin
                        REPORT.RunModal(REPORT::"Store Requisition", true, false, StoreRequest);
                    end;
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals', comment = 'ENU="Approvals"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                RunObject = page "Approval Entries";
                RunPageLink = "Document No." = field("No.");
                trigger OnAction()
                begin

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request', comment = 'ENU="Send Approval Request"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendApprovalRequest;

                trigger OnAction()
                begin
                    rec.TESTFIELD(Status, rec.Status::Open);
                    InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec, FALSE);

                    IF ApprovalsMgmt.CheckStoreRequisitionApprovalWorkflowEnabled(Rec) THEN
                        ApprovalsMgmt.OnSendStoreRequisitionForApproval(Rec);
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request', comment = 'ENU="Cancel Approval Request"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CancelApprovalRequest;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelStoreRequisitionForApproval(Rec);
                    WorkflowWebhookMgt.FindAndCancel(rec.RECORDID);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = All;
                Caption = 'Re-Open', comment = 'ENU="Re-Open"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReOpen;

                trigger OnAction()
                begin
                    rec.TestField(rec.Status, rec.Status::Approved);
                    rec.TestField(Posted, false);
                    IF CONFIRM('Re-Open Document?') THEN BEGIN
                        rec.Status := rec.Status::Open;
                        rec.Modify();
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
    var
        InventoryManagement: Codeunit "Inventory Management";
        ApprovalsMgmt: Codeunit "Store Requisition Approval";
        InventoryUserSetup: Record "Inventory User Setup";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        CreateIncomingDocumentEnabled: Boolean;
        StoreRequest: Record "Store Requisition Header";
        JTemplate: code[20];
        JBatch: code[20];
        Txt_001: TextConst ENU = 'User %1 is not setup for Inventory Posting. Contact System Administrator';
        ReOpenStoreRequisition: TextConst ENU = 'Reopen Store Requisition No.%1, the Status will be changed to Open. Continue?';
        RequisitionEditable: Boolean;

    trigger OnOpenPage()
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Posted) or (Rec.Status = Rec.Status::"Pending Approval") then
            RequisitionEditable := false
        else
            RequisitionEditable := true;
    end;
}
