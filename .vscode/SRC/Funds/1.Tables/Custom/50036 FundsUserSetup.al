table 50036 "Funds User Setup"
{
    Caption = 'Funds User Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; UserID; Code[50])
        {
            Caption = 'UserID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Receipt Journal Template"; Code[10])
        {
            Caption = 'Receipt Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(3; "Receipt Journal Batch"; Code[10])
        {
            Caption = 'Receipt Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("Receipt Journal Template"));
        }
        field(4; "Payment Journal Template"; Code[10])
        {
            Caption = 'Payment Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(5; "Payment Journal Batch"; Code[10])
        {
            Caption = 'Payment Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("Payment Journal Template"));
        }
        field(6; "Fund Transfer Template Name"; Code[10])
        {
            Caption = 'Fund Transfer Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(7; "Fund Transfer Batch Name"; Code[10])
        {
            Caption = 'Fund Transfer Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("Payment Journal Template"));
        }
        field(8; "Funds Claim Template"; Code[10])
        {
            Caption = 'Funds Claim Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(9; "Funds Claim  Batch"; Code[10])
        {
            Caption = 'Funds Claim  Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("Payment Journal Template"));
        }
        field(10; "Imprest Template"; Code[10])
        {
            Caption = 'Imprest Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(11; "Imprest Batch"; Code[10])
        {
            Caption = 'Imprest Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("Payment Journal Template"));
        }
        field(12; "Default Receipts Bank"; Code[20])
        {
            Caption = 'Default Receipts Bank';
            DataClassification = ToBeClassified;
        }
        field(13; "Default Payment Bank"; Code[20])
        {
            Caption = 'Default Payment Bank';
            DataClassification = ToBeClassified;
        }
        field(14; "Default Petty Cash Bank"; Code[20])
        {
            Caption = 'Default Petty Cash Bank';
            DataClassification = ToBeClassified;
        }
        field(15; "JV Template"; Code[10])
        {
            Caption = 'JV Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(16; "JV Batch"; Code[10])
        {
            Caption = 'JV Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("JV Template"));
        }
        field(17; "Reversal Template"; Code[10])
        {
            Caption = 'Reversal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(18; "Reversal Batch"; Code[10])
        {
            Caption = 'Reversal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("Reversal Template"));
        }
        field(19; "Invoice Template"; Code[20])
        {
            Caption = 'Invoice Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(20; "Invoice Batch"; Code[20])
        {
            Caption = 'Invoice Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".name where("Journal Template Name" = field("Invoice Template"));
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
