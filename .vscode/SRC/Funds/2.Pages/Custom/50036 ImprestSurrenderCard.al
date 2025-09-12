page 50036 "Imprest Surrender Card"
{
    Caption = 'Imprest Surrender Card';
    PageType = Card;
    SourceTable = "Imprest Surrender Header";
    SourceTableView = where(Posted = const(false));
    DeleteAllowed = false;
    PromotedActionCategoriesML = ENU = 'New,Process,Reports,Details,Approvals,Attachments,Category7_caption,Approvals,Category9_caption,Category10_caption,Category11_caption,Category12_caption,Category13_caption,Category14_caption,Category15_caption,Category16_caption,Category17_caption,Category18_caption,Category19_caption,Category20_caption';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = DocumentEditable;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    ToolTip = 'Specifies the value of the Imprest No. field.';
                    ApplicationArea = All;
                }
                field("Imprest Date"; Rec."Imprest Date")
                {
                    ToolTip = 'Specifies the value of the Imprest Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ToolTip = 'Specifies the value of the Actual Spent field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Spent(LCY)"; Rec."Actual Spent(LCY)")
                {
                    ToolTip = 'Specifies the value of the Actual Spent(LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Cash Receipt Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cash Receipt Amount(LCY)"; Rec."Cash Receipt Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Cash Receipt Amount(LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Difference; Rec.Difference)
                {
                    ToolTip = 'Specifies the value of the Difference field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Difference(LCY)"; Rec."Difference(LCY)")
                {
                    ToolTip = 'Specifies the value of the Difference(LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Surrenderd"; Rec."Actual Surrenderd")
                {
                    ToolTip = 'Specifies the value of the Actual Surrenderd field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Actual Advanced"; Rec."Actual Advanced")
                {
                    ToolTip = 'Specifies the value of the Actual Advanced field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Posting Details")
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            part(ImprestSurrenderLine; "Imprest Surrender Line")
            {
                Caption = 'Imprest Surrender Line';
                SubPageLink = "Document No." = field("No.");
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Portal Document Attachments")
            {
                Image = MakeDiskette;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page PortalDocuments;
                RunPageLink = "DocumentNo." = FIELD("No.");
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Visible = false;
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
            action("Preview Posting")
            {
                ApplicationArea = All;
                Caption = 'Preview Posting';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    PostImprestSurrender.CheckImprestSurrenderMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := true;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Imprest Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Imprest Batch");
                        JTemplate := FundsUserSetup."Imprest Template";
                        JBatch := FundsUserSetup."Imprest Batch";
                        PostImprestSurrender.PostImprestSurrender(Rec."No.", JTemplate, JBatch, Preview);
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }
            action("Post Imprest Surrender")
            {
                ApplicationArea = All;
                Caption = 'Post Imprest Surrender';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField(Status, rec.Status::Approved);
                    PostImprestSurrender.CheckImprestSurrenderMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := false;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Imprest Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Imprest Batch");
                        JTemplate := FundsUserSetup."Imprest Template";
                        JBatch := FundsUserSetup."Imprest Batch";
                        PostImprestSurrender.PostImprestSurrender(Rec."No.", JTemplate, JBatch, Preview);
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }

            action("Post & Imprest Surrender")
            {
                ApplicationArea = All;
                Caption = 'Post & Print Imprest Surrender';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField(Status, rec.Status::Approved);
                    PostImprestSurrender.CheckImprestSurrenderMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := false;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Imprest Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Imprest Batch");
                        JTemplate := FundsUserSetup."Imprest Template";
                        JBatch := FundsUserSetup."Imprest Batch";
                        PostImprestSurrender.PostImprestSurrender(Rec."No.", JTemplate, JBatch, Preview);
                        COMMIT;
                        ImprestSurrenderHeader.RESET;
                        ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", DocNo);
                        IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(REPORT::"Imprest Surrender Voucher", TRUE, FALSE, ImprestSurrenderHeader);
                        END
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                begin
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                begin
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
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
                RunObject = page "Approval Entries-Modified";
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
                    PostImprestSurrender.CheckImprestSurrenderMandatoryFields(Rec."No.");
                    IF IMprestSurrenderApprovalManager.CheckImprestsurrenderApprovalWorkflowEnabled(Rec) THEN
                        IMprestSurrenderApprovalManager.OnSendImprestsurrenderForApproval(Rec);
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
                    IMprestSurrenderApprovalManager.OnCancelImprestsurrenderForApproval(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
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
                    Rec.TESTFIELD(Status, Rec.Status::Approved);
                    UserSetup.RESET;
                    UserSetup.SETRANGE(UserSetup."User ID", USERID);
                    IF UserSetup.FINDFIRST THEN BEGIN
                        IF UserSetup."Re-open Payments" THEN
                            FundsManagement.ReopenImprestSurrender(Rec);
                        ApprovalEntries.Reset();
                        ApprovalEntries.SetRange("Document No.", Rec."No.");
                        if ApprovalEntries.FindSet() then begin
                            repeat
                                ApprovalEntries.Status := ApprovalEntries.Status::Canceled;
                                ApprovalEntries.Modify();
                            until ApprovalEntries.Next() = 0;
                        end;
                    END;
                end;
            }
        }
        area(Reporting)
        {
            action("Print Imprest surrender")
            {
                ApplicationArea = All;
                Caption = 'Print Imprest surrender', comment = 'ENU=Print Imprest surrender';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report2;

                trigger OnAction()
                begin
                    ImprestSurrenderHeader.RESET;
                    ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", Rec."No.");
                    IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Imprest Surrender Voucher", TRUE, FALSE, ImprestSurrenderHeader);
                    END;
                end;
            }
        }

    }
    var
        FundsUserSetup: Record "Funds User Setup";
        UserSetup: Record "User Setup";
        ApprovalEntries: Record "Approval Entry";
        FundsManagement: Codeunit "Funds Management";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        PostImprestSurrender: Codeunit ImprestSurrenderPost;
        ImprestSurrenderApprovalManager: Codeunit "Imprest Surrender Approval";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        JTemplate: code[20];
        JBatch: code[20];
        DocNo: code[20];
        Preview: Boolean;
        DocumentEditable: Boolean;
        Txt_001: TextConst ENU = 'User Account %1 is not Setup for Imprest Surrender Posting, Contact the System Administrator';
        Txt_002: TextConst ENU = 'There is an open Imprest surrender document under your name, use it before you create a new one.';
        Txt_003: TextConst ENU = 'Document reopened successfully.';
        ErrorUsedReferenceNumber: TextConst ENU = 'The Reference Number has been used for Imprest Surrender No:%1';
        PaymentTxt: TextConst ENU = 'Imprest Surrender';
        Error202: TextConst ENU = 'You do not Have permision to Reopen this document. Contact the system Administrator';

    trigger OnOpenPage()
    begin
        if rec.Status <> rec.Status::Open then
            DocumentEditable := false
        else
            DocumentEditable := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if rec.Status <> rec.Status::Open then
            DocumentEditable := false
        else
            DocumentEditable := true;
    end;
}
