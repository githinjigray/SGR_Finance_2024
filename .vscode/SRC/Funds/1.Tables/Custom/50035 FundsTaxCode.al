table 50035 "Funds Tax Code"
{
    Caption = 'Funds Tax Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tax Code"; Code[10])
        {
            Caption = 'Tax Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ",VAT,"W/TAX","W/VAT";
            OptionCaption = ' ,VAT,W/TAX,W/VAT';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Account Type"; enum "Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor."No."
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee."No.";
            trigger OnValidate()
            begin
                "Account Name" := '';
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF "G/LAccount".GET("Account No.") THEN BEGIN
                        "Account Name" := "G/LAccount".Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF Customer.GET("Account No.") THEN BEGIN
                        "Account Name" := Customer.Name;
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
            Editable=false;
        }
        field(7; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = ToBeClassified;
        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = ToBeClassified;
        }
        field(10; "Base Percentage (%)"; Decimal)
        {
            Caption = 'Base Percentage (%)';
            DataClassification = ToBeClassified;
        }
        field(11; "Current VAT"; Boolean)
        {
            Caption = 'Current VAT';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Tax Code")
        {
            Clustered = true;
        }
    }
    var
    "G/LAccount":Record "G/L Account";
    Customer:Record Customer;
    Vendor:Record Vendor;
    Employee:Record Employee;
}
