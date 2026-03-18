table 50800 "Denomination Types"
{
    Caption = 'Denomination Types';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Denomintaion; Code[50])
        {
            Caption = 'Denomintaion';
        }
        field(2; "Denomination Description"; Text[250])
        {
            Caption = 'Denomination Description';
        }
        field(3; "Denomination Amount"; Decimal)
        {
            Caption = 'Denomination Amount';
        }
    }
    keys
    {
        key(PK; Denomintaion)
        {
            Clustered = true;
        }
    }
}
