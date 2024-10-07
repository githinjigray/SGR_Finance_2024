table 50019 "Imprest Surrender Line"
{
    Caption = 'Imprest Surrender Line';
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
            TableRelation = "Imprest Surrender Header"."No.";
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
            OptionCaption = ',Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
        }
        field(4; "Imprest Code"; Code[50])
        {
            Caption = 'Imprest Code';
            DataClassification = ToBeClassified;

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
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Account Name" := '';

                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := GLAccount.Name;
                        "Expense Account Type" := "Account Type";
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF Customer.GET("Account No.") THEN BEGIN
                        "Account Name" := Customer.Name;
                        "Expense Account Type" := "Account Type";
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Employee THEN BEGIN
                    IF Employee.GET("Account No.") THEN BEGIN
                        "Account Name" := Employee."First Name" + '-' + Employee."Last Name";
                        "Expense Account Type" := "Account Type";
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    IF Vendor.GET("Account No.") THEN BEGIN
                        "Account Name" := Vendor.Name;
                        "Expense Account Type" := "Account Type";
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    IF BankAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := BankAccount.Name;
                        "Expense Account Type" := "Account Type";
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                    IF FixedAsset.GET("Account No.") THEN BEGIN
                        "Account Name" := FixedAsset.Description;
                        "Expense Account Type" := "Account Type";
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                    DepreciationBook.RESET;
                    // DepreciationBook.SETRANGE(DepreciationBook."FA No.","Account No.");
                    IF DepreciationBook.FINDFIRST THEN BEGIN
                        //"FA Depreciation Book":=DepreciationBook."Depreciation Book Code";
                    END;
                END;
            end;

        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Expense Account No." := "Account No.";
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
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "Petty Cash No."; Code[30])
        {
            Caption = 'Petty Cash No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ImprestHeader.RESET;
                ImprestHeader.SETRANGE(ImprestHeader."No.", "Petty Cash No.");
                IF ImprestHeader.FINDFIRST THEN BEGIN
                    ImprestHeader.CALCFIELDS(ImprestHeader.Amount);
                    "Employee No." := ImprestHeader."Employee No.";
                    "Employee Name" := ImprestHeader."Employee Name";
                    "Amount Advanced" := ImprestHeader.Amount;
                    "Amount Advanced (LCY)" := ImprestHeader.Amount;

                END;
            end;
        }
        field(12; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(14; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
        }
        field(15; "Amount Advanced"; Decimal)
        {
            Caption = 'Amount Advanced';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Amount Advanced (LCY)" := "Amount Advanced";
                IF "Currency Code" <> '' THEN BEGIN
                    "Amount Advanced (LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount Advanced", "Currency Factor"));
                END;
                Difference := 0;
                Difference := "Amount Advanced" - "Actual Spent";
                VALIDATE(Difference);
            end;
        }
        field(16; "Amount Advanced (LCY)"; Decimal)
        {
            Caption = 'Amount Advanced (LCY)';
            DataClassification = ToBeClassified;
        }
        field(17; "Actual Spent"; Decimal)
        {
            Caption = 'Actual Spent';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Overpayment := 0;
                Difference := 0;
                Difference := "Amount Advanced" - "Actual Spent" - "Cash Receipt";
                VALIDATE(Difference);

                "Actual Spent(LCY)" := "Actual Spent";
                IF "Currency Code" <> '' THEN BEGIN
                    "Actual Spent(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Actual Spent", "Currency Factor"));
                END;

                IF "Amount Advanced" <> 0 THEN BEGIN
                    IF "Actual Spent" > "Amount Advanced" THEN
                        Overpayment := "Actual Spent" - "Amount Advanced"
                    ELSE
                        Overpayment := 0;
                END;

                IF "Currency Code" <> '' THEN BEGIN
                    "Actual Spent(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Actual Spent", "Currency Factor"));
                END;
            end;
        }
        field(18; "Actual Spent(LCY)"; Decimal)
        {
            Caption = 'Actual Spent(LCY)';
            DataClassification = ToBeClassified;
        }
        field(19; Difference; Decimal)
        {
            Caption = 'Difference';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Difference(LCY)" := Difference;
                IF "Currency Code" <> '' THEN BEGIN
                    "Difference(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Difference, "Currency Factor"));
                END;
            end;
        }
        field(20; "Difference(LCY)"; Decimal)
        {
            Caption = 'Difference(LCY)';
            DataClassification = ToBeClassified;
        }
        field(21; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Cash Receipt" := 0;
                "Cash Receipt(LCY)" := 0;

                IF ReceiptHeader.GET("Receipt No.") THEN
                    "Cash Receipt" := ReceiptHeader."Amount Received";
                "Cash Receipt(LCY)" := ReceiptHeader."Amount Received";
            end;
        }
        field(22; "Cash Receipt"; Decimal)
        {
            Caption = 'Cash Receipt';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Difference := 0;
                Difference := "Amount Advanced" - "Actual Spent" - "Cash Receipt";
                VALIDATE(Difference);

                "Cash Receipt(LCY)" := "Cash Receipt";

                IF "Currency Code" <> '' THEN BEGIN
                    "Cash Receipt(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Cash Receipt", "Currency Factor"));
                END;
            end;
        }
        field(23; "Cash Receipt(LCY)"; Decimal)
        {
            Caption = 'Cash Receipt(LCY)';
            DataClassification = ToBeClassified;
        }
        field(24; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(25; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
        }
        field(26; "Expense Account Type"; Enum "Account Type")
        {
            Caption = '';
            DataClassification = ToBeClassified;
            //OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
        }

        field(27; "Expense Account No."; Code[20])
        {
            Caption = 'Expense Account No.';
            //DataClassification = ToBeClassified;
            TableRelation = IF ("Expense Account Type" = CONST("G/L Account")) "G/L Account"."No." WHERE("Direct Posting" = FILTER(true), "Account Type" = CONST(Posting))
            ELSE
            IF ("Expense Account Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Expense Account Type" = CONST(Vendor)) Vendor."No."
            ELSE
            IF ("Expense Account Type" = CONST("Fixed Asset")) "Fixed Asset"."No."
            ELSE
            IF ("Expense Account Type" = CONST(Employee)) Employee."No."
            ELSE
            IF ("Expense Account Type" = CONST("Bank Account")) "Bank Account"."No.";
            trigger OnValidate()
            begin
                "Expense Acc. Name" := '';

                IF "Expense Account Type" = "Expense Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Expense Account No.") THEN BEGIN
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;

                IF "Expense Account Type" = "Expense Account Type"::Customer THEN BEGIN
                    IF Customer.GET("Expense Account No.") THEN BEGIN
                        "Expense Acc. Name" := Customer.Name;
                    END;
                END;

                IF "Expense Account Type" = "Expense Account Type"::Employee THEN BEGIN
                    IF Employee.GET("Expense Account No.") THEN BEGIN
                        "Expense Acc. Name" := Employee."First Name" + '-' + Employee."Last Name";
                    END;
                END;

                IF "Expense Account Type" = "Expense Account Type"::Vendor THEN BEGIN
                    IF Vendor.GET("Expense Account No.") THEN BEGIN
                        "Expense Acc. Name" := Vendor.Name;
                    END;
                END;

                IF "Expense Account Type" = "Expense Account Type"::"Bank Account" THEN BEGIN
                    IF BankAccount.GET("Expense Account No.") THEN BEGIN
                        "Expense Acc. Name" := BankAccount.Name;
                    END;
                END;
            end;
        }
        field(28; "Expense Acc. Name"; Text[80])
        {
            Caption = 'Expense Acc. Name';
            DataClassification = ToBeClassified;
        }
        field(29; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(30; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(31; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(32; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(33; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(34; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(35; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(36; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(37; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(38; Overpayment; Decimal)
        {
            Caption = 'Overpayment';
            DataClassification = ToBeClassified;
        }
        field(39; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(40; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(41; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(42; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(43; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(44; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(45; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(46; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(47; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(48; "FA Depreciation Book"; Code[30])
        {
            Caption = 'FA Depreciation Book';
            DataClassification = ToBeClassified;
        }
        field(49; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Employee Name" := '';
                //"Imprest No.":='';
                //VALIDATE("Imprest No.");
                IF Employee.GET("Employee No.") THEN BEGIN
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                END;
            end;
        }
        field(50; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name ';
            DataClassification = ToBeClassified;
        }
        field(51; "Surrender Type"; Option)
        {
            Caption = 'Surrender Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Office,Property;
            OptionCaption = ' ,Office,Property';
        }

        field(52; "Expense Code"; Code[30])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
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
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        Employee: Record Employee;
        DepreciationBook: Record "Depreciation Book";
        ReceiptHeader: Record "Receipt Header";

    trigger OnInsert()
    begin
        ImprestSurrenderHeader.RESET;
        ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Document No.");
        IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
            "Document Type" := "Document Type"::"Imprest Surrender";
            "Posting Date" := ImprestSurrenderHeader."Posting Date";
            "Currency Code" := ImprestSurrenderHeader."Currency Code";
            "Currency Factor" := ImprestSurrenderHeader."Currency Factor";
            "Employee No." := ImprestSurrenderHeader."Employee No.";
            "Employee Name" := ImprestSurrenderHeader."Employee Name";
            "Global Dimension 1 Code" := ImprestSurrenderHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := ImprestSurrenderHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestSurrenderHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestSurrenderHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := ImprestSurrenderHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := ImprestSurrenderHeader."Shortcut Dimension 6 Code";
            "Shortcut Dimension 7 Code" := ImprestSurrenderHeader."Shortcut Dimension 7 Code";
            "Shortcut Dimension 8 Code" := ImprestSurrenderHeader."Shortcut Dimension 8 Code";
        END;
    end;

}
