tableextension 70012 "Purchase Line Archive EXT" extends "Purchase Line Archive"
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

        }
        field(70003; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;

        }
        field(70004; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;

        }
        field(70005; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;

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

    }
}


