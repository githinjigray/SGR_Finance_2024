page 70012 "Bid Analysis Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgeting,Category6_caption,Category7_caption,RequestToApprove,Category9_caption,Category10_caption';
    SourceTable = "Bid Analysis Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("RFQ No."; rec."RFQ No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Selected Vendor"; rec."Selected Vendor")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Reason for Selection of Vendor"; rec."Reason for Selection of Vendor")
                {
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
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }

                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("LPO No. Assigned"; rec."LPO No. Assigned")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control10; "Bid Analysis Line")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            part("Bid Analysis Partiulars"; "Bid Analysis Items")
            {
                Caption = 'Bid Analysis Particulars';
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control28; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control27; Notes)
            {
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
                Visible = ShowWorkflowStatus;
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
                Visible = false;
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

                trigger OnAction()
                begin
                    Rec.TestField("User ID", UserId);
                    if Confirm(Txt_003, false, Rec."No.") then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message(Txt_005);
                    end;

                    CurrPage.Close;
                end;
            }
            action(Release)
            {
                Caption = 'Release';
                Image = RegisterPick;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*ApprovalEntry.Reset;
                    ApprovalEntry.SetRange(ApprovalEntry."Document No.", Rec."No.");
                    ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                    if ApprovalEntry.FindLast then begin
                        if Confirm(Txt_004, false, Rec."No.") then begin*/
                    Rec.Status := Rec.Status::Released;
                    Rec.Modify;
                    Message(Txt_005);
                    //end;
                    //end;
                    //CurrPage.Close;
                end;
            }
            action("Bid Analysis Worksheet")
            {
                Caption = 'Bid Analysis Worksheet';
                Image = Worksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Bid Analysis Items";
                RunPageLink = "Document No." = FIELD("RFQ No.");
            }
            action("RFQ Assigned")
            {
                Caption = 'RFQ Assigned';
                Image = Worksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Request for Quotation List";
                RunPageLink = "No." = FIELD("RFQ No.");
            }

            action("Create Purchase Order")
            {
                Caption = 'Create Purchase Order';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    ProcurementManagement.CreateBIDLPO(Rec."No.");
                    Message(LPOcreated);
                end;
            }
            action("Create New Purchase Order")
            {
                Caption = 'Create New Purchase Order';
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                begin
                    if Confirm('Create New Purchase order? Exisiting Order must be archived first!') then begin
                        Rec.TestField(Status, Rec.Status::Released);
                        ProcurementManagement.CreateNewBIDLPO(Rec."No.");
                        Message(LPOcreated);
                    end;
                end;
            }
            action("Archive Document")
            {
                Image = CalculateHierarchy;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt_006) then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec."LPO No. Assigned" := 'Closed';
                        Rec.Modify;
                        Message(Txt_005);
                        CurrPage.Close;
                    end;
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
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
                        CurrPage.Close
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
                        CurrPage.Close
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
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Bid Analysis Header","RFQ No.");
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
                        REC.TestField(Status, REC.Status::Open);
                        ProcurementManagement.CheckBidAnalysisMandatoryFields(Rec);
                        REC.TestField("Selected Vendor");
                        REC.TestField("Global Dimension 1 Code");
                        REC.TestField("RFQ No.");

                        BidAnalysisItems.Reset();
                        BidAnalysisItems.SetRange("Vendor No.", REC."Selected Vendor");
                        if NOT BidAnalysisItems.FindFirst() then
                            Error('KINDLY ASSIGN ACTUAL VENDOR NO. TO THE BID ANALYSIS ITEMS FOR THE VENDOR SELECTED.');
                        BidAnalysisItems.Reset();
                        BidAnalysisItems.SetRange("Vendor No.", REC."Selected Vendor");
                        if NOT BidAnalysisItems.FindSet() then begin
                            repeat
                                BidAnalysisItems.TestField(BidAnalysisItems."No.");
                            until BidAnalysisItems.Next() = 0;
                        end;
                        if BidAnalysisApprovalManager.CheckBidAnalysisApprovalWorkflowEnabled(Rec) then
                            BidAnalysisApprovalManager.OnSendBidAnalysisForApproval(Rec);


                        RequestforQuotationHeader.Reset;
                        RequestforQuotationHeader.SetRange(RequestforQuotationHeader."No.", Rec."RFQ No.");
                        if RequestforQuotationHeader.FindFirst then begin
                            RequestforQuotationHeader.Status := RequestforQuotationHeader.Status::Closed;
                            RequestforQuotationHeader.Modify;
                        end;

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

                        BidAnalysisApprovalManager.OnCancelBidAnalysisForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);


                        RequestforQuotationHeader.Reset;
                        RequestforQuotationHeader.SetRange(RequestforQuotationHeader."No.", Rec."RFQ No.");
                        if RequestforQuotationHeader.FindFirst then begin
                            RequestforQuotationHeader.Status := RequestforQuotationHeader.Status::Released;
                            RequestforQuotationHeader.Modify;
                        end;

                        CurrPage.Close;
                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Bid Analysis")
                {
                    Caption = 'Print Bid Analysis';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        BidAnalysis.Reset;
                        BidAnalysis.SetRange(BidAnalysis."No.", Rec."No.");
                        if BidAnalysis.FindFirst then begin
                            REPORT.RunModal(REPORT::"Bid Analysis Items", true, false, BidAnalysis);
                        end;
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

        if rec.Status = rec.Status::Released then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        if rec.Status <> rec.Status::Open then
            CurrPage.Editable(false);
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        BidAnalysis: Record "Bid Analysis Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        BidAnalysisApprovalManager: Codeunit "Bid Analysis Approval Manager";
        BidAnalysisItems: Record "Bid Analysis Items";
        LPOcreated: Label 'Purchase Order created successfully!';
        CreateLPO: Label 'Are you sure you want to create a purchase order based on chosen suppllier?';
        RequestforQuotationHeader: Record "Request for Quotation Header";
        Txt_003: Label 'ARE YOU SURE YOU WANT TO REOPEN BID NO. %1';
        ApprovalEntry: Record "Approval Entry";
        Txt_004: Label 'ARE YOU SURE YOU WANT TO RELEASE BID NO. %1';
        Txt_005: Label 'ACTION SUCCESSFULL';
        Txt_006: Label 'ARE YOU SURE YOU WANT TO ARCHIVE DOCUMENT?';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

        if REC.Status = REC.Status::Released then
            CurrPage.Editable(false);
    end;
}

