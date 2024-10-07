table 50502 "Portal Documents Setup"
{
    Caption = 'Portal Documents Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Server File Path"; Text[250])
        {
            Caption = 'Server File Path';
            DataClassification = ToBeClassified;
        }
        field(3; "Local File Path"; Text[250])
        {
            Caption = 'Local File Path';
            DataClassification = ToBeClassified;
        }
        field(4; "Attachment File Path"; Text[250])
        {
            Caption = 'Attachment File Path';
            DataClassification = ToBeClassified;
        }
        field(5; "HR Document File Path"; Text[250])
        {
            Caption = 'HR Document File Path';
            DataClassification = ToBeClassified;
        }
       
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
