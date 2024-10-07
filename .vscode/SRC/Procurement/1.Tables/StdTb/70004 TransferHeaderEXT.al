tableextension 70004 "Transfer Header EXT" extends "Transfer Header"
{
    fields
    {
        field(70000; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    begin
        rec."User ID" := UserId;
        rec.Modify();
    end;
}
