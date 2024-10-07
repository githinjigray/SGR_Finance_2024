table 50056 "Activity Entries"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Activity Code"; Code[30])
        {
        }
        field(3; "Acticvity Description"; Text[250])
        {
        }
        field(4; "Activity Type"; Option)
        {
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";
        }
        field(5; "Additional Decsription"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Transaction No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Transaction Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Transaction Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Project Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
        }
        field(12; "Reference No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Description 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Programme Area Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Programme Area Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "County Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "County Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLEntry: Record "G/L Entry";
        DimensionValue: Record "Dimension Value";
        GLBudgetEntry: Record "G/L Budget Entry";

    procedure CreateActivityEntries()
    begin
    end;
}

