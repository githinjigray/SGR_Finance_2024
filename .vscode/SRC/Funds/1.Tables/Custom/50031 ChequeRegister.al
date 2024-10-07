table 50031 "Cheque Register"
{
    Caption = 'Cheque Register';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Bank Account"; Code[10])
        {
            Caption = 'Bank Account';
            DataClassification = ToBeClassified;
        }
        field(4; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Last Cheque No."; Code[10])
        {
            Caption = 'Last Cheque No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Cheque Book Number"; Code[30])
        {
            Caption = 'Cheque Book Number';
            DataClassification = ToBeClassified;
        }
        field(7; "No of Leaves"; Integer)
        {
            Caption = 'No of Leaves';
            DataClassification = ToBeClassified;
        }
        field(8; "Cheque Number From"; Code[10])
        {
            Caption = 'Cheque Number From';
            DataClassification = ToBeClassified;
        }
        field(9; "Cheque Number To."; Code[10])
        {
            Caption = 'Cheque Number To.';
            DataClassification = ToBeClassified;
        }
        field(10; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers="",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption=',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(13; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
