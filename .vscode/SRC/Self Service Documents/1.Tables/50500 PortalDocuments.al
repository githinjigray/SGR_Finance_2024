table 50500 "Portal Documents"
{
    Caption = 'Portal Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LineNo."; Integer)
        {
            Caption = 'LineNo.';
            DataClassification = ToBeClassified;
        }
        field(2; "DocumentNo."; Code[20])
        {
            Caption = 'DocumentNo.';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Code"; Code[50])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Document Description"; Text[250])
        {
            Caption = 'Document Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Document Attached"; Boolean)
        {
            Caption = 'Document Attached';
            DataClassification = ToBeClassified;
        }
        field(6; "Local File URL"; Text[250])
        {
            Caption = 'Local File URL';
            DataClassification = ToBeClassified;
        }
        field(7; "SharePoint URL"; Text[250])
        {
            Caption = 'SharePoint URL';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "LineNo.", "DocumentNo.", "Document Code")
        {
            Clustered = true;
        }
    }

}
