table 70502 "Inventory User Setup"
{
    Caption = 'Inventory User Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; UserID; Code[50])
        {
            Caption = 'UserID';
            DataClassification = ToBeClassified;
        }
        field(2; "Item Journal Template"; Code[10])
        {
            Caption = 'Item Journal Template';
            DataClassification = ToBeClassified;
        }
        field(3; "Item Journal Batch"; Code[10])
        {
            Caption = 'Item Journal Batch';

            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; UserID)
        {
            Clustered = true;
        }
    }
}
