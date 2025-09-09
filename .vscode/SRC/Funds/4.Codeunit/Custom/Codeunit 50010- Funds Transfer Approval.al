codeunit 50010 "Funds Transfer Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckFundsTransferApprovalWorkflowEnabled(var FundsTransfer: Record "Funds Transfer Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsFundsTransferApprovalWorkflowEnabled(FundsTransfer) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsFundsTransferApprovalWorkflowEnabled(var FundsTransfer: Record "Funds Transfer Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FundsTransfer, RunWorkflowOnSendFundsTransferForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    local procedure RunWorkflowOnSendFundsTransferForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFundsTransferForApproval'));
    end;

    local procedure RunWorkflowOnCancelFundsTransferApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFundsTransferApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50010, 'OnSendFundsTransferForApproval', '', false, false)]
    local procedure RunWorkflowOnSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFundsTransferForApprovalCode, FundsTransfer);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50010, 'OnCancelFundsTransferForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelFundsTransferApprovalRequest(var FundsTransfer: Record "Funds Transfer Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFundsTransferApprovalRequestCode, FundsTransfer);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendFundsTransferForApprovalCode,
                                    DATABASE::"Funds Transfer Header", 'Approval of a Funds Transfer document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelFundsTransferApprovalRequestCode,
                                    DATABASE::"Funds Transfer Header", 'An approval request for a Funds Transfer document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendFundsTransferForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Funds Transfer Header", 0,
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
                                                        RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelFundsTransferApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelFundsTransferApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        FundsTransfer: Record "Funds Transfer Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.CalcFields("Line Amount");
                    FundsTransfer.CalcFields("Line Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := FundsTransfer."No.";
                    ApprovalEntryArgument.Amount := FundsTransfer."Line Amount";
                    ApprovalEntryArgument."Amount (LCY)" := FundsTransfer."Line Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    // ApprovalEntryArgument.Description:='Funds Transfer';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(FundsTransfer.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::Open);
                    FundsTransfer.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::"Pending Approval");
                    FundsTransfer.Modify(true);
                    Variant := FundsTransfer;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     FundsTransfer: Record "Funds Transfer Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Funds Transfer Header":
    //             begin
    //                 RecRef.SetTable(FundsTransfer);
    //                 FundsTransfer.Validate(Status, FundsTransfer.Status::Approved);
    //                 if FundsTransfer.Modify(true) then
    //                     OnAfterReleaseDocument(FundsTransfer);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     FundsTransfer: Record "Funds Transfer Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Funds Transfer Header":
    //       begin
    //         RecRef.SetTable(FundsTransfer);
    //         FundsTransfer.Validate(Status,FundsTransfer.Status::Open);
    //         FundsTransfer.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecordRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecordRef.SetTable(FundsTransfer);
                    PageID := PAGE::"Funds Transfer Card";
                end;
        end;
    end;


}

