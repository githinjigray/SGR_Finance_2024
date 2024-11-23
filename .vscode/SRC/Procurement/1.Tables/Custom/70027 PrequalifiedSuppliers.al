table 70027 "Prequalified Suppliers"
{
    Caption = 'Prequalified Suppliers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Supplier Name"; Text[200])
        {
            Caption = 'Supplier Name';
            DataClassification = ToBeClassified;
        }
        field(2; "Procurement Period"; Text[50])
        {
            Caption = 'Procurement Period';
            DataClassification = ToBeClassified;
        }
        field(3; "Supplier Category"; Code[20])
        {
            Caption = 'Supplier Category';
            DataClassification = ToBeClassified;
        }
        field(4; "Supplier Category Description"; Text[200])
        {
            Caption = 'Supplier Category Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(6; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(7; Prequalified; Boolean)
        {
            Caption = 'Prequalified';
            DataClassification = ToBeClassified;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(9; "TIN No."; Code[30])
        {
            Caption = 'TIN No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Postal Address"; Text[30])
        {
            Caption = 'Postal Address';
            DataClassification = ToBeClassified;
        }
        field(11; "Postal Code"; Code[20])
        {
            Caption = 'Postal Code';
            DataClassification = ToBeClassified;
        }
        field(12; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(13; "Building Name"; Text[100])
        {
            Caption = 'Building Name';
            DataClassification = ToBeClassified;
        }
        field(14; Street; Text[100])
        {
            Caption = 'Street';
            DataClassification = ToBeClassified;
        }
        field(15; County; Code[20])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(16; "County Name"; Text[100])
        {
            Caption = 'County Name';
            DataClassification = ToBeClassified;
        }
        field(17; AGPO; Option)
        {
            Caption = 'AGPO';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
        field(18; "AGPO Number"; Code[50])
        {
            Caption = 'AGPO Number';
            DataClassification = ToBeClassified;
        }
        field(19; "Incorporation Cert. No."; Code[50])
        {
            Caption = 'Incorporation Cert. No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Incorporation Date"; Date)
        {
            Caption = 'Incorporation Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
        }
        field(22; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(23; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
        }
        field(24; "Bank Branch Name"; Text[100])
        {
            Caption = 'Bank Branch Name';
            DataClassification = ToBeClassified;
        }
        field(25; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(27; "VAT Registered"; Option)
        {
            Caption = 'VAT Registered';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
        field(28; "VAT Registration No."; Code[30])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;
        }
        field(50; "USER ID"; Code[30])
        {
            Caption = 'USER ID';
            DataClassification = ToBeClassified;
        }
        field(51; "Pre-Qualified By"; Code[30])
        {
            Caption = 'Pre-Qualified By';
            DataClassification = ToBeClassified;
        }
        field(52; "Date Pre-Qualified"; Date)
        {
            Caption = 'Date Pre-Qualified';
            DataClassification = ToBeClassified;
        }
        field(53; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(54; "Principal Phone No."; Text[30])
        {
            Caption = 'Principal Contact Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(55; "Document No."; Code[30])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(56; "Contact Person"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contact Person';
        }
    }
    keys
    {
        key(PK; "Supplier Name", "Document No.")
        {
            Clustered = true;
        }
    }
}
