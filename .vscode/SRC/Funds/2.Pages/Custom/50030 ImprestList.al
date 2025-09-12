page 50030 "Imprest List"
{
    ApplicationArea = All;
    Caption = 'Imprest List';
    PageType = List;
    SourceTable = "Imprest Header";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;
    DeleteAllowed = false;
    CardPageId = "Imprest Card";
    PromotedActionCategoriesML = ENU = 'New,Process,Reports,Details,Approvals,Attachments,Category7_caption,Category8_caption,Category9_caption,Category10_caption,Category11_caption,Category12_caption,Category13_caption,Category14_caption,Category15_caption,Category16_caption,Category17_caption,Category18_caption,Category19_caption,Category20_caption';
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

                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
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
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Imprest Remaining Amount"; Rec."Imprest Remaining Amount")
                {
                    ToolTip = 'Specifies the value of the Imprest Remaining Amount field.';
                    ApplicationArea = All;
                }
                field("Imprest Remaining Amount(LCY)"; Rec."Imprest Remaining Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Imprest Remaining Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Date From"; Rec."Date From")
                {
                    ToolTip = 'Specifies the value of the Date From field.';
                    ApplicationArea = All;
                }
                field("Date To"; Rec."Date To")
                {
                    ToolTip = 'Specifies the value of the Date To field.';
                    ApplicationArea = All;
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
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ToolTip = 'Specifies the value of the Employee Posting Group field.';
                    ApplicationArea = All;
                }
                field("Depature Time"; Rec."Depature Time")
                {
                    ToolTip = 'Specifies the value of the Depature Time field.';
                    ApplicationArea = All;
                }
                field("Return Time"; Rec."Return Time")
                {
                    ToolTip = 'Specifies the value of the Return Time field.';
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
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
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                Visible = false;
                trigger OnAction()
                begin
                    //   ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
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
            // action("Send Approval Request")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Send Approval Request', comment = 'ENU="Send Approval Request"';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Image = SendApprovalRequest;

            //     trigger OnAction()
            //     begin
            //         PostImprest.CheckImprestMandatoryFields(Rec."No.");
            //         IF ImprestApprovalManager.CheckImprestHeaderApprovalWorkflowEnabled(Rec) THEN
            //             ImprestApprovalManager.OnSendImprestHeaderForApproval(Rec);
            //     end;
            // }
            // action("Cancel Approval Request")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Cancel Approval Request', comment = 'ENU="Cancel Approval Request"';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Image = CancelApprovalRequest;

            //     trigger OnAction()
            //     begin
            //         ImprestApprovalManager.OnCancelImprestHeaderForApproval(Rec);
            //         //WorkflowWebhookMgt.FindAndCancel(RECORDID);
            //     end;
            // }
            action("Re-Open")
            {
                ApplicationArea = All;
                Caption = 'Re-Open', comment = 'ENU="Re-Open"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReOpen;
                Visible = false;
                trigger OnAction()
                begin
                    IF CONFIRM('Re-Open Document?') THEN BEGIN

                    end;
                end;
            }
        }
        area(Reporting)
        {
            action("Print Imprest")
            {
                ApplicationArea = All;
                Caption = 'Print Imprest', comment = 'ENU=Print Imprest';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report2;

                trigger OnAction()
                begin
                    ImprestHeader.RESET;
                    ImprestHeader.SETRANGE(ImprestHeader."No.", Rec."No.");
                    IF ImprestHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Imprest Voucher", TRUE, FALSE, ImprestHeader);
                    END;
                end;
            }
        }

    }
    var
        FundsUserSetup: Record "Funds User Setup";
        ImprestHeader: Record "Imprest Header";
        ImprestApprovalManager: Codeunit "Imprest Approval Manager";
        PostImprest: Codeunit PaymentPost;
        JTemplate: code[20];
        JBatch: code[20];
        DocNo: code[20];
        Txt_001: TextConst ENU = 'User Account %1 is not Setup for Imprest Posting, Contact the System Administrator';
        Txt_002: TextConst ENU = 'There is an open Imprest Header document under your name, use it before you create a new one.';
        Txt_003: TextConst ENU = 'Document reopened successfully.';
        ErrorUsedReferenceNumber: TextConst ENU = 'The Reference Number has been used for Imprest No:%1';
        PaymentTxt: TextConst ENU = 'Imprest';
        Error202: TextConst ENU = 'You do not Have permision to Reopen this document. Contact the system Administrator';
}
