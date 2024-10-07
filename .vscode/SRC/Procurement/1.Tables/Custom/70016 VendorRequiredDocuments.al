table 70016 "Vendor Required Documents"
{
    Caption = 'Vendor Required Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
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
        field(4; "Document Attached"; Boolean)
        {
            Caption = 'Document Attached';
            DataClassification = ToBeClassified;
        }
        field(5; "Document Verified"; Boolean)
        {
            Caption = 'Document Verified';
            DataClassification = ToBeClassified;
        }
        field(6; "Verified By"; Code[50])
        {
            Caption = 'Verified By';
            DataClassification = ToBeClassified;
        }
        field(10; "Product Code"; Code[50])
        {
            Caption = 'Product Code';
            DataClassification = ToBeClassified;
        }
        field(11; "LPO Invoice No"; Code[80])
        {
            Caption = 'LPO Invoice No';
            DataClassification = ToBeClassified;
        }
        field(12; "LPO Vendor No."; Code[80])
        {
            Caption = 'LPO Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(17; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            
        }
        field(18; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ","Pre-qualification","Purchase Requisition","Bid-Analysis","Purchase Order","Purchase Invoice",GRN,Tender;
            OptionCaption = ' ,Pre-qualification,Purchase Requisition,Bid-Analysis,Purchase Order,Purchase Invoice,GRN,Tender';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code", "Line No")
        {
            Clustered = true;
        }
    }
}
