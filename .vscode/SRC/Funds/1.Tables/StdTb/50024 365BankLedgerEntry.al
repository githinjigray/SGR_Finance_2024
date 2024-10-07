tableextension 50024 "365 Bank Ledger Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(70008; "Payee Name/Received From"; Text[250])
        {
            Caption = 'Payee Name/Received From';
            DataClassification = ToBeClassified;
        }
    }
}
