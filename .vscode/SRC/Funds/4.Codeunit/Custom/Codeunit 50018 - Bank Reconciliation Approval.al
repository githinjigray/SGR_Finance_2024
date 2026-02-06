codeunit 50018 "Bank Reconciliation Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        FundsCategoryTxt: Label 'Funds Management';
        FundsCategoryDescriptionTxt: Label 'Funds Management Workflows';
        WorkflowSetup: Codeunit "Workflow Setup";
        EmpReqApprWorkflowCodeTxt: Label 'BREC';
        EmpReqApprWorkflowDescTxt: Label 'Bank Reconciliation Approval Workflow';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', false, false)]
    local procedure C1502_WorkflowSetup_OnAddWorkflowCategoriesToLibrary()
    begin
        WorkflowSetup.InsertWorkflowCategory(FundsCategoryTxt, FundsCategoryDescriptionTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInitWorkflowTemplates', '', false, false)]
    local procedure C1502_OnAfterInitWorkflowTemplates()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
        BankRecHeader: Record "Bank Acc. Reconciliation";
        ApprovalEntry: Record "Approval Entry";
        WorkflowTemplate: Record Workflow;
    begin

        WorkflowSetup.InsertTableRelation(DATABASE::"Bank Acc. Reconciliation", 0,
          DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));

        InsertBankReconciliationApprovalWorkflowTemplate();
    end;

    local procedure InsertBankReconciliationApprovalWorkflowTemplate()
    var
        WorkflowTemplates: Record Workflow;
        Workflow: Record Workflow;
    begin

        WorkflowTemplates.Reset();
        WorkflowTemplates.SetRange(Code, 'MS-' + EmpReqApprWorkflowCodeTxt);
        WorkflowTemplates.SetRange(Template, true);
        if not WorkflowTemplates.FindFirst() then begin
            WorkflowSetup.InsertWorkflowTemplate(Workflow, EmpReqApprWorkflowCodeTxt,
                      EmpReqApprWorkflowDescTxt, FundsCategoryTxt);
            InsertBankReconciliationApprovalWorkflowDetails(Workflow);
            WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
        end;
    end;

    local procedure InsertBankReconciliationApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        BankRecHeader: Record "Bank Acc. Reconciliation";
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
    begin
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument,
          WorkflowStepArgument."Approver Type"::"Salesperson/Purchaser", WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
          0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow,
          BuildBankRecHeaderConditions(BankRecHeader.Status::Open),
          RunWorkflowOnSendBankReconciliationForApprovalCode(),
          BuildBankRecHeaderConditions(BankRecHeader.Status::"Pending Approval"),
          RunWorkflowOnCancelBankReconciliationApprovalRequestCode(),
          WorkflowStepArgument, true);
    end;

    procedure BuildBankRecHeaderConditions(Status: Option Open,"Pending Approval",Approved): Text
    var
        BankRecHeader: Record "Bank Acc. Reconciliation";
        BankRecHeaderTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Bank Acc. Reconciliation">%1</DataItem><DataItem name="Bank Acc. Reconciliation Line">%2</DataItem></DataItems></ReportParameters>';
    begin
        BankRecHeader.SetRange(Status, Status);
        exit(StrSubstNo(BankRecHeaderTypeCondnTxt, WorkflowSetup.Encode(BankRecHeader.GetView(false))));
    end;


    procedure CheckBankReconciliationApprovalWorkflowEnabled(var BankReconciliations: Record "Bank Acc. Reconciliation"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsBankReconciliationApprovalWorkflowEnabled(BankReconciliations) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsBankReconciliationApprovalWorkflowEnabled(var BankReconciliations: Record "Bank Acc. Reconciliation"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(BankReconciliations, RunWorkflowOnSendBankReconciliationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendBankReconciliationForApproval(var BankReconciliations: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendBankReconciliationForApproval(var BankReconciliations: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendBankReconciliationForApproval(var BankReconciliations: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancelBankReconciliationForApproval(var BankReconciliations: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelBankReconciliationForApproval(var BankReconciliations: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelBankReconciliationForApproval(var BankReconciliations: Record "Bank Acc. Reconciliation")
    begin
    end;

    local procedure RunWorkflowOnSendBankReconciliationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBankReconciliationForApproval'));
    end;

    local procedure RunWorkflowOnCancelBankReconciliationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBankReconciliationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 50018, 'OnSendBankReconciliationForApproval', '', false, false)]
    local procedure RunWorkflowOnSendBankReconciliationForApproval(var BankReconciliations: Record "Bank Acc. Reconciliation")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBankReconciliationForApprovalCode, BankReconciliations);
    end;

    [EventSubscriber(ObjectType::Codeunit, 50018, 'OnCancelBankReconciliationForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelBankReconciliationApprovalRequest(var BankReconciliations: Record "Bank Acc. Reconciliation")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankReconciliationApprovalRequestCode, BankReconciliations);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendBankReconciliationForApprovalCode,
                                    DATABASE::"Bank Acc. Reconciliation", 'Approval of a BankReconciliations document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBankReconciliationApprovalRequestCode,
                                    DATABASE::"Bank Acc. Reconciliation", 'An approval request for a BankReconciliation document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendBankReconciliationForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Bank Acc. Reconciliation", 0,
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
                                                        RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendBankReconciliationForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelBankReconciliationApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelBankReconciliationApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        BankReconciliations: Record "Bank Acc. Reconciliation";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliations);
                    // ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Employee Requisition";
                    ApprovalEntryArgument."Document No." := BankReconciliations."Statement No.";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Bank Reconciliation';
                    ApprovalEntryArgument."Document Source" := COPYSTR(BankReconciliations."Statement No.", 1, 250);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BankReconciliations: Record "Bank Acc. Reconciliation";
    begin
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliations);
                    BankReconciliations.Validate(Status, BankReconciliations.Status::Open);
                    BankReconciliations.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        BankReconciliations: Record "Bank Acc. Reconciliation";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliations);
                    BankReconciliations.Validate(Status, BankReconciliations.Status::"Pending Approval");
                    BankReconciliations.Modify(true);
                    Variant := BankReconciliations;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BankReconciliations: Record "Bank Acc. Reconciliation";
    begin
        case RecRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankReconciliations);
                    BankReconciliations.Validate(Status, BankReconciliations.Status::Approved);
                    if BankReconciliations.Modify(true) then
                        OnAfterReleaseDocument(BankReconciliations);
                    Handled := true;
                end;
        end;
    end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var BankReconciliations: Record "Bank Acc. Reconciliation")
    begin
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // var
    //     BankReconciliations: Record "Bank Acc. Reconciliation";
    // begin
    //     case RecRef.Number of
    //       DATABASE::"Bank Acc. Reconciliation":
    //       begin
    //         RecRef.SetTable(BankReconciliations);
    //         BankReconciliations.Validate(Status,BankReconciliations.Status::Rejected);
    //         BankReconciliations.Validate("Rejected By",UserId);
    //         BankReconciliations.Validate("Rejected DateTime",CurrentDateTime);
    //         BankReconciliations.Modify(true);
    //         Handled:=true;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        BankReconciliations: Record "Bank Acc. Reconciliation";
    begin
        case RecordRef.Number of
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecordRef.SetTable(BankReconciliations);
                    PageID := Page::"Bank Acc. Reconciliation";

                end;
        end;
    end;
}


