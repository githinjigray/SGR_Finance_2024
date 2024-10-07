table 70008 "Bid Analysis Items"
{
    Caption = 'Bid Analysis Items';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Request for Quotation No."; Code[20])
        {
            Caption = 'Request for Quotation No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(4; "Vendor Name"; Text[200])
        {
            Caption = 'Vendor Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; Name; Text[150])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Total Cost Exc. VAT" := "Unit Cost" * Quantity;
                "Total Cost Exc. VAT (LCY)" := "Unit Cost" * Quantity;
                MODIFY;
            end;
        }
        field(8; "Unit Of Measure"; Code[20])
        {
            Caption = 'Unit Of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(9; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Unit Cost (LCY)" := "Unit Cost";
                "Unit Cost Incl. VAT" := "Unit Cost";
                "Total Cost Exc. VAT" := "Unit Cost" * Quantity;
                Validate("Total Cost Exc. VAT");
                "Total Cost Exc. VAT (LCY)" := "Unit Cost" * Quantity;
                "Total Cost Inc. VAT" := "Total Cost Exc. VAT";
                "Total Cost Inc. VAT (LCY)" := "Total Cost Inc. VAT";
                MODIFY;

            end;
        }
        field(10; "Unit Cost (LCY)"; Decimal)
        {
            Caption = 'Unit Cost (LCY)';
            DataClassification = ToBeClassified;
        }
        field(11; "Total Cost Exc. VAT"; Decimal)
        {
            Caption = 'Total Cost Exc. VAT';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Total Cost Exc. VAT (LCY)" := 0;
                "Total Cost Inc. VAT" := 0;
                "Total Cost Inc. VAT (LCY)" := 0;
                "VAT Amount" := 0;
                "VAT Amount (LCY)" := 0;

                "Total Cost Exc. VAT (LCY)" := "Total Cost Exc. VAT";
                "Total Cost Inc. VAT" := "Total Cost Exc. VAT";
                "Total Cost Inc. VAT (LCY)" := "Total Cost Exc. VAT";


                IF "VAT Prod. Posting Group" <> '' THEN BEGIN
                    VATPostingSetup.RESET;
                    VATPostingSetup.SETRANGE(VATPostingSetup."Tax Code", "VAT Prod. Posting Group");
                    IF VATPostingSetup.FINDFIRST THEN BEGIN
                        "Unit Cost Incl. VAT" := ((VATPostingSetup.Percentage / 100) * "Unit Cost") + "Unit Cost";
                        "VAT Amount" := (VATPostingSetup.Percentage / 100) * "Total Cost Exc. VAT";
                        "VAT Amount (LCY)" := (VATPostingSetup.Percentage / 100) * "Total Cost Exc. VAT";
                        "Total Cost Inc. VAT" := "Total Cost Exc. VAT" + "VAT Amount";
                        "Total Cost Inc. VAT (LCY)" := "Total Cost Exc. VAT (LCY)" + "VAT Amount (LCY)";
                    END;
                END else begin
                    "VAT Amount" := 0;
                    "VAT Amount (LCY)" := 0;
                    "Unit Cost Incl. VAT" := "Unit Cost";
                    "Total Cost Inc. VAT" := "Total Cost Exc. VAT";
                    "Total Cost Inc. VAT (LCY)" := "Total Cost Exc. VAT (LCY)";
                end;

            end;
        }
        field(12; "Total Cost Exc. VAT (LCY)"; Decimal)
        {
            Caption = 'Total Cost Exc. VAT (LCY)';
            DataClassification = ToBeClassified;
        }
        field(13; "Unit Cost Incl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Cost Incl. VAT';
        }
        field(16; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(17; "Vendor Code"; Integer)
        {
            Caption = 'Vendor Code';
            DataClassification = ToBeClassified;
        }
        field(20; "Type"; enum "Purchase Line Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(21; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No."
            ELSE
            IF (Type = CONST(Item)) Item."No.";
            trigger OnValidate()
            begin
                Name := '';
                IF GLAccount.GET("No.") THEN
                    Name := GLAccount.Name;
                IF FixedAsset.GET("No.") THEN
                    Name := FixedAsset.Description;
                IF ItemList.GET("No.") THEN
                    Name := ItemList.Description;
            end;
        }
        field(22; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(24; "Total Cost Inc. VAT"; Decimal)
        {
            Caption = 'Total Cost Inc. VAT';
            DataClassification = ToBeClassified;
        }
        field(25; "Total Cost Inc. VAT (LCY)"; Decimal)
        {
            Caption = 'Total Cost Inc. VAT (LCY)';
            DataClassification = ToBeClassified;
        }
        field(26; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = ToBeClassified;
        }
        field(27; "VAT Amount (LCY)"; Decimal)
        {
            Caption = 'VAT Amount (LCY)';
            DataClassification = ToBeClassified;
        }
        field(28; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Tax Code"."Tax Code" where(Type = filter(VAT));
            trigger OnValidate()
            begin
                VALIDATE("Total Cost Exc. VAT");
            end;
        }
        field(29; "Actual Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual Vendor No.';
            TableRelation = Vendor."No.";
        }
        field(30; "Location Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(31; "Amounts inclusive VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(70050; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(70051; "Alternative Part No. 1"; Code[50])
        {
            Caption = 'Alternative Part No. 1';
            DataClassification = ToBeClassified;
        }
        field(70052; "Alternative Part No. 2"; Code[50])
        {
            Caption = 'Alternative Part No. 2';
            DataClassification = ToBeClassified;
        }
        field(70053; "Alternative Part No. 3"; Code[50])
        {
            Caption = 'Serial Number';
            DataClassification = ToBeClassified;
        }
        field(70054; "Alternative Part No. 4"; Decimal)
        {
            Caption = 'Total Cost Value';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Vendor No.", "Line No")
        {
            Clustered = true;
        }
    }
    var
        VATPostingSetup: Record "Funds Tax Code";
        GLAccount: Record "G/L Account";
        FixedAsset: Record "Fixed Asset";
        ItemList: Record Item;
}
