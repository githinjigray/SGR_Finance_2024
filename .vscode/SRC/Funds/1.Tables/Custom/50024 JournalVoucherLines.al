table 50024 "Journal Voucher Lines"
{
    Caption = 'Journal Voucher Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "JV No."; Code[20])
        {
            Caption = 'JV No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(3; "Account Type"; Enum "Account Type")
        {

            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            //OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
            //OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';


            trigger OnValidate()
            begin
                IF ("Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Fixed Asset",
                       "Account Type"::"IC Partner", "Account Type"::Employee]) AND
                        ("Bal. Account Type" IN ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"Fixed Asset",
                                                    "Bal. Account Type"::"IC Partner", "Bal. Account Type"::Employee])
                        THEN
                    ERROR(
                        // Text000,
                        FIELDCAPTION("Account Type"), FIELDCAPTION("Bal. Account Type"));

                IF ("Account Type" = "Account Type"::Employee) AND ("Currency Code" <> '') THEN
                    // ERROR(OnlyLocalCurrencyForEmployeeErr);

                    VALIDATE("Account No.", '');
                //VALIDATE(Description,'');

                IF "Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account", "Account Type"::Employee] THEN BEGIN

                END ELSE
                    IF "Bal. Account Type" IN ["Bal. Account Type"::"G/L Account", "Account Type"::"Bank Account", "Bal. Account Type"::"Fixed Asset"]
                    THEN

                        //UpdateSource;

                        IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
                        ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
                        THEN BEGIN
                            "Depreciation Book Code" := '';
                            VALIDATE("FA Posting Type", "FA Posting Type"::" ");
                        END;
                IF xRec."Account Type" IN
                [xRec."Account Type"::Customer, xRec."Account Type"::Vendor]
                THEN BEGIN

                END;
            end;
        }

        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            WHERE("Account Type" = CONST(Posting), Blocked = CONST(false), "Direct Posting" = CONST(true))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor ELSE
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
                    GLAccount.RESET;
                    GLAccount.SETRANGE(GLAccount."No.", "Account No.");
                    IF GLAccount.FINDFIRST THEN BEGIN
                        "Account Name" := GLAccount.Name;
                    END;
                END;
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    CustomerCard.RESET;
                    CustomerCard.SETRANGE(CustomerCard."No.", "Account No.");
                    IF CustomerCard.FINDFIRST THEN BEGIN
                        "Account Name" := CustomerCard.Name;
                        // "Customer Type":=CustomerCard."Account Type"
                    END;
                END;
                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    VendorCard.RESET;
                    VendorCard.SETRANGE(VendorCard."No.", "Account No.");
                    IF VendorCard.FINDFIRST THEN BEGIN
                        "Account Name" := VendorCard.Name;
                    END;
                END;
                IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                    FixedAsset.RESET;
                    FixedAsset.SETRANGE(FixedAsset."No.", "Account No.");
                    IF FixedAsset.FINDFIRST THEN BEGIN
                        "Account Name" := FixedAsset.Description;
                    END;
                END;
                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    BankAccount.RESET;
                    BankAccount.SETRANGE(BankAccount."No.", "Account No.");
                    IF BankAccount.FINDFIRST THEN BEGIN
                        "Account Name" := BankAccount.Name;
                    END;
                END;
                IF "Account Type" = "Account Type"::Employee THEN BEGIN
                    HREmployee.RESET;
                    HREmployee.SETRANGE(HREmployee."No.", "Account No.");
                    IF HREmployee.FINDFIRST THEN BEGIN
                        "Account Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name"
                    END;
                END;
            end;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DataClassification = ToBeClassified;
        }
        field(10; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
              WHERE("Account Type" = CONST(Posting), Blocked = CONST(false), "Direct Posting" = CONST(true))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) Employee;

            trigger OnValidate()
            begin
                "Bal. Account Name" := '';

                IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN BEGIN
                    GLAccount.RESET;
                    GLAccount.SETRANGE(GLAccount."No.", "Bal. Account No.");
                    IF GLAccount.FINDFIRST THEN BEGIN
                        "Bal. Account Name" := GLAccount.Name;
                    END;
                END;
                IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN BEGIN
                    CustomerCard.RESET;
                    CustomerCard.SETRANGE(CustomerCard."No.", "Bal. Account No.");
                    IF CustomerCard.FINDFIRST THEN BEGIN
                        "Bal. Account Name" := CustomerCard.Name;
                        // "Customer Type":=CustomerCard."Account Type";
                    END;
                END;
                IF "Bal. Account Type" = "Bal. Account Type"::Vendor THEN BEGIN
                    VendorCard.RESET;
                    VendorCard.SETRANGE(VendorCard."No.", "Bal. Account No.");
                    IF VendorCard.FINDFIRST THEN BEGIN
                        "Bal. Account Name" := VendorCard.Name;
                    END;
                END;
                IF "Bal. Account Type" = "Bal. Account Type"::"Fixed Asset" THEN BEGIN
                    FixedAsset.RESET;
                    FixedAsset.SETRANGE(FixedAsset."No.", "Bal. Account No.");
                    IF FixedAsset.FINDFIRST THEN BEGIN
                        "Bal. Account Name" := FixedAsset.Description;
                    END;
                END;
                IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
                    BankAccount.RESET;
                    BankAccount.SETRANGE(BankAccount."No.", "Bal. Account No.");
                    IF BankAccount.FINDFIRST THEN BEGIN
                        "Bal. Account Name" := BankAccount.Name;
                    END;
                END;
                IF "Bal. Account Type" = "Bal. Account Type"::Employee THEN BEGIN
                    HREmployee.RESET;
                    HREmployee.SETRANGE("No.", "Bal. Account No.");
                    IF HREmployee.FINDFIRST THEN BEGIN
                        "Bal. Account Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                    END;
                END;
            end;
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            trigger OnValidate()
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    if "Posting Date" <> 0D then
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code")
                    else
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                END;
            end;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    if "Posting Date" <> 0D then
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code")
                    else
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                END;
                "Amount (LCY)" := amount;
                IF "Currency Code" <> '' THEN BEGIN
                    "Amount (LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                end;
            end;
        }
        field(13; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // GetCurrency;
                "Debit Amount" := ROUND("Debit Amount", Currency."Amount Rounding Precision");
                IF ("Credit Amount" = 0) OR ("Debit Amount" <> 0) THEN BEGIN
                    Amount := "Debit Amount";
                    VALIDATE(Amount);
                END;
            end;
        }
        field(14; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // GetCurrency;
                "Credit Amount" := ROUND("Credit Amount", Currency."Amount Rounding Precision");
                IF ("Debit Amount" = 0) OR ("Credit Amount" <> 0) THEN BEGIN
                    Amount := -"Credit Amount";
                    VALIDATE(Amount);
                END;
            end;
        }
        field(15; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = ToBeClassified;
        }
        field(16; "Balance (LCY)"; Decimal)
        {
            Caption = 'Balance (LCY)';
            DataClassification = ToBeClassified;
        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code
                          WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));
        }
        field(20; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';

            trigger OnValidate()
            begin
                IF "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" THEN
                    VALIDATE("Applies-to Doc. No.", '');
            end;

        }
        field(21; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                xRec.Amount := Amount;
                xRec."Currency Code" := "Currency Code";
                xRec."Posting Date" := "Posting Date";
            end;
        }
        field(22; "Bal. Account Type"; enum "Account Type")
        {
            Caption = 'Bal. Account Type';
            DataClassification = ToBeClassified;
            //OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
            //OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';

            trigger OnValidate()
            begin
                IF ("Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Fixed Asset",
                       "Account Type"::"IC Partner", "Account Type"::Employee]) AND
            ("Bal. Account Type" IN ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"Fixed Asset",
                                        "Bal. Account Type"::"IC Partner", "Bal. Account Type"::Employee])
            THEN
                    ERROR(
                        // Text000,
                        FIELDCAPTION("Account Type"), FIELDCAPTION("Bal. Account Type"));

                IF ("Bal. Account Type" = "Bal. Account Type"::Employee) AND ("Currency Code" <> '') THEN
                    // ERROR(OnlyLocalCurrencyForEmployeeErr);

                    VALIDATE("Bal. Account No.", '');
                IF "Bal. Account Type" IN
                ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"Bank Account", "Bal. Account Type"::Employee]
                THEN BEGIN

                END ELSE
                    IF "Account Type" IN [
                                            "Bal. Account Type"::"G/L Account", "Account Type"::"Bank Account", "Account Type"::"Fixed Asset"]
                    THEN

                        //UpdateSource;
                        IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
            ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
            THEN BEGIN
                            "Depreciation Book Code" := '';
                            VALIDATE("FA Posting Type", "FA Posting Type"::" ");
                        END;
                IF xRec."Bal. Account Type" IN
                [xRec."Bal. Account Type"::Customer, xRec."Bal. Account Type"::Vendor]
                THEN BEGIN

                END;
                IF ("Account Type" IN [
                                    "Account Type"::"G/L Account", "Account Type"::"Bank Account", "Account Type"::"Fixed Asset"]) AND
                ("Bal. Account Type" IN [
                                            "Bal. Account Type"::"G/L Account", "Bal. Account Type"::"Bank Account", "Bal. Account Type"::"Fixed Asset"])
                THEN
                    IF "Bal. Account Type" = "Bal. Account Type"::"IC Partner" THEN BEGIN

                        IF GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany THEN
                            FIELDERROR("Bal. Account Type");
                    END;

            end;

        }
        field(23; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(24; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
            DataClassification = ToBeClassified;
        }
        field(25; "FA Posting Type"; Enum "Gen. Journal Line FA Posting Type")
        {
            Caption = 'FA Posting Type';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF NOT (("Account Type" = "Account Type"::"Fixed Asset") OR
                ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")) AND
                ("FA Posting Type" = "FA Posting Type"::" ")
                THEN BEGIN
                    "FA Posting Date" := 0D;

                END;
            end;

        }
        field(26; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            DataClassification = ToBeClassified;
            TableRelation = "Depreciation Book";
            trigger OnValidate()
            begin
                IF "Depreciation Book Code" = '' THEN
                    EXIT;

                IF ("Account No." <> '') AND
                ("Account Type" = "Account Type"::"Fixed Asset")
                THEN BEGIN
                    // FADeprBook.GET("Account No.","Depreciation Book Code");
                    //"Posting Group" := FADeprBook."FA Posting Group";
                END;

                IF ("Bal. Account No." <> '') AND
                ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")
                THEN BEGIN
                    // FADeprBook.GET("Bal. Account No.","Depreciation Book Code");
                    //  "Posting Group" := FADeprBook."FA Posting Group";
                END;
            end;


        }
        field(27; Description2; Text[250])
        {
            Caption = 'Description2';
            DataClassification = ToBeClassified;
        }
        field(28; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(29; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(30; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(31; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(32; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(33; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(34; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(35; "Account Name"; Text[80])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(36; "Bal. Account Name"; Text[80])
        {
            Caption = 'Bal. Account Name';
            DataClassification = ToBeClassified;
        }
        field(37; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(38; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(39; "Posted By"; Code[30])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(40; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(41; "Loan/Equity Account No"; Code[30])
        {
            Caption = 'Loan/Equity Account No';
            DataClassification = ToBeClassified;
            // TableRelation=IF ("Customer Type"=CONST(Employee)) Table52137801.Field1 
            //            WHERE (Field3=FIELD("Account No.")) ELSE IF ("Customer Type"=CONST(Investment)) Table52137650.Field1 
            //            WHERE (Field5=FIELD("Account No."));
        }
        field(42; "Account Transaction Type"; option)
        {
            Caption = 'Account Transaction Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Loan Disbursement","Principal Receivable","Principal Payment","Interest Receivable","Interest Payment","Penalty Receivable","Penalty Payment","Loan Fee Receivable","Loan Fee Payment","Equity Fair Value";
            OptionCaption = ' ,Loan Disbursement,Principal Receivable,Principal Payment,Interest Receivable,Interest Payment,Penalty Receivable,Penalty Payment,Loan Fee Receivable,Loan Fee Payment,Equity Fair Value';

        }
        field(43; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Employee,Investment,Tenant;
            OptionCaption = ',Employee,Investment,Tenant';
        }

    }
    keys
    {
        key(PK; "JV No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record Currency;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentTerms: Record "Payment Terms";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        EmplLedgEntry: Record "Employee Ledger Entry";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        VATPostingSetup: Record "VAT Posting Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        Job: Record Job;
        SourceCodeSetup: Record "Source Code Setup";
        TempJobJnlLine: Record "Job Journal Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit "No. Series";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlShowCTEntries: Codeunit "Gen. Jnl.-Show CT Entries";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        EmplEntrySetApplID: Codeunit "Empl. Entry-SetAppl.ID";
        DimMgt: Codeunit DimensionManagement;
        // PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        DeferralUtilities: Codeunit "Deferral Utilities";
        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Window: Dialog;
        DeferralDocType: Option;
        CurrencyCode: Code[20];
        TemplateFound: Boolean;
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        GLSetupRead: Boolean;
        GLAccount: Record "G/L Account";
        CustomerCard: Record Customer;
        VendorCard: Record Vendor;
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        HREmployee: Record Employee;
        JournalVoucherHeader: Record "Journal Voucher Header";

    trigger OnInsert()
    begin
        JournalVoucherHeader.RESET;
        JournalVoucherHeader.SETRANGE(JournalVoucherHeader."JV No.", "JV No.");
        IF JournalVoucherHeader.FINDFIRST THEN BEGIN
            //"Posting Date":=JournalVoucherHeader."Posting Date";
            Description := JournalVoucherHeader.Description;
        END;
    end;
}
