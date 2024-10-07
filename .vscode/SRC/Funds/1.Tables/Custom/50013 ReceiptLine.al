table 50013 "Receipt Line"
{
    Caption = 'Receipt Line';
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
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
            OptionCaption = ',Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender"';
        }
        field(4; "Receipt Code"; Code[50])
        {
            Caption = 'Receipt Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Code"."Transaction Code" where("Transaction Type" = const(Receipt));
            trigger onvalidate()
            begin
                "Account Type" := "Account Type"::"G/L Account";
                "Account No." := '';
                "Posting Group" := '';
                "Receipt Code Description" := '';
                "VAT Code" := '';
                "Withholding Tax Code" := '';
                "Withholding VAT Code" := '';
                FundsTransactionCodes.RESET;
                FundsTransactionCodes.SETRANGE(FundsTransactionCodes."Transaction Code", "Receipt Code");
                IF FundsTransactionCodes.FINDFIRST THEN BEGIN
                    "Account Type" := FundsTransactionCodes."Account Type";
                    "Account No." := FundsTransactionCodes."Account No.";
                    "Posting Group" := FundsTransactionCodes."Posting Group";
                    "Receipt Code Description" := FundsTransactionCodes.Description;
                    IF FundsTransactionCodes."Include VAT" THEN
                        "VAT Code" := FundsTransactionCodes."VAT Code";
                    IF FundsTransactionCodes."Include Withholding Tax" THEN
                        "Withholding Tax Code" := FundsTransactionCodes."Withholding Tax Code";
                    IF FundsTransactionCodes."Include Withholding VAT" THEN
                        "Withholding VAT Code" := FundsTransactionCodes."Withholding VAT Code";
                    //Employee Transaction Type
                    //"Employee Transaction Type" := FundsTransactionCodes."Transaction Type";
                END;

                VALIDATE("Account No.");
            end;
        }
        field(5; "Receipt Code Description"; Text[100])
        {
            Caption = 'Receipt Code Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Account Type"; Enum "Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No." where("Account Type" = filter(Posting), "Direct Posting" = filter(true))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor."No."
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee."No."
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"."No.";
            trigger OnValidate()
            begin

                "Account Name" := '';
                //"Customer Posting Group" := '';

                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    GLAccount.Reset();
                    GLAccount.SetRange("No.", "Account No.");
                    IF GLAccount.FindFirst THEN BEGIN
                        "Account Name" := GLAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    IF BankAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := BankAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF Customer.GET("Account No.") THEN BEGIN
                        "Account Name" := Customer.Name;
                        //"Customer Posting Group" := Customer."Customer Posting Group";
                        ReceiptHeader.RESET;
                        ReceiptHeader.SETRANGE(ReceiptHeader."No.", "Document No.");
                        IF ReceiptHeader.FINDFIRST THEN BEGIN
                            IF ReceiptHeader."Received From" = '' THEN
                                ReceiptHeader."Received From" := Customer.Name;
                            ReceiptHeader."Customer Email Address" := Customer."E-Mail";
                            ReceiptHeader."Customer Name" := Customer.Name;
                            ReceiptHeader.MODIFY;
                        END;
                    END;
                END;

                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    IF Vendor.GET("Account No.") THEN BEGIN
                        "Account Name" := Vendor.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Employee THEN BEGIN
                    IF Employee.GET("Account No.") THEN BEGIN
                        "Account Name" := Employee.FullName;
                        ReceiptHeader.RESET;
                        IF ReceiptHeader.GET("Document No.") THEN BEGIN
                            ReceiptHeader."Received From" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            ReceiptHeader.MODIFY;
                        END;
                    END;
                END;
            end;
        }
        field(8; "Account Name"; Text[200])
        {
            Caption = 'Account Name';
            Editable = false;
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

                VALIDATE("VAT Code");
                VALIDATE("Withholding Tax Code");
            end;
        }
        field(15; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "VAT Code"; Code[10])
        {
            Caption = 'VAT Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "VAT Amount" := 0;
                VALIDATE("VAT Amount");
                "Withholding Tax Code" := '';
                VALIDATE("Withholding Tax Code");
                "Withholding VAT Code" := '';
                VALIDATE("Withholding VAT Code");

                IF "VAT Code" <> '' THEN BEGIN
                    FundsTaxCodes.RESET;
                    FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code", "VAT Code");
                    IF FundsTaxCodes.FINDFIRST THEN BEGIN
                        "VAT Amount" := Amount - ((Amount * 100) / (FundsTaxCodes.Percentage + 100));
                        VALIDATE("VAT Amount");
                    END;
                END;
            end;
        }
        field(17; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Net Amount" := (Amount);

                IF "Currency Code" <> '' THEN BEGIN
                    "VAT Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "VAT Amount", "Currency Factor"));
                    "Net Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                END ELSE BEGIN
                    "VAT Amount(LCY)" := "VAT Amount";
                    "Net Amount(LCY)" := "Net Amount";
                END;
                VALIDATE("Withholding VAT Code");
            end;
        }
        field(18; "VAT Amount(LCY)"; Decimal)
        {
            Caption = 'VAT Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Withholding Tax Code"; Code[10])
        {
            Caption = 'Withholding Tax Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Withholding Tax Amount" := 0;
                VALIDATE("Withholding Tax Amount");

                IF "Withholding Tax Code" <> '' THEN BEGIN
                    FundsTaxCodes.RESET;
                    FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code", "Withholding Tax Code");
                    IF FundsTaxCodes.FINDFIRST THEN BEGIN
                        "Withholding Tax Amount" := ROUND(("Net Amount" - "VAT Amount") * (FundsTaxCodes.Percentage / 100));
                        VALIDATE("Withholding Tax Amount");
                    END;
                END;
            end;
        }
        field(20; "Withholding Tax Amount"; Decimal)
        {
            Caption = 'Withholding Tax Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."W/Tax Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest THEN BEGIN
                            "Withholding Tax Amount" := ROUND("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up THEN BEGIN
                            "Withholding Tax Amount" := ROUND("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down THEN BEGIN
                            "Withholding Tax Amount" := ROUND("Withholding Tax Amount", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        END;
                    END;
                END;
                //End Rounding
                "Net Amount" := ROUND(Amount - "Withholding Tax Amount" - "Withholding VAT Amount");
                IF "Currency Code" <> '' THEN BEGIN
                    "Withholding Tax Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Withholding Tax Amount", "Currency Factor"));
                    "Net Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                END ELSE BEGIN
                    "Withholding Tax Amount(LCY)" := "Withholding Tax Amount";
                    "Net Amount(LCY)" := "Net Amount";
                END;
                VALIDATE("Withholding Tax Amount(LCY)");
                VALIDATE("Net Amount(LCY)");
            end;
        }
        field(21; "Withholding Tax Amount(LCY)"; Decimal)
        {
            Caption = 'Withholding Tax Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Withholding VAT Code"; Code[10])
        {
            Caption = 'Withholding VAT Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Withholding VAT Code" <> '' THEN BEGIN
                    //TESTFIELD("VAT Amount");
                    FundsTaxCodes.RESET;
                    FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code", "Withholding VAT Code");
                    IF FundsTaxCodes.FINDFIRST THEN BEGIN
                        IF FundsTaxCodes2.GET("VAT Code") THEN BEGIN
                            "Withholding VAT Amount" := ROUND(("VAT Amount") * (FundsTaxCodes.Percentage / FundsTaxCodes2.Percentage));
                            VALIDATE("Withholding VAT Amount");
                        END;
                    END;
                END ELSE BEGIN
                    "Withholding VAT Amount" := 0;
                    VALIDATE("Withholding VAT Amount");
                END;
            end;
        }
        field(23; "Withholding VAT Amount"; Decimal)
        {
            Caption = 'Withholding VAT Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."W/VAT Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Nearest THEN BEGIN
                            "Withholding VAT Amount" := ROUND("Withholding VAT Amount", FundsGeneralSetup."W/VAT Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Up THEN BEGIN
                            "Withholding VAT Amount" := ROUND("Withholding VAT Amount", FundsGeneralSetup."W/VAT Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Down THEN BEGIN
                            "Withholding VAT Amount" := ROUND("Withholding VAT Amount", FundsGeneralSetup."W/VAT Rounding Precision", '<');
                        END;
                    END;
                END;
                //End Rounding

                "Net Amount" := ROUND(Amount - "Withholding Tax Amount" - "Withholding VAT Amount");
                IF "Currency Code" <> '' THEN BEGIN
                    "Withholding VAT Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Withholding VAT Amount", "Currency Factor"));
                    "Net Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                END ELSE BEGIN
                    "Withholding VAT Amount(LCY)" := "Withholding VAT Amount";
                    "Net Amount(LCY)" := "Net Amount";
                END;
                VALIDATE("Withholding VAT Amount(LCY)");
                VALIDATE("Net Amount(LCY)");
            end;
        }
        field(24; "Withholding VAT Amount(LCY)"; Decimal)
        {
            Caption = 'Withholding VAT Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            DataClassification = ToBeClassified;
        }
        field(26; "Net Amount(LCY)"; Decimal)
        {
            Caption = 'Net Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = ',Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
        }
        field(28; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SInvoice: Record "Sales Invoice Header";
            begin
                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE(CustLedgEntry."Document No.", "Applies-to Doc. No.");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    CustLedgEntry.CALCFIELDS(CustLedgEntry.Amount);
                    "Invoice Amount" := CustLedgEntry.Amount;
                    "Global Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code";
                    if SInvoice.get("Applies-to Doc. No.") then begin
                        "Shortcut Dimension 3 Code" := SInvoice."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := SInvoice."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := SInvoice."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := SInvoice."Shortcut Dimension 6 Code";
                    end;
                    MODIFY;
                END;
            end;

            trigger OnLookup()
            begin
                "Invoice Amount" := 0;
                "VAT Amount" := 0;
                "VAT Amount(LCY)" := 0;

                CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Customer No.", "Account No.");
                CustLedgEntry.SETRANGE(Open, TRUE);
                CustLedgEntry.SETRANGE(Positive, TRUE);
                CLEAR(CustomerLedgerEntries);
                CustomerLedgerEntries.SETRECORD(CustLedgEntry);
                CustomerLedgerEntries.SETTABLEVIEW(CustLedgEntry);
                CustomerLedgerEntries.LOOKUPMODE(TRUE);
                IF CustomerLedgerEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    CustomerLedgerEntries.GETRECORD(CustLedgEntry);
                    "Applies-to Doc. No." := CustLedgEntry."Document No.";
                    CustLedgEntry.CALCFIELDS("Remaining Amount");
                    CustLedgEntry.CALCFIELDS(Amount);
                    Amount := CustLedgEntry."Remaining Amount";
                    VALIDATE(Amount);
                    "Invoice Amount" := CustLedgEntry.Amount;
                    VALIDATE("VAT Amount");
                END ELSE BEGIN
                END;
            end;

        }
        field(29; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF ("Applies-to ID" <> xRec."Applies-to ID") AND (xRec."Applies-to ID" <> '') THEN BEGIN
                    CustLedgEntry.SETCURRENTKEY("Customer No.", Open);
                    CustLedgEntry.SETRANGE("Customer No.", "Account No.");
                    CustLedgEntry.SETRANGE(Open, TRUE);
                    CustLedgEntry.SETRANGE("Applies-to ID", xRec."Applies-to ID");
                    IF CustLedgEntry.FINDFIRST THEN
                        CustEntrySetAppliesToID.SetApplId(CustLedgEntry, TempCustLedgEntry, '');
                    CustLedgEntry.RESET;
                END;
            end;
        }
        field(30; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(31; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
        }
        field(32; "Invoice Amount"; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = ToBeClassified;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(35; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(36; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(37; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(38; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(39; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(40; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(41; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(42; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(43; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(44; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(45; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(46; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(47; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(48; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(49; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(50; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(51; "Management Fees Amount"; Decimal)
        {
            Caption = 'Management Fees Amount';
            DataClassification = ToBeClassified;
        }
        field(52; "Property Fees Code"; Code[20])
        {
            Caption = 'Property Fees Code';
            DataClassification = ToBeClassified;
        }
        field(53; "Property No."; Code[30])
        {
            Caption = 'Property No.';
            DataClassification = ToBeClassified;
        }
        field(54; "Fees Status"; Option)
        {
            Caption = 'Fees Status';
            DataClassification = ToBeClassified;
            OptionMembers = "","Not Invoiced",Invoiced;
            OptionCaption = ',Not Invoiced,Invoiced';
        }
        field(55; "LandLord Contract No."; Code[30])
        {
            Caption = 'LandLord Contract No.';
            DataClassification = ToBeClassified;
        }
        field(56; "Customer Posting Group"; Code[30])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group".Code;
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
        ReceiptHeader: Record "Receipt Header";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Employee: Record Employee;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        FundsTaxCodes: Record "Funds Tax Code";
        FundsTaxCodes2: Record "Funds Tax Code";
        FundsGeneralSetup: Record "Funds General Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustomerLedgerEntries: page "Customer Ledger Entries";
        CustEntrySetAppliesToID: Codeunit "Cust. Entry-SetAppl.ID";
        TempCustLedgEntry: Record "Cust. Ledger Entry";

    trigger OnInsert()
    begin
        IF "Account No." = '' THEN BEGIN
            ReceiptHeader.RESET;
            ReceiptHeader.SETRANGE(ReceiptHeader."No.", "Document No.");
            IF ReceiptHeader.FINDFIRST THEN BEGIN
                ReceiptHeader.TESTFIELD(ReceiptHeader.Description);
                Description := ReceiptHeader.Description;
                "Document Type" := "Document Type"::Receipt;
                "Posting Date" := ReceiptHeader."Posting Date";
                "Currency Code" := ReceiptHeader."Currency Code";
                "Currency Factor" := ReceiptHeader."Currency Factor";
                "Global Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                "Global Dimension 2 Code" := ReceiptHeader."Global Dimension 2 Code";
                "Shortcut Dimension 3 Code" := ReceiptHeader."Shortcut Dimension 3 Code";
                "Shortcut Dimension 4 Code" := ReceiptHeader."Shortcut Dimension 4 Code";
                "Shortcut Dimension 5 Code" := ReceiptHeader."Shortcut Dimension 5 Code";
                "Shortcut Dimension 6 Code" := ReceiptHeader."Shortcut Dimension 6 Code";
                "Shortcut Dimension 7 Code" := ReceiptHeader."Shortcut Dimension 7 Code";
                "Shortcut Dimension 8 Code" := ReceiptHeader."Shortcut Dimension 8 Code";
                "Responsibility Center" := ReceiptHeader."Responsibility Center";
            END;
        END;
    end;
}
