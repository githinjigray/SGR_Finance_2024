codeunit 70504 "Inventory Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        InventoryWorkflowEvents: Codeunit "Inventory Workflow Events";

    procedure AddResponsesToLibrary()
    begin
    end;

    procedure AddResponsePredecessors()
    begin
        //--------------------------------------Inventory Response Predecessors------------------------------------------------
        //Store Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnSendStoreRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnCancelStoreRequisitionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnCancelStoreRequisitionApprovalRequestCode);

        //Transfer Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnSendTransferHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnSendTransferHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnSendTransferHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnCancelTransferHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InventoryWorkflowEvents.RunWorkflowOnCancelTransferHeaderApprovalRequestCode);
    end;
}

