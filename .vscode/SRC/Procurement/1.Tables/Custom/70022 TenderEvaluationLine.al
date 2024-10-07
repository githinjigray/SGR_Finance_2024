table 70022 "Tender Evaluation Line"
{
    Caption = 'Tender Evaluation Line';
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
        field(12; "Tender No."; Code[30])
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
        field(15; "Marks Assigned"; Decimal)
        {
            Caption = 'Marks Assigned';
            DataClassification = ToBeClassified;
        }
        field(16; Comments; Text[150])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(17; "Supplier Name"; Text[100])
        {
            Caption = 'Supplier Name';
            DataClassification = ToBeClassified;
        }
        field(18; Evaluator; Code[30])
        {
            Caption = 'Evaluator';
            DataClassification = ToBeClassified;
        }
        field(19; "Evaluator Name"; Text[100])
        {
            Caption = 'Evaluator Name';
            DataClassification = ToBeClassified;
        }
        field(20; "Evaluator User ID"; Code[30])
        {
            Caption = 'Evaluator User ID';
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
