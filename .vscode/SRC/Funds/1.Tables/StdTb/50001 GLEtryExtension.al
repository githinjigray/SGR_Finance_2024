tableextension 50001 "G/L Etry Extension" extends "G/L Entry"
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
            OptionMembers = ,Receipt,Invoice,CreditMemo,Payment;
            OptionCaption = ' ,Receipt,Invoice,CreditMemo,Payment';
        }
        field(70003; "PAYE Name"; Text[250])
        {
            Caption = 'Source Name';
            DataClassification = ToBeClassified;
        }
        field(70004; "Restricted Account"; Boolean)
        {
            Caption = 'Restricted Account';
            DataClassification = ToBeClassified;
        }
        field(70005; "Employee Transaction Type"; Option)
        {
            Caption = 'Employee Transaction Type';
            OptionMembers = ,Salary,Imprest,Advance;
            OptionCaption = ' ,Salary,Imprest,Advance';
        }
        field(70006; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(70008; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(70009; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            DataClassification = ToBeClassified;
        }
        field(70010; "Payroll Group Code"; Code[50])
        {
            Caption = 'Payroll Group Code';
            DataClassification = ToBeClassified;
        }
        field(70011; "Cheque No."; Code[10])
        {
            Caption = 'Cheque No.';
            DataClassification = ToBeClassified;
        }
        field(70012; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            Editable = false;
        }
        field(70013; "Currency Amount"; Decimal)
        {
            Caption = 'Currency Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // field(70022; "Shortcut Dimension 3 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 3 Code';
        //     DataClassification = ToBeClassified;
        // }
        // field(70023; "Shortcut Dimension 4 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 4 Code';
        //     DataClassification = ToBeClassified;
        // }
        // field(70024; "Shortcut Dimension 5 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 5 Code';
        //     DataClassification = ToBeClassified;
        // }
        // field(70025; "Shortcut Dimension 6 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 6 Code';
        //     DataClassification = ToBeClassified;
        // }
        // field(70026; "Shortcut Dimension 7 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 7 Code';
        //     DataClassification = ToBeClassified;
        // }
        // field(70027; "Shortcut Dimension 8 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 8 Code';
        //     DataClassification = ToBeClassified;
        // }
    }
}
