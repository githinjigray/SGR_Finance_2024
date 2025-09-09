codeunit 70003 "Procurement Planning Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckProcurementPlanApprovalWorkflowEnabled(var ProcurementPlan: Record "Procurement Planning Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsProcurementPlanApprovalWorkflowEnabled(ProcurementPlan) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsProcurementPlanApprovalWorkflowEnabled(var ProcurementPlan: Record "Procurement Planning Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ProcurementPlan, RunWorkflowOnSendProcurementPlanForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeProcurementPlanCardForApproval(var ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;

    local procedure RunWorkflowOnSendProcurementPlanForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendProcurementPlanForApproval'));
    end;

    local procedure RunWorkflowOnCancelProcurementPlanApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelProcurementPlanApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70003, 'OnSendProcurementPlanForApproval', '', false, false)]
    local procedure RunWorkflowOnSendProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Planning Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProcurementPlanForApprovalCode, ProcurementPlan);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70003, 'OnCancelProcurementPlanForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelProcurementPlanApprovalRequest(var ProcurementPlan: Record "Procurement Planning Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProcurementPlanApprovalRequestCode, ProcurementPlan);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendProcurementPlanForApprovalCode,
                                    DATABASE::"Procurement Planning Header", 'Approval of a Procurement Plan document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelProcurementPlanApprovalRequestCode,
                                    DATABASE::"Procurement Planning Header", 'An approval request for a Procurement Plan document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendProcurementPlanForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendProcurementPlanForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendProcurementPlanForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Procurement Planning Header", 0,
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
                                                        RunWorkflowOnSendProcurementPlanForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendProcurementPlanForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendProcurementPlanForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelProcurementPlanApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelProcurementPlanApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ProcurementPlan: Record "Procurement Planning Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlan);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := ProcurementPlan."No.";
                    ApprovalEntryArgument.Amount := ProcurementPlan."Budget Amount";
                    ApprovalEntryArgument."Amount (LCY)" := ProcurementPlan."Budget Amount";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Procurement Plan';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(ProcurementPlan.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ProcurementPlan: Record "Procurement Planning Header";
    begin
        case RecRef.Number of
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlan);
                    ProcurementPlan.Validate(Status, ProcurementPlan.Status::Open);
                    ProcurementPlan.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ProcurementPlan: Record "Procurement Planning Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlan);
                    ProcurementPlan.Validate(Status, ProcurementPlan.Status::"Pending Approval");
                    ProcurementPlan.Modify(true);
                    Variant := ProcurementPlan;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     ProcurementPlan: Record "Procurement Planning Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Procurement Planning Header":
    //             begin
    //                 RecRef.SetTable(ProcurementPlan);
    //                 ProcurementPlan.Validate(Status, ProcurementPlan.Status::Approved);
    //                 if ProcurementPlan.Modify(true) then
    //                     OnAfterReleaseDocument(ProcurementPlan);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ProcurementPlan: Record "Procurement Planning Header";
    begin
        case RecRef.Number of
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlan);
                    ProcurementPlan.Validate(Status, ProcurementPlan.Status::Open);
                    ProcurementPlan.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        ProcurementPlan: Record "Procurement Planning Header";
    begin
        case RecordRef.Number of
            DATABASE::"Procurement Planning Header":
                begin
                    RecordRef.SetTable(ProcurementPlan);
                    PageID := PAGE::"Procurement Planning Card";
                end;
        end;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    local procedure CheckFieldsBeforeApproval(var ProcurementPlan: Record "Procurement Planning Header")
    begin
    end;
}

