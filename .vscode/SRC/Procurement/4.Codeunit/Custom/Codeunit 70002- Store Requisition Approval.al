codeunit 70002 "Store Requisition Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckStoreRequisitionApprovalWorkflowEnabled(var StoreRequisition: Record "Store Requisition Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsStoreRequisitionApprovalWorkflowEnabled(StoreRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsStoreRequisitionApprovalWorkflowEnabled(var StoreRequisition: Record "Store Requisition Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(StoreRequisition, RunWorkflowOnSendStoreRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    local procedure RunWorkflowOnSendStoreRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStoreRequisitionForApproval'));
    end;

    local procedure RunWorkflowOnCancelStoreRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStoreRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70002, 'OnSendStoreRequisitionForApproval', '', false, false)]
    local procedure RunWorkflowOnSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStoreRequisitionForApprovalCode, StoreRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70002, 'OnCancelStoreRequisitionForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelStoreRequisitionApprovalRequest(var StoreRequisition: Record "Store Requisition Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStoreRequisitionApprovalRequestCode, StoreRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStoreRequisitionForApprovalCode,
                                    DATABASE::"Store Requisition Header", 'Approval of a Store Requisition document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelStoreRequisitionApprovalRequestCode,
                                    DATABASE::"Store Requisition Header", 'An approval request for a Store Requisition document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendStoreRequisitionForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Store Requisition Header", 0,
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
                                                        RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelStoreRequisitionApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelStoreRequisitionApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        StoreRequisition: Record "Store Requisition Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    StoreRequisition.CalcFields(Amount);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := StoreRequisition."No.";
                    ApprovalEntryArgument.Amount := StoreRequisition.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := StoreRequisition.Amount;
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Store Requisitiopn';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(StoreRequisition.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        StoreRequisition: Record "Store Requisition Header";
    begin
        case RecRef.Number of
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    StoreRequisition.Validate(Status, StoreRequisition.Status::Open);
                    StoreRequisition.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        StoreRequisition: Record "Store Requisition Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    StoreRequisition.Validate(Status, StoreRequisition.Status::"Pending Approval");
                    StoreRequisition.Modify(true);
                    Variant := StoreRequisition;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     StoreRequisition: Record "Store Requisition Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Store Requisition Header":
    //             begin
    //                 RecRef.SetTable(StoreRequisition);
    //                 StoreRequisition.Validate(Status, StoreRequisition.Status::Approved);
    //                 if StoreRequisition.Modify(true) then
    //                     OnAfterReleaseDocument(StoreRequisition);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        StoreRequisition: Record "Store Requisition Header";
    begin
        case RecRef.Number of
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    StoreRequisition.Validate(Status, StoreRequisition.Status::Open);
                    StoreRequisition.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        StoreRequisition: Record "Store Requisition Header";
    begin
        case RecordRef.Number of
            DATABASE::"Store Requisition Header":
                begin
                    RecordRef.SetTable(StoreRequisition);
                    PageID := PAGE::"Store Requisition Card";
                end;
        end;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    local procedure CheckFieldsBeforeApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;
}

