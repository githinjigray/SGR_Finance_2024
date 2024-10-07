table 70014 "Procurement Lookup Values"
{
    Caption = 'Procurement Lookup Values';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(11; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers="Tender Criteria",City;
            OptionCaption='Tender Criteria,City';
            DataClassification = ToBeClassified;
        }
        field(12; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(14; "Cluster Code"; Code[30])
        {
            Caption = 'Cluster Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No","Type","Code")
        {
            Clustered = true;
        }
    }
}
