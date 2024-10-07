codeunit 70008 "Procurement Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowManagement: Codeunit "Workflow Management";
        ProcurementWFEvents: Codeunit "Procurement Workflow Events";
        ProcurementWFResponses: Codeunit "Procurement Workflow Responses";
        InventoryWFEvents: Codeunit "Inventory Workflow Events";

    procedure ReleasePurchaseRequisitionHeader(var "Purchase Requisition Header": Record "Purchase Requisitions")
    var
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
    begin
        PurchaseRequisitionHeader.Reset;
        PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."No.", "Purchase Requisition Header"."No.");
        if PurchaseRequisitionHeader.FindFirst then begin
            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Approved;
            PurchaseRequisitionHeader.Validate(PurchaseRequisitionHeader.Status);
            PurchaseRequisitionHeader.Modify;
        end;
    end;

    procedure ReOpenPurchaseRequisitionHeader(var "Purchase Requisition Header": Record "Purchase Requisitions")
    var
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
    begin
        PurchaseRequisitionHeader.Reset;
        PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."No.", "Purchase Requisition Header"."No.");
        if PurchaseRequisitionHeader.FindFirst then begin
            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Open;
            PurchaseRequisitionHeader.Validate(PurchaseRequisitionHeader.Status);
            PurchaseRequisitionHeader.Modify;
        end;
    end;

    procedure ReOpenRequestforQuotation(RequestforQuotation: Record "Request for Quotation Header")
    var
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        RequestforQuotationHeader.Reset;
        RequestforQuotationHeader.SetRange("No.", RequestforQuotation."No.");
        if RequestforQuotationHeader.FindFirst then begin
            RequestforQuotationHeader.Status := RequestforQuotationHeader.Status::Open;
            RequestforQuotationHeader.Validate(Status);
            RequestforQuotationHeader.Modify;
        end;
    end;

    procedure ReleaseRequestforQuotation(var RequestforQuotation: Record "Request for Quotation Header")
    var
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        RequestforQuotationHeader.Reset;
        RequestforQuotationHeader.SetRange("No.", RequestforQuotation."No.");
        if RequestforQuotationHeader.FindFirst then begin
            RequestforQuotationHeader.Status := RequestforQuotationHeader.Status::Released;
            RequestforQuotationHeader.Validate(Status);
            RequestforQuotationHeader.Modify;
        end;
    end;

    procedure ReopenBidAnalysis("Bid Analysis Header": Record "Bid Analysis Header")
    var
        BidAnalysisHeader: Record "Bid Analysis Header";
        BidAnalysisLine: Record "Bid Analysis Vendors";
    begin
        BidAnalysisHeader.Reset;
        BidAnalysisHeader.SetRange(BidAnalysisHeader."No.", "Bid Analysis Header"."No.");
        if BidAnalysisHeader.FindFirst then begin
            BidAnalysisHeader.Status := BidAnalysisHeader.Status::Open;
            BidAnalysisHeader.Validate(Status);
            BidAnalysisHeader.Modify;
        end;
    end;

    procedure ReleaseBidAnalysis(var "Bid Analysis Header": Record "Bid Analysis Header")
    var
        BidAnalysisHeader: Record "Bid Analysis Header";
        BidAnalysisLine: Record "Bid Analysis Vendors";
    begin
        BidAnalysisHeader.Reset;
        BidAnalysisHeader.SetRange(BidAnalysisHeader."No.", "Bid Analysis Header"."No.");
        if BidAnalysisHeader.FindFirst then begin
            BidAnalysisHeader.Status := BidAnalysisHeader.Status::Released;
            BidAnalysisHeader.Validate(Status);
            BidAnalysisHeader.Modify;
        end;
    end;

    procedure ReopenProcurementPlan(ProcurementPlanningHeaders: Record "Procurement Planning Header")
    var
        ProcurementPlanningHeader: Record "Procurement Planning Header";
    begin
        ProcurementPlanningHeader.Reset;
        ProcurementPlanningHeader.SetRange(ProcurementPlanningHeader."No.", ProcurementPlanningHeaders."No.");
        if ProcurementPlanningHeader.FindFirst then begin
            ProcurementPlanningHeader.Status := ProcurementPlanningHeader.Status::Open;
            ProcurementPlanningHeader.Validate(Status);
            ProcurementPlanningHeader.Modify;
        end;
    end;

    procedure ReleaseProcurementPlan(ProcurementPlanningHeaders: Record "Procurement Planning Header")
    var
        ProcurementPlanningHeader: Record "Procurement Planning Header";
    begin
        ProcurementPlanningHeader.Reset;
        ProcurementPlanningHeader.SetRange(ProcurementPlanningHeader."No.", ProcurementPlanningHeaders."No.");
        if ProcurementPlanningHeader.FindFirst then begin
            ProcurementPlanningHeader.Status := ProcurementPlanningHeader.Status::Approved;
            ProcurementPlanningHeader.Validate(Status);
            ProcurementPlanningHeader.Modify;
        end;
    end;

    procedure ReopenTenderHeader(TenderHeader: Record "Tender Header")
    var
        TenderHeaders: Record "Tender Header";
    begin
        TenderHeaders.Reset;
        TenderHeaders.SetRange(TenderHeaders."No.", TenderHeader."No.");
        if TenderHeaders.FindFirst then begin
            TenderHeaders.Status := TenderHeaders.Status::Open;
            TenderHeaders.Validate(Status);
            TenderHeaders.Modify;
        end;
    end;

    procedure ReleaseTenderHeader(TenderHeader: Record "Tender Header")
    var
        TenderHeaders: Record "Tender Header";
    begin
        TenderHeaders.Reset;
        TenderHeaders.SetRange(TenderHeaders."No.", TenderHeader."No.");
        if TenderHeaders.FindFirst then begin
            TenderHeaders.Status := TenderHeaders.Status::Approved;
            TenderHeaders.Validate(Status);
            TenderHeaders.Modify;
        end;
    end;

    procedure PopulateApprovalEntryArgument(RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance"; var ApprovalEntryArgument: Record "Approval Entry")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CurrencyCode: Code[10];
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
        PaymentApprovalDescription: Label 'Payment';
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        BidAnalysis: Record "Bid Analysis Header";
        StoreRequisitionHeader: Record "Store Requisition Header";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        TenderHeader: Record "Tender Header";
    begin
        GeneralLedgerSetup.Reset;
        GeneralLedgerSetup.Get;

        case RecRef.Number of

            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader.CalcFields(PurchaseRequisitionHeader.Amount, PurchaseRequisitionHeader."Amount(LCY)");
                    ApprovalAmount := PurchaseRequisitionHeader.Amount;
                    ApprovalAmountLCY := PurchaseRequisitionHeader."Amount(LCY)";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := PurchaseRequisitionHeader."No.";
                    ApprovalEntryArgument.Description := PurchaseRequisitionHeader.Description;
                    ApprovalEntryArgument."Document Source" := 'PROCUREMENT';
                    ApprovalEntryArgument.Document_Type := 'Purchase Requisition';
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := PurchaseRequisitionHeader."Currency Code";
                end;

            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    ApprovalAmount := 1;
                    ApprovalAmountLCY := 1;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := BidAnalysis."No.";
                    ApprovalEntryArgument.Description := BidAnalysis.Description;
                    ApprovalEntryArgument."Document Source" := 'PROCUREMENT';
                    ApprovalEntryArgument.Document_Type := 'Bid Analysis';
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Procurement Plan
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlanningHeader);
                    ApprovalAmount := 1;
                    ApprovalAmountLCY := 1;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := ProcurementPlanningHeader."No.";
                    ApprovalEntryArgument.Description := ProcurementPlanningHeader.Name;
                    ApprovalEntryArgument."Document Source" := 'PROCUREMENT';
                    ApprovalEntryArgument.Document_Type := 'Procurement Plan';
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Tender Header
            DATABASE::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    ApprovalAmount := 1;
                    ApprovalAmountLCY := 1;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := TenderHeader."No.";
                    ApprovalEntryArgument.Description := TenderHeader."Purchase Req. Description";
                    ApprovalEntryArgument."Document Source" := 'PROCUREMENT';
                    ApprovalEntryArgument.Document_Type := 'Tender Header';
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //---------------------End Populate Procurement Management Approval Entry Arguments-------------------------------------------

            //---------------------End Populate Inventory Management Approval Entry Arguments---------------------------------------------
            //Store Requisition
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisitionHeader);
                    StoreRequisitionHeader.CalcFields(StoreRequisitionHeader.Amount);
                    ApprovalAmount := StoreRequisitionHeader.Amount;
                    ApprovalAmountLCY := StoreRequisitionHeader.Amount;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                    ApprovalEntryArgument."Document No." := StoreRequisitionHeader."No.";
                    ApprovalEntryArgument.Description := StoreRequisitionHeader.Description;
                    ApprovalEntryArgument."Document Source" := 'INVENTORY';
                    ApprovalEntryArgument.Document_Type := 'Store Requisition';
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
        end;
    end;

    procedure ReleaseDocument(var Variant: Variant) RecordTypeSupported: Boolean
    var
        RecRef: RecordRef;
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        BidAnalysis: Record "Bid Analysis Header";
        StoreRequisitionHeader: Record "Store Requisition Header";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        TenderHeader: Record "Tender Header";
    begin
        RecordTypeSupported := false;

        RecRef.GetTable(Variant);
        case RecRef.Number of

            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader.Validate(PurchaseRequisitionHeader.Status, PurchaseRequisitionHeader.Status::Approved);
                    PurchaseRequisitionHeader.Modify(true);
                    Variant := PurchaseRequisitionHeader;
                    RecordTypeSupported := true;
                end;

            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    BidAnalysis.Validate(BidAnalysis.Status, BidAnalysis.Status::Released);
                    BidAnalysis.Modify(true);
                    Variant := BidAnalysis;
                    RecordTypeSupported := true;
                end;


            //Procurement Plan
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlanningHeader);
                    ProcurementPlanningHeader.Validate(ProcurementPlanningHeader.Status, ProcurementPlanningHeader.Status::Approved);
                    ProcurementPlanningHeader.Modify(true);
                    Variant := ProcurementPlanningHeader;
                    RecordTypeSupported := true;
                end;

            //Tender Header
            DATABASE::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    TenderHeader.Validate(TenderHeader.Status, TenderHeader.Status::Approved);
                    TenderHeader.Modify(true);
                    Variant := TenderHeader;
                    RecordTypeSupported := true;
                end;


            //Store Requisition
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisitionHeader);
                    StoreRequisitionHeader.Validate(StoreRequisitionHeader.Status, StoreRequisitionHeader.Status::Approved);
                    StoreRequisitionHeader.Modify(true);
                    Variant := StoreRequisitionHeader;
                    RecordTypeSupported := true;
                end;
        end;
    end;

    procedure ReopenDocument(var Variant: Variant) RecordTypeSupported: Boolean
    var
        RecRef: RecordRef;
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        BidAnalysis: Record "Bid Analysis Header";
        StoreRequisitionHeader: Record "Store Requisition Header";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        TenderHeader: Record "Tender Header";
    begin
        RecordTypeSupported := false;

        RecRef.GetTable(Variant);
        case RecRef.Number of

            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader.Validate(PurchaseRequisitionHeader.Status, PurchaseRequisitionHeader.Status::Open);
                    PurchaseRequisitionHeader.Modify(true);
                    Variant := PurchaseRequisitionHeader;
                    RecordTypeSupported := true;
                end;

            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    BidAnalysis.Validate(BidAnalysis.Status, BidAnalysis.Status::Open);
                    BidAnalysis.Modify(true);
                    Variant := BidAnalysis;
                    RecordTypeSupported := true;
                end;


            //Procurement Plan
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlanningHeader);
                    ProcurementPlanningHeader.Validate(ProcurementPlanningHeader.Status, ProcurementPlanningHeader.Status::Open);
                    ProcurementPlanningHeader.Modify(true);
                    Variant := ProcurementPlanningHeader;
                    RecordTypeSupported := true;
                end;

            //Tender Header
            DATABASE::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    TenderHeader.Validate(TenderHeader.Status, TenderHeader.Status::Open);
                    TenderHeader.Modify(true);
                    Variant := TenderHeader;
                    RecordTypeSupported := true;
                end;


            //Store Requisition
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisitionHeader);
                    StoreRequisitionHeader.Validate(StoreRequisitionHeader.Status, StoreRequisitionHeader.Status::Open);
                    StoreRequisitionHeader.Modify(true);
                    Variant := StoreRequisitionHeader;
                    RecordTypeSupported := true;
                end;
        end;
    end;

    procedure SetStatusToPendingApproval(var Variant: Variant) RecordTypeSupported: Boolean
    var
        RecRef: RecordRef;
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        BidAnalysis: Record "Bid Analysis Header";
        StoreRequisitionHeader: Record "Store Requisition Header";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
        TenderHeader: Record "Tender Header";
    begin
        RecordTypeSupported := false;

        RecRef.GetTable(Variant);
        case RecRef.Number of

            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                begin
                    RecRef.SetTable(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader.Validate(Status, PurchaseRequisitionHeader.Status::"Pending Approval");
                    PurchaseRequisitionHeader.Modify(true);
                    Variant := PurchaseRequisitionHeader;
                end;

            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                begin
                    RecRef.SetTable(BidAnalysis);
                    BidAnalysis.Validate(BidAnalysis.Status, BidAnalysis.Status::"Pending Approval");
                    BidAnalysis.Modify(true);
                    Variant := BidAnalysis;
                end;

            //Procurement Plan
            DATABASE::"Procurement Planning Header":
                begin
                    RecRef.SetTable(ProcurementPlanningHeader);
                    ProcurementPlanningHeader.Validate(Status, ProcurementPlanningHeader.Status::"Pending Approval");
                    ProcurementPlanningHeader.Modify(true);
                    Variant := ProcurementPlanningHeader;
                end;

            //Tender Header
            DATABASE::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    TenderHeader.Validate(Status, TenderHeader.Status::"Pending Approval");
                    TenderHeader.Modify(true);
                    Variant := TenderHeader;
                end;
            //-------------------------End Procurement Management Documents-------------------------------

            //------------------------ Inventory Management Documents-------------------------------

            //Store Requisition
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.SetTable(StoreRequisitionHeader);
                    StoreRequisitionHeader.Validate(Status, StoreRequisitionHeader.Status::"Pending Approval");
                    StoreRequisitionHeader.Modify(true);
                    Variant := StoreRequisitionHeader;
                end;
        end;
    end;

    procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        case RecordRef.Number of

            //Purchase Requisition Header
            DATABASE::"Purchase Requisitions":
                exit(PAGE::"Purchase Requisition Card");

            //Procurement Planning
            DATABASE::"Procurement Planning Header":
                exit(PAGE::"Procurement Planning Card");

            //Store Requisition Header
            DATABASE::"Store Requisition Header":
                exit(PAGE::"Store Requisition Card");
        end;
        exit(0);
    end;

    procedure CheckPurchaseRequisitionApprovalsWorkflowEnabled(var PurchaseRequisition: Record "Purchase Requisitions"): Boolean
    begin
        if not IsPurchaseRequisitionApprovalsWorkflowEnabled(PurchaseRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsPurchaseRequisitionApprovalsWorkflowEnabled(var PurchaseRequisition: Record "Purchase Requisitions"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PurchaseRequisition, ProcurementWFEvents.RunWorkflowOnSendPurchaseRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisition: Record "Purchase Requisitions")
    begin
    end;

    procedure CheckTenderHeaderApprovalsWorkflowEnabled(var TenderHeader: Record "Tender Header"): Boolean
    begin
        if not IsTenderHeaderApprovalsWorkflowEnabled(TenderHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTenderHeaderApprovalsWorkflowEnabled(var TenderHeader: Record "Tender Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TenderHeader, ProcurementWFEvents.RunWorkflowOnSendTenderHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendTenderHeaderForApproval(var TenderHeader: Record "Tender Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelTenderHeaderApprovalRequest(var TenderHeader: Record "Tender Header")
    begin
    end;

    procedure CheckBidAnalysisApprovalsWorkflowEnabled(var BidAnalysis: Record "Bid Analysis Header"): Boolean
    begin
        if not IsBidAnalysisApprovalsWorkflowEnabled(BidAnalysis) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsBidAnalysisApprovalsWorkflowEnabled(var BidAnalysis: Record "Bid Analysis Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(BidAnalysis, ProcurementWFEvents.RunWorkflowOnSendBidAnalysisForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendBidAnalysisForApproval(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelBidAnalysisApprovalRequest(var BidAnalysis: Record "Bid Analysis Header")
    begin
    end;

    procedure CheckProcurementPlanApprovalsWorkflowEnabled(var ProcurementPlanningHeader: Record "Procurement Planning Header"): Boolean
    begin
        if not IsProcurementPlanApprovalsWorkflowEnabled(ProcurementPlanningHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsProcurementPlanApprovalsWorkflowEnabled(var ProcurementPlanningHeader: Record "Procurement Planning Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ProcurementPlanningHeader, ProcurementWFEvents.RunWorkflowOnSendProcurementPlanForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendProcurementPlanForApproval(var ProcurementPlanningHeader: Record "Procurement Planning Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelProcurementPlanApprovalRequest(var ProcurementPlanningHeader: Record "Procurement Planning Header")
    begin
    end;

    procedure CheckStoreRequisitionApprovalsWorkflowEnabled(var StoreRequisition: Record "Store Requisition Header"): Boolean
    begin
        if not IsStoreRequisitionApprovalsWorkflowEnabled(StoreRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsStoreRequisitionApprovalsWorkflowEnabled(var StoreRequisition: Record "Store Requisition Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(StoreRequisition, InventoryWFEvents.RunWorkflowOnSendStoreRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendStoreRequisitionForApproval(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelStoreRequisitionApprovalRequest(var StoreRequisition: Record "Store Requisition Header")
    begin
    end;
    //OnCancelVendorPrequalificationForApproval  
    procedure OnCancelVendorPrequalificationForApproval(var VendorPrequalification: Record "Prequlification Application")
    begin
    end;
}

