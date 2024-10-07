table 70026 "Procurement Period"
{
    Caption = 'Procurement Period';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Period name"; Code[50])
        {
            Caption = 'Period name';
            DataClassification = ToBeClassified;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Period name")
        {
            Clustered = true;
        }
    }
}
