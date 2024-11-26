tableextension 50009 "365 Employee" extends Employee
{
    fields
    {
        field(70000; "Employee User ID"; Code[20])
        {
            Caption = 'Employee User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(70001; Signature; Media)
        {
            Caption = 'Signature';
            DataClassification = ToBeClassified;
        }
    }
}
