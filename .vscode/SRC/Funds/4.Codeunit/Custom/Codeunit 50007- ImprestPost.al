codeunit 50007 "Imprest Post"
{
    procedure CheckImprestMandatoryFields(DocumentNo:Code[20])
    begin
        ImprestHeader.get(DocumentNo);
        ImprestHeader.CALCFIELDS(Amount);
        ImprestHeader.TESTFIELD("Posting Date");
        ImprestHeader.TESTFIELD(Amount);
        ImprestHeader.TESTFIELD("Employee No.");
        ImprestHeader.TESTFIELD(Description);
        //ImprestHeader.TESTFIELD("Employee Posting Group");
        //ImprestHeader.TESTFIELD("Global Dimension 1 Code");
        //ImprestHeader.TESTFIELD("Global Dimension 2 Code");
        ImprestHeader.TESTFIELD("Date From");
        ImprestHeader.TESTFIELD("Date To");
        //IF Posting THEN
        // ImprestHeader.TESTFIELD(Status,ImprestHeader.Status::Released);

        //Check Imprest Lines
        ImprestLine.RESET;
        ImprestLine.SETRANGE("Document No.",ImprestHeader."No.");
        IF ImprestLine.FINDSET THEN BEGIN
        REPEAT
            //ImprestLine.TESTFIELD("Budget Committed",TRUE);
            ImprestLine.TESTFIELD(Amount);
            IF ImprestLine."Account Type"=ImprestLine."Account Type"::"G/L Account" THEN BEGIN
              ImprestLine.TESTFIELD("Global Dimension 1 Code");
              ImprestLine.TESTFIELD("Global Dimension 2 Code");
            // ImprestLine.TESTFIELD("Shortcut Dimension 4 Code");
            // ImprestLine.TESTFIELD("Shortcut Dimension 5 Code");
            //ImprestLine.TESTFIELD("Shortcut Dimension 6 Code");
            END;
        UNTIL ImprestLine.NEXT=0;
        END ELSE BEGIN
            ERROR('One or more Imprest lines are empty');
        END;
    end;
    var
        ImprestHeader:Record "Imprest Header";
        ImprestLine:Record "Imprest Line";
}
