page 50025 "Funds Transfer List"
{
    ApplicationArea = All;
    Caption = 'Funds Transfer List';
    PageType = List;
    SourceTable = "Funds Transfer Header";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;
    //DeleteAllowed=false;
    CardPageId = "Funds Transfer Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the value of the Bank Account No. field.';
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ToolTip = 'Specifies the value of the Bank Account Name field.';
                    ApplicationArea = All;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ToolTip = 'Specifies the value of the Cheque Type field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
                }
                field("Tranfer Type"; Rec."Tranfer Type")
                {
                    ToolTip = 'Specifies the value of the Tranfer Type field.';
                    ApplicationArea = All;
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ToolTip = 'Specifies the value of the Posting Type field.';
                    ApplicationArea = All;
                }
                field("Transfer To"; Rec."Transfer To")
                {
                    ToolTip = 'Specifies the value of the Transfer To field.';
                    ApplicationArea = All;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
                field("Currency Exchange Rate"; Rec."Currency Exchange Rate")
                {
                    ToolTip = 'Currency Exchange Rate"';
                    ApplicationArea = All;
                }
                field("Amount To Transfer"; Rec."Amount To Transfer")
                {
                    ToolTip = 'Specifies the value of the Amount To Transfer field.';
                    ApplicationArea = All;
                }
                field("Amount To Transfer(LCY)"; Rec."Amount To Transfer(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount To Transfer(LCY) field.';
                    ApplicationArea = All;
                }
                field("Post Lumpsum"; Rec."Post Lumpsum")
                {
                    ToolTip = 'Specifies the value of the Post Lumpsum field.';
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                    ApplicationArea = All;
                }
                field("Line Amount(LCY)"; Rec."Line Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Line Amount(LCY) field.';
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
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
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
                    PostFundsTransfer.CheckFundsTransferMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := true;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                        JTemplate := FundsUserSetup."Payment Journal Template";
                        JBatch := FundsUserSetup."Payment Journal Batch";
                        PostFundsTransfer.PostFundsTransfer(Rec."No.", JTemplate, JBatch, Preview);
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }
            action("Post Funds Transfer")
            {
                ApplicationArea = All;
                Caption = 'Post Funds Transfer';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.Posted = true then
                        error('Document is already posted');
                    PostFundsTransfer.CheckFundsTransferMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := false;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                        JTemplate := FundsUserSetup."Payment Journal Template";
                        JBatch := FundsUserSetup."Payment Journal Batch";
                        PostFundsTransfer.PostFundsTransfer(rec."No.", JTemplate, JBatch, Preview);
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }

            action("Post & Print Funds Transfer")
            {
                ApplicationArea = All;
                Caption = 'Post & Print Funds Transfer';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.Posted = true then
                        error('Document is already posted');
                    PostFundsTransfer.CheckFundsTransferMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := false;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                        JTemplate := FundsUserSetup."Payment Journal Template";
                        JBatch := FundsUserSetup."Payment Journal Batch";
                        PostFundsTransfer.PostFundsTransfer(Rec."No.", JTemplate, JBatch, preview);
                        COMMIT;
                        FundsTransferHeader.RESET;
                        FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", DocNo);
                        IF FundsTransferHeader.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(REPORT::"Funds Transfers Voucher", TRUE, FALSE, FundsTransferHeader);
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
                Visible = false;
                Image = Approve;
                trigger OnAction()
                begin
                    // ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
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
                Visible = false;
                trigger OnAction()
                begin
                    // ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
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
                    PostFundsTransfer.CheckFundsTransferMandatoryFields(Rec."No.");
                    IF FundsApprovalManager.CheckFundsTransferApprovalWorkflowEnabled(Rec) THEN
                        FundsApprovalManager.OnSendFundsTransferForApproval(Rec);
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
                    FundsApprovalManager.OnCancelFundsTransferForApproval(Rec);
                    //WorkflowWebhookMgt.FindAndCancel(RECORDID);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = All;
                Caption = 'Re-Open', comment = 'ENU="Re-Open"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                Image = ReOpen;

                trigger OnAction()
                begin
                    IF CONFIRM('Re-Open Document?') THEN BEGIN

                    end;
                end;
            }
        }
        area(Reporting)
        {
            action("Print Funds Transfer")
            {
                ApplicationArea = All;
                Caption = 'Print Funds Transfer', comment = 'ENU=PPrint Funds Transfer';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report2;

                trigger OnAction()
                begin
                    FundsTransferHeader.RESET;
                    FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", Rec."No.");
                    IF FundsTransferHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Funds Transfers Voucher", TRUE, FALSE, FundsTransferHeader);
                    END;
                end;
            }
            action("Print Cheque")
            {
                ApplicationArea = All;
                Caption = 'Print Cheque', comment = 'ENU=Print Cheque';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report2;

                trigger OnAction()
                begin
                    FundsTransferHeader.RESET;
                    FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", Rec."No.");
                    IF FundsTransferHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Funds Transfers Voucher", TRUE, FALSE, FundsTransferHeader);
                    END;
                end;
            }

        }

    }
    var
        FundsUserSetup: Record "Funds User Setup";
        FundsTransferHeader: Record "Funds Transfer Header";
        PostFundsTransfer: Codeunit FundsTransferPost;
        FundsApprovalManager: Codeunit "Funds Transfer Approval";
        Preview: Boolean;
        JTemplate: code[20];
        JBatch: code[20];
        DocNo: code[20];
        Txt_001: TextConst ENU = 'User Account %1 is not Setup for Payments Posting, Contact the System Administrator';
        Txt_002: TextConst ENU = 'There is an open Funds Transfer document under your name, use it before you create a new one.';
        Txt_003: TextConst ENU = 'Document reopened successfully.';
        ErrorUsedReferenceNumber: TextConst ENU = 'The Reference Number has been used for Funds Transfer No:%1';
        PaymentTxt: TextConst ENU = 'Payment';
        Error202: TextConst ENU = 'You do not Have permision to Reopen this document. Contact the system Administrator';
}
