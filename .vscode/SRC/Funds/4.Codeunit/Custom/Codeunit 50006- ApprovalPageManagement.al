codeunit 50006 "Approval Page Management"
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
}
