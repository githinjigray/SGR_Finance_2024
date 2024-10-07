table 50041 "Bank Integration Credential"
{
    Caption = 'Bank Integration Credential';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(2; Username; Text[30])
        {
            Caption = 'Username';
            DataClassification = ToBeClassified;
        }
        field(3; Password; Text[250])
        {
            Caption = 'Password';
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
}
