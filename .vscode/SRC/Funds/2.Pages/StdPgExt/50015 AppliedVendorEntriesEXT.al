pageextension 50015 "Applied Vendor Entries EXT" extends "Apply Vendor Entries"
{
    layout
    {
    }
    var
    PaymentLine:Record "Payment Line";
    PaymentLineApply:Boolean;
    procedure SetPaymentLine(NewPaymentLine: Record "Payment Line"; ApplnTypeSelect: Integer)
    begin
        PaymentLine := NewPaymentLine;
        PaymentLineApply := TRUE;

        IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN
            ApplyingAmount := PaymentLine."Total Amount";
        ApplnDate := PaymentLine."Posting Date";
        ApplnCurrencyCode := PaymentLine."Currency Code";
        CalcType := CalcType::PaymentLine;

        CASE ApplnTypeSelect OF
            PaymentLine.FIELDNO("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PaymentLine.FIELDNO("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        END;

        SetApplyingVendLedgEntry;
    end;
}
