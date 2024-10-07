table 70023 "Tender Evaluation Results"
{
    Caption = 'Tender Evaluation Results';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(11; "Tender No."; Code[30])
        {
            Caption = 'Tender No.';
            DataClassification = ToBeClassified;
        }
        field(13; Question; Text[200])
        {
            Caption = 'Question';
            DataClassification = ToBeClassified;
        }
        field(14; Marks; Decimal)
        {
            Caption = 'Marks';
            DataClassification = ToBeClassified;
        }
        field(15; "Supplier Name"; Text[30])
        {
            Caption = 'Supplier Name';
            DataClassification = ToBeClassified;
        }
        field(16; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;
        }
        field(17; "Average"; Decimal)
        {
            Caption = 'Average';
            DataClassification = ToBeClassified;
        }
        field(18; Position; Decimal)
        {
            Caption = 'Position';
            DataClassification = ToBeClassified;
        }
        field(19; "Drop Supplier"; Boolean)
        {
            Caption = 'Drop Supplier';
            DataClassification = ToBeClassified;
        }
        field(20; "Reason for Disqualification"; Text[200])
        {
            Caption = 'Reason for Disqualification';
            DataClassification = ToBeClassified;
        }
        field(21; "Count Evaluators"; Integer)
        {
            Caption = 'Count Evaluators';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No.","Tender No.")
        {
            Clustered = true;
        }
    }
}
