table 50050 "Bank Code"
{
    Caption = 'Bank Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Bank Name"; Text[200])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Bank Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Bank Name")
        {

        }
    }
}
