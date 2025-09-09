tableextension 70002 "Item EXT" extends Item
{
    fields
    {
        field(70000; "Location Code"; Code[30])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(70001; "Market Price"; Decimal)
        {
            Caption = 'Market Price';
            DataClassification = ToBeClassified;
        }
        field(70002; "Item G/L Budget Account"; Code[30])
        {
            Caption = 'Item G/L Budget Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(70005; "Wholesale Price"; Decimal)
        {
            Caption = 'Wholesale Price';
            DataClassification = ToBeClassified;
        }
        field(70006; "Promotion Price"; Decimal)
        {
            Caption = 'Promotion Price';
            DataClassification = ToBeClassified;
        }
        field(70010; "NEW NO."; Code[30])
        {
            Caption = 'NEW NO.';
            DataClassification = ToBeClassified;
        }
        field(70011; "Old Item No."; Code[30])
        {
            Caption = 'Old Item No.';
            DataClassification = ToBeClassified;
        }
        field(70012; "Purchase Unit Cost"; Decimal)
        {
            Caption = 'Purchase Unit Cost';
            DataClassification = ToBeClassified;
        }
        field(70013; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(70014; "Alternative Part No. 1"; Code[50])
        {
            Caption = 'Alternative Part No. 1';
            DataClassification = ToBeClassified;
        }
        field(70015; "Alternative Part No. 2"; Code[50])
        {
            Caption = 'Alternative Part No. 2';
            DataClassification = ToBeClassified;
        }
        field(70016; "Alternative Part No. 3"; Code[50])
        {
            Caption = 'ASerial Number';
            DataClassification = ToBeClassified;
        }
        field(70017; "Alternative Part No. 4"; Decimal)
        {
            Caption = 'Total Cost Value';
            DataClassification = ToBeClassified;
        }
        field(70018; "Inventory Qty."; Decimal)
        {
            Caption = 'Inventory Qty.';
            DataClassification = ToBeClassified;
        }
        field(70019; "Inventory Cost"; Decimal)
        {
            Caption = 'Inventory Cost';
            DataClassification = ToBeClassified;
        }

    }
    fieldgroups
    {
        addlast(DropDown; "Part No.", "Alternative Item No.", "Alternative Part No. 1", "Alternative Part No. 2", "Alternative Part No. 3", "Alternative Part No. 4")
        {
        }

    }
}
