table 50045 "Interest Buffer1"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(3; "Account Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Interest Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Interest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                CurrExchRate: Record "Currency Exchange Rate";
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    "Interest Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Interest Date", "Currency Code", "Interest Amount", "Currency Factor"));
                END ELSE BEGIN
                    "Interest Amount(LCY)" := "Interest Amount";
                END;
            end;
        }
        field(6; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Account Matured"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; "Late Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Transferred; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Mark For Deletion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Description; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Accrued; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Interest Amount(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                CurrExchRate: Record "Currency Exchange Rate";
            begin

                "Currency Factor" := 0;
                TESTFIELD("Document No.");
                TESTFIELD("Interest Date");
                IF "Currency Code" <> '' THEN BEGIN
                    "Currency Factor" := CurrExchRate.ExchangeRate("Interest Date", "Currency Code");
                    Validate("Currency Factor");
                END;
            END;
        }
        field(21; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                Text002: Label 'cannot be specified without %1';
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                Validate("Interest Amount");

            end;
        }
    }

    keys
    {
        key(Key1; No, "Account No")
        {
        }
    }

    fieldgroups
    {
    }
}

