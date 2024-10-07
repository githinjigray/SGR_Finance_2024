tableextension 50021 "Bank Account Statement EXT" extends "Bank Account Statement"
{
    fields
    {
        field(70000; "Total Reconciled"; Decimal)
        {
            Caption = 'Total Reconciled';
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Statement Line"."Statement Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = FILTER(true), "Statement No." = FIELD("Statement No.")));
            Editable = false;
        }
        field(70001; "Difference Btw Statements"; Decimal)
        {
            Caption = 'Difference Btw Statements';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70003; "Total Unreconciled"; Decimal)
        {
            Caption = 'Total Unreconciled';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Statement Line"."Statement Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = FILTER(false), "Statement No." = FIELD("Statement No.")));
        }
        field(70004; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed';
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
        field(70007; "Cash Book Balance"; Decimal)
        {
            Caption = 'Cash Book Balance';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}
