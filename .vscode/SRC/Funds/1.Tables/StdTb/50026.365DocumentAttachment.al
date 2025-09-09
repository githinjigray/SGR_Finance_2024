tableextension 50026 "365 Document Attachment" extends "Document Attachment"
{

    fields
    {
        field(50100; "Attachment Type"; Option)
        {
            OptionMembers = Invoice, Receipt, Other;
            DataClassification = ToBeClassified;
        }
    }
}


