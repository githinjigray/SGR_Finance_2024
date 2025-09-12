page 70007 "Request for Quotation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgeting,Category6_caption,Category7_caption,RequestToApprove,Category9_caption,Category10_caption';
    SourceTable = "Request for Quotation Header";
    ApplicationArea = All;
    //
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique document number for the request for quotation';
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the request for quotation was created';
                }
                field("RFQ Date"; rec."RFQ Date")
                {
                    ToolTip = 'RFQ Date';
                }
                field("Issue Date"; rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Closing Date"; rec."Closing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expected closing date for the request for quotation was created, after this date the request for quotation is considered complete and moved to the closed request for quotations';
                }
                field("Supplier Category"; rec."Supplier Category")
                {
                    ApplicationArea = All;
                }
                field("Category Name"; rec."Category Name")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the currency used for the amounts on the request for quotation';
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated total amount of the request for quotation';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description for the purchase requisition';
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
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = All;
                }  
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status for the purchase requisition';
                }
                field("RFQ Enquiries Email"; rec."RFQ Enquiries Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address to receive enquiries';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who created the purchase requisition';
                }
            }
            part(Control16; "Request for Quotation Line")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            part(Control43; "Procurement Requirements")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control18; Links)
            {
                Visible = false;
            }
            systempart(Control17; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {

            ToolTip = 'NewDocumentItems';
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
            action("Send Email")
            {
                Caption = 'Send Email';
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt_005) = false then exit;
                    ProcurementManagement.SendRequestforQuotationToVendor(rec."No.");
                end;
            }
            action("RFQ Lines Attributes")
            {
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Request for Quotation Line";
                RunPageLink = "Document No." = FIELD("No.");
            }
            action("Archive Document")
            {
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(ArchiveRFQ) then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;
                        CurrPage.Close;
                    end;
                end;
            }
            group(RequestforQuotation)
            {
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    begin
                        Rec.TestField("User ID", UserId);
                        if Confirm(Txt_003, false, Rec."No.") then begin
                            ProcurementApprovalWorkflow.ReOpenRequestforQuotation(Rec);
                        end;
                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    begin
                        ProcurementManagement.CheckRequestforQuotationMandatoryFields(Rec);
                        if Confirm(Txt_004, false, Rec."No.") then begin
                            ProcurementApprovalWorkflow.ReleaseRequestforQuotation(Rec);
                        end;
                    end;
                }
                action("Get Requisition Lines")
                {
                    Caption = 'Get Requisition Lines';
                    Image = GetSourceDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Get the purchase requisition lines to add to this request for quotation';

                    trigger OnAction()
                    begin
                        rec.TestField(Description);

                        CurrPage.Update(true);

                        InsertRFQLinesFromPurchaseRequisition();
                    end;
                }
                action("Assign Vendors")
                {
                    Caption = 'Assign Vendor(s)';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Request for Quotation Vendors";
                    RunPageLink = "RFQ Document No." = FIELD("No.");
                    ToolTip = 'Assign Vendors to the Request for Quotation';

                    trigger OnAction()
                    var
                        Vends: Record Vendor;
                    begin
                    end;
                }
                action("Supplier Required Documents")
                {
                    Image = CalculateConsumption;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Vendor Required Documents";
                    RunPageLink = "Document Code" = FIELD("No.");
                }
                action("Purchase Requisition Assigned")
                {
                    Caption = 'Purchase Requisition Assigned';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "All Purchase Requisition Lines";
                    RunPageLink = "Request for Quotation No." = FIELD("No.");

                }

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
                    RunPageLink = "Document No." = FIELD("No.");
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
                        Rec.TestField(Rec.Status, Rec.Status::Open);

                        if RFQApprovalManager.CheckRFQHeaderApprovalWorkflowEnabled(Rec) then
                            RFQApprovalManager.OnSendRFQHeaderForApproval(Rec);
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
                        RFQApprovalManager.OnCancelRFQHeaderForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(rec.RecordId);
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
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RecordId);
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
            group("Report")
            {
                Caption = 'Report';
                ToolTip = 'Report';
                action("Print Request for Quotation")
                {
                    Caption = 'Print Request for Quotation';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        RequestforQuotationHeader.Reset;
                        RequestforQuotationHeader.SetRange(RequestforQuotationHeader."No.", Rec."No.");
                        if RequestforQuotationHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Request for Quotation", true, false, RequestforQuotationHeader);
                        end;
                    end;
                }
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                ToolTip = 'Incoming Document';
                action(IncomingDocCard)
                {
                    ApplicationArea = Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
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
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate(Rec."Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = CreateIncomingDocumentEnabled;
                    Image = Attach;
                    ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        //IncomingDocumentAttachment.NewAttachmentFromRequestForQuotationDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    ToolTip = 'Remove any incoming document records and file attachments.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                            IncomingDocument.RemoveLinkToRelatedRecord;
                        Rec."Incoming Document Entry No." := 0;
                        Rec.Modify(true);
                    end;
                }
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*RequestforQuotationHeader.RESET;
        RequestforQuotationHeader.SETRANGE("User ID",USERID);
        RequestforQuotationHeader.SETRANGE(Status,RequestforQuotationHeader.Status::Open);
        IF RequestforQuotationHeader.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */

    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable(false);
    end;

    var
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        RequestforQuotationHeader: Record "Request for Quotation Header";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        Txt_002: Label 'There is an open request for quotation under your name, use it before you create a new one';
        Txt_003: Label 'Reopen Request for Quotation No.:%1';
        Txt_004: Label 'Release Request for Quotation No.:%1';
        ReportSelections: Record "Report Selections";
        Txt_005: Label 'This will send email message with RRF attachment continue?';
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        RFQApprovalManager: Codeunit "RFQ Approval Manager";
        ArchiveRFQ: Label 'ARCHIVE DOCUMENT';

    procedure InsertRFQLinesFromPurchaseRequisition()
    var
        RequisitionLines: Page "Submitted Requisition Lines";
        SelectedPurchaseRequisitionLine: Record "Purchase Requisition Line";
        Counter: Integer;
        RFQLine: Record "Request for Quotation Line";
        "LineNo.": Integer;
        RFQLine2: Record "Request for Quotation Line";
    begin
        Rec.TestField(Description);

        //Get Last Line No.
        RFQLine2.Reset;
        RFQLine2.SetRange(RFQLine2."Document No.", Rec."No.");
        RFQLine2.SetCurrentKey("Document No.", "Line No.");
        if RFQLine2.FindLast then begin
            "LineNo." := RFQLine2."Line No.";
        end else begin
            "LineNo." := 1000;
        end;
        //End Get Last Line No.
        RequisitionLines.LookupMode(true);
        if RequisitionLines.RunModal = ACTION::LookupOK then begin
            RequisitionLines.SetSelection(SelectedPurchaseRequisitionLine);
            Counter := SelectedPurchaseRequisitionLine.Count;
            if Counter > 0 then begin
                if SelectedPurchaseRequisitionLine.FindSet then
                    repeat
                        "LineNo." := "LineNo." + 1;
                        RFQLine.Init;
                        RFQLine."Line No." := "LineNo.";
                        RFQLine."Document No." := Rec."No.";
                        RFQLine."Document Date" := Rec."Document Date";
                        RFQLine."Requisition Type" := SelectedPurchaseRequisitionLine."Requisition Type";
                        RFQLine."Requisition Code" := SelectedPurchaseRequisitionLine."Requisition Code";
                        if RFQLine."Requisition Type" = RFQLine."Requisition Type"::Service then begin
                            RFQLine.Type := RFQLine.Type::"G/L Account";
                        end;
                        if RFQLine."Requisition Type" = RFQLine."Requisition Type"::Item then begin
                            RFQLine.Type := RFQLine.Type::Item;
                        end;
                        if RFQLine."Requisition Type" = RFQLine."Requisition Type"::"Fixed Asset" then begin
                            RFQLine.Type := RFQLine.Type::"Fixed Asset";
                        end;
                        RFQLine."No." := SelectedPurchaseRequisitionLine."No.";
                        RFQLine.Name := SelectedPurchaseRequisitionLine.Name;
                        RFQLine."Location Code" := SelectedPurchaseRequisitionLine."Location Code";
                        RFQLine."Unit of Measure Code" := SelectedPurchaseRequisitionLine."Unit of Measure";
                        RFQLine.Quantity := SelectedPurchaseRequisitionLine.Quantity;
                        RFQLine."Currency Code" := SelectedPurchaseRequisitionLine."Currency Code";
                        RFQLine."Currency Factor" := SelectedPurchaseRequisitionLine."Currency Factor";
                        RFQLine."Unit Cost" := SelectedPurchaseRequisitionLine."Estimated Unit Cost";
                        RFQLine."Unit Cost(LCY)" := SelectedPurchaseRequisitionLine."Estimated Unit Cost(LCY)";
                        RFQLine."Total Cost" := SelectedPurchaseRequisitionLine."Total Cost";
                        RFQLine."Total Cost(LCY)" := SelectedPurchaseRequisitionLine."Total Cost(LCY)";
                        RFQLine.Description := SelectedPurchaseRequisitionLine.Description;
                        RFQLine."Part No." := SelectedPurchaseRequisitionLine."Part No.";                        
                        RFQLine."Global Dimension 1 Code" := SelectedPurchaseRequisitionLine."Global Dimension 1 Code";
                        RFQLine."Global Dimension 2 Code" := SelectedPurchaseRequisitionLine."Global Dimension 2 Code";
                        RFQLine."Shortcut Dimension 3 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 3 Code";
                        RFQLine."Shortcut Dimension 4 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 4 Code";
                        RFQLine."Shortcut Dimension 5 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 5 Code";
                        RFQLine."Shortcut Dimension 6 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 6 Code";
                        RFQLine."Shortcut Dimension 7 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 7 Code";
                        RFQLine."Shortcut Dimension 8 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 8 Code";
                        RFQLine."Responsibility Center" := SelectedPurchaseRequisitionLine."Responsibility Center";
                        RFQLine."Purchase Requisition Line" := SelectedPurchaseRequisitionLine."Line No.";
                        RFQLine."Purchase Requisition No." := SelectedPurchaseRequisitionLine."Document No.";
                        if RFQLine.Insert then begin
                            PurchaseRequisitionLines.Reset;
                            PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines."Line No.", SelectedPurchaseRequisitionLine."Line No.");
                            PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines."Document No.", SelectedPurchaseRequisitionLine."Document No.");
                            PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines."Requisition Code", SelectedPurchaseRequisitionLine."Requisition Code");
                            if PurchaseRequisitionLines.FindFirst then begin
                                PurchaseRequisitionLines.Closed := true;
                                PurchaseRequisitionLines."Request for Quotation No." := rec."No.";
                                PurchaseRequisitionLines."Request for Quotation Line" := "LineNo.";
                                PurchaseRequisitionLines.Modify;
                            end;
                            rec."Global Dimension 1 Code" := SelectedPurchaseRequisitionLine."Global Dimension 1 Code";
                            rec."Global Dimension 2 Code" := SelectedPurchaseRequisitionLine."Global Dimension 2 Code";
                            rec."Shortcut Dimension 3 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 3 Code";
                            rec."Shortcut Dimension 4 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 4 Code";
                            rec."Shortcut Dimension 5 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 5 Code";
                            rec."Shortcut Dimension 6 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 6 Code";
                        end;
                    until SelectedPurchaseRequisitionLine.Next = 0;
            end;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);


        if rec.Status <> rec.Status::Open then
            CurrPage.Editable(false);
    end;

    procedure SendRecords()
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
    begin
        /*CheckMixedDropShipment;
        
        DocumentSendingProfile.SendVendorRecords(
          DummyReportSelections.Usage::"P.Order",Rec,DocTxt,"Buy-from Vendor No.","No.",
          FIELDNO("Buy-from Vendor No."),FIELDNO("No."));*/

    end;
}

