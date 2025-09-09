codeunit 70004 "Purchase Requisition Approval"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntry: Record "Approval Entry";

    procedure CheckPurchaseRequisitionApprovalWorkflowEnabled(var PurchaseRequisition: Record "Purchase Requisitions"): Boolean
    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    begin
        if not IsPurchaseRequisitionApprovalWorkflowEnabled(PurchaseRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsPurchaseRequisitionApprovalWorkflowEnabled(var PurchaseRequisition: Record "Purchase Requisitions"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PurchaseRequisition, RunWorkflowOnSendPurchaseRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSendurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeCancePurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCancelPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    local procedure RunWorkflowOnSendPurchaseRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseRequisitionForApproval'));
    end;

    local procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70004, 'OnSendPurchaseRequisitionForApproval', '', false, false)]
    local procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseRequisitionForApprovalCode, PurchaseRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70004, 'OnCancelPurchaseRequisitionForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisition: Record "Purchase Requisitions")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode, PurchaseRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPurchaseRequisitionForApprovalCode,
                                    DATABASE::"Purchase Requisitions", 'Approval of a Purchase Requisition document is requested.', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode,
                                    DATABASE::"Purchase Requisitions", 'An approval request for a Purchase Requisition document is canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
                                                  RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
                                                  RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
                                                  RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    local procedure AddTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Purchase Requisitions", 0,
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
                                                        RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
                                                        RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                                        RunWorkflowOnSendPurchaseRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                                        RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode);//To Ammend
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                                        RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseRequisition: Record "Purchase Requisitions";
        CurrencyCode: Code[10];
        DocumentTypeTxt: Label '%1 Payment';
        ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");

        case RecRef.Number of
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisition);
                    PurchaseRequisition.CalcFields(Amount);
                    PurchaseRequisition.CalcFields("Amount(LCY)");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := PurchaseRequisition."No.";
                    ApprovalEntryArgument.Amount := PurchaseRequisition.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := PurchaseRequisition."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := CurrencyCode;
                    ApprovalEntryArgument.Description := 'Purchase Requisition';
                    // ApprovalEntryArgument."Document Source":=COPYSTR(PurchaseRequisition.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PurchaseRequisition: Record "Purchase Requisitions";
    begin
        case RecRef.Number of
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisition);
                    PurchaseRequisition.Validate(Status, PurchaseRequisition.Status::Open);
                    PurchaseRequisition.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PurchaseRequisition: Record "Purchase Requisitions";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisition);
                    PurchaseRequisition.Validate(Status, PurchaseRequisition.Status::"Pending Approval");
                    PurchaseRequisition.Modify(true);
                    Variant := PurchaseRequisition;
                    IsHandled := true;
                end;
        end;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     PurchaseRequisition: Record "Purchase Requisitions";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Purchase Requisitions":
    //             begin
    //                 RecRef.SetTable(PurchaseRequisition);
    //                 PurchaseRequisition.Validate(Status, PurchaseRequisition.Status::Approved);
    //                 if PurchaseRequisition.Modify(true) then
    //                     CreateApprovalEmail(PurchaseRequisition."No.");
    //                 //OnAfterReleaseDocument(PurchaseRequisition);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    [BusinessEvent(false)]
    local procedure OnAfterReleaseDocument(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    //[EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    local procedure RejectDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PurchaseRequisition: Record "Purchase Requisitions";
    begin
        case RecRef.Number of
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisition);
                    PurchaseRequisition.Validate(Status, PurchaseRequisition.Status::Open);
                    PurchaseRequisition.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    var
        PurchaseRequisition: Record "Purchase Requisitions";
    begin
        case RecordRef.Number of
            DATABASE::"Purchase Requisitions":
                begin
                    RecordRef.SetTable(PurchaseRequisition);
                    PageID := PAGE::"Purchase Requisition Card";
                end;
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 51535002, 'OnBeforeSendPaymentForApproval', '', false, false)]
    local procedure CheckFieldsBeforeApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    local procedure InsertEmailMessage("Sender Name": Text[100]; "Sender Address": Text[80]; Subject: Text[100]; Recipients: Text[250]; "Recipients CC": Text[250]; "Recipients BCC": Text[250]; Body: Text; "DocumentNo.": Code[20]) EmailMessageInserted: Boolean
    var
        ProcurementEmailMessages: Record "Procurement Email Messages";
        EmailBodyText: BigText;
        EmailBodyOutStream: OutStream;
    begin
        EmailMessageInserted := false;

        ProcurementEmailMessages.Init;
        ProcurementEmailMessages."Entry No." := 0;
        ProcurementEmailMessages."Sender Name" := "Sender Name";
        ProcurementEmailMessages."Sender Address" := "Sender Address";
        ProcurementEmailMessages.Subject := Subject;
        ProcurementEmailMessages.Recipients := Recipients;
        ProcurementEmailMessages."Recipients CC" := "Recipients CC";
        ProcurementEmailMessages."Recipients BCC" := "Recipients BCC";
        EmailBodyText.AddText(Body);
        ProcurementEmailMessages.Body.CreateOutStream(EmailBodyOutStream);
        EmailBodyText.Write(EmailBodyOutStream);
        ProcurementEmailMessages.HtmlFormatted := true;
        ProcurementEmailMessages."Created By" := UserId;
        ProcurementEmailMessages."Date Created" := Today;
        ProcurementEmailMessages."Time Created" := Time;
        ProcurementEmailMessages."Document No." := "DocumentNo.";
        if ProcurementEmailMessages.Insert then
            EmailMessageInserted := true;
    end;

    procedure CreateApprovalEmail("RequestNo.": Code[20])
    var
        PurchaseRequisitions: Record "Purchase Requisitions";
        Customer: Record Customer;
        //  SMTPMail: Record "SMTP Mail Setup";
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
    // SMTPMailSetup: Record "SMTP Mail Setup";
    begin
        PurchaseRequisitions.Get("RequestNo.");
        PurchaseRequisitions.CalcFields(PurchaseRequisitions.Amount);

        CompanyInformation.Get;

        UserSetup.Reset;
        UserSetup.SetRange("User ID", PurchaseRequisitions."User ID");
        if UserSetup.FindSet then begin
            repeat
                //SMTPMailSetup.Get;
                EmailBody := '';
                EmailBody := EmailBody + 'Dear ' + UserSetup."User ID" + ',<br><br>';
                EmailBody := EmailBody + 'Here are details of a purchase requisition that has been approved under your system USER ID.: ' + '<br>';
                EmailBody := EmailBody + '_____________________________________________________________________________<br>';
                EmailBody := EmailBody + 'Request No.: ' + PurchaseRequisitions."No." + '<br>';
                EmailBody := EmailBody + 'Date: ' + Format(PurchaseRequisitions."Requested Receipt Date") + '<br>';
                EmailBody := EmailBody + 'Amount: ' + Format(PurchaseRequisitions.Amount) + '<br>';
                EmailBody := EmailBody + 'Description: ' + PurchaseRequisitions.Description + '<br>';
                EmailBody := EmailBody + 'Find attached Requisition ' + '.<br>';
                EmailBody := EmailBody + 'Regards ' + '.<br><br>';
                EmailBody := EmailBody + '_____________________________________________________________________________<br>';
                EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

                CompanyInformation.Get;
                SenderName := 'Microsoft Dynamics 365 BC';
                //  SenderAddress:=SMTPMailSetup."User ID";
                Subject := 'Purchase Request - ' + PurchaseRequisitions."No." + '-' + Format(PurchaseRequisitions."Requested Receipt Date");
                Recipients := UserSetup."E-Mail";
                RecipientsBCC := '';

                if Recipients <> '' then
                    InsertEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, PurchaseRequisitions."No.");

            until UserSetup.Next = 0;
        end;
    end;
}

