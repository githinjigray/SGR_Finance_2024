codeunit 50001 "Approval Page Management"
{
    procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer

    begin
        CASE RecordRef.NUMBER OF
            //Funds Management
            DATABASE::"Payment Header":
                EXIT(GetPaymentHeaderPageID(RecordRef));
            DATABASE::"Funds Transfer Header":
                EXIT(PAGE::"Funds Transfer Card");
            DATABASE::"Receipt Header":
                EXIT(PAGE::"Receipt Card");
            DATABASE::"Imprest Header":
                EXIT(PAGE::"Imprest Card Application");
            DATABASE::"Imprest Surrender Header":
                EXIT(PAGE::"Imprest Surrender Card");
            DATABASE::"Funds Claim Header":
                EXIT(PAGE::"Funds Claim Card");
            DATABASE::"Cheque Register":
                EXIT(PAGE::"Cheque Register Card");
            DATABASE::"Budget Allocation Header":
                EXIT(PAGE::"Budget Allocation Card");
            DATABASE::"Contract Request Header":
                EXIT(PAGE::"Contract Request Card");
        END;
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


    //End Sysre NextGen Addon
    // var
    // DataTypeManagement: Codeunit "Data Type Management";

    procedure ReopenImprestDocument(VAR "Imprest Header": Record "Imprest Header")
    begin

        ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.", "Imprest Header"."No.");
        IF ImprestHeader.FINDFIRST THEN BEGIN
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader.VALIDATE(ImprestHeader.Status);
            ImprestHeader.MODIFY;
        END;
    end;

    procedure ReopenImprestSurrender(VAR "Imprest Surrender Header": Record "Imprest Surrender Header")
    begin

        ImprestSurrenderHeader.RESET;
        ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Imprest Surrender Header"."No.");
        IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
            ImprestSurrenderHeader.Status := ImprestSurrenderHeader.Status::Open;
            ImprestSurrenderHeader.VALIDATE(ImprestSurrenderHeader.Status);
            ImprestSurrenderHeader.MODIFY;
        END;

    end;

    procedure ReOpenFundsClaim(VAR "Funds Claim Header": Record "Funds Claim Header")
    begin

        FundsClaimHeader.RESET;
        FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Funds Claim Header"."No.");
        IF FundsClaimHeader.FINDFIRST THEN BEGIN
            FundsClaimHeader.Status := FundsClaimHeader.Status::Open;
            FundsClaimHeader.VALIDATE(FundsClaimHeader.Status);
            FundsClaimHeader.MODIFY;
        END;

    end;

    procedure MatchAuutmattiically("Bank Reconciliation": Record "Bank Acc. Reconciliation")
    begin

    end;

    var
        recon: Record "Bank Acc. Reconciliation";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        PaymentHeader: Record "Payment Header";
        GLEntry: Record "G/L Entry";
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CustEntry: Record "Cust. Ledger Entry";
        FundsTransferHeader: Record "Funds Transfer Header";
        ReceiptHeader: Record "Receipt Header";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        TaxCodes: Record "Funds Tax Code";
        FundsClaimHeader: Record "Funds Claim Header";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        SourceCode: code[20];
        IMPJNL: code[20];
        LineNo: Integer;
}
