codeunit 50028 "Salary Advance Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckSalaryAdvanceApprovalWorkflowEnabled(var SalaryAdvance: Record "Salary Advance Request"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsSalaryAdvanceApprovalWorkflowEnabled(SalaryAdvance) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsSalaryAdvanceApprovalWorkflowEnabled(var SalaryAdvance: Record "Salary Advance Request"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(SalaryAdvance, RunWorkflowOnSendSalaryAdvanceForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance Request")
    begin
    end;

    local procedure RunWorkflowOnSendSalaryAdvanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSalaryAdvanceForApproval'));
    end;

    local procedure RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSalaryAdvanceApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50028, 'OnSendSalaryAdvanceForApproval', '', false, false)]
    local procedure RunWorkflowOnSendSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance Request")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSalaryAdvanceForApprovalCode, SalaryAdvance);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50028, 'OnCancelSalaryAdvanceForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelSalaryAdvanceApprovalRequest(var SalaryAdvance: Record "Salary Advance Request")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode, SalaryAdvance);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendSalaryAdvanceForApprovalCode,
                                    DATABASE::"Salary Advance Request", 'Approval of a Salary Advance document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode,
                                    DATABASE::"Salary Advance Request", 'An approval request for a Salary Advance document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendSalaryAdvanceForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Salary Advance Request", 0,
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
                                                        RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalaryAdvance: Record "Salary Advance Request";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Salary Advance Request":
                begin
                    RecRef.SetTable(SalaryAdvance);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := SalaryAdvance."No.";
                    ApprovalEntryArgument.Amount := SalaryAdvance.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := SalaryAdvance."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Salary Advance';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(SalaryAdvance.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        SalaryAdvance: Record "Salary Advance Request";
    begin
        case RecRef.Number of
            DATABASE::"Salary Advance Request":
                begin
                    RecRef.SetTable(SalaryAdvance);
                    SalaryAdvance.Validate(Status, SalaryAdvance.Status::Open);
                    SalaryAdvance.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        SalaryAdvance: Record "Salary Advance Request";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Salary Advance Request":
                begin
                    RecRef.SetTable(SalaryAdvance);
                    SalaryAdvance.Validate(Status, SalaryAdvance.Status::"Pending Approval");
                    SalaryAdvance.Modify(true);
                    Variant := SalaryAdvance;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     SalaryAdvance: Record "Salary Advance Request";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Salary Advance Request":
    //             begin
    //                 RecRef.SetTable(SalaryAdvance);
    //                 SalaryAdvance.Validate(Status, SalaryAdvance.Status::Approved);
    //                 SalaryAdvance.Modify(true);
    //                 Handled := true;
    //                 //OnAfterReleaseDocument(SalaryAdvance);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(PaymentCard: Record "Payment Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     SalaryAdvance: Record "Salary Advance Request";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Salary Advance Request":
    //             begin
    //                 RecRef.SetTable(SalaryAdvance);
    //                 SalaryAdvance.Validate(Status, SalaryAdvance.Status::Open);
    //                 SalaryAdvance.Modify(true);
    //                 Handled := true;
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    // local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    // var
    //     SalaryAdvance: Record "Salary Advance Request";
    // begin
    //     case RecordRef.Number of
    //         DATABASE::"Salary Advance Request":
    //             begin
    //                 RecordRef.SetTable(SalaryAdvance);
    //                 PageID := PAGE::"Salary Advance Card";
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    // local procedure CheckFieldsBeforeApproval(PaymentCard: Record "Payment Header")
    // begin
    // end;
}

