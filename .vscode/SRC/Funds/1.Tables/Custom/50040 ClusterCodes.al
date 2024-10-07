table 50040 "Cluster Codes"
{
    Caption = 'Cluster Codes';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Cluster Code"; Code[20])
        {
            Caption = 'Cluster Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Cluster Name"; Text[50])
        {
            Caption = 'Cluster Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Cluster Code")
        {
            Clustered = true;
        }
    }
}
