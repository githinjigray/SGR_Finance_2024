tableextension 50019 "Bank Acc. Reconciliation EXT" extends "Bank Acc. Reconciliation"
{
    fields
    {
        field(70000; "Total Reconciled"; Decimal)
        {
            Caption = 'Total Reconciled';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Applied Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = FILTER(true), "Statement No." = FIELD("Statement No.")));
        }
        field(70001; "Difference Btw Statements"; Decimal)
        {
            Caption = 'Difference Btw Statements';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                CALCFIELDS("Total Reconciled", "Total Unreconciled");
                "Difference Btw Statements" := "Statement Ending Balance" - ("Balance Last Statement" + "Total Reconciled");

            end;
        }
        field(70003; "Total Unreconciled"; Decimal)
        {
            Caption = 'Total Unreconciled';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Statement Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = FILTER(false), "Statement No." = FIELD("Statement No.")));
        }
        field(70004; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed';
            Editable = false;
        }
        field(70005; "User ID"; Code[30])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70006; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70011; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
            Editable = false;
        }
        field(70012; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(70013; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70014; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70015; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70016; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        modify("Bank Account No.")
        {
            trigger OnAfterValidate()
            begin
                BankAccReconciliation.RESET;
                BankAccReconciliation.SETRANGE(BankAccReconciliation."Bank Account No.", "Bank Account No.");
                IF BankAccReconciliation.FINDFIRST THEN BEGIN
                    ERROR('There exist a Reconciliation for this account. Kindly act on it first!');
                END;
            end;

        }

    }
    trigger OnInsert()
    begin
        "Document Date" := Today;
        "User ID" := UserId;
    end;

    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
}
