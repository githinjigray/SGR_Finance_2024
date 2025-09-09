codeunit 50022 "Receipt Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckReceiptHeaderApprovalWorkflowEnabled(var ReceiptHeader: Record "Receipt Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsReceiptHeaderApprovalWorkflowEnabled(ReceiptHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsReceiptHeaderApprovalWorkflowEnabled(var ReceiptHeader: Record "Receipt Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ReceiptHeader, RunWorkflowOnSendReceiptHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    begin
    end;

    local procedure RunWorkflowOnSendReceiptHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendReceiptHeaderForApproval'));
    end;

    local procedure RunWorkflowOnCancelReceiptHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelReceiptHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50022, 'OnSendReceiptHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnSendReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendReceiptHeaderForApprovalCode, ReceiptHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50022, 'OnCancelReceiptHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelReceiptHeaderApprovalRequest(var ReceiptHeader: Record "Receipt Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelReceiptHeaderApprovalRequestCode, ReceiptHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendReceiptHeaderForApprovalCode,
                                    DATABASE::"Receipt Header", 'Approval of a ReceiptHeader document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelReceiptHeaderApprovalRequestCode,
                                    DATABASE::"Receipt Header", 'An approval request for a ReceiptHeader document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendReceiptHeaderForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Receipt Header", 0,
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
                                                        RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelReceiptHeaderApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelReceiptHeaderApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ReceiptHeader: Record "Receipt Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Receipt Header":
                begin
                    RecRef.SetTable(ReceiptHeader);
                    ReceiptHeader.CalcFields("Total Line Amount");
                    ReceiptHeader.CalcFields("Total Line Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := ReceiptHeader."No.";
                    ApprovalEntryArgument.Amount := ReceiptHeader."Total Line Amount";
                    ApprovalEntryArgument."Amount (LCY)" := ReceiptHeader."Total Line Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := COPYSTR((ReceiptHeader.Description) + format(ReceiptHeader."Total Line Amount"), 1, 250);
                    // ApprovalEntryArgument."Document Source":=COPYSTR(ReceiptHeader.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        case RecRef.Number of
            DATABASE::"Receipt Header":
                begin
                    RecRef.SetTable(ReceiptHeader);
                    ReceiptHeader.Validate(Status, ReceiptHeader.Status::Open);
                    ReceiptHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Receipt Header":
                begin
                    RecRef.SetTable(ReceiptHeader);
                    ReceiptHeader.Validate(Status, ReceiptHeader.Status::"Pending Approval");
                    ReceiptHeader.Modify(true);
                    Variant := ReceiptHeader;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     ReceiptHeader: Record "Receipt Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Receipt Header":
    //             begin
    //                 RecRef.SetTable(ReceiptHeader);
    //                 ReceiptHeader.Validate(Status, ReceiptHeader.Status::Approved);
    //                 ReceiptHeader.Modify(true);
    //                 Handled := true;
    //                 //OnAfterReleaseDocument(ReceiptHeader);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(ReceiptHeader: Record "Receipt Header")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     ReceiptHeader: Record "Receipt Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Receipt Header":
    //       begin
    //         RecRef.SetTable(ReceiptHeader);
    //         ReceiptHeader.Validate(Status,ReceiptHeader.Status::Open);
    //         ReceiptHeader.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        case RecordRef.Number of
            DATABASE::"Receipt Header":
                begin
                    RecordRef.SetTable(ReceiptHeader);
                    PageID := GetReceiptHeaderPageID(RecordRef);
                end;

        end;
    end;

    procedure GetReceiptHeaderPageID(RecordRef: RecordRef): Integer
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        //Sysre NextGen Addon
        RecordRef.SETTABLE(ReceiptHeader);
        EXIT(PAGE::"Receipt Card");
    end;
}

