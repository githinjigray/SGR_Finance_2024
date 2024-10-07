tableextension 50000 "General Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        field(70000; Description2; Text[250])
        {
            Caption = 'Description2';
            DataClassification = ToBeClassified;
        }
        field(70001; "Document Source"; Code[50])
        {
            Caption = 'Document Source';
            DataClassification = ToBeClassified;
        }
        field(70002; Document_Type; Option)
        {
            Caption = 'Document_Type';
            OptionMembers = ,Receipt,Invoice,CreditMemo,Payment,Application;
            OptionCaption = ' ,Receipt,Invoice,CreditMemo,Payment,Application';
        }
        field(70003; "PAYE Name"; Text[250])
        {
            Caption = 'PAYE Name';
            DataClassification = ToBeClassified;
        }
        field(70004; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
        }
        field(70005; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
        }
        field(70006; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
        }
        field(70007; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
        }
        field(70008; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(70009; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
        }
        field(70010; "Employee Transaction Type"; Option)
        {
            Caption = 'Employee Transaction Type';
            OptionMembers = ,Salary,Imprest,Advance;
            OptionCaption = ' ,Salary,Imprest,Advance';
        }
        field(70011; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(70012; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(70013; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            DataClassification = ToBeClassified;
        }
        field(70014; "Payroll Group Code"; Code[50])
        {
            Caption = 'Payroll Group Code';
            DataClassification = ToBeClassified;
        }
        field(70015; "Transaction Code1"; Code[30])
        {
            Caption = 'Transaction Code1';
            DataClassification = ToBeClassified;
        }
    }
}
