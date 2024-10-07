tableextension 50008 "365 G/L Account" extends "G/L Account"
{
    fields
    {
        field(50000; "Account Location"; Text[256])
        {
            Caption = 'Account Location';
            DataClassification = ToBeClassified;
        }
    }
}
