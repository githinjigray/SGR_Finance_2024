tableextension 50018 "Approval Comment Line EXT" extends "Approval Comment Line"
{
    fields
    {
        field(70000; "Additional Comments"; Text[1000])
        {
            Caption = 'Additional Comment';
            DataClassification = ToBeClassified;
        }
        field(70001; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Sent';
        }
    }
    trigger OnInsert()
    begin
        //"Document No.":=FORMAT(MyFieldRef.VALUE);
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry."Record ID to Approve", "Record ID to Approve");
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            "Document No." := ApprovalEntry."Document No.";
        END;
    end;

    var
        MyFieldRef: FieldRef;
        ApprovalEntry: Record "Approval Entry";
}
