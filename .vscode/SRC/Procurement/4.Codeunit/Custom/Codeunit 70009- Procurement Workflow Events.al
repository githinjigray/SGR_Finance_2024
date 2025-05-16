codeunit 70009 "Procurement Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";

    procedure AddEventsToLibrary()
    begin
        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Purchase Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPurchaseRequisitionForApprovalCode,
                                    DATABASE::"Purchase Requisitions",'Approval of a purchase requisition is requested.',0,false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode,
                                    DATABASE::"Purchase Requisitions",'An approval request for a purchase requisition is canceled.',0,false);

        //Bid Analysis
        WFHandler.AddEventToLibrary(RunWorkflowOnSendBidAnalysisForApprovalCode,
                                    DATABASE::"Bid Analysis Header",'Approval of a bid analysis document is requested.',0,false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBidAnalysisApprovalRequestCode,
                                    DATABASE::"Bid Analysis Header",'An approval request for a bid analysis document is canceled.',0,false);

        //Procurement Plan
        WFHandler.AddEventToLibrary(RunWorkflowOnSendProcurementPlanForApprovalCode,
                                    DATABASE::"Procurement Planning Header",'Approval of a Procurement Plan Document is requested.',0,false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelProcurementPlanApprovalRequestCode,
                                    DATABASE::"Procurement Planning Header",'An approval request for a Procurement Plan Document is canceled.',0,false);

        //Tender Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTenderHeaderForApprovalCode,
                                    DATABASE::"Tender Header",'Approval of a Tender Header Document is requested.',0,false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTenderHeaderApprovalRequestCode,
                                    DATABASE::"Tender Header",'An approval request for a Tender Header Document is canceled.',0,false);

        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;

    procedure AddEventsPredecessor()
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Purchase Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendPurchaseRequisitionForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendPurchaseRequisitionForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendPurchaseRequisitionForApprovalCode);//Delegate

        //Bid Analysis
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendBidAnalysisForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendBidAnalysisForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendBidAnalysisForApprovalCode);//Delegate

        //Procurement Plan
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendProcurementPlanForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendProcurementPlanForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendProcurementPlanForApprovalCode);//Delegate

        //Tender Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendTenderHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendTenderHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendTenderHeaderForApprovalCode);//Delegate


        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;

    procedure RunWorkflowOnSendPurchaseRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70004, 'OnSendPurchaseRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseRequisitionForApprovalCode,PurchaseRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70008, 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode,PurchaseRequisition);
    end;

    procedure RunWorkflowOnSendBidAnalysisForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBidAnalysisForApproval'));
    end;

    procedure RunWorkflowOnCancelBidAnalysisApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBidAnalysisApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 70001, 'OnSendBidAnalysisForApproval', '', false, false)]
    // procedure RunWorkflowOnSendBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendBidAnalysisForApprovalCode,BidAnalysis);
    // end;

    [EventSubscriber(ObjectType::Codeunit, 70008, 'OnCancelBidAnalysisApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelBidAnalysisApprovalRequest(var BidAnalysis: Record "Bid Analysis Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBidAnalysisApprovalRequestCode,BidAnalysis);
    end;

    procedure RunWorkflowOnSendProcurementPlanForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendProcurementPlanForApproval'));
    end;

    procedure RunWorkflowOnCancelProcurementPlanApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelProcurementPlanApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, 70003, 'OnSendProcurementPlanForApproval', '', false, false)]
    // procedure RunWorkflowOnSendProcurementPlanForApproval(var ProcurementPlanningHeader: Record "Procurement Planning Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendProcurementPlanForApprovalCode,ProcurementPlanningHeader);
    // end;

    [EventSubscriber(ObjectType::Codeunit, 70008, 'OnCancelProcurementPlanApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelProcurementPlanApprovalRequest(var ProcurementPlanningHeader: Record "Procurement Planning Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProcurementPlanApprovalRequestCode,ProcurementPlanningHeader);
    end;

    procedure RunWorkflowOnSendTenderHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTenderHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelTenderHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTenderHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70008, 'OnSendTenderHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendTenderHeaderForApproval(var TenderHeader: Record "Tender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTenderHeaderForApprovalCode,TenderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70008, 'OnCancelTenderHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTenderHeaderApprovalRequest(var TenderHeader: Record "Tender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTenderHeaderApprovalRequestCode,TenderHeader);
    end;

    procedure RunWorkflowOnSendStoreRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStoreRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelStoreRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStoreRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 70008, 'OnSendStoreRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStoreRequisitionForApprovalCode,StoreRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, 70008, 'OnCancelStoreRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelStoreRequisitionApprovalRequest(var StoreRequisition: Record "Store Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStoreRequisitionApprovalRequestCode,StoreRequisition);
    end;
}

