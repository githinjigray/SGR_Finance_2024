tableextension 70001 "Payment Line EXT" extends "Purchase Line"
{
    fields
    {
        field(70000; "Purchase Requisition Line"; Integer)
        {
            Caption = 'Purchase Requisition Line';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70001; "Purchase Requisition No."; Code[20])
        {
            Caption = 'Purchase Requisition No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Purchase Requisition Line"."Document No." where("Document No." = field("Document No."), "Line No." = field("Purchase Requisition Line"));
        }
        field(70002; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            END;
        }
        field(70003; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            END;
        }
        field(70004; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            END;
        }
        field(70005; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            END;
        }
        field(70006; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            END;
        }
        field(70007; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            END;
        }
        field(70008; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(70009; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(70010; "Amount Including VAT(LCY)"; Decimal)
        {
            Caption = 'Amount Including VAT(LCY)';
            DataClassification = ToBeClassified;
        }
        field(70011; "Property Charge Code"; Code[50])
        {
            Caption = 'Property Charge Code';
            DataClassification = ToBeClassified;
        }
        field(70012; "Property Code"; Code[20])
        {
            Caption = 'Property Code';
            DataClassification = ToBeClassified;
        }
        field(70013; "Request for Quotation Code"; Code[20])
        {
            Caption = 'Request for Quotation Code';
            DataClassification = ToBeClassified;
        }
        field(70015; "Withholding Tax Code"; Code[10])
        {
            Caption = 'Withholding Tax Code';
            DataClassification = ToBeClassified;
        }
        field(70016; "Withholding VAT Code"; Code[10])
        {
            Caption = 'Withholding VAT Code';
            DataClassification = ToBeClassified;
        }
        field(70017; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(70050; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70051; "Alternative Part No. 1"; Code[50])
        {
            Caption = 'Alternative Part No. 1';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70052; "Alternative Part No. 2"; Code[50])
        {
            Caption = 'Alternative Part No. 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70053; "Alternative Part No. 3"; Code[50])
        {
            Caption = 'Serial Number';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70054; "Alternative Part No. 4"; Decimal)
        {
            Caption = 'Total Cost Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70060; "Service Date"; Date)
        {
            Caption = 'Service Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec.Type = Rec.Type::"G/L Account" then begin
                    "Gen. Prod. Posting Group" := 'GENERAL';
                    Validate(REC."Gen. Prod. Posting Group");
                end
            end;
        }

    }
}
