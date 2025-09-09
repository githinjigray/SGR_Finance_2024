codeunit 70005 "Prequalification Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckVendorPrequalificationApprovalWorkflowEnabled(var VendorPrequalification: Record "Prequlification Application"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsVendorPrequalificationApprovalWorkflowEnabled(VendorPrequalification) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsVendorPrequalificationApprovalWorkflowEnabled(var VendorPrequalification: Record "Prequlification Application"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(VendorPrequalification, RunWorkflowOnSendVendorPrequalificationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;

    local procedure RunWorkflowOnSendVendorPrequalificationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendVendorPrequalificationForApproval'));
    end;

    local procedure RunWorkflowOnCancelVendorPrequalificationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelVendorPrequalificationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70005, 'OnSendVendorPrequalificationForApproval', '', false, false)]
    local procedure RunWorkflowOnSendVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendVendorPrequalificationForApprovalCode, VendorPrequalification);
    end;

    // [EventSubscriber(ObjectType::Codeunit, 70008, 'OnCancelVendorPrequalificationForApproval', '', false, false)]
    // local procedure RunWorkflowOnCancelVendorPrequalificationApprovalRequest(var VendorPrequalification: Record "Prequlification Application")
    // var
    //     WorkflowManagement: Codeunit "Workflow Management";
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelVendorPrequalificationApprovalRequestCode,VendorPrequalification);
    // end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendVendorPrequalificationForApprovalCode,
                                    DATABASE::"Prequlification Application", 'Approval of a Vendor Prequalification document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelVendorPrequalificationApprovalRequestCode,
                                    DATABASE::"Prequlification Application", 'An approval request for a Vendor Prequalification document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendVendorPrequalificationForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendVendorPrequalificationForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendVendorPrequalificationForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Prequlification Application", 0,
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
                                                        RunWorkflowOnSendVendorPrequalificationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendVendorPrequalificationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendVendorPrequalificationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelVendorPrequalificationApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelVendorPrequalificationApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        VendorPrequalification: Record "Prequlification Application";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Prequlification Application":
                begin
                    RecRef.SetTable(VendorPrequalification);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := Format(VendorPrequalification.Int);
                    ApprovalEntryArgument.Amount := 1;
                    ApprovalEntryArgument."Amount (LCY)" := 1;
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Vendor Prequalification';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(VendorPrequalification.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        VendorPrequalification: Record "Prequlification Application";
    begin
        case RecRef.Number of
            DATABASE::"Prequlification Application":
                begin
                    RecRef.SetTable(VendorPrequalification);
                    VendorPrequalification.Validate(Status, VendorPrequalification.Status::Open);
                    VendorPrequalification.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        VendorPrequalification: Record "Prequlification Application";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Prequlification Application":
                begin
                    RecRef.SetTable(VendorPrequalification);
                    VendorPrequalification.Validate(Status, VendorPrequalification.Status::"Pending Approval");
                    VendorPrequalification.Modify(true);
                    Variant := VendorPrequalification;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     VendorPrequalification: Record "Prequlification Application";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Prequlification Application":
    //             begin
    //                 RecRef.SetTable(VendorPrequalification);
    //                 VendorPrequalification.Validate(Status, VendorPrequalification.Status::Approved);
    //                 if VendorPrequalification.Modify(true) then
    //                     OnAfterReleaseDocument(VendorPrequalification);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     VendorPrequalification: Record "Prequlification Application";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Prequlification Application":
    //       begin
    //         RecRef.SetTable(VendorPrequalification);
    //         VendorPrequalification.Validate(Status,VendorPrequalification.Status::Open);
    //         VendorPrequalification.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        VendorPrequalification: Record "Prequlification Application";
    begin
        case RecordRef.Number of
            DATABASE::"Prequlification Application":
                begin
                    RecordRef.SetTable(VendorPrequalification);
                    PageID := PAGE::"Pre-Qualified App. Card";
                end;
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    // local procedure CheckFieldsBeforeApproval(var VendorPrequalification: Record "Prequlification Application")
    // begin
    // end;
}

