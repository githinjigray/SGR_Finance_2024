codeunit 50012 "Imprest Surrender Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckImprestsurrenderApprovalWorkflowEnabled(var Imprestsurrender: Record "Imprest Surrender Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsImprestsurrenderApprovalWorkflowEnabled(Imprestsurrender) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsImprestsurrenderApprovalWorkflowEnabled(var Imprestsurrender: Record "Imprest Surrender Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Imprestsurrender, RunWorkflowOnSendImprestsurrenderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendImprestsurrenderForApproval(var Imprestsurrender: Record "Imprest Surrender Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendImprestsurrenderForApproval(var Imprestsurrender: Record "Imprest Surrender Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendImprestsurrenderForApproval(var Imprestsurrender: Record "Imprest Surrender Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelImprestsurrenderForApproval(var Imprestsurrender: Record "Imprest Surrender Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelImprestsurrenderForApproval(var Imprestsurrender: Record "Imprest Surrender Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelImprestsurrenderForApproval(var Imprestsurrender: Record "Imprest Surrender Header")
    begin
    end;

    local procedure RunWorkflowOnSendImprestsurrenderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestsurrenderForApproval'));
    end;

    local procedure RunWorkflowOnCancelImprestsurrenderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestsurrenderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50012, 'OnSendImprestsurrenderForApproval', '', false, false)]
    local procedure RunWorkflowOnSendImprestsurrenderForApproval(var Imprestsurrender: Record "Imprest Surrender Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestsurrenderForApprovalCode, Imprestsurrender);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50012, 'OnCancelImprestsurrenderForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelImprestsurrenderApprovalRequest(var Imprestsurrender: Record "Imprest Surrender Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestsurrenderApprovalRequestCode, Imprestsurrender);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestsurrenderForApprovalCode,
                                    DATABASE::"Imprest Surrender Header", 'Approval of a Imprest surrender document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestsurrenderApprovalRequestCode,
                                    DATABASE::"Imprest Surrender Header", 'An approval request for a Imprest surrender document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendImprestsurrenderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendImprestsurrenderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendImprestsurrenderForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Imprest Surrender Header", 0,
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
                                                        RunWorkflowOnSendImprestsurrenderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendImprestsurrenderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendImprestsurrenderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelImprestsurrenderApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelImprestsurrenderApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Imprestsurrender: Record "Imprest Surrender Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(Imprestsurrender);
                    Imprestsurrender.CalcFields(Amount);
                    Imprestsurrender.CalcFields("Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Imprest Accounting";
                    ApprovalEntryArgument."Document No." := Imprestsurrender."No.";
                    ApprovalEntryArgument.Amount := Imprestsurrender.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := Imprestsurrender."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Imprest Surrender';
                    //ApprovalEntryArgument."Document Source":=COPYSTR(Imprestsurrender.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Imprestsurrender: Record "Imprest Surrender Header";
    begin
        case RecRef.Number of
            DATABASE::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(Imprestsurrender);
                    Imprestsurrender.Validate(Status, Imprestsurrender.Status::Open);
                    Imprestsurrender.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Imprestsurrender: Record "Imprest Surrender Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(Imprestsurrender);
                    Imprestsurrender.Validate(Status, Imprestsurrender.Status::"Pending Approval");
                    Imprestsurrender.Modify(true);
                    Variant := Imprestsurrender;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     Imprestsurrender: Record "Imprest Surrender Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Imprest Surrender Header":
    //             begin
    //                 RecRef.SetTable(Imprestsurrender);
    //                 Imprestsurrender.Validate(Status, Imprestsurrender.Status::Approved);
    //                 if Imprestsurrender.Modify(true) then
    //                     OnAfterReleaseDocument(Imprestsurrender);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(Imprestsurrender: Record "Imprest Surrender Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     Imprestsurrender: Record "Imprest Surrender Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Imprest Surrender Header":
    //       begin
    //         RecRef.SetTable(Imprestsurrender);
    //         Imprestsurrender.Validate(Status,Imprestsurrender.Status::Open);
    //         Imprestsurrender.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        Imprestsurrender: Record "Imprest Surrender Header";
    begin
        case RecordRef.Number of
            DATABASE::"Imprest Surrender Header":
                begin
                    RecordRef.SetTable(Imprestsurrender);
                    PageID := PAGE::"Imprest Surrender Card";
                end;
        end;
    end;
}

