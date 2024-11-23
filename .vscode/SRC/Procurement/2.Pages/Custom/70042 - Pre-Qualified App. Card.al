page 70042 "Pre-Qualified App. Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgeting,Category6_caption,Category7_caption,RequestToApprove,Category9_caption,Category10_caption';
    SourceTable = "Prequlification Application";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Document No. field';
                    Editable = false;
                }
                field("Supplier Name"; rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Supplier Name field';

                }
                field("Procurement Period"; rec."Procurement Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Procurement Period field';

                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Vendor No. field';
                    Editable = false;
                }
                field(Prequalified; rec.Prequalified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Prequalified field';
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Status field';
                }
            }
            group(Communication)
            {
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the E-Mail field';
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Phone No. field';

                }
                field("Principal Phone No."; rec."Principal Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Principal Phone No. field';
                }
                field("TIN No."; rec."TIN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the TIN No. field';
                }
                field("Postal Address"; rec."Postal Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Postal Address field';
                }
                field("Postal Code"; rec."Postal Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Postal Code field';
                }
                field(City; rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the City field';
                }
                field("Building Name"; rec."Building Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Building Name field';
                }
                field(Street; rec.Street)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Street field';
                }
                field(County; rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the County field';
                }
                field("County Name"; rec."County Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the County Name field';
                }
            }
            group("Company Details")
            {
                field(AGPO; rec.AGPO)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AGPO Status field';
                }
                field("AGPO Number"; rec."AGPO Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AGPO No. field';
                }
                field("Incorporation Cert. No."; rec."Incorporation Cert. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Incorporation Cert. No. field';
                }
                field("Incorporation Date"; rec."Incorporation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Incorporation date field';
                }
                field("Vendor Declaration Submitted"; rec."Vendor Declaration Submitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Vendor declaration submitted field';
                }
                field("Bank Code"; rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Code field';
                }
                field("Bank Name"; rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Name field';
                }
                field("Bank Branch Code"; rec."Bank Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Branch Code field';
                }
                field("Bank Branch Name"; rec."Bank Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Branch Name field';
                }
                field("Bank Account Name"; rec."Bank Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Account Name field';
                }
                field("Bank Account No."; rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Account No. field';
                }
                field("VAT Registered"; rec."VAT Registered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT Registred Staus field';
                }
                field("VAT Registration No."; rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT Registration No. field';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Links)
            {
            }
            systempart(Control8; Notes)
            {
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
            action("Pre-Qualify Supplier")
            {
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GetMandatoryFields;

                    Rec.TestField(Status, Rec.Status::Approved);

                    if Confirm(Txt0001) then begin
                        ProcurementManagement.PrequalifyVendor(rec."Supplier Name");
                        Rec.Prequalified := true;
                        Rec."Pre-Qualified By" := UserId;
                        Rec."Date Pre-Qualified" := Today;
                        Message(Txt0002);
                        CurrPage.Close;
                    end;
                end;
            }
            action("Supplier Categories")
            {
                Image = CalculateConsumption;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Supplier Category";
                RunPageLink = "Document Number" = FIELD("Supplier Name");
            }
            action("Supplier Required Documents")
            {
                Image = CalculateConsumption;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Vendor Required Documents";
                RunPageLink = Code = FIELD("Document No.");
            }
            action("Vendor Regions of Operations")
            {
                Image = CalculateConsumption;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Vendor Regions of Operation";
                RunPageLink = "Document No." = FIELD("Document No.");
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
                    RunObject = Page "Approval Entries-Modified";
                    RunPageLink = "Document No." = FIELD("Document No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Store Requisition Header","No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
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
                        rec.TestField(Status, rec.Status::Open);

                        GetMandatoryFields;

                        if PrequalificationApproval.CheckVendorPrequalificationApprovalWorkflowEnabled(Rec) then
                            PrequalificationApproval.OnSendVendorPrequalificationForApproval(Rec);
                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
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
                        PrequalificationApproval.OnCancelVendorPrequalificationForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action("Approval Comment")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approval Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;


        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Txt0001: Label 'Are you sure you want to Pre-Qualify the supplier?';
        ProcurementManagement: Codeunit "Procurement Management";
        Txt0002: Label 'Supplier Pre-Qualified successfully!';
        SupplierCategory: Record "Supplier Category";
        Txt0003: Label 'Kindly specify atleast one supplier category';
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        PrequalificationApproval: Codeunit "Prequalification Approval";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        IsEditable: Boolean;
    //  PrequalificationApproval: Codeunit "Prequalification Approval";

    local procedure GetMandatoryFields()
    begin
        rec.TestField("Supplier Name");
        rec.TestField(AGPO);
        rec.TestField("Bank Account No.");
        rec.TestField("Bank Account Name");
        rec.TestField(City);
        rec.TestField(County);
        rec.TestField("TIN No.");
        rec.TestField(AGPO);
        rec.TestField("Incorporation Cert. No.");
        rec.TestField("Incorporation Date");
        rec.TestField("VAT Registered");
        rec.TestField(Prequalified, false);


        SupplierCategory.Reset;
        SupplierCategory.SetRange(SupplierCategory."Document Number", Rec."Supplier Name");
        if not SupplierCategory.FindFirst then
            Error(Txt0003);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."Supplier Name" <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

