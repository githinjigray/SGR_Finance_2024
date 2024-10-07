table 50039 "Allowance Matrix"
{
    Caption = 'Allowance Matrix';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Job Group"; Code[30])
        {
            Caption = 'Job Group';
            DataClassification = ToBeClassified;
            //TableRelation="HR Job Lookup Value"."Code" where (option= const ("Job Grade"));
        }
        field(2; "Allowance Code"; Code[50])
        {
            Caption = 'Allowance Code';
            DataClassification = ToBeClassified;
            TableRelation="Funds Transaction Code"."Transaction Code" where ("Transaction Type"=const (Imprest));
        }
        field(3; "Cluster Code"; Code[50])
        {
            Caption = 'Cluster Code';
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(5; "Traveling From"; Code[50])
        {
            Caption = 'Traveling From';
            DataClassification = ToBeClassified;
           // TableRelation="HR Lookup Values".Code WHERE (Option=CONST(City));
        }
        field(6; "Traveling To"; Code[50])
        {
            Caption = 'Traveling To';
            DataClassification = ToBeClassified;
            //TableRelation="HR Lookup Values".Code WHERE (Option=CONST(City));
        }
        field(7; "Allowance Description"; Text[150])
        {
            Caption = 'Allowance Description';
            DataClassification = ToBeClassified;
        }
        field(8; "Transport Allowance"; Boolean)
        {
            Caption = 'Transport Allowance';
            DataClassification = ToBeClassified;
        }
        field(9; "Exempt from Cluster Code"; Boolean)
        {
            Caption = 'Exempt from Cluster Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        
    }
    keys
    {
        key(PK; "Job Group","Allowance Code","Traveling From","Traveling To")
        {
            Clustered = true;
        }
    }
}
