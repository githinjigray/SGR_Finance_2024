codeunit 50013 "Journal Voucher Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckJournalVoucherApprovalWorkflowEnabled(var JournalVoucher: Record "Journal Voucher Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsJournalVoucherApprovalWorkflowEnabled(JournalVoucher) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsJournalVoucherApprovalWorkflowEnabled(var JournalVoucher: Record "Journal Voucher Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(JournalVoucher, RunWorkflowOnSendJournalVoucherForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendJournalVoucherForApproval(var JournalVoucher: Record "Journal Voucher Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendJournalVoucherForApproval(var JournalVoucher: Record "Journal Voucher Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendJournalVoucherForApproval(var JournalVoucher: Record "Journal Voucher Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelJournalVoucherForApproval(var JournalVoucher: Record "Journal Voucher Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelJournalVoucherForApproval(var JournalVoucher: Record "Journal Voucher Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelJournalVoucherForApproval(var JournalVoucher: Record "Journal Voucher Header")
    begin
    end;

    local procedure RunWorkflowOnSendJournalVoucherForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendJournalVoucherForApproval'));
    end;

    local procedure RunWorkflowOnCancelJournalVoucherApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelJournalVoucherApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50013, 'OnSendJournalVoucherForApproval', '', false, false)]
    local procedure RunWorkflowOnSendJournalVoucherForApproval(var JournalVoucher: Record "Journal Voucher Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendJournalVoucherForApprovalCode, JournalVoucher);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50013, 'OnCancelJournalVoucherForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelJournalVoucherApprovalRequest(var JournalVoucher: Record "Journal Voucher Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelJournalVoucherApprovalRequestCode, JournalVoucher);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendJournalVoucherForApprovalCode,
                                    DATABASE::"Journal Voucher Header", 'Approval of a Journal Voucher document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelJournalVoucherApprovalRequestCode,
                                    DATABASE::"Journal Voucher Header", 'An approval request for a Journal Voucher document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendJournalVoucherForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendJournalVoucherForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendJournalVoucherForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Journal Voucher Header", 0,
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
                                                        RunWorkflowOnSendJournalVoucherForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendJournalVoucherForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendJournalVoucherForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelJournalVoucherApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelJournalVoucherApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        JournalVoucher: Record "Journal Voucher Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Journal Voucher Header":
                begin
                    RecRef.SetTable(JournalVoucher);
                    JournalVoucher.CalcFields("Total Amount");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := JournalVoucher."JV No.";
                    ApprovalEntryArgument.Amount := JournalVoucher."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := JournalVoucher."Total Amount";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    //ApprovalEntryArgument.Description:='Journal Voucher';
                    //ApprovalEntryArgument."Document Source":=COPYSTR(JournalVoucher.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        JournalVoucher: Record "Journal Voucher Header";
    begin
        case RecRef.Number of
            DATABASE::"Journal Voucher Header":
                begin
                    RecRef.SetTable(JournalVoucher);
                    JournalVoucher.Validate(Status, JournalVoucher.Status::Open);
                    JournalVoucher.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        JournalVoucher: Record "Journal Voucher Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Journal Voucher Header":
                begin
                    RecRef.SetTable(JournalVoucher);
                    JournalVoucher.Validate(Status, JournalVoucher.Status::"Pending Approval");
                    JournalVoucher.Modify(true);
                    Variant := JournalVoucher;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     JournalVoucher: Record "Journal Voucher Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Journal Voucher Header":
    //             begin
    //                 RecRef.SetTable(JournalVoucher);
    //                 JournalVoucher.Validate(Status, JournalVoucher.Status::Approved);
    //                 if JournalVoucher.Modify(true) then
    //                     Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var JournalVoucher: Record "Journal Voucher Header")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     JournalVoucher: Record "Journal Voucher Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Journal Voucher Header":
    //       begin
    //         RecRef.SetTable(JournalVoucher);
    //         JournalVoucher.Validate(Status,JournalVoucher.Status::Open);
    //         JournalVoucher.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    // local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    // var
    //     JournalVoucher: Record "Journal Voucher Header";
    // begin
    //     case RecordRef.Number of
    //         DATABASE::"Journal Voucher Header":
    //             begin
    //                 RecordRef.SetTable(JournalVoucher);
    //                 PageID := PAGE::"Journal Voucher Card";
    //             end;
    //     end;
    // end;
}

