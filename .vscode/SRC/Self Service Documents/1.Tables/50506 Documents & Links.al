table 50506 "Documents & Links"
{
    Caption = 'Documents & Links';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Integer)
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document Description"; Text[250])
        {
            Caption = 'Document Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Path"; Text[250])
        {
            Caption = 'Document Path';
            DataClassification = ToBeClassified;
        }
        field(4; Uploaded; Boolean)
        {
            Caption = 'Uploaded';
            DataClassification = ToBeClassified;
        }

        field(5; "Document Link"; Text[250])
        {
            Caption = 'Document Link';
            ExtendedDatatype = URL;
            DataClassification = ToBeClassified;

        }
        field(6; "Shared"; Boolean)
        {
            Caption = 'Shared';
            DataClassification = ToBeClassified;
        }
        field(7; "Department Code"; enum "Department Lookup Values")
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
