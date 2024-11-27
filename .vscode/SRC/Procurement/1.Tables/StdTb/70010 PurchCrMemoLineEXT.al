tableextension 70010 "Purch. Cr. Memo Line EXT" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(70000; "Purchase Requisition Line"; Integer)
        {
            Caption = 'Purchase Requisition Line';
            DataClassification = ToBeClassified;
        }
        field(70001; "Purchase Requisition No."; Code[20])
        {
            Caption = 'Purchase Requisition No.';
            DataClassification = ToBeClassified;
        }
        field(70002; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70003; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70004; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70005; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70006; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(70007; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
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
        field(70018; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
            trigger OnValidate()
            begin

            end;
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

        // modify("Shortcut Dimension 2 Code")
        // {
        //     TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        // }
    }
}
