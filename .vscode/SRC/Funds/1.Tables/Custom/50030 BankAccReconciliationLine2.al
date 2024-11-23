table 50030 "Bank Acc. Reconciliation Line2"
{
    Caption = 'Bank Acc. Reconciliation Line2';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Statement Line No."; Integer)
        {
            Caption = 'Statement Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Statement Amount"; Decimal)
        {
            Caption = 'Statement Amount';
            DataClassification = ToBeClassified;
        }
        field(8; Difference; Decimal)
        {
            Caption = 'Difference';
            DataClassification = ToBeClassified;
        }
        field(9; "Applied Amount"; Decimal)
        {
            Caption = 'Applied Amount';
            DataClassification = ToBeClassified;
        }
        field(10; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;
            OptionCaption = 'Bank Account Ledger Entry,Check Ledger Entry,Difference';
        }
        field(11; "Applied Entries"; Integer)
        {
            Caption = 'Applied Entries';
            DataClassification = ToBeClassified;
        }
        field(12; "Value Date"; Date)
        {
            Caption = 'Value Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Ready for Application"; Boolean)
        {
            Caption = 'Ready for Application';
            DataClassification = ToBeClassified;
        }
        field(14; "Check No."; Code[20])
        {
            Caption = 'Check No.';
            DataClassification = ToBeClassified;
        }
        field(15; "Related-Party Name"; Text[250])
        {
            Caption = 'Related-Party Name';
            DataClassification = ToBeClassified;
        }
        field(16; "Additional Transaction Info"; Text[100])
        {
            Caption = 'Additional Transaction Info';
            DataClassification = ToBeClassified;
        }
        field(17; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            DataClassification = ToBeClassified;
        }
        field(18; "Data Exch. Line No."; Integer)
        {
            Caption = 'Data Exch. Line No.';
            DataClassification = ToBeClassified;
        }
        field(19; "Statement Type"; Option)
        {
            Caption = 'Statement Type';
            DataClassification = ToBeClassified;
            OptionMembers = "Bank Reconciliation","Payment Application";
            OptionCaption = 'Bank Reconciliation,Payment Application';
        }
        field(20; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
        }
        field(21; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(22; "Transaction Text"; Text[140])
        {
            Caption = 'Transaction Text';
            DataClassification = ToBeClassified;
        }
        field(23; "Related-Party Bank Acc. No."; Text[100])
        {
            Caption = 'Related-Party Bank Acc. No.';
            DataClassification = ToBeClassified;
        }
        field(24; "Related-Party Address"; Text[100])
        {
            Caption = 'Related-Party Address';
            DataClassification = ToBeClassified;
        }
        field(25; "Related-Party City"; Text[50])
        {
            Caption = 'Related-Party City';
            DataClassification = ToBeClassified;
        }
        field(26; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
        }
        field(28; "Match Confidence"; Option)
        {
            Caption = 'Match Confidence';
            DataClassification = ToBeClassified;
            OptionMembers = "None",Low,Medium,High,"High - Text-to-Account MapTINg",Manual,Accepted;
            OptionCaption = 'None,Low,Medium,High,High - Text-to-Account MapTINg,Manual,Accepted';
        }
        field(29; "Match Quality"; Integer)
        {
            Caption = 'Match Quality';
            DataClassification = ToBeClassified;
        }
        field(30; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            DataClassification = ToBeClassified;
        }
        field(31; "Parent Line No."; Integer)
        {
            Caption = 'Parent Line No.';
            DataClassification = ToBeClassified;
        }
        field(32; "Transaction ID"; Text[50])
        {
            Caption = 'Transaction ID';
            DataClassification = ToBeClassified;
        }
        field(33; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
        }
        field(34; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
            DataClassification = ToBeClassified;
        }
        field(35; "Open Type"; Option)
        {
            Caption = 'Open Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Unpresented Cheques List","Uncredited Cheques List";
            OptionCaption = ',Unpresented Cheques List,Uncredited Cheques List';
        }
        field(36; "Bank Ledger Entry Line No"; Integer)
        {
            Caption = 'Bank Ledger Entry Line No';
            DataClassification = ToBeClassified;
        }
        field(37; "Bank Statement Entry Line No"; Integer)
        {
            Caption = 'Bank Statement Entry Line No';
            DataClassification = ToBeClassified;
        }
        field(38; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(39; "Reconciling Date"; Date)
        {
            Caption = 'Reconciling Date';
            DataClassification = ToBeClassified;
        }
        field(40; "Parent Line No 2."; Integer)
        {
            Caption = 'Parent Line No 2.';
            DataClassification = ToBeClassified;
        }
        field(41; "Transaction ID 2"; Text[50])
        {
            Caption = 'Transaction ID 2';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Bank Account No.", "Statement No.", "Statement Line No.")
        {
            Clustered = true;
        }
    }
}
