report 50104 "Approval Updates"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Approval Updates.rdlc';
    Caption = 'Approval Updates';
    ProcessingOnly = true;
    ApplicationArea = All;
    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {
            DataItemTableView = WHERE(Status = FILTER(Open));

            trigger OnAfterGetRecord()
            begin
                PurchaseHeader.RESET;
                PurchaseHeader.SETRANGE(PurchaseHeader."No.", "Approval Entry"."Document No.");
                PurchaseHeader.SETRANGE(PurchaseHeader.Status, PurchaseHeader.Status::Released);
                IF PurchaseHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;

                PurchInvHeader.RESET;
                PurchInvHeader.SETRANGE(PurchInvHeader."Pre-Assigned No.", "Approval Entry"."Document No.");
                IF PurchInvHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;


                ImprestHeader.RESET;
                ImprestHeader.SETRANGE(ImprestHeader."No.", "Approval Entry"."Document No.");
                ImprestHeader.SETRANGE(ImprestHeader.Status, ImprestHeader.Status::Approved);
                IF ImprestHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;

                ImprestHeader.RESET;
                ImprestHeader.SETRANGE(ImprestHeader."No.", "Approval Entry"."Document No.");
                ImprestHeader.SETRANGE(ImprestHeader.Posted, TRUE);
                IF ImprestHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;

                ImprestSurrenderHeader.RESET;
                ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Approval Entry"."Document No.");
                ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader.Status, ImprestSurrenderHeader.Status::Approved);
                IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;

                PaymentHeader.RESET;
                PaymentHeader.SETRANGE(PaymentHeader."No.", "Approval Entry"."Document No.");
                PaymentHeader.SETRANGE(PaymentHeader.Status, PaymentHeader.Status::Approved);
                IF PaymentHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;

                PaymentHeader.RESET;
                PaymentHeader.SETRANGE(PaymentHeader."No.", "Approval Entry"."Document No.");
                PaymentHeader.SETRANGE(PaymentHeader.Posted, TRUE);
                IF PaymentHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;

                FundsClaimHeader.RESET;
                FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Approval Entry"."Document No.");
                FundsClaimHeader.SETRANGE(FundsClaimHeader.Status, FundsClaimHeader.Status::Approved);
                IF FundsClaimHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;


                FundsClaimHeader.RESET;
                FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Approval Entry"."Document No.");
                FundsClaimHeader.SETRANGE(FundsClaimHeader.Posted, TRUE);
                IF FundsClaimHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;

                PurchaseRequisitionHeader.RESET;
                PurchaseRequisitionHeader.SETRANGE(PurchaseRequisitionHeader."No.", "Approval Entry"."Document No.");
                PurchaseRequisitionHeader.SETRANGE(PurchaseRequisitionHeader.Status, PurchaseRequisitionHeader.Status::Approved);
                IF PurchaseRequisitionHeader.FINDFIRST THEN BEGIN
                    "Approval Entry".Status := "Approval Entry".Status::Canceled;
                    "Approval Entry".MODIFY
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        PaymentHeader: Record "Payment Header";
        FundsClaimHeader: Record "Funds Claim Header";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
}

