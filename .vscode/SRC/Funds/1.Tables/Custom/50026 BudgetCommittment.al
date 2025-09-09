table 50026 "Budget Committment"
{
    Caption = 'Budget Committment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; Enum BudgetCommitmentTypes)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Month Budget"; Decimal)
        {
            Caption = 'Month Budget';
            DataClassification = ToBeClassified;
        }
        field(8; "Month Actual"; Decimal)
        {
            Caption = 'Month Actual';
            DataClassification = ToBeClassified;
        }
        field(9; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(10; "Committed By"; Code[50])
        {
            Caption = 'Committed By';
            DataClassification = ToBeClassified;
        }
        field(11; "Committed Date"; Date)
        {
            Caption = 'Committed Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Committed Time"; Time)
        {
            Caption = 'Committed Time';
            DataClassification = ToBeClassified;
        }
        field(13; "Committed Machine"; Text[100])
        {
            Caption = 'Committed Machine';
            DataClassification = ToBeClassified;
        }
        field(14; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
            DataClassification = ToBeClassified;
        }
        field(15; "Cancelled By"; Code[20])
        {
            Caption = 'Cancelled By';
            DataClassification = ToBeClassified;
        }
        field(16; "Cancelled Date"; Date)
        {
            Caption = 'Cancelled Date';
            DataClassification = ToBeClassified;
        }
        field(17; "Cancelled Time"; Time)
        {
            Caption = 'Cancelled Time';
            DataClassification = ToBeClassified;
        }
        field(18; "Cancelled Machine"; Text[100])
        {
            Caption = 'Cancelled Machine';
            DataClassification = ToBeClassified;
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,1,1';
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,2';
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,3';
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,4';
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,5';
        }
        field(24; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,6';
        }
        field(25; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = ToBeClassified;
        }
        field(26; Budget; Code[20])
        {
            Caption = 'Budget';
            DataClassification = ToBeClassified;
        }
        field(27; "Vendor/Cust No."; Code[20])
        {
            Caption = 'Vendor/Cust No.';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Line No.", "Document No.")
        {
            Clustered = true;
        }
    }
}
