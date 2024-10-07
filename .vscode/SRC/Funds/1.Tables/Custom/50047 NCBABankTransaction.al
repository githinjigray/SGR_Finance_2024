table 50047 "NCBA Bank Transaction"
{
    Caption = 'NCBA Bank Transaction';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
            Caption = 'Transaction ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Transaction Type"; Code[50])
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(3; "Transaction DateTime"; DateTime)
        {
            Caption = 'Transaction DateTime';
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionMembers="" ,Customer,Vendor;
            OptionCaption=' ,Customer,Vendor';
        }
        field(6; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Account Name"; Text[50])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Transaction Amount"; Decimal)
        {
            Caption = 'Transaction Amount';
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; Status; Code[50])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Transaction ID")
        {
            Clustered = true;
        }
    }
}
