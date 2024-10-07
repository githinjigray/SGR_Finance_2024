table 50021 "Funds Claim Line"
{
    Caption = 'Funds Claim Line';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
        }
        field(4; "Funds Claim Code"; Code[50])
        {
            Caption = 'Funds Claim Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Code"."Transaction Code"
            WHERE("Transaction Type" = CONST(Refund));
            trigger OnValidate()
            begin
                "Account Type" := "Account Type"::"G/L Account";
                "Account No." := '';
                "Posting Group" := '';
                "Funds Claim Code Description" := '';

                FundsTransactionCodes.RESET;
                FundsTransactionCodes.SETRANGE(FundsTransactionCodes."Transaction Code", "Funds Claim Code");
                IF FundsTransactionCodes.FINDFIRST THEN BEGIN
                    "Account Type" := FundsTransactionCodes."Account Type";
                    "Account No." := FundsTransactionCodes."Account No.";
                    "Posting Group" := FundsTransactionCodes."Posting Group";
                    "Funds Claim Code Description" := FundsTransactionCodes.Description;
                    //Employee Transaction Type
                    // "Employee Transaction Type":=FundsTransactionCodes."Employee Transaction Type";
                END;
                VALIDATE("Account Type");
                VALIDATE("Account No.");
            end;
        }
        field(5; "Funds Claim Code Description"; Text[100])
        {
            Caption = 'Funds Claim Code Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Account Type"; Enum "Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Account Type" = "Account Type"::Employee THEN BEGIN
                    FundsClaimHeader.RESET;
                    FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Document No.");
                    IF FundsClaimHeader.FINDFIRST THEN BEGIN
                        "Account No." := FundsClaimHeader."Payee No.";
                        VALIDATE("Account No.");
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
                "Account Name" := '';
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := GLAccount.Name;
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
        field(8; "Account Name"; Text[50])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
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
            trigger OnValidate()
            begin
                "Net Amount" := Amount;
                IF "Currency Code" <> '' THEN BEGIN
                    "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                    "Net Amount(LCY)" := "Amount(LCY)";
                END ELSE BEGIN
                    "Amount(LCY)" := Amount;
                    "Net Amount(LCY)" := Amount;
                END;
            end;
        }
        field(15; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(16; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            DataClassification = ToBeClassified;
        }
        field(17; "Net Amount(LCY)"; Decimal)
        {
            Caption = 'Net Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(18; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
        }
        field(19; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = ToBeClassified;
        }
        field(21; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(22; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
        }
        field(25; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
        }
        field(26; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
        }
        field(27; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
        }
        field(28; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
        }
        field(29; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
        }
        field(30; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
        }
        field(31; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(32; "Expense Account Type"; Option)
        {
            Caption = 'Expense Account Type';
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';

            trigger OnValidate()
            begin
                IF "Account Type" = "Account Type"::Employee THEN BEGIN
                    FundsClaimHeader.RESET;
                    FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Document No.");
                    IF FundsClaimHeader.FINDFIRST THEN BEGIN
                        "Account No." := FundsClaimHeader."Payee No.";
                        VALIDATE("Account No.");
                    END;
                END;
            end;
        }
        field(33; "Expense Account No."; Code[20])
        {
            Caption = 'Expense Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                "Expense Acc. Name" := '';
                IF "Expense Account Type" = "Expense Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Account No.") THEN BEGIN
                        "Expense Acc. Name" := GLAccount.Name;
                    END;
                END;

                IF "Expense Account Type" = "Expense Account Type"::Customer THEN BEGIN
                    IF Customer.GET("Account No.") THEN BEGIN
                        "Expense Acc. Name" := Customer.Name;
                    END;
                END;

                IF "Expense Account Type" = "Expense Account Type"::Vendor THEN BEGIN
                    IF Vendor.GET("Account No.") THEN BEGIN
                        "Expense Acc. Name" := Vendor.Name;
                    END;
                END;

                IF "Expense Account Type" = "Expense Account Type"::Employee THEN BEGIN
                    IF Employee.GET("Account No.") THEN BEGIN
                        "Expense Acc. Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    END;
                END;
            end;
        }
        field(34; "Expense Acc. Name"; Text[80])
        {
            Caption = 'Expense Acc. Name';
            DataClassification = ToBeClassified;
        }
        field(35; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(36; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(37; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(38; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(39; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(40; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(41; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(42; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(43; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(50; "Payee No."; Code[20])
        {
            Caption = 'Payee No.';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(51; "Payee Name"; Text[100])
        {
            Caption = 'Payee Name';
            DataClassification = ToBeClassified;
            Editable = false;

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
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        FundsClaimHeader: Record "Funds Claim Header";
        FundsClaimLine: Record "Funds Claim Line";
        CurrExchRate: Record "Currency Exchange Rate";

    trigger OnInsert()
    begin
        FundsClaimHeader.RESET;
        FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Document No.");
        IF FundsClaimHeader.FINDFIRST THEN BEGIN
            "Document Type" := "Document Type"::Refund;
            "Posting Date" := FundsClaimHeader."Posting Date";
            "Currency Code" := FundsClaimHeader."Currency Code";
            "Currency Factor" := FundsClaimHeader."Currency Factor";
            "Global Dimension 1 Code" := FundsClaimHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := FundsClaimHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := FundsClaimHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := FundsClaimHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := FundsClaimHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := FundsClaimHeader."Shortcut Dimension 6 Code";
            "Shortcut Dimension 7 Code" := FundsClaimHeader."Shortcut Dimension 7 Code";
            "Shortcut Dimension 8 Code" := FundsClaimHeader."Shortcut Dimension 8 Code";
            "Responsibility Center" := FundsClaimHeader."Responsibility Center";
        END;
    end;
}
