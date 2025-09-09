codeunit 70001 "Bid Analysis Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckBidAnalysisApprovalWorkflowEnabled(var BidAnalysis: Record "Bid Analysis Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsBidAnalysisApprovalWorkflowEnabled(BidAnalysis) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsBidAnalysisApprovalWorkflowEnabled(var BidAnalysis: Record "Bid Analysis Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(BidAnalysis, RunWorkflowOnSendBidAnalysisForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    local procedure RunWorkflowOnSendBidAnalysisForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBidAnalysisForApproval'));
    end;

    local procedure RunWorkflowOnCancelBidAnalysisApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBidAnalysisApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70001, 'OnSendBidAnalysisForApproval', '', false, false)]
    local procedure RunWorkflowOnSendBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBidAnalysisForApprovalCode, BidAnalysis);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70001, 'OnCancelBidAnalysisForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelBidAnalysisApprovalRequest(var BidAnalysis: Record "Bid Analysis Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBidAnalysisApprovalRequestCode, BidAnalysis);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendBidAnalysisForApprovalCode,
                                    DATABASE::"Bid Analysis Header", 'Approval of a Bid Analysis document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBidAnalysisApprovalRequestCode,
                                    DATABASE::"Bid Analysis Header", 'An approval request for a Bid Analysis document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendBidAnalysisForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendBidAnalysisForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendBidAnalysisForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Bid Analysis Header", 0,
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
                                                        RunWorkflowOnSendBidAnalysisForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendBidAnalysisForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendBidAnalysisForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelBidAnalysisApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelBidAnalysisApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        BidAnalysis: Record "Bid Analysis Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    // BidAnalysis.CALCFIELDS("Net Amount");
                    // BidAnalysis.CALCFIELDS("Net Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := BidAnalysis."No.";
                    ApprovalEntryArgument.Amount := 1;
                    ApprovalEntryArgument."Amount (LCY)" := 1;
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Bid Analysis';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(BidAnalysis.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BidAnalysis: Record "Bid Analysis Header";
    begin
        case RecRef.Number of
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    BidAnalysis.Validate(Status, BidAnalysis.Status::Open);
                    BidAnalysis.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        BidAnalysis: Record "Bid Analysis Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    BidAnalysis.Validate(Status, BidAnalysis.Status::"Pending Approval");
                    BidAnalysis.Modify(true);
                    Variant := BidAnalysis;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     BidAnalysis: Record "Bid Analysis Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Bid Analysis Header":
    //             begin
    //                 RecRef.SetTable(BidAnalysis);
    //                 BidAnalysis.Validate(Status, BidAnalysis.Status::Released);
    //                 if BidAnalysis.Modify(true) then
    //                     OnAfterReleaseDocument(BidAnalysis);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BidAnalysis: Record "Bid Analysis Header";
    begin
        case RecRef.Number of
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    BidAnalysis.Validate(Status, BidAnalysis.Status::Open);
                    BidAnalysis.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        BidAnalysis: Record "Bid Analysis Header";
    begin
        case RecordRef.Number of
            DATABASE::"Bid Analysis Header":
                begin
                    RecordRef.SetTable(BidAnalysis);
                    PageID := PAGE::"Bid Analysis Card";
                end;
        end;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    local procedure CheckFieldsBeforeApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;
}

