tableextension 50022 "Bank Account Statement Lineext" extends "Bank Account Statement Line"
{
    fields
    {
        field(70000; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
            DataClassification = ToBeClassified;
        }
        field(70001; "Open Type"; Option)
        {
            Caption = 'Open Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Unpresented,Uncredited;
            OptionCaption = ' ,Unpresented,Uncredited';
        }
        field(70002; "Bank Ledger Entry Line No"; Integer)
        {
            Caption = 'Bank Ledger Entry Line No';
            DataClassification = ToBeClassified;
        }
        field(70003; "Bank Statement Entry Line No"; Integer)
        {
            Caption = 'Bank Statement Entry Line No';
            DataClassification = ToBeClassified;
        }
        field(70004; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(70005; "Reconciling Date"; Date)
        {
            Caption = 'Reconciling Date';
            DataClassification = ToBeClassified;
        }
        field(70006; "Parent Line No 2."; Integer)
        {
            Caption = 'Parent Line No 2.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Transaction ID 2"; Text[50])
        {
            Caption = 'Transaction ID 2';
            DataClassification = ToBeClassified;
        }
        field(70008; "Payee Name/Received From"; Text[250])
        {
            Caption = 'Payee Name/Received From';
            DataClassification = ToBeClassified;
        }
    }
}
