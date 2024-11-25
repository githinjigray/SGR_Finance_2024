table 50011 "Payment Line"
{
    Caption = 'Payment Line';
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
        field(4; "Payment Code"; Code[50])
        {
            Caption = 'Payment Code';
            TableRelation = "Funds Transaction Code"."Transaction Code" where("Transaction Type" = filter(Payment));
            trigger OnValidate()
            begin

                "Account Type" := "Account Type"::"G/L Account";
                "Account No." := '';
                "Posting Group" := '';
                "Payment Code Description" := '';
                "VAT Code" := '';
                "Withholding Tax Code" := '';
                "Withholding VAT Code" := '';
                FundsTransactionCodes.RESET;
                FundsTransactionCodes.SETRANGE(FundsTransactionCodes."Transaction Code", "Payment Code");
                IF FundsTransactionCodes.FINDFIRST THEN BEGIN
                    "Account Type" := FundsTransactionCodes."Account Type";
                    "Account No." := FundsTransactionCodes."Account No.";
                    "Posting Group" := FundsTransactionCodes."Posting Group";
                    "Payment Code Description" := FundsTransactionCodes.Description;
                    IF FundsTransactionCodes."Include VAT" THEN
                        "VAT Code" := FundsTransactionCodes."VAT Code";
                    IF FundsTransactionCodes."Include Withholding Tax" THEN
                        "Withholding Tax Code" := FundsTransactionCodes."Withholding Tax Code";
                    IF FundsTransactionCodes."Include Withholding VAT" THEN
                        "Withholding VAT Code" := FundsTransactionCodes."Withholding VAT Code";
                END;

                VALIDATE("Account No.");
            end;
        }
        field(5; "Payment Code Description"; Text[100])
        {
            Caption = 'Payment Code Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Account Type"; enum "Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const(Customer)) Customer."No."
            else
            if ("Account Type" = const(Vendor)) Vendor."No."
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"."No."
            else
            if ("Account Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = const(Customer)) Customer."No."
            else
            if ("Account Type" = const(Employee)) Customer."No.";
            trigger OnValidate()
            begin
                "Account Name" := '';
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := GLAccount.Name;
                    END;
                END;

                // IF "Account Type" = "Account Type"::Customer THEN BEGIN
                //     IF CustomerAccount.GET("Account No.") THEN BEGIN
                //         "Account Name" := CustomerAccount.Name;
                //         Employee.Reset();
                //         Employee.SetRange("No.", "Account No.");
                //         if Employee.FindFirst() THEN BEGIN
                //             "Account Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //             "Payee Bank Code" := Employee."Bank Code";
                //             "Payee Bank Name" := Employee."Bank Name";
                //             "Payee Bank Branch Code" := Employee."Bank Branch Code";
                //             "Payee Bank Branch Name" := Employee."Bank Branch Name";
                //             "Payee Bank Account No." := Employee."Bank Account No.";
                //             "Mobile Payment Account No." := Employee."Mobile Phone No.";
                //             "Phone No." := Employee."Mobile Phone No.";
                //         end;
                //     END;
                // END;

                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    IF BankAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := BankAccount.Name;
                    END;
                END;

                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    VendorAccount.RESET;
                    IF VendorAccount.GET("Account No.") THEN BEGIN
                        "Account Name" := VendorAccount.Name;
                        "Payee Bank Code" := VendorAccount."Bank Code";
                        "Payee Bank Name" := VendorAccount."Bank Name";
                        "Payee Bank Branch Code" := VendorAccount."Bank Branch Code";
                        "Payee Bank Branch Name" := VendorAccount."Bank Branch Name";
                        "Payee Bank Account No." := VendorAccount."Bank Account No.";
                        "Mobile Payment Account No." := VendorAccount."MPESA/Paybill Account No.";

                        PaymentHeader.RESET;
                        PaymentHeader.GET("Document No.");
                        IF PaymentHeader."Payee Name" = '' THEN
                            PaymentHeader."Payee Name" := VendorAccount.Name;
                        PaymentHeader.MODIFY;
                    END;
                END;

                // IF "Account Type" = "Account Type"::Employee THEN BEGIN
                //     IF Employee.GET("Account No.") THEN BEGIN
                //         "Account Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //         "Payee Bank Code" := Employee."Bank Code";
                //         "Payee Bank Name" := Employee."Bank Name";
                //         "Payee Bank Branch Code" := Employee."Bank Branch Code";
                //         "Payee Bank Branch Name" := Employee."Bank Branch Name";
                //         "Payee Bank Account No." := Employee."Bank Account No.";
                //         "Mobile Payment Account No." := Employee."Mobile Phone No.";
                //         "Phone No." := Employee."Mobile Phone No.";
                //         "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                //         "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                //         "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                //         "Shortcut Dimension 5 Code" := Employee."Shortcut Dimension 5 Code";
                //         "Shortcut Dimension 6 Code" := Employee."Shortcut Dimension 6 Code";
                //         "Shortcut Dimension 7 Code" := Employee."Shortcut Dimension 7 Code";
                //         "Shortcut Dimension 8 Code" := Employee."Shortcut Dimension 8 Code";
                //     END;
                //END;
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
        field(11; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
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
        }
        field(15; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."Payment Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest THEN BEGIN
                            "Total Amount" := ROUND("Total Amount", FundsGeneralSetup."Payment Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up THEN BEGIN
                            "Total Amount" := ROUND("Total Amount", FundsGeneralSetup."Payment Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down THEN BEGIN
                            "Total Amount" := ROUND("Total Amount", FundsGeneralSetup."Payment Rounding Precision", '<');
                        END;
                    END;
                    "Net Amount" := "Total Amount";

                    IF "Currency Code" <> '' THEN BEGIN
                        "Total Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Total Amount", "Currency Factor"));
                        "Net Amount(LCY)" := "Total Amount(LCY)";
                    END ELSE BEGIN
                        "Total Amount(LCY)" := "Total Amount";
                        "Net Amount(LCY)" := "Total Amount";
                    END;
                    VALIDATE("Total Amount(LCY)");
                    VALIDATE("Net Amount(LCY)");

                    VALIDATE("VAT Code");
                    VALIDATE("Withholding Tax Code");
                    VALIDATE("Withholding VAT Code");
                END;
            end;
        }
        field(16; "Total Amount(LCY)"; Decimal)
        {
            Caption = 'Total Amount(LCY)';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."Payment Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest THEN BEGIN
                            "Total Amount(LCY)" := ROUND("Total Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up THEN BEGIN
                            "Total Amount(LCY)" := ROUND("Total Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down THEN BEGIN
                            "Total Amount(LCY)" := ROUND("Total Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '<');
                        END;
                    END;
                END;
            end;
        }
        field(17; "VAT Code"; Code[10])
        {
            Caption = 'VAT Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Tax Code"."Tax Code" where(Type = const(VAT));
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
                        "VAT Amount" := "Total Amount" - (("Total Amount" * 100) / (FundsTaxCodes.Percentage + 100));
                        VALIDATE("VAT Amount");
                    END;
                END;
            end;
        }
        field(18; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Net Amount" := "Total Amount";

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
        field(19; "VAT Amount(LCY)"; Decimal)
        {
            Caption = 'VAT Amount(LCY)';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(20; "Withholding Tax Code"; Code[10])
        {
            Caption = 'Withholding Tax Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Tax Code"."Tax Code" where(Type = const("W/TAX"));
            trigger OnValidate()
            begin
                "Withholding Tax Amount" := 0;
                VALIDATE("Withholding Tax Amount");
                IF "Withholding Tax Code" <> '' THEN BEGIN
                    FundsTaxCodes.RESET;
                    FundsTaxCodes.SETRANGE(FundsTaxCodes."Tax Code", "Withholding Tax Code");
                    IF FundsTaxCodes.FINDFIRST THEN BEGIN
                        "Withholding Tax Amount" := (("Total Amount" - "VAT Amount") * (FundsTaxCodes.Percentage / 100));
                        VALIDATE("Withholding Tax Amount");
                    END;
                END;
            end;
        }
        field(21; "Withholding Tax Amount"; Decimal)
        {
            Caption = 'Withholding Tax Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //Rounding
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
                "Net Amount" := "Total Amount" - "Withholding Tax Amount" - "Withholding VAT Amount";
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
        field(22; "Withholding Tax Amount(LCY)"; Decimal)
        {
            Caption = 'Withholding Tax Amount(LCY)';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."W/Tax Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Nearest THEN BEGIN
                            "Withholding Tax Amount(LCY)" := ROUND("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Up THEN BEGIN
                            "Withholding Tax Amount(LCY)" := ROUND("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."W/Tax Rounding Type" = FundsGeneralSetup."W/Tax Rounding Type"::Down THEN BEGIN
                            "Withholding Tax Amount(LCY)" := ROUND("Withholding Tax Amount(LCY)", FundsGeneralSetup."W/Tax Rounding Precision", '<');
                        END;
                    END;
                END;
            end;
        }
        field(23; "Withholding VAT Code"; Code[10])
        {
            Caption = 'Withholding VAT Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Tax Code"."Tax Code" where(Type = const("W/VAT"));
            trigger OnValidate()
            begin
                IF "Withholding VAT Code" <> '' THEN BEGIN

                    TESTFIELD("VAT Amount");
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
        field(24; "Withholding VAT Amount"; Decimal)
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
                "Net Amount" := "Total Amount" - "Withholding Tax Amount" - "Withholding VAT Amount";
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
        field(25; "Withholding VAT Amount(LCY)"; Decimal)
        {
            Caption = 'Withholding VAT Amount(LCY)';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."W/VAT Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Nearest THEN BEGIN
                            "Withholding VAT Amount(LCY)" := ROUND("Withholding VAT Amount(LCY)", FundsGeneralSetup."W/VAT Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Up THEN BEGIN
                            "Withholding VAT Amount(LCY)" := ROUND("Withholding VAT Amount(LCY)", FundsGeneralSetup."W/VAT Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."W/VAT Rounding Type" = FundsGeneralSetup."W/VAT Rounding Type"::Down THEN BEGIN
                            "Withholding VAT Amount(LCY)" := ROUND("Withholding VAT Amount(LCY)", FundsGeneralSetup."W/VAT Rounding Precision", '<');
                        END;
                    END;
                END;
            end;
        }
        field(26; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            DataClassification = ToBeClassified;
        }
        field(27; "Net Amount(LCY)"; Decimal)
        {
            Caption = 'Net Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."Payment Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest THEN BEGIN
                            "Net Amount(LCY)" := ROUND("Net Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up THEN BEGIN
                            "Net Amount(LCY)" := ROUND("Net Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down THEN BEGIN
                            "Net Amount(LCY)" := ROUND("Net Amount(LCY)", FundsGeneralSetup."Payment Rounding Precision", '<');
                        END;
                    END;
                END;
            end;
        }
        field(28; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;
        }
        field(29; "Applies-to Doc. No."; Code[60])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;
            /*trigger OnValidate()
            begin
                PurchInvHeader.RESET;
                PurchInvHeader.SETRANGE(PurchInvHeader."No.", "Applies-to Doc. No.");
                IF PurchInvHeader.FINDFIRST THEN BEGIN
                    PurchInvHeader.CALCFIELDS(Amount, "Amount Including VAT");
                    "VAT Amount" := PurchInvHeader."Amount Including VAT" - PurchInvHeader.Amount;
                    "Vendor Invoice No." := PurchInvHeader."Vendor Invoice No.";
                END;
            end;

            trigger OnLookup()
            var
            AccType:Enum "Account Type";
            OK:Boolean;
            AccNo: code [50];
            PayToVendorNo : code [50];
            begin
                IF ("Account Type" <> "Account Type"::Customer) AND ("Account Type" <> Rec."Account Type"::Vendor) THEN
                    ERROR(ApplicationNotAllowed, "Account Type");

                xRec."Total Amount" := "Total Amount";
                xRec."Currency Code" := "Currency Code";
                xRec."Posting Date" := "Posting Date";

                GetAccTypeAndNo(Rec, AccType, AccNo);
                CLEAR(VendLedgEntry);

                CASE AccType OF
                    AccType::Vendor:
                        LookUpAppliesToDocVend(AccNo);
                END;
                SetPaymentLineFieldsFromApplication;
            end;*/
            //borrowed from receipt
            trigger OnValidate()
            begin
                VendLedgEntry.RESET;
                VendLedgEntry.SETRANGE(VendLedgEntry."Document No.", "Applies-to Doc. No.");
                IF VendLedgEntry.FINDFIRST THEN BEGIN
                    VendLedgEntry.CALCFIELDS(VendLedgEntry.Amount);
                    "Invoice Amount" := VendLedgEntry.Amount;
                    MODIFY;
                END;
            end;

            trigger OnLookup()
            begin
                //"Invoice Amount" := 0;
                "VAT Amount" := 0;
                "VAT Amount(LCY)" := 0;

                VendLedgEntry.RESET;
                VendLedgEntry.SETRANGE("Vendor No.", "Account No.");
                VendLedgEntry.SETRANGE(Open, TRUE);
                //VendLedgEntry.SETRANGE(Positive, TRUE);
                CLEAR(VendorLedgerPage);
                VendorLedgerPage.SETRECORD(VendLedgEntry);
                VendorLedgerPage.SETTABLEVIEW(VendLedgEntry);
                VendorLedgerPage.LOOKUPMODE(TRUE);
                IF VendorLedgerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    VendorLedgerPage.GETRECORD(VendLedgEntry);
                    "Applies-to Doc. No." := VendLedgEntry."Document No.";
                    VendLedgEntry.CALCFIELDS("Remaining Amount");
                    VendLedgEntry.CALCFIELDS(Amount);
                    "Total Amount" := (VendLedgEntry."Remaining Amount") * -1;
                    VALIDATE("Total Amount");
                    "Invoice Amount" := (VendLedgEntry.Amount) * -1;
                    VALIDATE("VAT Amount");
                END ELSE BEGIN
                END;
            end;
            //borrowed end
        }
        field(30; "Applies-to ID"; Code[30])
        {
            Caption = 'Applies-to ID';
            DataClassification = ToBeClassified;
        }
        field(31; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(32; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
        }
        field(33; "Payee Type"; Enum "Payee Type")
        {
            Caption = 'Payee Type';
            DataClassification = ToBeClassified;
        }
        field(34; "Payee No."; Code[20])
        {
            Caption = 'Payee No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payee Type" = CONST(Vendor)) Vendor."No." WHERE(Balance = FILTER(<> 0))
            ELSE
            IF ("Payee Type" = CONST(Employee)) Employee."No."
            ELSE
            IF ("Payee Type" = CONST(Imprest)) "Imprest Header"."No." WHERE(Posted = CONST(false), Status = CONST(Approved))
            ELSE
            IF ("Payee Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Payee Type" = CONST(GL)) "G/L Account"."No."
            ELSE
            IF ("Payee Type" = CONST("Pre-Payment")) Vendor."No.";

            trigger OnValidate()
            begin
                IF "Payee Type" = "Payee Type"::Imprest THEN BEGIN
                    ImprestHeader.RESET;
                    ImprestHeader.SETRANGE(ImprestHeader."No.", "Payee No.");
                    IF ImprestHeader.FINDFIRST THEN BEGIN
                        PaymentLine.RESET;
                        PaymentLine.SETRANGE(PaymentLine."Payee No.", "Payee No.");
                        IF PaymentLine.FINDFIRST THEN BEGIN
                            IF PaymentLine."Document No." <> "Document No." THEN
                                ERROR(Text005, PaymentLine."Document No.");
                        END;

                        ImprestHeader.CALCFIELDS(ImprestHeader.Amount);
                        ImprestHeader.CALCFIELDS(ImprestHeader."Amount(LCY)");
                        "Account Type" := "Account Type"::Customer;
                        "Account No." := ImprestHeader."Employee No.";
                        VALIDATE("Account No.");
                        Description := ImprestHeader.Description;
                        if ImprestHeader."Currency Code" = 'KSH SHS' then
                            "Currency Code" := ''
                        else
                            "Currency Code" := ImprestHeader."Currency Code";
                        "Total Amount" := ImprestHeader.Amount;
                        VALIDATE("Total Amount");
                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                        PaymentHeader.RESET;
                        PaymentHeader.SETRANGE(PaymentHeader."No.", "Document No.");
                        IF PaymentHeader.FINDFIRST THEN BEGIN
                            IF PaymentHeader."Payee Name" = '' THEN BEGIN
                                PaymentHeader."Payee Name" := ImprestHeader."Employee Name";
                                //  PaymentHeader."Phone No." := ImprestHeader."Phone No.";
                            END;
                            PaymentHeader."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                            PaymentHeader."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                            PaymentHeader."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                            PaymentHeader."Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                            PaymentHeader."Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                            PaymentHeader."Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                            PaymentHeader."Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                            PaymentHeader."Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                            PaymentHeader.MODIFY;
                        END;
                    END;
                END;

                IF "Payee Type" = "Payee Type"::Customer THEN BEGIN
                    "Account Type" := "Account Type"::Customer;
                    "Account No." := "Payee No.";
                    VALIDATE("Account No.");
                END;

                IF ("Payee Type" = "Payee Type"::Vendor) OR ("Payee Type" = "Payee Type"::"Pre-Payment") THEN BEGIN
                    "Account Type" := "Account Type"::Vendor;
                    "Account No." := "Payee No.";
                    VALIDATE("Account No.");
                END;

                IF "Payee Type" = "Payee Type"::Employee THEN BEGIN
                    "Account Type" := "Account Type"::Employee;
                    "Account No." := "Payee No.";
                    VALIDATE("Account No.");
                END;

                IF "Payee Type" = "Payee Type"::GL THEN BEGIN
                    "Account Type" := "Account Type"::"G/L Account";
                    "Account No." := "Payee No.";
                    VALIDATE("Account No.");
                END;
            END;
        }
        field(35; "Vendor Invoice No."; Code[50])
        {
            Caption = 'Vendor Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(36; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = ToBeClassified;
        }
        field(37; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."Payment Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest THEN BEGIN
                            "Tax Amount" := ROUND("Tax Amount", FundsGeneralSetup."Payment Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up THEN BEGIN
                            "Tax Amount" := ROUND("Tax Amount", FundsGeneralSetup."Payment Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down THEN BEGIN
                            "Tax Amount" := ROUND("Tax Amount", FundsGeneralSetup."Payment Rounding Precision", '<');
                        END;
                    END;
                END;
                IF "Currency Code" <> '' THEN BEGIN
                    "Tax Amount (LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Tax Amount", "Currency Factor"));
                END ELSE BEGIN
                    "Tax Amount (LCY)" := "Tax Amount";
                END;
            end;
        }
        field(38; "Tax Amount (LCY)"; Decimal)
        {
            Caption = 'Tax Amount (LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                IF FundsGeneralSetup.GET THEN BEGIN
                    IF FundsGeneralSetup."Payment Rounding Precision" <> 0 THEN BEGIN
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Nearest THEN BEGIN
                            "Tax Amount (LCY)" := ROUND("Tax Amount (LCY)", FundsGeneralSetup."Payment Rounding Precision", '=');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Up THEN BEGIN
                            "Tax Amount (LCY)" := ROUND("Tax Amount (LCY)", FundsGeneralSetup."Payment Rounding Precision", '>');
                        END;
                        IF FundsGeneralSetup."Payment Rounding Type" = FundsGeneralSetup."Payment Rounding Type"::Down THEN BEGIN
                            "Tax Amount (LCY)" := ROUND("Tax Amount (LCY)", FundsGeneralSetup."Payment Rounding Precision", '<');
                        END;
                    END;
                END;
            end;
        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(41; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(42; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(43; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(44; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(45; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(46; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(47; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(48; "Payee Bank Code"; Code[20])
        {
            Caption = 'Payee Bank Code';
            DataClassification = ToBeClassified;
        }
        field(49; "Payee Bank Name"; Text[250])
        {
            Caption = 'Payee Bank Name';
            DataClassification = ToBeClassified;
        }
        field(50; "Payee Bank Branch Code"; Code[20])
        {
            Caption = 'Payee Bank Branch Code';
            DataClassification = ToBeClassified;
        }
        field(51; "Payee Bank Branch Name"; Text[250])
        {
            Caption = 'Payee Bank Branch Name';
            DataClassification = ToBeClassified;
        }
        field(52; "Payee Bank Account No."; Code[20])
        {
            Caption = 'Payee Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(53; "Mobile Payment Account No."; Code[20])
        {
            Caption = 'Mobile Payment Account No.';
            DataClassification = ToBeClassified;
        }
        field(54; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer";
            OptionCaption = ',Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer"';
        }
        field(55; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(56; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(57; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(58; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(59; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(60; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(61; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(62; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(63; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(64; "Job No."; Code[50])
        {
            Caption = 'Job No.';
            DataClassification = ToBeClassified;
        }
        field(65; "Employee Transaction Type"; Option)
        {
            Caption = 'Employee Transaction Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",NetPay,Imprest;
            OptionCaption = ' ,NetPay,Imprest';
        }
        field(66; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(70; "Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Amount';
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
        FundsGeneralSetup: Record "Funds General Setup";
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        ImprestHeader: Record "Imprest Header";
        CustomerAccount: Record Customer;
        VendorAccount: Record Vendor;
        PaymentLine2: Record "Payment Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        FixedAsset: Record "Fixed Asset";
        HREmployee: Record Employee;
        SalaryAdvance: Record "Salary Advance Request";
        Employee: Record Employee;
        BankAccountLegderEntry: Record "Bank Account Ledger Entry";
        FundsClaims: Record "Funds Claim Header";
        ActivityRequest: Record "Travel Request Header";
        ActivityRequestLine: Record "Travel Request Line";
        FundsTaxCodes2: Record "Funds Tax Code";
        PaymentHeader: Record "Payment Header";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        vendorList: Record Vendor;
        VendorLedgerPage: page "Vendor Ledger Entries";
        CurrExchRate: Record "Currency Exchange Rate";
        PurchInvHeader: Record "Purch. Inv. Header";
        PaymentLine: Record "Payment Line";
        FundsClaimHeader: Record "Funds Claim Header";
        FundsClaimLine: Record "Funds Claim Line";
        Text001: TextConst ENU = 'You Cannot Delete line when status is Released';
        Text005: TextConst ENU = 'The Imprest has already been assigned to Payment Voucher no. %1';
        Text006: TextConst ENU = 'The request has already been assigned to Payment Voucher no. %1';
        ApplicationNotAllowed: TextConst ENU = 'You cannot apply to %1';

    trigger OnInsert()
    begin
        PaymentHeader.RESET;
        PaymentHeader.SETRANGE(PaymentHeader."No.", "Document No.");
        IF PaymentHeader.FINDFIRST THEN BEGIN
            PaymentHeader.TESTFIELD("Posting Date");
            // PaymentHeader.TESTFIELD("Global Dimension 1 Code");
            "Document Type" := "Document Type"::Payment;
            "Posting Date" := PaymentHeader."Posting Date";
            "Currency Code" := PaymentHeader."Currency Code";
            "Currency Factor" := PaymentHeader."Currency Factor";
            if PaymentHeader."Payment Type" = PaymentHeader."Payment Type"::"Cheque Payment" then begin
                Description := PaymentHeader.Description;
                "Global Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                "Global Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                "Shortcut Dimension 3 Code" := PaymentHeader."Shortcut Dimension 3 Code";
                "Shortcut Dimension 4 Code" := PaymentHeader."Shortcut Dimension 4 Code";
                "Shortcut Dimension 5 Code" := PaymentHeader."Shortcut Dimension 5 Code";
                "Shortcut Dimension 6 Code" := PaymentHeader."Shortcut Dimension 6 Code";
                "Shortcut Dimension 7 Code" := PaymentHeader."Shortcut Dimension 7 Code";
                "Shortcut Dimension 8 Code" := PaymentHeader."Shortcut Dimension 8 Code";
            end;
        END;
    end;

    trigger OnModify()
    begin

    end;

    PROCEDURE LookUpAppliesToDocVend(AccNo: code[20])
    var
        ApplyVendEntries: page "Apply Vendor Entries";
    begin
        CLEAR(VendLedgEntry);
        VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date");
        //filter by dimension
        VendLedgEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        IF AccNo <> '' THEN
            VendLedgEntry.SETRANGE("Vendor No.", AccNo);
        VendLedgEntry.SETRANGE(Open, TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
            VendLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
            VendLedgEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
            IF VendLedgEntry.ISEMPTY THEN BEGIN
                VendLedgEntry.SETRANGE("Document Type");
                VendLedgEntry.SETRANGE("Document No.");
                VendLedgEntry.SETRANGE("Global Dimension 1 Code");
            END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
            VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
            IF VendLedgEntry.ISEMPTY THEN
                VendLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
            IF VendLedgEntry.ISEMPTY THEN
                VendLedgEntry.SETRANGE("Document Type");
        END;
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            VendLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
            IF VendLedgEntry.ISEMPTY THEN
                VendLedgEntry.SETRANGE("Document No.");
        END;
        IF "Total Amount" <> 0 THEN BEGIN
            VendLedgEntry.SETRANGE(Positive, "Total Amount" < 0);
            IF VendLedgEntry.ISEMPTY THEN;
            VendLedgEntry.SETRANGE(Positive);
        END;
        ApplyVendEntries.SetPaymentLine(Rec, PaymentLine.FIELDNO("Applies-to Doc. No."));
        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
        ApplyVendEntries.SETRECORD(VendLedgEntry);
        ApplyVendEntries.LOOKUPMODE(TRUE);
        IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ApplyVendEntries.GETRECORD(VendLedgEntry);
            IF AccNo = '' THEN BEGIN
                AccNo := VendLedgEntry."Vendor No.";
                VALIDATE("Account No.", AccNo);
            END;
            SetAmountWithVendLedgEntry;
            "Applies-to Doc. Type" := VendLedgEntry."Document Type";
            "Applies-to Doc. No." := VendLedgEntry."Document No.";
            "Applies-to ID" := '';
        END;
    end;

    procedure SetApplyToAmount()
    begin
        IF "Account Type" = "Account Type"::Vendor THEN BEGIN
            VendLedgEntry.SETCURRENTKEY("Document No.");
            VendLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
            VendLedgEntry.SETRANGE("Vendor No.", "Account No.");
            VendLedgEntry.SETRANGE(Open, TRUE);
            IF VendLedgEntry.FIND('-') THEN
                IF VendLedgEntry."Amount to Apply" = 0 THEN BEGIN
                    VendLedgEntry.CALCFIELDS("Remaining Amount");
                    VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
                    CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
                END;
        END;
    end;

    LOCAL PROCEDURE GetAccTypeAndNo(PaymentLine: Record "Payment Line"; VAR AccType: Enum "Account Type"; VAR AccNo: Code[20]);
    BEGIN
        AccType := PaymentLine2."Account Type";
        AccNo := PaymentLine2."Account No.";
    END;

    LOCAL PROCEDURE SetAmountWithVendLedgEntry();
    BEGIN
        IF "Currency Code" <> VendLedgEntry."Currency Code" THEN
            CheckModifyCurrencyCode("Account Type"::Vendor, VendLedgEntry."Currency Code");
        IF "Total Amount" = 0 THEN BEGIN
            VendLedgEntry.CALCFIELDS("Remaining Amount");
            SetAmountWithRemaining(FALSE, VendLedgEntry."Amount to Apply", VendLedgEntry."Remaining Amount", VendLedgEntry."Remaining Pmt. Disc. Possible");
        END;
    END;

    PROCEDURE CheckModifyCurrencyCode(AccountType: enum "Account Type"; CustVendLedgEntryCurrencyCode: Code[10]);
    BEGIN
    END;

    LOCAL PROCEDURE SetAmountWithRemaining(CalcPmtDisc: Boolean; AmountToApply: Decimal; RemainingAmount: Decimal; RemainingPmtDiscPossible: Decimal);
    BEGIN
        IF AmountToApply <> 0 THEN
            IF CalcPmtDisc AND (ABS(AmountToApply) >= ABS(RemainingAmount - RemainingPmtDiscPossible)) THEN
                "Total Amount" := -(RemainingAmount - RemainingPmtDiscPossible)
            ELSE
                "Total Amount" := -AmountToApply
        ELSE
            IF CalcPmtDisc THEN
                "Total Amount" := -(RemainingAmount - RemainingPmtDiscPossible)
            ELSE
                "Total Amount" := -RemainingAmount;
        VALIDATE("Total Amount");
    END;

    LOCAL PROCEDURE SetPaymentLineFieldsFromApplication();
    VAR
        AccType: Enum "Account Type";
        AccNo: Code[20];
    BEGIN
        //"Exported to Payment File" := FALSE;
        GetAccTypeAndNo(Rec, AccType, AccNo);
        CASE AccType OF
            AccType::Vendor:
                IF "Applies-to ID" <> '' THEN BEGIN
                    IF FindFirstVendLedgEntryWithAppliesToID(AccNo, "Applies-to ID") THEN BEGIN
                        VendLedgEntry.SETRANGE("Exported to Payment File", TRUE);
                        // "Exported to Payment File" := VendLedgEntry.FINDFIRST;
                    END
                END ELSE
                    IF "Applies-to Doc. No." <> '' THEN
                        IF FindFirstVendLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") THEN BEGIN
                            //"Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                            //"Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
                            //sysre
                        END;
        END;
    END;

    LOCAL PROCEDURE FindFirstVendLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean;
    BEGIN
        VendLedgEntry.RESET;
        VendLedgEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID", Open);
        VendLedgEntry.SETRANGE("Vendor No.", AccNo);
        VendLedgEntry.SETRANGE("Applies-to ID", AppliesToID);
        VendLedgEntry.SETRANGE(Open, TRUE);
        EXIT(VendLedgEntry.FINDFIRST)
    END;

    LOCAL PROCEDURE FindFirstVendLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean;
    BEGIN
        VendLedgEntry.RESET;
        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Document No.", AppliestoDocNo);
        VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
        VendLedgEntry.SETRANGE("Vendor No.", AccNo);
        VendLedgEntry.SETRANGE(Open, TRUE);
        EXIT(VendLedgEntry.FINDFIRST)
    END;

    LOCAL PROCEDURE TestStatusOpen(AllowApproverEdit: Boolean);
    VAR
        PaymentHeader: Record "Payment Header";
        ApprovalEntry: Record "Approval Entry";
    BEGIN
        PaymentHeader.GET("Document No.");
        IF AllowApproverEdit THEN BEGIN
            ApprovalEntry.RESET;
            ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", PaymentHeader."No.");
            ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", USERID);
            IF NOT ApprovalEntry.FINDFIRST THEN BEGIN
                PaymentHeader.TESTFIELD(Status, PaymentHeader.Status::Open);
            END;
        END ELSE BEGIN
            PaymentHeader.TESTFIELD(Status, PaymentHeader.Status::Open);
        END;
    END;
}

