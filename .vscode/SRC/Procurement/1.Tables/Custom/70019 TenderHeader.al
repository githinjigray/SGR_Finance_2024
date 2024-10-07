table 70019 "Tender Header"
{
    Caption = 'Tender Header';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Tender Description"; Text[250])
        {
            Caption = 'Tender Description';
            DataClassification = ToBeClassified;
        }
        field(12; "Tender Type"; Option)
        {
            Caption = 'Tender Type';
            OptionMembers=Open,Restricted;
            OptionCaption='Open,Restricted';
            DataClassification = ToBeClassified;
        }
        field(13; "Tender Submission (From)"; Date)
        {
            Caption = 'Tender Submission (From)';
            DataClassification = ToBeClassified;
        }
        field(14; "Tender Submission (To)"; Date)
        {
            Caption = 'Tender Submission (To)';
            DataClassification = ToBeClassified;
        }
        field(15; "Tender Status"; Option)
        {
            Caption = 'Tender Status';
            OptionMembers="Tender Preparation","Tender Opening","Tender Evaluation",Closed;
            OptionCaption='Tender Preparation,Tender Opening,Tender Evaluation,Closed';
            DataClassification = ToBeClassified;
        }
        field(20; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(21; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(22; "Tender Closing Date"; Date)
        {
            Caption = 'Tender Closing Date';
            DataClassification = ToBeClassified;
        }
        field(23; "Evaluation Date"; Date)
        {
            Caption = 'Evaluation Date';
            DataClassification = ToBeClassified;
        }
        field(24; "Award Date"; Date)
        {
            Caption = 'Award Date';
            DataClassification = ToBeClassified;
        }
        field(25; "Supplier Awarded"; Code[30])
        {
            Caption = 'Supplier Awarded';
            DataClassification = ToBeClassified;
        }
        field(26; "Supplier Name"; Text[80])
        {
            Caption = 'Supplier Name';
            DataClassification = ToBeClassified;
        }
        field(27; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(28; "Purchase Requisition"; Code[30])
        {
            Caption = 'Purchase Requisition';
            DataClassification = ToBeClassified;
        }
        field(29; "Purchase Req. Description"; Text[150])
        {
            Caption = 'Purchase Req. Description';
            DataClassification = ToBeClassified;
        }
        field(30; "Tender closed by"; Code[30])
        {
            Caption = 'Tender closed by';
            DataClassification = ToBeClassified;
        }
        field(31; "Supplier Category"; Code[30])
        {
            Caption = 'Supplier Category';
            DataClassification = ToBeClassified;
        }
        field(32; "Supplier Category Description"; Text[200])
        {
            Caption = 'Supplier Category Description';
            DataClassification = ToBeClassified;
        }
        field(33; Status; Option)
        {
            Caption = 'Status';
            OptionMembers=Open,"Pending Approval",Approved,Rejected;
            OptionCaption='Open,Pending Approval,Approved,Rejected';
            DataClassification = ToBeClassified;
        }
        field(34; "Tender Preparation Approved"; Boolean)
        {
            Caption = 'Tender Preparation Approved';
            DataClassification = ToBeClassified;
        }
        field(35; "Held By"; Code[30])
        {
            Caption = 'Held By';
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
