page 50016 "Cash Payment Card"
{
    Caption = 'Cash Payment Card';
    PageType = Card;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Type" = CONST("Cash Payment"));
    DeleteAllowed = false;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
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
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
                }
                field("Payee No."; Rec."Payee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee No. field.';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ToolTip = 'Specifies the value of the Payee Name field.';
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
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                    ApplicationArea = All;
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("WithHolding Tax Amount"; Rec."WithHolding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the WithHolding Tax Amount field.';
                    ApplicationArea = All;
                }
                field("WithHolding Tax Amount(LCY)"; Rec."WithHolding Tax Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the WithHolding Tax Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Withholding VAT Amount"; Rec."Withholding VAT Amount")
                {
                    ToolTip = 'Specifies the value of the Withholding VAT Amount field.';
                    ApplicationArea = All;
                }
                field("Withholding VAT Amount(LCY)"; Rec."Withholding VAT Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Withholding VAT Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the value of the Net Amount field.';
                    ApplicationArea = All;
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Net Amount(LCY) field.';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(CashPaymentLIne; "Payment Line")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Process)
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
                // action("Upload Transactions")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Upload Transactions';
                //     Image = Excel;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Process;
                //     trigger OnAction()
                    
                //         //TESTFIELD(rec.Status,rec.Status::Open);

                //         //delete existing lines

                //         PaymentLines.RESET;
                //         PaymentLines.SETRANGE("Document No.", Rec."No.");
                //         PaymentLines.DELETEALL;
                //         //end delete

                //         XMLPORT.RUN(XMLPORT::"Petty cash Upload", FALSE, TRUE);
                //         COMMIT;
                //     ;
                // }
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
                        PostPayment.CheckPaymentsMandatoryFields(Rec."No.", false);
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                            Preview := true;
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            PostPayment.PostPayment(Rec."No.", JTemplate, JBatch, Preview);
                        END ELSE BEGIN
                            ERROR(Txt_001, USERID);
                        END;
                    end;
                }
                action("Post Payment")
                {
                    ApplicationArea = All;
                    Caption = 'PostPayment';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        PostPayment.CheckPaymentsMandatoryFields(Rec."No.", false);
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                            Preview := false;
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            PostPayment.PostPayment(Rec."No.", JTemplate, JBatch, Preview);
                            CurrPage.Close();
                        END ELSE BEGIN
                            ERROR(Txt_001, USERID);
                        END;
                    end;
                }

                action("Post & Print Payment")
                {
                    ApplicationArea = All;
                    Caption = 'Post & Print Payment';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        //PostPayment.CheckPaymentsMandatoryFields(Rec."No.");
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                            Preview := false;
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            PostPayment.PostPayment(Rec."No.", JTemplate, JBatch, Preview);
                            COMMIT;
                            PaymentHeader.RESET;
                            PaymentHeader.SETRANGE(PaymentHeader."No.", DocNo);
                            IF PaymentHeader.FINDFIRST THEN BEGIN
                                REPORT.RUNMODAL(REPORT::"Cash Voucher Report", TRUE, FALSE, PaymentHeader);
                            END;
                            CurrPage.Close();
                        END ELSE BEGIN
                            ERROR(Txt_001, USERID);
                        END;
                    end;
                }
                action("Post Payment Line by Line")
                {
                    ApplicationArea = All;
                    Caption = 'Post Payment Line by Line';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        if Rec.Posted = true then
                            error('Document is already posted');
                        PostPayment.CheckPaymentsMandatoryFields(Rec."No.", true);

                        FundsUserSetup.Reset();
                        FundsUserSetup.SetRange(UserID, UserId);
                        IF FundsUserSetup.FindFirst() THEN BEGIN
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";

                            BankAccountLedgerEntry.RESET;
                            BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry."Document No.", Rec."No.");
                            BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry."Bank Account No.", Rec."Bank Account No.");
                            BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry.Reversed, FALSE);
                            IF BankAccountLedgerEntry.FINDFIRST THEN
                                ERROR('Payment voucher already posted. Click on "Mark as posted" to move it to posted documents');

                            Preview := false;
                            PostPayment.PostPaymentLineByLine(Rec."No.", JTemplate, JBatch, Preview);
                            CurrPage.Close();
                        END ELSE BEGIN
                            ERROR(Txt_001, USERID);
                        END;

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
                        IF CONFIRM('Re-Open Document?') THEN BEGIN
                            rec.Status := rec.status::Open;
                            rec.modify;
                            ApprovalEntries.Reset();
                            ApprovalEntries.SetRange("Document No.", rec."No.");
                            if ApprovalEntries.FindSet() then begin
                                repeat
                                    ApprovalEntries.Status := ApprovalEntries.Status::Canceled;
                                    ApprovalEntries.Modify();
                                until ApprovalEntries.Next() = 0;
                            end;
                            Message('Success!');
                            CurrPage.Close();
                        end;
                    end;
                }
            }
            group(Approvals)
            {
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
                        //ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
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
                        // pprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Approval)
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
                        PostPayment.CheckPaymentsMandatoryFields(Rec."No.", false);
                        IF PaymentsApprovalManager.CheckPaymentCardApprovalWorkflowEnabled(Rec) THEN
                            PaymentsApprovalManager.OnSendPaymentCardForApproval(Rec);
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
                        PaymentsApprovalManager.OnCancelPaymentCardForApproval(Rec);
                        //WorkflowWebhookMgt.FindAndCancel(RECORDID);
                    end;
                }
            }
        }
        area(Reporting)
        {
            action("Print Payment")
            {
                ApplicationArea = All;
                Caption = 'Print Payment', comment = 'ENU=Print Payment';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report2;

                trigger OnAction()
                begin
                    PaymentHeader.RESET;
                    PaymentHeader.SETRANGE(PaymentHeader."No.", Rec."No.");
                    IF PaymentHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Cash Voucher Report", TRUE, FALSE, PaymentHeader);
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
                    PaymentHeader.RESET;
                    PaymentHeader.SETRANGE(PaymentHeader."No.", Rec."No.");
                    IF PaymentHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Payment Voucher", TRUE, FALSE, PaymentHeader);
                    END;
                end;
            }

        }

    }
    var
        FundsUserSetup: Record "Funds User Setup";
        PaymentHeader: Record "Payment Header";
        PostPayment: Codeunit PaymentPost;
        PaymentsApprovalManager: Codeunit "Payments Approval Manager";
        Preview: Boolean;
        JTemplate: code[20];
        JBatch: code[20];
        DocNo: code[20];
        ApprovalEntries: Record "Approval Entry";
        PaymentLines: Record "Payment Line";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        Txt_001: TextConst ENU = 'User Account %1 is not Setup for Payments Posting, Contact the System Administrator';
        Txt_002: TextConst ENU = 'There is an open payment document under your name, use it before you create a new one.';
        Txt_003: TextConst ENU = 'Document reopened successfully.';
        ErrorUsedReferenceNumber: TextConst ENU = 'The Reference Number has been used for Payment No:%1';
        PaymentTxt: TextConst ENU = 'Payment';
        Error202: TextConst ENU = 'You do not Have permision to Reopen this document. Contact the system Administrator';

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Payment Type" := rec."Payment Type"::"Cash Payment";
    end;
}
