codeunit 50014 "Document Reversal Approval"
{

    // trigger OnRun()
    // begin
    // end;

    // var
    //     ApprovalEntry: Record "Approval Entry";

    // procedure CheckDocumentReversalApprovalWorkflowEnabled(var DocumentReversal: Record "Document Reversal Header"): Boolean
    // var
    //     NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    // begin
    //     if not IsDocumentReversalApprovalWorkflowEnabled(DocumentReversal) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;

    // local procedure IsDocumentReversalApprovalWorkflowEnabled(var DocumentReversal: Record "Document Reversal Header"): Boolean
    // var
    //     WorkflowManagement: Codeunit "Workflow Management";
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(DocumentReversal, RunWorkflowOnSendDocumentReversalForApprovalCode));
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnBeforeSendDocumentReversalForApproval(var DocumentReversal: Record "Document Reversal Header")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendDocumentReversalForApproval(var DocumentReversal: Record "Document Reversal Header")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnAfterSendDocumentReversalForApproval(var DocumentReversal: Record "Document Reversal Header")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnBeforeCancelDocumentReversalForApproval(var DocumentReversal: Record "Document Reversal Header")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelDocumentReversalForApproval(var DocumentReversal: Record "Document Reversal Header")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnAfterCancelDocumentReversalForApproval(var DocumentReversal: Record "Document Reversal Header")
    // begin
    // end;

    // local procedure RunWorkflowOnSendDocumentReversalForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendDocumentReversalForApproval'));
    // end;

    // local procedure RunWorkflowOnCancelDocumentReversalApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelDocumentReversalApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 50014, 'OnSendDocumentReversalForApproval', '', false, false)]
    // local procedure RunWorkflowOnSendDocumentReversalForApproval(var DocumentReversal: Record "Document Reversal Header")
    // var
    //     WorkflowManagement: Codeunit "Workflow Management";
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendDocumentReversalForApprovalCode, DocumentReversal);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 50014, 'OnCancelDocumentReversalForApproval', '', false, false)]
    // local procedure RunWorkflowOnCancelDocumentReversalApprovalRequest(var DocumentReversal: Record "Document Reversal Header")
    // var
    //     WorkflowManagement: Codeunit "Workflow Management";
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelDocumentReversalApprovalRequestCode, DocumentReversal);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    // local procedure AddEventsToLibrary()
    // var
    //     WorkflowEventHandling: Codeunit "Workflow Event Handling";
    // begin
    //     WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendDocumentReversalForApprovalCode,
    //                                 DATABASE::"Document Reversal Header", 'Approval of a Document Reversal document is requested.', 0, false);
    //     WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDocumentReversalApprovalRequestCode,
    //                                 DATABASE::"Document Reversal Header", 'An approval request for a Document Reversal document is canceled.', 0, false);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    // local procedure AddEventPredecessorsToLibrary(EventFunctionName: Code[128])
    // var
    //     WorkflowEventHandling: Codeunit "Workflow Event Handling";
    // begin
    //     WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode,
    //                                               RunWorkflowOnSendDocumentReversalForApprovalCode);
    //     WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode,
    //                                               RunWorkflowOnSendDocumentReversalForApprovalCode);
    //     WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode,
    //                                               RunWorkflowOnSendDocumentReversalForApprovalCode);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]
    // local procedure AddTableRelationsToLibrary()
    // var
    //     WorkflowSetup: Codeunit "Workflow Setup";
    // begin
    //     WorkflowSetup.InsertTableRelation(DATABASE::"Document Reversal Header", 0,
    //                                       DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    // local procedure AddResponsesToLibrary()
    // var
    //     WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    // local procedure AddResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    // var
    //     WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    // begin
    //     WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
    //                                                     RunWorkflowOnSendDocumentReversalForApprovalCode);
    //     WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode,
    //                                                     RunWorkflowOnSendDocumentReversalForApprovalCode);
    //     WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
    //                                                     RunWorkflowOnSendDocumentReversalForApprovalCode);
    //     WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
    //                                                     RunWorkflowOnCancelDocumentReversalApprovalRequestCode);//To Ammend
    //     WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
    //                                                     RunWorkflowOnCancelDocumentReversalApprovalRequestCode);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    // local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    // var
    //     GeneralLedgerSetup: Record "General Ledger Setup";
    //     DocumentReversal: Record "Document Reversal Header";
    //     CurrencyCode: Code[10];
    //     DocumentTypeTxt: Label '%1 Payment';
    //     ApprovalDescriptionTxt: Label 'Payment of %1:%2 to %3.';
    // begin
    //     GeneralLedgerSetup.Reset;
    //     GeneralLedgerSetup.Get;
    //     GeneralLedgerSetup.TestField("LCY Code");

    //     case RecRef.Number of
    //         DATABASE::"Document Reversal Header":
    //             begin
    //                 RecRef.SetTable(DocumentReversal);
    //                 //DocumentReversal.CALCFIELDS(Amount);
    //                 // DocumentReversal.CALCFIELDS("Amount (LCY)");
    //                 ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
    //                 ApprovalEntryArgument."Document No." := DocumentReversal."No.";
    //                 ApprovalEntryArgument.Amount := DocumentReversal.Amount;
    //                 ApprovalEntryArgument."Amount (LCY)" := DocumentReversal."Amount (LCY)";
    //                 ApprovalEntryArgument."Currency Code" := CurrencyCode;
    //                 //ApprovalEntryArgument.Description:='Document Reversal';
    //                 // ApprovalEntryArgument."Document Source":=COPYSTR(DocumentReversal.Description,0,MAXSTRLEN(ApprovalEntryArgument."Document Source"));
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    // local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     DocumentReversal: Record "Document Reversal Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Document Reversal Header":
    //             begin
    //                 RecRef.SetTable(DocumentReversal);
    //                 DocumentReversal.Validate(Status, DocumentReversal.Status::Open);
    //                 DocumentReversal.Modify(true);
    //                 Handled := true;
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]
    // local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    // var
    //     DocumentReversal: Record "Document Reversal Header";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number of
    //         DATABASE::"Document Reversal Header":
    //             begin
    //                 RecRef.SetTable(DocumentReversal);
    //                 DocumentReversal.Validate(Status, DocumentReversal.Status::"Pending Approval");
    //                 DocumentReversal.Modify(true);
    //                 Variant := DocumentReversal;
    //                 IsHandled := true;
    //             end;
    //     end;
    //     IsHandled := true;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    // local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    // var
    //     DocumentReversal: Record "Document Reversal Header";
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Document Reversal Header":
    //             begin
    //                 RecRef.SetTable(DocumentReversal);
    //                 DocumentReversal.Validate(Status, DocumentReversal.Status::Approved);
    //                 if DocumentReversal.Modify(true) then
    //                     OnAfterReleaseDocument(DocumentReversal);
    //                 Handled := true;
    //             end;
    //     end;
    //     Handled := true;
    // end;

    // [BusinessEvent(false)]
    // local procedure OnAfterReleaseDocument(var DocumentReversal: Record "Document Reversal Header")
    // begin
    // end;

    // // [EventSubscriber(ObjectType::Codeunit, 51535079, 'OnRejectDocument', '', false, false)]
    // // local procedure RejectDocument(RecRef: RecordRef;var Handled: Boolean)
    // // var
    // //     DocumentReversal: Record "Document Reversal Header";
    // // begin
    // //     case RecRef.Number of
    // //       DATABASE::"Document Reversal Header":
    // //       begin
    // //         RecRef.SetTable(DocumentReversal);
    // //         DocumentReversal.Validate(Status,DocumentReversal.Status::Open);
    // //         DocumentReversal.Modify(true);
    // //         Handled:=true;
    // //       end;
    // //     end;
    // // end;

    // [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    // local procedure GetPageID(RecordRef: RecordRef; var PageID: Integer)
    // var
    //     DocumentReversal: Record "Document Reversal Header";
    // begin
    //     case RecordRef.Number of
    //         DATABASE::"Document Reversal Header":
    //             begin
    //                 RecordRef.SetTable(DocumentReversal);
    //                 PageID := PAGE::"Document Reversal Card";
    //             end;
    //     end;
    // end;
}

