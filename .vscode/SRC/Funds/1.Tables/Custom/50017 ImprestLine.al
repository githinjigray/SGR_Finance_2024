table 50017 "Imprest Line"
{
    Caption = 'Imprest Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "Imprest Header"."No.";
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
            OptionCaption = ' , ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
        }
        field(4; "Imprest Code"; Code[50])
        {
            Caption = 'Imprest Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Code"."Transaction Code"
            WHERE("Transaction Type" = CONST(Imprest));
            trigger OnValidate()
            begin
                "Account Type" := "Account Type"::"G/L Account";
                "Account No." := '';
                "Posting Group" := '';
                "Imprest Code Description" := '';

                FundsTransactionCodes.RESET;
                FundsTransactionCodes.SETRANGE(FundsTransactionCodes."Transaction Code", "Imprest Code");
                IF FundsTransactionCodes.FINDFIRST THEN BEGIN
                    "Account Type" := FundsTransactionCodes."Account Type";
                    "Account No." := FundsTransactionCodes."Account No.";
                    "Posting Group" := FundsTransactionCodes."Posting Group";
                    "Imprest Code Description" := FundsTransactionCodes.Description;
                END;

                VALIDATE("Account No.");
            end;

        }
        field(5; "Imprest Code Description"; Text[100])
        {
            Caption = 'Imprest Code Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Account Type"; Enum "Account Type")
        {
            Caption = 'Imprest Code Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            WHERE("Direct Posting" = CONST(true)) ELSE
            IF ("Account Type" = CONST(Customer))
            Customer."No."
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor."No."
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee."No.";

            trigger OnValidate()
            begin
                "Account Name" := '';
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := GLAccount.Name;
                    END;

                    "Expense Account No." := "Account No.";
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
                IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                    IF FixedAsset.GET("Account No.") THEN BEGIN
                        "Account Name" := FixedAsset.Description;
                    END;
                    DepreciationBook.RESET;
                    DepreciationBook.SETRANGE(DepreciationBook."FA No.", "Account No.");
                    IF DepreciationBook.FINDFIRST THEN BEGIN
                        "FA Depreciation Book" := DepreciationBook."Depreciation Book Code";
                    END;
                END;
            end;

        }
        field(8; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group".Code
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group".Code
            ELSE
            IF ("Account Type" = CONST(Employee)) "Employee Posting Group".Code;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                VALIDATE(Amount);
            end;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(13; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
        }
        field(14; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                END;

                IF "Currency Code" <> '' THEN BEGIN
                    "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                END ELSE BEGIN
                    "Amount(LCY)" := Amount;
                END;
            end;
        }
        field(15; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
        }
        field(16; "Budget Committed"; Boolean)
        {
            Caption = 'Budget Committed';
            DataClassification = ToBeClassified;
        }
        field(17; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
        }
        field(18; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(24; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(25; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(26; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(27; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(28; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(29; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(30; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(31; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(32; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(33; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(34; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(35; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(36; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(37; "FA Depreciation Book"; Code[30])
        {
            Caption = 'FA Depreciation Book';
            DataClassification = ToBeClassified;
        }
        field(38; "Expense Account No."; Code[20])
        {
            Caption = 'Expense Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));
            trigger OnValidate()
            begin
                "Expense Acc. Name" := '';
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Expense Account No.") THEN BEGIN
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;
            end;
        }
        field(39; "Expense Acc. Name"; Text[80])
        {
            Caption = 'Expense Acc. Name';
            DataClassification = ToBeClassified;
        }
        field(40; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Imprest Code" := '';
                "Imprest Code Description" := '';
                Amount := 0;
                "Amount(LCY)" := 0;
                "From City" := '';
                "To City" := '';
                City := '';
                "Account No." := '';
                "Account Name" := '';
            end;
        }
        field(41; "From City"; Code[50])
        {
            Caption = 'From City';
            DataClassification = ToBeClassified;
        }
        field(42; "To City"; Code[50])
        {
            Caption = 'To City';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount := 0;
                "Amount(LCY)" := 0;

                TESTFIELD("From City");
                IF "To City" = "From City" THEN BEGIN
                    // ERROR(Error001);
                END;

                AlowanceMatrix.RESET;
                AlowanceMatrix.SETRANGE(AlowanceMatrix."Allowance Code", "Imprest Code");
                AlowanceMatrix.SETRANGE(AlowanceMatrix."Job Group", "HR Job Grade");
                AlowanceMatrix.SETRANGE(AlowanceMatrix."Traveling From", "From City");
                AlowanceMatrix.SETRANGE(AlowanceMatrix."Traveling To", "To City");
                IF AlowanceMatrix.FINDFIRST THEN BEGIN
                    Amount := AlowanceMatrix.Amount;
                    VALIDATE(Amount);
                END;
            end;
        }
        field(43; "HR Job Grade"; Code[30])
        {
            Caption = 'HR Job Grade';
            DataClassification = ToBeClassified;
        }
        field(44; City; Code[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(46; "Employee No"; Code[30])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
        }
        field(47; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            trigger onvalidate()
            var
            begin
                Amount := "Unit Cost" * Quantity;
                Validate(Amount);
            end;
        }
        field(48; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger onvalidate()
            var
            begin
                Amount := "Unit Cost" * Quantity;
                Validate(Amount);
            end;
        }
    }
    keys
    {
        key(PK; "Line No.", "Document No.")
        {
            Clustered = true;
        }
    }
    var
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        Employee: Record Employee;
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        DepreciationBook: Record "FA Depreciation Book";
        AlowanceMatrix: Record "Allowance Matrix";
        //CityCodes: Record "HR Job Lookup Value";
        CurrencyFactor: Decimal;

    trigger OnInsert()
    begin
        ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.", "Document No.");
        IF ImprestHeader.FINDFIRST THEN BEGIN
            Description := ImprestHeader.Description;
            "Document Type" := "Document Type"::Imprest;
            "Posting Date" := ImprestHeader."Posting Date";
            "Currency Code" := ImprestHeader."Currency Code";
            "Currency Factor" := ImprestHeader."Currency Factor";
            "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
            "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
            "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
            "HR Job Grade" := ImprestHeader."HR Job Grade";
            "Employee No" := ImprestHeader."Employee No.";
        END;
    end;


}
