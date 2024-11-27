tableextension 70011 "Purchase Header Archive EXT" extends "Purchase Header Archive"
{
    fields
    {
        field(70000; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
        }
        field(70001; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
        }
        field(70002; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
        }
        field(70003; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
        }
        field(70004; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(70005; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
        }
        field(70006; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(70007; "Amount Including VAT(LCY)"; Decimal)
        {
            Caption = 'Amount Including VAT(LCY)';
            DataClassification = ToBeClassified;
        }
        field(70008; "Purchase Order Sent"; Boolean)
        {
            Caption = 'Purchase Order Sent';
            DataClassification = ToBeClassified;
        }
        field(70009; "Request for Quotation Code"; Code[20])
        {
            Caption = 'Request for Quotation Code';
            DataClassification = ToBeClassified;
            TableRelation = "Request for Quotation Header"."No." where(Status = const(Released));
        }
        field(70010; "Purchase Order Type"; Enum LPOTypes)
        {
            Caption = 'Purchase Order Types';
            DataClassification = ToBeClassified;
        }
        field(70020; "Header User ID"; Code[50])
        {
            Caption = 'Header User ID';
            DataClassification = ToBeClassified;
        }
        field(70021; "PO sent to Vendor"; Boolean)
        {
            Caption = 'PO sent to Vendor';
            DataClassification = ToBeClassified;
        }
        field(70023; "Delivery Note No."; Code[30])
        {
            Caption = 'Delivery Note No.';
            DataClassification = ToBeClassified;
        }
        field(70024; "Expense Period"; Code[20])
        {
            Caption = 'Expense Period';
            DataClassification = ToBeClassified;
        }
        field(70025; Archive; Boolean)
        {
            Caption = 'Archive';
            DataClassification = ToBeClassified;
        }
        field(70026; "Archive Reason"; Text[150])
        {
            Caption = 'Archive Reason';
            DataClassification = ToBeClassified;
        }
        field(70027; "Responsibility CenterS"; Code[20])
        {
            Caption = 'Responsibility CenterS';
            DataClassification = ToBeClassified;
        }
        field(70028; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
            trigger OnValidate()
            begin

            end;
        }
        field(70029; "Purchase Type"; Option)
        {
            Caption = 'Purchase Type';
            DataClassification = ToBeClassified;
            OptionMembers = Goods,Services;
            OptionCaption = 'Goods,Services';
        }
        field(70030; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(70050; "Actual Posting Date"; Date)
        {
            Caption = 'Actual Posting Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70070; "PRF No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'PRF No.';
        }
        field(70071; "RFQ No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'RFQ No.';
        }
    }
    trigger OnInsert()
    begin
        rec."Actual Posting Date" := Today;
    end;

    trigger OnDelete()
    begin
        Error('Delete Not Allowed!');
    end;
}

