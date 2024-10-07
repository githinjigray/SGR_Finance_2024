table 70013 "Specification Attributes"
{
    Caption = 'Specification Attributes';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(11; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = ToBeClassified;
        }
        field(12; Specification; Text[150])
        {
            Caption = 'Specification';
            DataClassification = ToBeClassified;
        }
        field(13; Requirement; Text[150])
        {
            Caption = 'Requirement';
            DataClassification = ToBeClassified;
        }
        field(14; No; Code[10])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(15; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers="Purchase Requisition",LPO,"Procurement Planning",RFQ;
            OptionCaption='Purchase Requisition,LPO,Procurement Planning,RFQ';
            DataClassification = ToBeClassified;
        }
        field(16; Item; Code[30])
        {
            Caption = 'Item';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No.","RFQ No.","Type",Item)
        {
            Clustered = true;
        }
    }
}
