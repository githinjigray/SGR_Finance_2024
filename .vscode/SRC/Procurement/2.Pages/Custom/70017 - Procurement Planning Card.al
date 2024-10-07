page 70017 "Procurement Planning Card"
{
    //DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgeting,Category6_caption,Category7_caption,RequestToApprove,Category9_caption,Category10_caption';
    SourceTable = "Procurement Planning Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Budget; rec.Budget)
                {
                    ApplicationArea = All;
                }
                field("From Date"; rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; rec."To Date")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Purchase Planning Sub Form"; "Procurement Planning Sub Form")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
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
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';
            }
            action("Planning Lines Attributes")
            {
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Procurement Planning Sub Form";
                RunPageLink = "Document No." = FIELD("No.");
            }
            group("Request Approval")
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
                    RunObject = Page "Approval Entries-Modified";
                    RunPageLink = "Document No." = FIELD("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Receipt Header","Document Type","No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Open);

                        /*CALCFIELDS("Budget Amount");
                        
                        ProcurementPlanningLine.RESET;
                        ProcurementPlanningLine.SETRANGE(ProcurementPlanningLine."Document No.","No.");
                        ProcurementPlanningLine.CALCSUMS("Estimated cost");
                        AmountAssigned:=ProcurementPlanningLine."Estimated cost";
                        
                        IF "Budget Amount" >  AmountAssigned THEN
                          ERROR(Text047);
                        
                        IF "Budget Amount" < AmountAssigned THEN
                          ERROR(Text048);*/


                        //Send Approval Request
                        if ProcurementPlanningApproval.CheckProcurementPlanApprovalWorkflowEnabled(Rec) then
                            ProcurementPlanningApproval.OnSendProcurementPlanForApproval(Rec);

                        CurrPage.Close

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
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::"Pending Approval");

                        ProcurementPlanningApproval.OnCancelProcurementPlanForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                action("Procurement Planning")
                {
                    Caption = 'Procurement Planning';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        ProcurementPlanningHeader.Reset;
                        ProcurementPlanningHeader.SetRange(ProcurementPlanningHeader."No.", Rec."No.");
                        if ProcurementPlanningHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Procurement Planning", true, false, ProcurementPlanningHeader);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if rec.Status <> rec.Status::Open then
            CurrPage.Editable(false);
    end;

    var
        Txt_001: Label 'User %1 is not setup for Inventory Posting. Contact System Administrator';
        Text046: Label 'The %1 does not match the quantity defined in item tracking.';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        ProcurementPlanningLine: Record "Procurement Planning Line";
        AmountAssigned: Decimal;
        Text047: Label 'Amount broken down in the Procurement planning lines is LESS than the budget line amount. The figures should be equal';
        Text048: Label 'Amount broken down in the Procurement planning lines is MORE than the budget line amount. The figures should be equal';
        ProcurementApprovalManager: Codeunit "Procurement Approval Manager";
        ProcurementPlanningApproval: Codeunit "Procurement Planning Approval";

    procedure UpdateControls()
    begin
    end;

    procedure CurrPageUpdate()
    begin
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
    end;
}

