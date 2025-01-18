tableextension 70613 "365 Company Information" extends "Company Information"
{
    fields
    {
        field(70025; Website; Text[250])
        {
            Caption = 'Website';
            ExtendedDatatype = URL;
            DataClassification = ToBeClassified;
        }
    }
}
