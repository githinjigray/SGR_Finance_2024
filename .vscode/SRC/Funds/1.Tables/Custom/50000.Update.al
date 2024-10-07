table 50000 Update
{
    Caption = 'Update';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';
            DataClassification = ToBeClassified;
        }
        field(2; "GL Account No"; Code[20])
        {
            Caption = 'GL Account No';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No","GL Account No")
        {
            Clustered = true;
        }
    }
}
