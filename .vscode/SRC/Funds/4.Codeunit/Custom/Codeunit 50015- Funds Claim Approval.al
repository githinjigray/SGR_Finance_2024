codeunit 50015 "Funds Claim Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckFundsClaimApprovalWorkflowEnabled(var FundsClaimHeader: Record "Funds Claim Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsFundsClaimApprovalWorkflowEnabled(FundsClaimHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsFundsClaimApprovalWorkflowEnabled(var FundsClaimHeader: Record "Funds Claim Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FundsClaimHeader, RunWorkflowOnSendFundsClaimForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendFundsClaimForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendFundsClaimForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendFundsClaimForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelFundsClaimForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelFundsClaimForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelFundsClaimForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    begin
    end;

    local procedure RunWorkflowOnSendFundsClaimForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFundsClaimForApproval'));
    end;

    local procedure RunWorkflowOnCancelFundsClaimApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFundsClaimApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50015, 'OnSendFundsClaimForApproval', '', false, false)]
    local procedure RunWorkflowOnSendFundsClaimForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFundsClaimForApprovalCode, FundsClaimHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50015, 'OnCancelFundsClaimForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelFundsClaimApprovalRequest(var FundsClaimHeader: Record "Funds Claim Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFundsClaimApprovalRequestCode, FundsClaimHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendFundsClaimForApprovalCode,
                                    DATABASE::"Funds Claim Header", 'Approval of a Funds Claim document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelFundsClaimApprovalRequestCode,
                                    DATABASE::"Funds Claim Header", 'An approval request for a Funds Claim document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendFundsClaimForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendFundsClaimForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendFundsClaimForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Funds Claim Header", 0,
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
                                                        RunWorkflowOnSendFundsClaimForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendFundsClaimForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendFundsClaimForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelFundsClaimApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelFundsClaimApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Funds Claim Header":
                begin
                    RecRef.SetTable(FundsClaimHeader);
                    FundsClaimHeader.CalcFields(Amount);
                    FundsClaimHeader.CalcFields("Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Funds Claim Request";
                    ApprovalEntryArgument."Document No." := FundsClaimHeader."No.";
                    ApprovalEntryArgument.Amount := FundsClaimHeader.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := FundsClaimHeader."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    // ApprovalEntryArgument.Description:='Funds Claim';
                    //  ApprovalEntryArgument."Document Source":=COPYSTR(FundsClaimHeader.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        case RecRef.Number of
            DATABASE::"Funds Claim Header":
                begin
                    RecRef.SetTable(FundsClaimHeader);
                    FundsClaimHeader.Validate(Status, FundsClaimHeader.Status::Open);
                    FundsClaimHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Funds Claim Header":
                begin
                    RecRef.SetTable(FundsClaimHeader);
                    FundsClaimHeader.Validate(Status, FundsClaimHeader.Status::"Pending Approval");
                    FundsClaimHeader.Modify(true);
                    Variant := FundsClaimHeader;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     FundsClaimHeader: Record "Funds Claim Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Funds Claim Header":
    //             begin
    //                 RecRef.SetTable(FundsClaimHeader);
    //                 FundsClaimHeader.Validate(Status, FundsClaimHeader.Status::Approved);
    //                 if FundsClaimHeader.Modify(true) then
    //                     OnAfterReleaseDocument(FundsClaimHeader);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var FundsClaimHeader: Record "Funds Claim Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     FundsClaimHeader: Record "Funds Claim Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Funds Claim Header":
    //       begin
    //         RecRef.SetTable(FundsClaimHeader);
    //         FundsClaimHeader.Validate(Status,FundsClaimHeader.Status::Open);
    //         FundsClaimHeader.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        case RecordRef.Number of
            DATABASE::"Funds Claim Header":
                begin
                    RecordRef.SetTable(FundsClaimHeader);
                    PageID := PAGE::"Funds Claim Card";
                end;
        end;
    end;
}

