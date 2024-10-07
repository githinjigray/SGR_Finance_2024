codeunit 50008 "Contracts Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckContractCardApprovalWorkflowEnabled(var ContractCard: Record "Contract Request Header"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsContractCardApprovalWorkflowEnabled(ContractCard) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsContractCardApprovalWorkflowEnabled(var ContractCard: Record "Contract Request Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ContractCard, RunWorkflowOnSendContractCardForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendContractCardForApproval(var ContractCard: Record "Contract Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendContractCardForApproval(var ContractCard: Record "Contract Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendContractCardForApproval(var ContractCard: Record "Contract Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelContractCardForApproval(var ContractCard: Record "Contract Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelContractCardForApproval(var ContractCard: Record "Contract Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelContractCardForApproval(var ContractCard: Record "Contract Request Header")
    begin
    end;

    local procedure RunWorkflowOnSendContractCardForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendContractCardForApproval'));
    end;

    local procedure RunWorkflowOnCancelContractCardApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelContractCardApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50008, 'OnSendContractCardForApproval', '', false, false)]
    local procedure RunWorkflowOnSendContractCardForApproval(var ContractCard: Record "Contract Request Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendContractCardForApprovalCode, ContractCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50008, 'OnCancelContractCardForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelContractCardApprovalRequest(var ContractCard: Record "Contract Request Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelContractCardApprovalRequestCode, ContractCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendContractCardForApprovalCode,
                                    DATABASE::"Contract Request Header", 'Approval of a ContractCard document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelContractCardApprovalRequestCode,
                                    DATABASE::"Contract Request Header", 'An approval request for a ContractCard document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendContractCardForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendContractCardForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendContractCardForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Contract Request Header", 0,
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
                                                        RunWorkflowOnSendContractCardForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendContractCardForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendContractCardForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelContractCardApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelContractCardApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ContractCard: Record "Contract Request Header";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Contract';
        ApprovalDescriptionTxt: Label 'Contract of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Contract Request Header":
                begin
                    RecRef.SetTable(ContractCard);
                    ContractCard.CalcFields("Total Amount");
                    ContractCard.CalcFields("Total Amount");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := ContractCard."No.";
                    ApprovalEntryArgument.Amount := ContractCard."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := ContractCard."Total Amount";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := COPYSTR((ContractCard.Description) + format(ContractCard."Total Amount"), 1, 250);
                    // ApprovalEntryArgument."Document Source":=COPYSTR(ContractCard.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ContractCard: Record "Contract Request Header";
    begin
        case RecRef.Number of
            DATABASE::"Contract Request Header":
                begin
                    RecRef.SetTable(ContractCard);
                    ContractCard.Validate(Status, ContractCard.Status::Open);
                    ContractCard.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ContractCard: Record "Contract Request Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Contract Request Header":
                begin
                    RecRef.SetTable(ContractCard);
                    ContractCard.Validate(Status, ContractCard.Status::"Pending Approval");
                    ContractCard.Modify(true);
                    Variant := ContractCard;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ContractCard: Record "Contract Request Header";
    begin
        case RecRef.Number of
            DATABASE::"Contract Request Header":
                begin
                    RecRef.SetTable(ContractCard);
                    ContractCard.Validate(Status, ContractCard.Status::Approved);
                    ContractCard.Modify(true);
                    Handled := true;
                    //OnAfterReleaseDocument(ContractCard);
                    Handled := true;
                end;
        end;
        Handled := true;
    end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(ContractCard: Record "Contract Request Header")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     ContractCard: Record "Contract Request Header";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Contract Request Header":
    //       begin
    //         RecRef.SetTable(ContractCard);
    //         ContractCard.Validate(Status,ContractCard.Status::Open);
    //         ContractCard.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        ContractCard: Record "Contract Request Header";
    begin
        case RecordRef.Number of
            DATABASE::"Contract Request Header":
                begin
                    RecordRef.SetTable(ContractCard);
                    PageID := GetContractHeaderPageID(RecordRef);
                end;

        end;
    end;

    procedure GetContractHeaderPageID(RecordRef: RecordRef): Integer
    var
        ContractHeader: Record "Contract Request Header";
    begin
        //Sysre NextGen Addon
        RecordRef.SETTABLE(ContractHeader);
        // CASE ContractHeader."Contract Type" OF
        //     ContractHeader."Contract Type"::"Cheque Contract":
        //         EXIT(PAGE::"Contract Request Card");            
        // END;
    end;
}

