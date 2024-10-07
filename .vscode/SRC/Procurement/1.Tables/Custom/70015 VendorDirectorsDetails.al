table 70015 "Vendor Directors Details"
{
    Caption = 'Vendor Directors Details';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(11; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
            DataClassification = ToBeClassified;
        }
        field(12; "Director Name"; Text[150])
        {
            Caption = 'Director Name';
            DataClassification = ToBeClassified;
        }
        field(13; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(14; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(15; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(16; "ID/Passport No."; Code[30])
        {
            Caption = 'ID/Passport No.';
            DataClassification = ToBeClassified;
        }
        field(17; Nationality; Code[30])
        {
            Caption = 'Nationality';
            DataClassification = ToBeClassified;
        }
        field(18; "If Other, Nationality"; Code[30])
        {
            Caption = 'If Other, Nationality';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No","Vendor No")
        {
            Clustered = true;
        }
    }
}
