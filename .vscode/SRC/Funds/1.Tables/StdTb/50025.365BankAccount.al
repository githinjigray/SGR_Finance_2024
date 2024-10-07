tableextension 50025 "365 Bank Account" extends "Bank Account"
{
    fields
    {
        field(50000; "Show In Sales Invoice"; Boolean)
        {
            Caption = 'Show In Sales Invoice';
            DataClassification = ToBeClassified;
        }
    }
}
