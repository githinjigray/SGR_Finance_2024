codeunit 50008 "Funds Claim Post"
{
    procedure CheckFundsClaimMandatoryFields(DocumentNo: code[20])
    begin
        FundsClaimHeader.get(DocumentNo);
        FundsClaimHeader.TESTFIELD("Posting Date");
        FundsClaimHeader.TESTFIELD("Global Dimension 2 Code");
        FundsClaimHeader.TESTFIELD("Payee No.");
        FundsClaimHeader.TESTFIELD(Description);
        FundsClaimHeader.TESTFIELD("Global Dimension 1 Code");
        // IF Posting THEN BEGIN
        //FundsClaimHeader.TESTFIELD("Bank Account No.");
        // FundsClaimHeader.TESTFIELD(Status,FundsClaimHeader.Status::Approved);
        //END;

        //Check Funds Claim Lines
        FundsClaimLine.RESET;
        FundsClaimLine.SETRANGE("Document No.", FundsClaimHeader."No.");
        IF FundsClaimLine.FINDSET THEN BEGIN
            REPEAT
                FundsClaimLine.TESTFIELD("Account No.");
                FundsClaimLine.TESTFIELD(Amount);
                FundsClaimLine.TESTFIELD(Description);
                FundsClaimLine.TESTFIELD("Global Dimension 1 Code");
                FundsClaimLine.TESTFIELD("Global Dimension 2 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 4 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 3 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 5 Code");
                FundsClaimLine.TESTFIELD("Shortcut Dimension 6 Code");
            UNTIL FundsClaimLine.NEXT = 0;
        END ELSE BEGIN
            ERROR('One or more Funds Claim lines are empty');
        END;
    end;

    var
        FundsClaimHeader: Record "Funds Claim Header";
        FundsClaimLine: Record "Funds Claim Line";
}
