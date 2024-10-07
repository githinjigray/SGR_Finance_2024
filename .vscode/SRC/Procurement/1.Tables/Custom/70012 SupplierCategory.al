table 70012 "Supplier Category"
{
    Caption = 'Supplier Category';
    DataClassification = ToBeClassified;

    fields
    {
        field(11; "Document Number"; Code[200])
        {
            Caption = 'Document Number';
            DataClassification = ToBeClassified;
        }
        field(12; "Supplier Category"; Code[30])
        {
            Caption = 'Supplier Category';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category"."Code";
            trigger OnValidate()
            begin
                ItemCategory.RESET;
                ItemCategory.SETRANGE(ItemCategory.Code, "Supplier Category");
                IF ItemCategory.FINDFIRST THEN BEGIN
                    "Category Description" := ItemCategory.Description;
                END;
            end;
        }
        field(13; "Category Description"; Text[250])
        {
            Caption = 'Category Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Number", "Supplier Category")
        {
            Clustered = true;
        }
    }
    var
        ItemCategory: Record "Item Category";
}
