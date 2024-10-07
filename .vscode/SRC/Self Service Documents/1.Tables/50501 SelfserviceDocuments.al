table 50501 "Selfservice Documents"
{
    Caption = 'Selfservice Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Portal Document Types")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Code"; Code[50])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Description"; Text[150])
        {
            Caption = 'Document Description';
            DataClassification = ToBeClassified;
        }

        field(4; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document Code")
        {
            Clustered = true;
        }
    }
}
