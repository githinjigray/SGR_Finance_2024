table 70020 "Tender Lines"
{
    Caption = 'Tender Lines';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(11; "Document No."; Code[30])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Supplier Name"; Text[100])
        {
            Caption = 'Supplier Name';
            DataClassification = ToBeClassified;
        }
        field(14; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(15; "Reason for Disqualification"; Text[200])
        {
            Caption = 'Reason for Disqualification';
            DataClassification = ToBeClassified;
        }
        field(16; Disqualified; Boolean)
        {
            Caption = 'Disqualified';
            DataClassification = ToBeClassified;
        }
        field(17; "Disqualification point"; Code[30])
        {
            Caption = 'Disqualification point';
            DataClassification = ToBeClassified;
        }
        field(18; "Bid Amount"; Decimal)
        {
            Caption = 'Bid Amount';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No.","Document No.")
        {
            Clustered = true;
        }
    }
}
