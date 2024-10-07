tableextension 50005 "Vendor Ledger Entry Ext" extends "Vendor Ledger Entry"
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
            OptionMembers = ,Receipt,Invoice,CreditMemo,Payment;
            OptionCaption = ' ,Receipt,Invoice,CreditMemo,Payment';
        }
    }
}
