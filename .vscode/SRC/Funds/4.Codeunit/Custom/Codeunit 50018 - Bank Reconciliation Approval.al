codeunit 50018 "Bank Reconciliation Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckBankReconciliationApprovalWorkflowEnabled(var BankReconciliation: Record "Bank Acc. Reconciliation"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsBankReconciliationApprovalWorkflowEnabled(BankReconciliation) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsBankReconciliationApprovalWorkflowEnabled(var BankReconciliation: Record "Bank Acc. Reconciliation"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(BankReconciliation, RunWorkflowOnSendBankReconciliationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendBankReconciliationForApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendBankReconciliationForApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendBankReconciliationForApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelBankReconciliationForApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelBankReconciliationForApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelBankReconciliationForApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    local procedure RunWorkflowOnSendBankReconciliationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBankReconciliationForApproval'));
    end;

    local procedure RunWorkflowOnCancelBankReconciliationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBankReconciliationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50018, 'OnSendBankReconciliationForApproval', '', false, false)]
    local procedure RunWorkflowOnSendBankReconciliationForApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBankReconciliationForApprovalCode, BankReconciliation);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50018, 'OnCancelBankReconciliationForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelBankReconciliationApprovalRequest(var BankReconciliation: Record "Bank Acc. Reconciliation")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankReconciliationApprovalRequestCode, BankReconciliation);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendBankReconciliationForApprovalCode,
                                    DATABASE::"Bank Acc. Reconciliation", 'Approval of a Bank Reconciliation document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBankReconciliationApprovalRequestCode,
                                    DATABASE::"Bank Acc. Reconciliation", 'An approval request for a Bank Reconciliation document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendBankReconciliationForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Bank Acc. Reconciliation", 0,
                                          DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure AddResponsesToLibrary()
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                                        RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelBankReconciliationApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelBankReconciliationApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        BankReconciliation: Record "Bank Acc. Reconciliation";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliation);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := BankReconciliation."Statement No.";
                    ApprovalEntryArgument."Document Source" := BankReconciliation."Bank Account No.";
                    ApprovalEntryArgument.Amount := BankReconciliation."Statement Ending Balance";
                    ApprovalEntryArgument."Amount (LCY)" := BankReconciliation."Statement Ending Balance";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Bank Reconciliation';
                    //ApprovalEntryArgument."Document Source" := BankReconciliation."Bank Account No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BankReconciliation: Record "Bank Acc. Reconciliation";
    begin
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliation);
                    BankReconciliation.Validate(Status, BankReconciliation.Status::Open);
                    BankReconciliation.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        BankReconciliation: Record "Bank Acc. Reconciliation";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliation);
                    BankReconciliation.Validate(Status, BankReconciliation.Status::"Pending Approval");
                    BankReconciliation.Modify(true);
                    Variant := BankReconciliation;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     BankReconciliation: Record "Bank Acc. Reconciliation";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Bank Acc. Reconciliation":
    //             begin
    //                 RecRef.SetTable(BankReconciliation);
    //                 BankReconciliation.Validate(Status, BankReconciliation.Status::Approved);
    //                 if BankReconciliation.Modify(true) then
    //                     OnAfterReleaseDocument(BankReconciliation);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BankReconciliation: Record "Bank Acc. Reconciliation";
    begin
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliation);
                    BankReconciliation.Validate(Status, BankReconciliation.Status::Open);
                    BankReconciliation.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        BankReconciliation: Record "Bank Acc. Reconciliation";
    begin
        case RecordRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecordRef.SetTable(BankReconciliation);
                    PageID := PAGE::"Bank Acc. Reconciliation";
                end;
        end;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    local procedure CheckFieldsBeforeApproval(var BankReconciliation: Record "Bank Acc. Reconciliation")
    begin
    end;
}

