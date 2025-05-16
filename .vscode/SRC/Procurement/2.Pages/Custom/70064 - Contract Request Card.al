page 70064 "Contract Request Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Actions,Budgeting,Category6_caption,Category7_caption,RequestToApprove,Category9_caption,Category10_caption';
    SourceTable = "Contract Request Header";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field("Commencement Date"; rec."Commencement Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field(Duration; rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Expiry Notification Period"; rec."Expiry Notification Period")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created DateTime"; rec."Created DateTime")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
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
            systempart(Control31; Links)
            {
                Visible = false;
            }
            systempart(Control30; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
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

                    // IF ContractApprovalManager.CheckContractCardApprovalWorkflowEnabled(Rec) THEN
                    //     ContractApprovalManager.OnSendContractCardForApproval(Rec);
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
                    // ContractApprovalManager.OnCancelContractCardForApproval(Rec);
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
                var
                    ApprovalEntries: Record "Approval Entry";
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
            action("Update Contract List")
            {
                Caption = 'Update Contract List';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ContractList: Record "Contract Header2";
                    UpdatedContractList: Record "Contract Header2";
                begin
                    rec.TestField(Description);
                    rec.TestField("Account Type");
                    rec.TestField("Account No.");
                    rec.TestField("Contract Type");
                    rec.TestField("Commencement Date");

                    if Confirm('Are you sure you want to update the contract request details into the contract list?') then begin
                        ContractList.Init();
                        ContractList.TransferFields(Rec);
                        if not ContractList.Insert() then ContractList.Modify();

                        UpdatedContractList.Reset();
                        UpdatedContractList.SetRange("No.", rec."No.");
                        if UpdatedContractList.FindFirst() then begin
                            UpdatedContractList.Status := UpdatedContractList.Status::Approved;
                            UpdatedContractList."Contract Status" := UpdatedContractList."Contract Status"::Active;
                            UpdatedContractList.Modify();
                        end;
                        Message('Added.Updated Successfully!');
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(rec.RECORDID);

        IF rec.Status = rec.Status::Approved THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        IF rec.Status = rec.Status::Approved THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        // ContractApprovalManager: Codeunit Codeunit51535781;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
    // ContractApprovalManager: Codeunit "Contracts Approval Manager";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (NOT HasIncomingDocument) AND (rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RECORDID);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(rec.RECORDID, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

