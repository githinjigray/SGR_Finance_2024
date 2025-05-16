codeunit 50026 "Funds Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowManagement: Codeunit "Workflow Management";
        DataTypeManagement: Codeunit "Data Type Management";

    procedure ReleasePaymentHeader(var "Payment Header": Record "Payment Header")
    var
        PaymentHeader: Record "Payment Header";
    begin
        /*PaymentHeader.RESET;
        PaymentHeader.SETRANGE(PaymentHeader."No.","Payment Header"."No.");
        IF PaymentHeader.FINDFIRST THEN BEGIN
          PaymentHeader.Status:=PaymentHeader.Status::Approved;
          PaymentHeader.VALIDATE(PaymentHeader.Status);
          PaymentHeader.MODIFY;
        END;*/

    end;

    procedure ReOpenPaymentHeader(var "Payment Header": Record "Payment Header")
    var
        PaymentHeader: Record "Payment Header";
    begin
        PaymentHeader.RESET;
        PaymentHeader.SETRANGE(PaymentHeader."No.", "Payment Header"."No.");
        IF PaymentHeader.FINDFIRST THEN BEGIN
            PaymentHeader.Status := PaymentHeader.Status::Open;
            PaymentHeader.VALIDATE(PaymentHeader.Status);
            PaymentHeader.MODIFY;
        END;
    end;

    procedure ReleaseReceiptHeader(var "Receipt Header": Record "Receipt Header")
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        ReceiptHeader.RESET;
        ReceiptHeader.SETRANGE(ReceiptHeader."No.", "Receipt Header"."No.");
        IF ReceiptHeader.FINDFIRST THEN BEGIN
            ReceiptHeader.Status := ReceiptHeader.Status::Posted;
            ReceiptHeader.VALIDATE(ReceiptHeader.Status);
            ReceiptHeader.MODIFY;
        END;
    end;

    procedure ReOpenReceiptHeader(var "Receipt Header": Record "Receipt Header")
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        ReceiptHeader.RESET;
        ReceiptHeader.SETRANGE(ReceiptHeader."No.", "Receipt Header"."No.");
        IF ReceiptHeader.FINDFIRST THEN BEGIN
            ReceiptHeader.Status := ReceiptHeader.Status::Open;
            ReceiptHeader.VALIDATE(ReceiptHeader.Status);
            ReceiptHeader.MODIFY;
        END;
    end;

    procedure ReleaseFundsTransferHeader(var "Funds Transfer Header": Record "Funds Transfer Header")
    var
        FundsTransferHeader: Record "Funds Transfer Header";
    begin
        FundsTransferHeader.RESET;
        FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", "Funds Transfer Header"."No.");
        IF FundsTransferHeader.FINDFIRST THEN BEGIN
            FundsTransferHeader.Status := FundsTransferHeader.Status::Approved;
            FundsTransferHeader.VALIDATE(FundsTransferHeader.Status);
            FundsTransferHeader.MODIFY;
        END;
    end;

    procedure ReOpenFundsTransferHeader(var "Funds Transfer Header": Record "Funds Transfer Header")
    var
        FundsTransferHeader: Record "Funds Transfer Header";
    begin
        FundsTransferHeader.RESET;
        FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", "Funds Transfer Header"."No.");
        IF FundsTransferHeader.FINDFIRST THEN BEGIN
            FundsTransferHeader.Status := FundsTransferHeader.Status::Open;
            FundsTransferHeader.VALIDATE(FundsTransferHeader.Status);
            FundsTransferHeader.MODIFY;
        END;
    end;

    procedure ReleaseImprestHeader(var "Imprest Header": Record "Imprest Header")
    var
        ImprestHeader: Record "Imprest Header";
    begin
        ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.", "Imprest Header"."No.");
        IF ImprestHeader.FINDFIRST THEN BEGIN
            ImprestHeader.Status := ImprestHeader.Status::Approved;
            ImprestHeader.VALIDATE(ImprestHeader.Status);
            ImprestHeader.MODIFY;
        END;
    end;

    procedure ReOpenImprestHeader(var "Imprest Header": Record "Imprest Header")
    var
        ImprestHeader: Record "Imprest Header";
    begin
        ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.", "Imprest Header"."No.");
        IF ImprestHeader.FINDFIRST THEN BEGIN
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader.VALIDATE(ImprestHeader.Status);
            ImprestHeader.MODIFY;
        END;
    end;

    procedure ReleaseImprestSurrenderHeader(var "Imprest Surrender Header": Record "Imprest Surrender Header")
    var
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
    begin
        ImprestSurrenderHeader.RESET;
        ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Imprest Surrender Header"."No.");
        IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
            ImprestSurrenderHeader.Status := ImprestSurrenderHeader.Status::Approved;
            ImprestSurrenderHeader.VALIDATE(ImprestSurrenderHeader.Status);
            ImprestSurrenderHeader.MODIFY;
        END;
    end;

    procedure ReOpenImprestSurrenderHeader(var "Imprest Surrender Header": Record "Imprest Surrender Header")
    var
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
    begin
        ImprestSurrenderHeader.RESET;
        ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Imprest Surrender Header"."No.");
        IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
            ImprestSurrenderHeader.Status := ImprestSurrenderHeader.Status::Open;
            ImprestSurrenderHeader.VALIDATE(ImprestSurrenderHeader.Status);
            ImprestSurrenderHeader.MODIFY;
        END;
    end;

    procedure ReleaseFundsClaim(var "Funds Claim Header": Record "Funds Claim Header")
    var
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        FundsClaimHeader.RESET;
        FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Funds Claim Header"."No.");
        IF FundsClaimHeader.FINDFIRST THEN BEGIN
            FundsClaimHeader.Status := FundsClaimHeader.Status::Approved;
            FundsClaimHeader.VALIDATE(FundsClaimHeader.Status);
            FundsClaimHeader.MODIFY;
        END;
    end;

    procedure ReOpenFundsClaim(var "Funds Claim Header": Record "Funds Claim Header")
    var
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        FundsClaimHeader.RESET;
        FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Funds Claim Header"."No.");
        IF FundsClaimHeader.FINDFIRST THEN BEGIN
            FundsClaimHeader.Status := FundsClaimHeader.Status::Open;
            FundsClaimHeader.VALIDATE(FundsClaimHeader.Status);
            FundsClaimHeader.MODIFY;
        END;
    end;

    // procedure ReleaseDocumentReversal(var DocumentReversalHeader: Record "Document Reversal Header")
    // var
    //     DocumentReversalHeaders: Record "Document Reversal Header";
    // begin
    //     DocumentReversalHeader.RESET;
    //     DocumentReversalHeader.SETRANGE(DocumentReversalHeader."No.", DocumentReversalHeaders."No.");
    //     IF DocumentReversalHeader.FINDFIRST THEN BEGIN
    //         DocumentReversalHeader.Status := DocumentReversalHeader.Status::Approved;
    //         DocumentReversalHeader.VALIDATE(DocumentReversalHeader.Status);
    //         DocumentReversalHeader.MODIFY;
    //     END;
    // end;

    // procedure ReOpenDocumentReversal(var DocumentReversalHeader: Record "Document Reversal Header")
    // var
    //     DocumentReversalHeaders: Record "Document Reversal Header";
    // begin
    //     DocumentReversalHeader.RESET;
    //     DocumentReversalHeader.SETRANGE(DocumentReversalHeader."No.", DocumentReversalHeaders."No.");
    //     IF DocumentReversalHeader.FINDFIRST THEN BEGIN
    //         DocumentReversalHeader.Status := DocumentReversalHeader.Status::Open;
    //         DocumentReversalHeader.VALIDATE(DocumentReversalHeader.Status);
    //         DocumentReversalHeader.MODIFY;
    //     END;
    // end;

    procedure ReleaseJournalVoucher(var "Journal Voucher": Record "Journal Voucher Header")
    var
        JournalVoucherHeader: Record "Journal Voucher Header";
    begin
        JournalVoucherHeader.RESET;
        JournalVoucherHeader.SETRANGE(JournalVoucherHeader."JV No.", "Journal Voucher"."JV No.");
        IF JournalVoucherHeader.FINDFIRST THEN BEGIN
            JournalVoucherHeader.Status := JournalVoucherHeader.Status::Approved;
            JournalVoucherHeader.VALIDATE(JournalVoucherHeader.Status);
            JournalVoucherHeader.MODIFY;
        END;
    end;

    procedure ReOpenJournalVoucher(var "Journal Voucher": Record "Journal Voucher Header")
    var
        JournalVoucherHeader: Record "Journal Voucher Header";
    begin
        JournalVoucherHeader.RESET;
        JournalVoucherHeader.SETRANGE(JournalVoucherHeader."JV No.", "Journal Voucher"."JV No.");
        IF JournalVoucherHeader.FINDFIRST THEN BEGIN
            JournalVoucherHeader.Status := JournalVoucherHeader.Status::Open;
            JournalVoucherHeader.VALIDATE(JournalVoucherHeader.Status);
            JournalVoucherHeader.MODIFY;
        END;
    end;

    procedure ReleaseChequeRegister(var "Cheque Register": Record "Cheque Register")
    var
        ChequeRegister: Record "Cheque Register";
    begin
        ChequeRegister.RESET;
        ChequeRegister.SETRANGE(ChequeRegister."No.", "Cheque Register"."No.");
        IF ChequeRegister.FINDFIRST THEN BEGIN
            ChequeRegister.Status := ChequeRegister.Status::Approved;
            ChequeRegister.VALIDATE(ChequeRegister.Status);
            ChequeRegister.MODIFY;
        END;
    end;

    procedure ReOpenChequeRegister(var "Cheque Register": Record "Cheque Register")
    var
        ChequeRegister: Record "Cheque Register";
    begin
        ChequeRegister.RESET;
        ChequeRegister.SETRANGE(ChequeRegister."No.", "Cheque Register"."No.");
        IF ChequeRegister.FINDFIRST THEN BEGIN
            ChequeRegister.Status := ChequeRegister.Status::Open;
            ChequeRegister.VALIDATE(ChequeRegister.Status);
            ChequeRegister.MODIFY;
        END;
    end;

    procedure ReleaseBudgetHeader(var "Budget Allocation Header": Record "Budget Allocation Header")
    var
        BudgetAllocationHeader: Record "Budget Allocation Header";
    begin
        BudgetAllocationHeader.RESET;
        BudgetAllocationHeader.SETRANGE(BudgetAllocationHeader."No.", "Budget Allocation Header"."No.");
        IF BudgetAllocationHeader.FINDFIRST THEN BEGIN
            BudgetAllocationHeader.Status := BudgetAllocationHeader.Status::Approved;
            BudgetAllocationHeader.VALIDATE(BudgetAllocationHeader.Status);
            BudgetAllocationHeader.MODIFY;
        END;
    end;

    procedure ReOpenBudgetHeader(var "Budget Allocation Header": Record "Budget Allocation Header")
    var
        BudgetAllocationHeader: Record "Budget Allocation Header";
    begin
        /*BudgetAllocationHeader.RESET;
        BudgetAllocationHeader.SETRANGE(BudgetAllocationHeader."No.","Budget Allocation Header"."No.");
        IF BudgetAllocationHeader.FINDFIRST THEN BEGIN
          BudgetAllocationHeader.Status:=BudgetAllocationHeader.Status::Open;
          BudgetAllocationHeader.VALIDATE(BudgetAllocationHeader.Status);
          BudgetAllocationHeader.MODIFY;
        END;*/

    end;
}

