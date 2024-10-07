table 50022 "Payment Line Import Buffer"
{
    Caption = 'Payment Line Import Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; BigInteger)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Payment Code"; Code[50])
        {
            Caption = 'Payment Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Code"."Transaction Code" WHERE("Transaction Type" = CONST(Payment));
            trigger OnValidate()
            begin
                FundsTransactionCodes.RESET;
                FundsTransactionCodes.SETRANGE(FundsTransactionCodes."Transaction Code", "Payment Code");
                IF FundsTransactionCodes.FINDFIRST THEN BEGIN
                    "Account Type" := FundsTransactionCodes."Account Type";
                    "Account No." := FundsTransactionCodes."Account No.";
                END;
            end;
        }
        field(3; "Account Type"; Enum "Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            //OptionMembers="G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
            //OptionCaption='G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE IF ("Account Type" = CONST(Customer)) Customer."No."
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor."No."
            ELSE IF ("Account Type" = CONST(Employee)) Employee."No.";
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
    var
        FundsGeneralSetup: Record "Funds General Setup";
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        CurrExchRate: Record "Currency Exchange Rate";
        VendLedgEntry: Record "Vendor Ledger Entry";
        //PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        "Exported to Payment File": Boolean;
        "Applies-to Ext. Doc. No.": Code[20];
        FundsTaxCodes2: Record "Funds Tax Code";


    trigger OnInsert()
    begin
        "User ID" := USERID;
    end;
}
