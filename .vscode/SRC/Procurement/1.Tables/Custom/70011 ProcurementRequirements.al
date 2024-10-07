table 70011 "Procurement Requirements"
{
    Caption = 'Procurement Requirements';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Document No."; Code[30])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(12; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.","Line No.")
        {
            Clustered = true;
        }
    }
}
