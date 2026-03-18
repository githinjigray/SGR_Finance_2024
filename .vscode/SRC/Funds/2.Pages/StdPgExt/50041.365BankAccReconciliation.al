pageextension 50041 "365 Bank Acc. Reconciliation" extends "Bank Acc. Reconciliation"
{
    layout
    {
        addlast(general)
        {

            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field.', Comment = '%';
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
            }
            field("Total Reconciled"; Rec."Total Reconciled")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Reconciled field.', Comment = '%';
            }
            field("Total Unreconciled"; Rec."Total Unreconciled")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Unreconciled field.', Comment = '%';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.', Comment = '%';
            }
        }
        modify(Control8)
        {
            Visible = false;
        }
        addafter(Control8)
        {
            part("Bank Acc.Reconciliation Lines2"; "Bank Acc.Reconciliation Lines2")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast("Ba&nk")
        {
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals', comment = 'ENU="Approvals"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                RunObject = Page "Approval Entries-Modified";
                RunPageLink = "Document No." = field("Statement No.");
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

                    IF ApprovalManager.CheckBankReconciliationApprovalWorkflowEnabled(Rec) THEN
                        ApprovalManager.OnSendBankReconciliationForApproval(Rec);
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
                    ApprovalManager.OnCancelBankReconciliationForApproval(Rec);
                    //WorkflowWebhookMgt.FindAndCancel(RECORDID);
                end;
            }
            action("Print Reconciliation")
            {
                Caption = 'Print Reconciliation';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Print Reconciliation';
                ApplicationArea = All;


                trigger OnAction()
                var
                    PrintStatement: Record "Bank Acc. Reconciliation";
                begin
                    PrintStatement.Reset;
                    PrintStatement.SetRange(PrintStatement."Bank Account No.", rec."Bank Account No.");
                    PrintStatement.SetRange(PrintStatement."Statement No.", rec."Statement No.");
                    if PrintStatement.FindFirst then begin
                        REPORT.RunModal(REPORT::"Bank Acc ReconciliationTest", true, false, PrintStatement);
                    end;
                end;
            }
        }
    }
    var
        ApprovalManager: Codeunit "Bank Reconciliation Approval";
}
