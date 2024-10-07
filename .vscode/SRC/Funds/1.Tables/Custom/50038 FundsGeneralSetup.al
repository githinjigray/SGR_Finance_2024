table 50038 "Funds General Setup"
{
    Caption = 'Funds General Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Payment Voucher Nos."; Code[20])
        {
            Caption = 'Payment Voucher Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(3; "Cash Voucher Nos."; Code[20])
        {
            Caption = 'Cash Voucher Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(4; "Receipt Nos."; Code[20])
        {
            Caption = 'Receipt Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(5; "Funds Transfer Nos."; Code[20])
        {
            Caption = 'Funds Transfer Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(6; "Imprest Nos."; Code[20])
        {
            Caption = 'Imprest Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(7; "Imprest Surrender Nos."; Code[20])
        {
            Caption = 'Imprest Surrender Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(8; "Funds Claim Nos."; Code[20])
        {
            Caption = 'Funds Claim Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(9; "Travel Advance Nos."; Code[20])
        {
            Caption = 'Travel Advance Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(10; "Travel Surrender Nos."; Code[20])
        {
            Caption = 'Travel Surrender Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(11; "Payment Voucher Reference Nos."; Code[20])
        {
            Caption = 'Payment Voucher Reference Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(12; "Loan App. Receipt Nos."; Code[20])
        {
            Caption = 'Loan App. Receipt Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(13; "Employee Loan Receipt Nos."; Code[20])
        {
            Caption = 'Employee Loan Receipt Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(14; "Budget Allocation Nos."; Code[20])
        {
            Caption = 'Budget Allocation Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(15; "JV Nos."; Code[30])
        {
            Caption = 'JV Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(16; "Cheque Tolerance Days"; Integer)
        {
            Caption = 'Cheque Tolerance Days';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(17; "Funds Claim Account"; Code[30])
        {
            Caption = 'Funds Claim Account';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(18; "Payment Rounding Type"; Option)
        {
            Caption = 'Payment Rounding Type';
            DataClassification = ToBeClassified;
            OptionMembers = Nearest,Up,Down;
            OptionCaption = 'Nearest,Up,Down';
        }
        field(19; "Payment Rounding Precision"; Decimal)
        {
            Caption = 'Payment Rounding Precision';
            DataClassification = ToBeClassified;
        }
        field(20; "W/Tax Rounding Type"; Option)
        {
            Caption = 'W/Tax Rounding Type';
            DataClassification = ToBeClassified;
            OptionMembers = Nearest,Up,Down;
            OptionCaption = 'Nearest,Up,Down';
        }
        field(21; "W/Tax Rounding Precision"; Decimal)
        {
            Caption = 'W/Tax Rounding Precision';
            DataClassification = ToBeClassified;
        }
        field(22; "W/VAT Rounding Type"; Option)
        {
            Caption = 'W/VAT Rounding Type';
            DataClassification = ToBeClassified;
            OptionMembers = Nearest,Up,Down;
            OptionCaption = 'Nearest,Up,Down';
        }
        field(23; "W/VAT Rounding Precision"; Decimal)
        {
            Caption = 'W/VAT Rounding Precision';
            DataClassification = ToBeClassified;
        }
        field(24; "Cheque Register No."; Code[30])
        {
            Caption = 'Cheque Register No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(25; "Reversal Header"; Code[30])
        {
            Caption = 'Reversal Header';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(26; "Fixed Deposit Receivable A/c"; Code[30])
        {
            Caption = 'Fixed Deposit Receivable A/c';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(27; "Fixed Deposit Interest A/c"; Code[30])
        {
            Caption = 'Fixed Deposit Interest A/c';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(28; "FD Account Nos."; Code[20])
        {
            Caption = 'FD Account Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(29; "Project Transaction No."; Code[30])
        {
            Caption = 'Project Transaction No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(30; "Travel Request No."; Code[20])
        {
            Caption = 'Travel Request No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(31; "Discount Account No."; Code[20])
        {
            Caption = 'Discount Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(32; "Fixed Deposit Accrual A/c"; Code[30])
        {
            Caption = 'Fixed Deposit Accrual A/c';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
