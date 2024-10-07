table 70021 "Tender Evaluation"
{
    Caption = 'Tender Evaluation';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Evaluation No."; Code[30])
        {
            Caption = 'Evaluation No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Tender No."; Code[30])
        {
            Caption = 'Tender No.';
            DataClassification = ToBeClassified;
        }
        field(12; "Tender Date"; Date)
        {
            Caption = 'Tender Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Tender Close Date"; Date)
        {
            Caption = 'Tender Close Date';
            DataClassification = ToBeClassified;
        }
        field(14; "Evaluation Date"; Date)
        {
            Caption = 'Evaluation Date';
            DataClassification = ToBeClassified;
        }
        field(15; Supplier; Text[80])
        {
            Caption = 'Supplier';
            DataClassification = ToBeClassified;
        }
        field(16; Marks; Decimal)
        {
            Caption = 'Marks';
            DataClassification = ToBeClassified;
        }
        field(19; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(30; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(31; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(32; Status; Option)
        {
            Caption = 'Status';
            OptionMembers=Open,"Pending Approval",Approved,Submitted;
            OptionCaption='Open,Pending Approval,Approved,Submitted';
            DataClassification = ToBeClassified;
        }
        field(33; "Evaluation Criteria"; Code[30])
        {
            Caption = 'Evaluation Criteria';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Evaluation No.")
        {
            Clustered = true;
        }
    }
}
