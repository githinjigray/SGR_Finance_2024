page 50021 "Receipt Card"
{
    Caption = 'Receipt Card';
    PageType = Card;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(false));
    DeleteAllowed = false;
    PromotedActionCategoriesML = ENU = 'New,Process,Reports,Details,Approvals,Attachments,Category7_caption,Category8_caption,Category9_caption,Category10_caption,Category11_caption,Category12_caption,Category13_caption,Category14_caption,Category15_caption,Category16_caption,Category17_caption,Category18_caption,Category19_caption,Category20_caption';
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
                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;
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
                field("Receipt Type"; Rec."Receipt Type")
                {
                    ToolTip = 'Specifies the value of the Receipt Type field.';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
                }
                field("Received From"; Rec."Received From")
                {
                    ToolTip = 'Specifies the value of the Received From field.';
                    ApplicationArea = All;
                }
                field("On Behalf of"; Rec."On Behalf of")
                {
                    ToolTip = 'Specifies the value of the On Behalf of field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                    AssistEdit = true;
                    //Visible = NOT IsSimplePage;
                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        if ChangeExchangeRate.RunModal() = ACTION::OK then
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter());

                        Clear(ChangeExchangeRate);
                    end;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                    ApplicationArea = All;
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ToolTip = 'Specifies the value of the Amount Received field.';
                    ApplicationArea = All;
                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount Received(LCY) field.';
                    ApplicationArea = All;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ToolTip = 'Specifies the value of the Total Line Amount field.';
                    ApplicationArea = All;
                }
                field("Total Line Amount(LCY)"; Rec."Total Line Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Line Amount(LCY) field.';
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
                    Editable = false;
                }
            }
            part(ReceiptLine; "Receipt Line")
            {
                Caption = 'Receipt Line';
                SubPageLink = "Document No." = field("No.");
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
                        PostReceipt.CheckReceiptMandatoryFields(Rec."No.");
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                            Preview := true;
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Template");
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Batch");
                            JTemplate := FundsUserSetup."Receipt Journal Template";
                            JBatch := FundsUserSetup."Receipt Journal Batch";
                            PostReceipt.PostReceipt(Rec."No.", JTemplate, JBatch, Preview);
                        END ELSE BEGIN
                            ERROR(Txt_001, USERID);
                        END;
                    end;
                }
                action("Post Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Post Receipt';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        PostReceipt.CheckReceiptMandatoryFields(Rec."No.");
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                            Preview := false;
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Template");
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Batch");
                            JTemplate := FundsUserSetup."Receipt Journal Template";
                            JBatch := FundsUserSetup."Receipt Journal Batch";
                            PostReceipt.PostReceipt(Rec."No.", JTemplate, JBatch, Preview);
                        END ELSE BEGIN
                            ERROR(Txt_001, USERID);
                        END;
                    end;
                }

                action("Post & Print Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Post & Print Payment';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        PostReceipt.CheckReceiptMandatoryFields(Rec."No.");
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                            Preview := false;
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Template");
                            FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Batch");
                            JTemplate := FundsUserSetup."Receipt Journal Template";
                            JBatch := FundsUserSetup."Receipt Journal Batch";
                            PostReceipt.PostReceipt(Rec."No.", JTemplate, JBatch, Preview);
                            COMMIT;
                            ReceiptHeader.RESET;
                            ReceiptHeader.SETRANGE(ReceiptHeader."No.", Rec."No.");
                            IF ReceiptHeader.FINDFIRST THEN BEGIN
                                REPORT.RUNMODAL(REPORT::"Receipt Header", TRUE, FALSE, ReceiptHeader);
                            END
                        END ELSE BEGIN
                            ERROR(Txt_001, USERID);
                        END;
                    end;
                }
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals', comment = 'ENU="Approvals"';
                    Promoted = true;
                    PromotedCategory = Category5;
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
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    begin
                        PostReceipt.CheckReceiptMandatoryFields(Rec."No.");

                        // IF ReceiptApproval.CheckReceiptHeaderApprovalWorkflowEnabled(Rec) THEN
                        // ReceiptApproval.OnSendReceiptHeaderForApproval(Rec);
                        CurrPage.Close();
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Request', comment = 'ENU="Cancel Approval Request"';
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = CancelApprovalRequest;

                    trigger OnAction()
                    begin
                        //  ReceiptApproval.OnCancelReceiptHeaderForApproval(Rec);
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
        }
        area(Reporting)
        {
            action("Print Receipt")
            {
                ApplicationArea = All;
                Caption = 'Print Receipt', comment = 'ENU="Print Receipt"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Receipt;

                trigger OnAction()
                begin
                    ReceiptHeader.RESET;
                    ReceiptHeader.SETRANGE(ReceiptHeader."No.", Rec."No.");
                    IF ReceiptHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Receipt Header", TRUE, FALSE, ReceiptHeader);
                    END
                end;
            }

        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
        IF (Rec.Status = rec.Status::"Pending Approval") or (Rec.Status = rec.Status::Approved) or (Rec.Status = rec.Status::Posted) THEN BEGIN
            CurrPage.Editable(false);
        END ELSE BEGIN
            CurrPage.Editable(true);
        END;
    end;

    trigger OnOpenPage()
    begin
        ReferenceEditable := true;
        IF (Rec.Status = rec.Status::"Pending Approval") or (Rec.Status = rec.Status::Approved) or (Rec.Status = rec.Status::Posted) THEN BEGIN
            CurrPage.Editable(false);
        END ELSE BEGIN
            CurrPage.Editable(true);
        END;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);


        IF (rec.Status = rec.Status::"Pending Approval") or (rec.Status = rec.Status::Approved) THEN BEGIN
            PageEditable := false;
            ReferenceEditable := true;
        END ELSE BEGIN
            PageEditable := true;
            ReferenceEditable := true;
        END;
        if rec.Status = rec.Status::Posted then begin
            PageEditable := false;
            ReferenceEditable := false;
        end
    end;

    var
        FundsUserSetup: Record "Funds User Setup";
        ReceiptHeader: Record "Receipt Header";
        PostReceipt: Codeunit ReceiptPost;
        // ReceiptApproval: Codeunit "Receipt Approval";
        ApprovalEntries: Record "Approval Entry";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        JTemplate: code[20];
        JBatch: code[20];
        Preview: Boolean;
        PageEditable: Boolean;
        ActionsVisible: Boolean;
        ReferenceEditable: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ChangeExchangeRate: Page "Change Exchange Rate";
        Txt_001: TextConst ENU = 'User Account %1 is not Setup for Receipt Posting, Contact the System Administrator';
}
