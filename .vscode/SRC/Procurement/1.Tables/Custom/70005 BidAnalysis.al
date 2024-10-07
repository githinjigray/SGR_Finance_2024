table 70005 "Bid Analysis"
{
    Caption = 'Bid Analysis';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Request for Quotation No."; Code[20])
        {
            Caption = 'Request for Quotation No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement=true;//
        }
        field(3; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Of Measure"; Code[20])
        {
            Caption = 'Unit Of Measure';
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(10; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = ToBeClassified;
        }
        field(11; Total; Decimal)
        {
            Caption = 'Total';
            DataClassification = ToBeClassified;
        }
        field(12; "Last Direct Cost"; Decimal)
        {
            Caption = 'Last Direct Cost';
            DataClassification = ToBeClassified;
        }
        field(13; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Request for Quotation No.","Line No.","Quote No.","Vendor No.")
        {
            Clustered = true;
        }
    }
}
