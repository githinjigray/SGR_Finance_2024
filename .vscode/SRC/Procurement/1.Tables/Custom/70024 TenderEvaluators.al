table 70024 "Tender Evaluators"
{
    Caption = 'Tender Evaluators';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(9; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(10; "Tender No"; Code[30])
        {
            Caption = 'Tender No';
            DataClassification = ToBeClassified;
        }
        field(11; Evaluator; Code[10])
        {
            Caption = 'Evaluator';
            DataClassification = ToBeClassified;
        }
        field(12; "Evaluator Name"; Text[100])
        {
            Caption = 'Evaluator Name';
            DataClassification = ToBeClassified;
        }
        field(13; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(14; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(15; "Committee Chairperson"; Boolean)
        {
            Caption = 'Committee Chairperson';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No","Tender No")
        {
            Clustered = true;
        }
    }
}
