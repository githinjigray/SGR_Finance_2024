codeunit 70000 "RFQ Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckRFQHeaderApprovalWorkflowEnabled(var RFQHeader: Record "Request for Quotation Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsRFQHeaderApprovalWorkflowEnabled(RFQHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsRFQHeaderApprovalWorkflowEnabled(var RFQHeader: Record "Request for Quotation Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(RFQHeader, RunWorkflowOnSendRFQHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendRFQHeaderForApproval(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendRFQHeaderForApproval(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendRFQHeaderForApproval(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelRFQHeaderForApproval(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRFQHeaderForApproval(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelRFQHeaderForApproval(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;

    local procedure RunWorkflowOnSendRFQHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendRFQHeaderForApproval'));
    end;

    local procedure RunWorkflowOnCancelRFQHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelRFQHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70000, 'OnSendRFQHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnSendRFQHeaderForApproval(var RFQHeader: Record "Request for Quotation Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRFQHeaderForApprovalCode, RFQHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70000, 'OnCancelRFQHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelRFQHeaderApprovalRequest(var RFQHeader: Record "Request for Quotation Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRFQHeaderApprovalRequestCode, RFQHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRFQHeaderForApprovalCode,
                                    DATABASE::"Request for Quotation Header", 'Approval of a RFQ Header document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRFQHeaderApprovalRequestCode,
                                    DATABASE::"Request for Quotation Header", 'An approval request for a RFQ Header document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendRFQHeaderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendRFQHeaderForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendRFQHeaderForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Request for Quotation Header", 0,
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
                                                        RunWorkflowOnSendRFQHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendRFQHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendRFQHeaderForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelRFQHeaderApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelRFQHeaderApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        RFQHeader: Record "Request for Quotation Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Request for Quotation Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.CalcFields(Amount);
                    RFQHeader.CalcFields("Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := RFQHeader."No.";
                    ApprovalEntryArgument.Amount := RFQHeader.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := RFQHeader."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Request For Quotation';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(RFQHeader.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        RFQHeader: Record "Request for Quotation Header";
    begin
        case RecRef.Number of
            DATABASE::"Request for Quotation Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate(Status, RFQHeader.Status::Open);
                    RFQHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        RFQHeader: Record "Request for Quotation Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Request for Quotation Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate(Status, RFQHeader.Status::"Pending Approval");
                    RFQHeader.Modify(true);
                    Variant := RFQHeader;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     RFQHeader: Record "Request for Quotation Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Request for Quotation Header":
    //             begin
    //                 RecRef.SetTable(RFQHeader);
    //                 RFQHeader.Validate(Status, RFQHeader.Status::Released);
    //                 if RFQHeader.Modify(true) then
    //                     OnAfterReleaseDocument(RFQHeader);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        RFQHeader: Record "Request for Quotation Header";
    begin
        case RecRef.Number of
            DATABASE::"Request for Quotation Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate(Status, RFQHeader.Status::Open);
                    RFQHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        RFQHeader: Record "Request for Quotation Header";
    begin
        case RecordRef.Number of
            DATABASE::"Request for Quotation Header":
                begin
                    RecordRef.SetTable(RFQHeader);
                    PageID := PAGE::"Request for Quotation Card";
                end;
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    local procedure CheckFieldsBeforeApproval(var RFQHeader: Record "Request for Quotation Header")
    begin
    end;
}

