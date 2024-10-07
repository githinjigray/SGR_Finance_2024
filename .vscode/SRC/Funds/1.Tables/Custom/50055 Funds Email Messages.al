table 50055 "Funds Email Messages"
{
    Caption = 'Funds Email Messages';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            AutoIncrement=true;
            DataClassification = ToBeClassified;
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
        field(4; Subject; Text[100])
        {
            Caption = 'Subject';
            DataClassification = ToBeClassified;
        }
        field(5; Recipients; Text[250])
        {
            Caption = 'Recipients';
            DataClassification = ToBeClassified;
        }
        field(6; "Recipients CC"; Text[250])
        {
            Caption = 'Recipients CC';
            DataClassification = ToBeClassified;
        }
        field(7; "Recipients BCC"; Text[250])
        {
            Caption = 'Recipients BCC';
            DataClassification = ToBeClassified;
        }
        field(8; Body; BLOB)
        {
            Caption = 'Body';
            DataClassification = ToBeClassified;
        }
        field(9; HtmlFormatted; Boolean)
        {
            Caption = 'HtmlFormatted';
            DataClassification = ToBeClassified;
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(11; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(12; "Time Created"; Time)
        {
            Caption = 'Time Created';
            DataClassification = ToBeClassified;
        }
        field(13; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
            DataClassification = ToBeClassified;
        }
        field(14; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = ToBeClassified;
        }
        field(15; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
            DataClassification = ToBeClassified;
        }
        field(16; "Document No"; Code[20])
        {
            Caption = 'Document No';
            DataClassification = ToBeClassified;
        }
        field(17; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK;"Entry No.")
        {
            Clustered = true;
        }
    }
}
