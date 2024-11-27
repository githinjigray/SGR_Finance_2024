tableextension 50012 "Sales Header EXT" extends "Sales Header"
{
    fields
    {
        field(70000; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70001; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70002; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70003; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
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
        field(70006; "Date Of Flight"; Date)
        {
            Caption = 'Date Of Flight';
            DataClassification = ToBeClassified;
        }
        field(70011; "Amount (LCY)"; decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70012; "Amount Inc. VAT (LCY)"; decimal)
        {
            Caption = 'Amount Inc. VAT (LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70013; "Order From"; Option)
        {
            Caption = 'Order From';
            DataClassification = ToBeClassified;
            OptionMembers = ,Procurement,Stores;
            OptionCaption = ' ,Procurement,Stores';
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
    }
}
