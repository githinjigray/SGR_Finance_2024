tableextension 50010 "Fixed Asset Ext" extends "Fixed Asset"
{
    fields
    {
        field(70000; "Book Value"; Decimal)
        {
            Caption = 'Book Value';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA No." = FIELD("No."), "Part of Book Value" = CONST(true)));
        }
        field(70001; "FA Tag No."; Code[50])
        {
            Caption = 'FA Tag No.';
            DataClassification = ToBeClassified;
        }
        field(70002; "Employee Name"; Text[90])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(70003; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70004; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70005; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70006; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70007; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(70008; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
        }
        field(70009; "FA Status"; Option)
        {
            Caption = 'FA Status';
            OptionMembers = Good,Fair,Faulty,Disposed;
            OptionCaption = 'Good,Fair,Faulty,Disposed';
            DataClassification = ToBeClassified;
        }
        field(70010; "FA Status Comment"; Text[250])
        {
            Caption = 'FA Status Comment';
            DataClassification = ToBeClassified;
        }
        field(70011; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70013; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70014; "FA Creation Date"; Date)
        {
            Caption = 'FA Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70015; "FA Book Value"; Decimal)
        {
            Caption = 'FA Book Value';
            Editable = false;
            DataClassification = ToBeClassified;
        }

    }
    trigger OnInsert()
    begin
        "User ID" := UserId;
        "Created By" := UserId;
        "FA Creation Date" := Today;

    end;
}
