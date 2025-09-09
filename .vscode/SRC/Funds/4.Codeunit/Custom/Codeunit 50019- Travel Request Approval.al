codeunit 50019 "Travel Request Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckTravelVoucherApprovalWorkflowEnabled(var TravelVoucher: Record "Travel Request Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsTravelVoucherApprovalWorkflowEnabled(TravelVoucher) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsTravelVoucherApprovalWorkflowEnabled(var TravelVoucher: Record "Travel Request Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TravelVoucher, RunWorkflowOnSendTravelVoucherForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendTravelVoucherForApproval(var TravelVoucher: Record "Travel Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTravelVoucherForApproval(var TravelVoucher: Record "Travel Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendTravelVoucherForApproval(var TravelVoucher: Record "Travel Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelTravelVoucherForApproval(var TravelVoucher: Record "Travel Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTravelVoucherForApproval(var TravelVoucher: Record "Travel Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelTravelVoucherForApproval(var TravelVoucher: Record "Travel Request Header")
    begin
    end;

    local procedure RunWorkflowOnSendTravelVoucherForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTravelVoucherForApproval'));
    end;

    local procedure RunWorkflowOnCancelTravelVoucherApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTravelVoucherApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50019, 'OnSendTravelVoucherForApproval', '', false, false)]
    local procedure RunWorkflowOnSendTravelVoucherForApproval(var TravelVoucher: Record "Travel Request Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTravelVoucherForApprovalCode, TravelVoucher);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50019, 'OnCancelTravelVoucherForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelTravelVoucherApprovalRequest(var TravelVoucher: Record "Travel Request Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTravelVoucherApprovalRequestCode, TravelVoucher);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTravelVoucherForApprovalCode,
                                    DATABASE::"Travel Request Header", 'Approval of a Travel Voucher document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTravelVoucherApprovalRequestCode,
                                    DATABASE::"Travel Request Header", 'An approval request for a Travel Voucher document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendTravelVoucherForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendTravelVoucherForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendTravelVoucherForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Travel Request Header", 0,
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
                                                        RunWorkflowOnSendTravelVoucherForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendTravelVoucherForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendTravelVoucherForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelTravelVoucherApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelTravelVoucherApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        TravelVoucher: Record "Travel Request Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Travel Request Header":
                begin
                    RecRef.SetTable(TravelVoucher);
                    TravelVoucher.CalcFields(Amount);
                    TravelVoucher.CalcFields("Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Travel Request";
                    ApprovalEntryArgument."Document No." := TravelVoucher."No.";
                    ApprovalEntryArgument.Amount := TravelVoucher.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := TravelVoucher."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Travel Request';
                    //  ApprovalEntryArgument."Document Source":=COPYSTR(TravelVoucher.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        TravelVoucher: Record "Travel Request Header";
    begin
        case RecRef.Number of
            DATABASE::"Travel Request Header":
                begin
                    RecRef.SetTable(TravelVoucher);
                    TravelVoucher.Validate(Status, TravelVoucher.Status::Open);
                    TravelVoucher.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        TravelVoucher: Record "Travel Request Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Travel Request Header":
                begin
                    RecRef.SetTable(TravelVoucher);
                    TravelVoucher.Validate(Status, TravelVoucher.Status::"Pending Approval");
                    TravelVoucher.Modify(true);
                    Variant := TravelVoucher;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     TravelVoucher: Record "Travel Request Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Travel Request Header":
    //             begin
    //                 RecRef.SetTable(TravelVoucher);
    //                 TravelVoucher.Validate(Status, TravelVoucher.Status::Approved);
    //                 if TravelVoucher.Modify(true) then
    //                     OnAfterReleaseDocument(TravelVoucher);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(TravelVoucher: Record "Travel Request Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     TravelVoucher: Record "Travel Request Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Travel Request Header":
    //             begin
    //                 RecRef.SetTable(TravelVoucher);
    //                 TravelVoucher.Validate(Status, TravelVoucher.Status::Open);
    //                 TravelVoucher.Modify(true);
    //                 Handled := true;
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    // local procedure GetPageID(RecordRef: RecordRef;var PageID: Integer)
    // var
    //     TravelVoucher: Record "Travel Request Header";
    // begin
    //     case RecordRef.Number of
    //       DATABASE::"Travel Request Header":
    //       begin
    //         RecordRef.SetTable(TravelVoucher);
    //         PageID:=PAGE::Page51535681;
    //       end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    // local procedure CheckFieldsBeforeApproval(TravelVoucher: Record "Travel Request Header")
    // begin
    // end;
}

