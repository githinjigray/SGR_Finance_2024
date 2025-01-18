tableextension 70611 "365 General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {

        field(70000; "Company Data Directory Path"; Text[250])
        {
            Caption = 'Company Data Directory Path';
            DataClassification = ToBeClassified;
        }
        field(70001; "NSSF No."; Code[20])
        {
            Caption = 'NSSF No.';
            DataClassification = ToBeClassified;
        }
        field(70002; "NHIF No."; Code[20])
        {
            Caption = 'NHIF No.';
            DataClassification = ToBeClassified;
        }
        field(70003; "Telephone No."; Text[50])
        {
            Caption = 'Telephone No.';
            DataClassification = ToBeClassified;
        }
        field(70004; "Company TIN"; Text[100])
        {
            Caption = 'Company TIN';
            DataClassification = ToBeClassified;
        }
        field(70005; "Company URL"; Text[100])
        {
            Caption = 'Company URL';
            DataClassification = ToBeClassified;
        }
        field(70006; "Payslip Message"; Text[150])
        {
            Caption = 'Payslip Message';
            DataClassification = ToBeClassified;
        }
        field(70007; "Company Letter Head"; BLOB)
        {
            Caption = 'Company Letter Head';
            DataClassification = ToBeClassified;
        }
        field(70008; "Bank Names"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(70009; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(70010; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(70011; "Bank Branch name"; Text[100])
        {
            Caption = 'Bank Branch name';
            DataClassification = ToBeClassified;
        }
        field(70012; "Bank SWIFT Code"; Code[20])
        {
            Caption = 'Bank SWIFT Code';
            DataClassification = ToBeClassified;
        }
        field(70013; "VAT No."; Code[20])
        {
            Caption = 'VAT No.';
            DataClassification = ToBeClassified;
        }
        field(70014; "Staff Data URL"; Text[250])
        {
            Caption = 'Staff Data URL';
            DataClassification = ToBeClassified;
        }
        field(70015; "Recruitment Data URL"; Text[250])
        {
            Caption = 'Recruitment Data URL';
            DataClassification = ToBeClassified;
        }
        field(70016; "Procurement Email"; Text[250])
        {
            Caption = 'Procurement Email';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(70017; "Human Resource Email"; Text[250])
        {
            Caption = 'Human Resource Email';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(70018; "Human Resource Sender Name"; Text[250])
        {
            Caption = 'Human Resource Sender Name';
            DataClassification = ToBeClassified;
        }
        field(70019; "Path to Save Documents"; Text[100])
        {
            Caption = 'Path to Save Documents';
            DataClassification = ToBeClassified;
        }
        field(70020; "Stores Email"; Text[250])
        {
            Caption = 'Stores Email';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }        
    }
}
