table 70017 "Procurement Email Messages"
{
    Caption = 'Procurement Email Messages';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(2; "Sender Name"; Text[100])
        {
            Caption = 'Sender Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Sender Address"; Text[80])
        {
            Caption = 'Sender Address';
            DataClassification = ToBeClassified;
        }
        field(9; Subject; Text[250])
        {
            Caption = 'Subject';
            DataClassification = ToBeClassified;
        }
        field(10; Recipients; Text[250])
        {
            Caption = 'Recipients';
            DataClassification = ToBeClassified;
        }
        field(11; "Recipients CC"; Text[250])
        {
            Caption = 'Recipients CC';
            DataClassification = ToBeClassified;
        }
        field(12; "Recipients BCC"; Text[250])
        {
            Caption = 'Recipients BCC';
            DataClassification = ToBeClassified;
        }
        field(20; Body; BLOB)
        {
            Caption = 'Body';
            DataClassification = ToBeClassified;
        }
        field(25; HtmlFormatted; Boolean)
        {
            Caption = 'HtmlFormatted';
            DataClassification = ToBeClassified;
        }
        field(27; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(28; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(29; "Time Created"; Time)
        {
            Caption = 'Time Created';
            DataClassification = ToBeClassified;
        }
        field(30; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
            DataClassification = ToBeClassified;
        }
        field(31; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = ToBeClassified;
        }
        field(32; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
            DataClassification = ToBeClassified;
        }
        field(33; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
