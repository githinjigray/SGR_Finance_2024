tableextension 70500 "Inventory Setup EXT" extends "Inventory Setup"
{
    fields
    {
        field(70000; "Stores Requisition Nos."; Code[20])
        {
            Caption = 'Stores Requisition Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(70001; "Item Journal Template"; Code[20])
        {
            Caption = 'Item Journal Template';
            DataClassification = ToBeClassified;
        }
        field(70002; "Item Journal Batch"; Code[20])
        {
            Caption = 'Item Journal Batch';
            DataClassification = ToBeClassified;
        }
    }
}
