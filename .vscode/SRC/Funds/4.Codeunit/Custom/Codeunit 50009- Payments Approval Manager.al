codeunit 50009 "Payments Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckPaymentCardApprovalWorkflowEnabled(var PaymentCard: Record "Payment Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsPaymentCardApprovalWorkflowEnabled(PaymentCard) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsPaymentCardApprovalWorkflowEnabled(var PaymentCard: Record "Payment Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PaymentCard, RunWorkflowOnSendPaymentCardForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    begin
    end;

    local procedure RunWorkflowOnSendPaymentCardForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPaymentCardForApproval'));
    end;

    local procedure RunWorkflowOnCancelPaymentCardApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPaymentCardApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50009, 'OnSendPaymentCardForApproval', '', false, false)]
    local procedure RunWorkflowOnSendPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentCardForApprovalCode, PaymentCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50009, 'OnCancelPaymentCardForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelPaymentCardApprovalRequest(var PaymentCard: Record "Payment Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentCardApprovalRequestCode, PaymentCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPaymentCardForApprovalCode,
                                    DATABASE::"Payment Header", 'Approval of a PaymentCard document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPaymentCardApprovalRequestCode,
                                    DATABASE::"Payment Header", 'An approval request for a PaymentCard document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendPaymentCardForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendPaymentCardForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendPaymentCardForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Payment Header", 0,
                                          DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    procedure ReleaseDocumentCode(): Code[128]
    begin
        exit('RELEASEDOCUMENT');
    end;

    procedure OpenDocumentCode(): Code[128]
    begin
        exit('OPENDOCUMENT');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure CreateResponsesLibrary()
    var
        OpenDocumentTxt: Label 'Reopen the Payment document.';
        ReleaseDocumentTxt: Label 'Release the Payment document.';
        WorkflowRespHandling: Codeunit "Workflow Response Handling";
    begin

        WorkflowRespHandling.AddResponseToLibrary(ReleaseDocumentCode(), 0, ReleaseDocumentTxt, 'GROUP 0');
        WorkflowRespHandling.AddResponseToLibrary(OpenDocumentCode(), 0, OpenDocumentTxt, 'GROUP 0');

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                                        RunWorkflowOnSendPaymentCardForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendPaymentCardForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendPaymentCardForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelPaymentCardApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelPaymentCardApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        PaymentCard: Record "Payment Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Payment Header":
                begin
                    RecRef.SetTable(PaymentCard);
                    PaymentCard.CalcFields("Net Amount");
                    PaymentCard.CalcFields("Net Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Payment;
                    ApprovalEntryArgument."Document No." := PaymentCard."No.";
                    ApprovalEntryArgument.Amount := PaymentCard."Net Amount";
                    ApprovalEntryArgument."Amount (LCY)" := PaymentCard."Net Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := COPYSTR((PaymentCard."Payee Name") + format(PaymentCard."Net Amount"), 1, 250);
                    // ApprovalEntryArgument."Document Source":=COPYSTR(PaymentCard.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentCard: Record "Payment Header";
    begin
        case RecRef.Number of
            DATABASE::"Payment Header":
                begin
                    RecRef.SetTable(PaymentCard);
                    PaymentCard.Validate(Status, PaymentCard.Status::Open);
                    PaymentCard.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PaymentCard: Record "Payment Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Payment Header":
                begin
                    RecRef.SetTable(PaymentCard);
                    PaymentCard.Validate(Status, PaymentCard.Status::"Pending Approval");
                    PaymentCard.Modify(true);
                    Variant := PaymentCard;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentCard: Record "Payment Header";
    begin
        case RecRef.Number of
            DATABASE::"Payment Header":
                begin
                    RecRef.SetTable(PaymentCard);
                    Message(PaymentCard."No.");
                    PaymentCard.Validate(Status, PaymentCard.Status::Approved);
                    PaymentCard.Modify(true);
                    Handled := true;
                    //OnAfterReleaseDocument(PaymentCard);
                    //Handled := true;
                end;
        end;
        Handled := true;
    end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(PaymentCard: Record "Payment Header")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     PaymentCard: Record "Payment Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Payment Header":
    //       begin
    //         RecRef.SetTable(PaymentCard);
    //         PaymentCard.Validate(Status,PaymentCard.Status::Open);
    //         PaymentCard.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        PaymentCard: Record "Payment Header";
    begin
        case RecordRef.Number of
            DATABASE::"Payment Header":
                begin
                    RecordRef.SetTable(PaymentCard);
                    PageID := GetPaymentHeaderPageID(RecordRef);
                end;

        end;
    end;

    procedure GetPaymentHeaderPageID(RecordRef: RecordRef): Integer
    var
        PaymentHeader: Record "Payment Header";
    begin
        //Sysre NextGen Addon
        RecordRef.SETTABLE(PaymentHeader);
        CASE PaymentHeader."Payment Type" OF
            PaymentHeader."Payment Type"::"Cheque Payment":
                EXIT(PAGE::"Payment Card");
            PaymentHeader."Payment Type"::"Cash Payment":
                EXIT(PAGE::"Cash Payment Card");
        END;
    end;
    
}

