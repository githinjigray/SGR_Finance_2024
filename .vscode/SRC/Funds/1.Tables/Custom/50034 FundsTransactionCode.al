table 50034 "Funds Transaction Code"
{
    Caption = 'Funds Transaction Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transaction Code"; Code[50])
        {
            Caption = 'Transaction Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
            OptionMembers = Payment,Receipt,Imprest,Refund,"Service Code";
            OptionCaption = 'Payment,Receipt,Imprest,Refund,Service Code';
        }
        field(4; "Account Type"; Enum "Account Type")
        {
            Caption = 'Account Type"';
            DataClassification = ToBeClassified;
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting), Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee;
            trigger OnValidate()
            begin
                "Account Name" := '';
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF "G/L Account".GET("Account No.") THEN BEGIN
                        "Account Name" := "G/L Account".Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF Customer.GET("Account No.") THEN BEGIN
                        "Account Name" := Customer.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                    IF FA.GET("Account No.") THEN BEGIN
                        "Account Name" := FA.Description;
                    END;
                END;

                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    IF Vendor.GET("Account No.") THEN BEGIN
                        "Account Name" := Vendor.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Employee THEN BEGIN
                    IF Employee.GET("Account No.") THEN BEGIN
                        "Account Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    END;
                END;
            end;
        }
        field(6; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = ToBeClassified;
        }
        field(8; "Include VAT"; Boolean)
        {
            Caption = 'Include VAT';
            DataClassification = ToBeClassified;
        }
        field(9; "VAT Code"; Code[10])
        {
            Caption = 'VAT Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Include Withholding Tax"; Boolean)
        {
            Caption = 'Include Withholding Tax';
            DataClassification = ToBeClassified;
        }
        field(11; "Withholding Tax Code"; Code[10])
        {
            Caption = 'Withholding Tax Code';
            DataClassification = ToBeClassified;
        }
        field(12; "Include Withholding VAT"; Boolean)
        {
            Caption = 'Include Withholding VAT';
            DataClassification = ToBeClassified;
        }
        field(13; "Withholding VAT Code"; Code[10])
        {
            Caption = 'Withholding VAT Code';
            DataClassification = ToBeClassified;
        }
        field(14; "Funds Claim Code"; Boolean)
        {
            Caption = 'Funds Claim Code';
            DataClassification = ToBeClassified;
        }
        field(16; "Payroll Taxable"; Boolean)
        {
            Caption = 'Payroll Taxable';
            DataClassification = ToBeClassified;
        }
        field(17; "Payroll Allowance Code"; Code[50])
        {
            Caption = 'Payroll Allowance Code';
            DataClassification = ToBeClassified;
        }
        field(18; "Payroll Deduction Code"; Code[50])
        {
            Caption = 'Payroll Deduction Code';
            DataClassification = ToBeClassified;
        }
        field(19; "Employee Transaction Type"; Code[50])
        {
            Caption = 'Employee Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(20; "Unit Rate"; Decimal)
        {
            Caption = 'Unit Rate';
            DataClassification = ToBeClassified;
        }
        field(21; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
        field(22; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Transaction Code", "Transaction Type")
        {
            Clustered = true;
        }
    }
    var
        "G/L Account": Record "G/L Account";
        Vendor: Record Vendor;
        Customer: Record Customer;
        Employee: Record Employee;
        FA: Record "Fixed Asset";
}
