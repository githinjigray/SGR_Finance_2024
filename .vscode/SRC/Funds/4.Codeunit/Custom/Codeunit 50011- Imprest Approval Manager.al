codeunit 50011 "Imprest Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckImprestHeaderApprovalWorkflowEnabled(var ImprestHeader: Record "Imprest Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsImprestHeaderApprovalWorkflowEnabled(ImprestHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsImprestHeaderApprovalWorkflowEnabled(var ImprestHeader: Record "Imprest Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ImprestHeader, RunWorkflowOnSendImprestHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    begin
    end;

    local procedure RunWorkflowOnSendImprestHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestHeaderForApproval'));
    end;

    local procedure RunWorkflowOnCancelImprestHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50011, 'OnSendImprestHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnSendImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestHeaderForApprovalCode, ImprestHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50011, 'OnCancelImprestHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelImprestHeaderApprovalRequest(var ImprestHeader: Record "Imprest Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestHeaderApprovalRequestCode, ImprestHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestHeaderForApprovalCode,
                                    DATABASE::"Imprest Header", 'Approval of a Imprest Header document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestHeaderApprovalRequestCode,
                                    DATABASE::"Imprest Header", 'An approval request for a Imprest Header document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendImprestHeaderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendImprestHeaderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendImprestHeaderForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Imprest Header", 0,
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
                                                        RunWorkflowOnSendImprestHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendImprestHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendImprestHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelImprestHeaderApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelImprestHeaderApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ImprestHeader: Record "Imprest Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
        ImprestDescriptionTxt: Label 'Imprest Request';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.CalcFields(Amount);
                    ImprestHeader.CalcFields("Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Imprest Request";
                    ApprovalEntryArgument."Document No." := ImprestHeader."No.";
                    ApprovalEntryArgument.Amount := ImprestHeader.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := ImprestHeader."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := ImprestDescriptionTxt;
                    // ApprovalEntryArgument."Document Source":=COPYSTR(ImprestHeader.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
    begin
        case RecRef.Number of
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::Open);
                    ImprestHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::"Pending Approval");
                    ImprestHeader.Modify(true);
                    Variant := ImprestHeader;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     ImprestHeader: Record "Imprest Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Imprest Header":
    //             begin
    //                 RecRef.SetTable(ImprestHeader);
    //                 ImprestHeader.Validate(Status, ImprestHeader.Status::Approved);
    //                 if ImprestHeader.Modify(true) then
    //                     OnAfterReleaseDocument(ImprestHeader);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(ImprestHeader: Record "Imprest Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     ImprestHeader: Record "Imprest Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Imprest Header":
    //       begin
    //         RecRef.SetTable(ImprestHeader);
    //         ImprestHeader.Validate(Status,ImprestHeader.Status::Open);
    //         ImprestHeader.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        ImprestHeader: Record "Imprest Header";
    begin
        case RecordRef.Number of
            DATABASE::"Imprest Header":
                begin
                    RecordRef.SetTable(ImprestHeader);
                    PageID := PAGE::"Imprest Card";
                end;
        end;
    end;
}

