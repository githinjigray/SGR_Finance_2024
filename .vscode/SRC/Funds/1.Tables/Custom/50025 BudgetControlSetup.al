table 50025 "Budget Control Setup"
{
    Caption = 'Budget Control Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Current Budget Code"; Code[20])
        {
            Caption = 'Current Budget Code';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name;
        }
        field(3; "Current Budget Start Date"; Date)
        {
            Caption = 'Current Budget Start Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Current Budget End Date"; Date)
        {
            Caption = 'Current Budget End Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Budget Dimension 1 Code"; Code[20])
        {
            Caption = 'Budget Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
        field(6; "Budget Dimension 2 Code"; Code[20])
        {
            Caption = 'Budget Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false), "Global Dimension 1 Code" = FIELD("Budget Dimension 1 Code"));
        }
        field(7; "Budget Dimension 3 Code"; Code[20])
        {
            Caption = 'Budget Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(3), Blocked = CONST(false), "Global Dimension 1 Code" = FIELD("Budget Dimension 1 Code"));
        }
        field(8; "Budget Dimension 4 Code"; Code[20])
        {
            Caption = 'Budget Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(4), Blocked = CONST(false), "Global Dimension 1 Code" = FIELD("Budget Dimension 1 Code"));
        }
        field(9; "Budget Dimension 5 Code"; Code[20])
        {
            Caption = 'Budget Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false), "Global Dimension 1 Code" = FIELD("Budget Dimension 1 Code"));
        }
        field(10; "Budget Dimension 6 Code"; Code[20])
        {
            Caption = 'Budget Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(6), Blocked = CONST(false), "Global Dimension 1 Code" = FIELD("Budget Dimension 1 Code"));
        }
        field(11; "Analysis View Code"; Code[20])
        {
            Caption = 'Analysis View Code';
            DataClassification = ToBeClassified;
        }
        field(12; "Dimension 1 Code"; Code[20])
        {
            Caption = 'Dimension 1 Code';
            DataClassification = ToBeClassified;
        }
        field(13; "Dimension 2 Code"; Code[20])
        {
            Caption = 'Dimension 2 Code';
            DataClassification = ToBeClassified;
        }
        field(14; "Dimension 3 Code"; Code[20])
        {
            Caption = 'Dimension 3 Code';
            DataClassification = ToBeClassified;
        }
        field(15; "Dimension 4 Code"; Code[20])
        {
            Caption = 'Dimension 4 Code';
            DataClassification = ToBeClassified;
        }
        field(16; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            DataClassification = ToBeClassified;
        }
        field(17; "Allow OverExpenditure"; Boolean)
        {
            Caption = 'Allow OverExpenditure';
            DataClassification = ToBeClassified;
        }
        field(18; "Current Item Budget"; Code[10])
        {
            Caption = 'Current Item Budget';
            DataClassification = ToBeClassified;
        }
        field(21; "Partial Budgetary Check"; Boolean)
        {
            Caption = 'Partial Budgetary Check';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
