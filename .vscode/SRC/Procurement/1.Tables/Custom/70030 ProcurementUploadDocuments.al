table 70030 "Procurement Upload Documents"
{
    Caption = 'Procurement Upload Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Code"; Code[50])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Description"; Text[100])
        {
            Caption = 'Document Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Document Mandatory"; Boolean)
        {
            Caption = 'Document Mandatory';
            DataClassification = ToBeClassified;
        }
        field(5; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","Pre-qualification","Purchase Requisition","Bid-Analysis","Purchase Order","Purchase Invoice",GRN,Tender,RFQ;
            OptionCaption = ' ,Pre-qualification,Purchase Requisition,Bid-Analysis,Purchase Order,Purchase Invoice,GRN,Tender,RFQ';
            DataClassification = ToBeClassified;
        }
        field(6; "Tender Stage"; Option)
        {
            Caption = 'Tender Stage';
            OptionMembers = "Tender Preparation","Tender Opening","Tender Evaluation";
            OptionCaption = 'Tender Preparation,Tender Opening,Tender Evaluation';
            DataClassification = ToBeClassified;
        }
        field(20; "Document Attached"; Boolean)
        {
            Caption = 'Document Attached';
            DataClassification = ToBeClassified;
        }
        field(21; "Local File URL"; Text[250])
        {
            Caption = 'Local File URL';
            DataClassification = ToBeClassified;
        }
        field(22; "SharePoint URL"; Text[250])
        {
            Caption = 'SharePoint URL';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code", "Document Code")
        {
            Clustered = true;
        }
    }
}
