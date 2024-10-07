codeunit 50002 "Payments Approval Manager"
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

    [EventSubscriber(ObjectType::Codeunit, 50002, 'OnSendPaymentCardForApproval', '', false, false)]
    local procedure RunWorkflowOnSendPaymentCardForApproval(var PaymentCard: Record "Payment Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentCardForApprovalCode, PaymentCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50002, 'OnCancelPaymentCardForApproval', '', false, false)]
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

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure AddResponsesToLibraryFT()
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddResponsePredecessorsToLibraryFT(ResponseFunctionName: Code[128])
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
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
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

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentCard: Record "Payment Header";
    begin
        case RecRef.Number of
            DATABASE::"Payment Header":
                begin
                    RecRef.SetTable(PaymentCard);
                    PaymentCard.Validate(Status, PaymentCard.Status::Approved);
                    PaymentCard.Modify(true);
                    Handled := true;
                    //OnAfterReleaseDocument(PaymentCard);
                    Handled := true;
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


    procedure CheckFundsTransferApprovalWorkflowEnabled(var FundsTransfer: Record "Funds Transfer Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsFundsTransferApprovalWorkflowEnabled(FundsTransfer) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsFundsTransferApprovalWorkflowEnabled(var FundsTransfer: Record "Funds Transfer Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FundsTransfer, RunWorkflowOnSendFundsTransferForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    local procedure RunWorkflowOnSendFundsTransferForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFundsTransferForApproval'));
    end;

    local procedure RunWorkflowOnCancelFundsTransferApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFundsTransferApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50002, 'OnSendFundsTransferForApproval', '', false, false)]
    local procedure RunWorkflowOnSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFundsTransferForApprovalCode, FundsTransfer);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50002, 'OnCancelFundsTransferForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelFundsTransferApprovalRequest(var FundsTransfer: Record "Funds Transfer Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFundsTransferApprovalRequestCode, FundsTransfer);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibraryFT()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendFundsTransferForApprovalCode,
                                    DATABASE::"Funds Transfer Header", 'Approval of a Funds Transfer document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelFundsTransferApprovalRequestCode,
                                    DATABASE::"Funds Transfer Header", 'An approval request for a Funds Transfer document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibraryFT(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendFundsTransferForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibraryFT()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Funds Transfer Header", 0,
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
                                                        RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendFundsTransferForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelFundsTransferApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelFundsTransferApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgumentFT(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        FundsTransfer: Record "Funds Transfer Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.CalcFields("Line Amount");
                    FundsTransfer.CalcFields("Line Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := FundsTransfer."No.";
                    ApprovalEntryArgument.Amount := FundsTransfer."Line Amount";
                    ApprovalEntryArgument."Amount (LCY)" := FundsTransfer."Line Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    // ApprovalEntryArgument.Description:='Funds Transfer';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(FundsTransfer.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocumentFT(RecRef: RecordRef; var Handled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::Open);
                    FundsTransfer.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApprovalFT(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::"Pending Approval");
                    FundsTransfer.Modify(true);
                    Variant := FundsTransfer;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    local procedure ReleaseDocumentFundsTransfer(RecRef: RecordRef; var Handled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::Approved);
                    if FundsTransfer.Modify(true) then
                        OnAfterReleaseDocumentFundsTransfer(FundsTransfer);
                    Handled := true;
                end;
        end;
        Handled := true;
    end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocumentFundsTransfer(FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     FundsTransfer: Record "Funds Transfer Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Funds Transfer Header":
    //       begin
    //         RecRef.SetTable(FundsTransfer);
    //         FundsTransfer.Validate(Status,FundsTransfer.Status::Open);
    //         FundsTransfer.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageIDfundsTransfer(RecordRef: RecordRef; var PageID: Integer)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecordRef.Number of
            DATABASE::"Funds Transfer Header":
                begin
                    RecordRef.SetTable(FundsTransfer);
                    PageID := PAGE::"Funds Transfer Card";
                end;
        end;
    end;

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

    [EventSubscriber(ObjectType::Codeunit, 50003, 'OnSendImprestHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnSendImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestHeaderForApprovalCode, ImprestHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50003, 'OnCancelImprestHeaderForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelImprestHeaderApprovalRequest(var ImprestHeader: Record "Imprest Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestHeaderApprovalRequestCode, ImprestHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibraryIMP()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestHeaderForApprovalCode,
                                    DATABASE::"Imprest Header", 'Approval of a Imprest Header document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestHeaderApprovalRequestCode,
                                    DATABASE::"Imprest Header", 'An approval request for a Imprest Header document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibraryIMP(EventFunctionName: Code[128])
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
    local procedure AddTableRelationsToLibraryIMP()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Imprest Header", 0,
                                          DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure AddResponsesToLibraryIMP()
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddResponsePredecessorsToLibraryIMP(ResponseFunctionName: Code[128])
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
    local procedure PopulateApprovalEntryArgumentIMP(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
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
    procedure OpenDocumentIMP(RecRef: RecordRef; var Handled: Boolean)
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
    local procedure SetStatusToPendingApprovalIMP(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
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

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    local procedure ReleaseDocumentIMP(RecRef: RecordRef; var Handled: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
    begin
        case RecRef.Number of
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::Approved);
                    if ImprestHeader.Modify(true) then
                        OnAfterReleaseDocumentIMP(ImprestHeader);
                    Handled := true;
                end;
        end;
        Handled := true;
    end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocumentIMP(ImprestHeader: Record "Imprest Header")
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
    local procedure GetPageIDIMP(RecordRef: RecordRef; var PageID: Integer)
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




