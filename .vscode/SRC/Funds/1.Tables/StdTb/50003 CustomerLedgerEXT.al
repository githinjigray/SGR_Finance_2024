tableextension 50003 "Customer Ledger EXT" extends "Cust. Ledger Entry"
{
    fields
    {
        field(70000; Description2; Text[250])
        {
            Caption = 'Description2';
            DataClassification = ToBeClassified;
        }
        field(70005; Document_Type; Option)
        {
            Caption = 'Document_Type';
            OptionMembers = ,Receipt,Invoice,CreditMemo,Payment,Application;
            OptionCaption = ' ,Receipt,Invoice,CreditMemo,Payment,Application';
        }
        field(70012; "Transaction Code"; Code[30])
        {
            Caption = 'Transaction Code';
            DataClassification = ToBeClassified;
        }
    }
}
