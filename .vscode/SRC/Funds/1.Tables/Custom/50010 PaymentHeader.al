table 50010 "Payment Header"
{
    Caption = 'Payment Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
            OptionCaption = ',Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender"';
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Payment Mode"; Enum "Payment Modes")
        {
            Caption = 'Payment Mode';
            DataClassification = ToBeClassified;
        }
        field(6; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionMembers = "Cheque Payment","Cash Payment",EFT,RTGS,MPESA,"Pesa Link";
            OptionCaption = 'Cheque Payment,Cash Payment,EFT,RTGS,MPESA,Pesa Link';
        }
        field(7; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            trigger onvalidate()
            begin
                "Bank Account Name" := '';
                BankAccount.Reset();
                BankAccount.SetRange("No.", "Bank Account No.");
                if BankAccount.FindFirst() then begin
                    BankAccount.CalcFields(Balance);
                    "Bank Account Name" := BankAccount.Name;
                    "On Behalf Of" := BankAccount.Name;
                    "Bank Account Balance" := BankAccount.Balance;
                    "Currency Code" := BankAccount."Currency Code";
                    VALIDATE("Currency Code");
                end;
            end;
        }
        field(8; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(9; "Bank Account Balance"; Decimal)
        {
            Caption = 'Bank Account Balance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Cheque Type"; Option)
        {
            Caption = 'Cheque Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Computer Cheque","Manual Cheque";
            OptionCaption = ',Computer Cheque,Manual Cheque';
        }
        field(11; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PaymentHeader: Record "Payment Header";
                FudsTransfers: Record "Funds Transfer Header";
                BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                ErrorUsedReferenceNumber: Label 'The Reference Number has been used for Transaction No: %1';
            begin

                PaymentHeader.RESET;
                PaymentHeader.SETRANGE(PaymentHeader."Reference No.", "Reference No.");
                PaymentHeader.SETRANGE(PaymentHeader."Bank Account No.", "Bank Account No.");
                IF PaymentHeader.FINDFIRST THEN BEGIN
                    ERROR(ErrorUsedReferenceNumber, PaymentHeader."No.");
                END;

                FudsTransfers.RESET;
                FudsTransfers.SETRANGE(FudsTransfers."Reference No.", "Reference No.");
                FudsTransfers.SETRANGE(FudsTransfers."Bank Account No.", "Bank Account No.");
                IF FudsTransfers.FINDFIRST THEN BEGIN
                    ERROR(ErrorUsedReferenceNumber, FudsTransfers."No.");
                END;
                BankAccountLedgerEntry.RESET;
                BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry."External Document No.", "Reference No.");
                BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry."Bank Account No.", "Bank Account No.");
                IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
                    ERROR(ErrorUsedReferenceNumber, BankAccountLedgerEntry."Document No.");
                END;
                "Cheque No." := '';
                "Cheque No." := "Reference No.";
            end;
        }
        field(12; "Payee Type"; Option)
        {
            Caption = 'Payee Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Vendor,Employee,Claim,Imprest,"Imprest Surrender","Staff Loan",Board;
            OptionCaption = ',Vendor,Employee,Claim,Imprest,Imprest Surrender,Staff Loan,Board';
        }
        field(13; "Payee No."; Code[20])
        {
            Caption = 'Payee No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Payee Type" = CONST(Vendor)) Vendor."No."
            else
            if ("Payee Type" = CONST(Employee)) Employee."No."
            else
            if ("Payee Type" = CONST(Claim)) "Funds Claim Header"."No."
            where(Posted = const(false), Status = CONST(Approved))
            else
            if ("Payee Type" = CONST(Imprest)) "Imprest Header"."No."
            WHERE(Posted = const(false), Status = CONST(Approved));
            trigger OnValidate()
            begin
                VendorAccount.Reset();
                VendorAccount.SetRange("No.", "Payee No.");
                if VendorAccount.FindFirst() then begin
                    "Payee Name" := VendorAccount.Name;
                end;
                HREmployee.Reset();
                HREmployee.SetRange("No.", "Payee No.");
                if HREmployee.FindFirst() then begin
                    "Payee Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                end;

            end;
        }
        field(14; "Payee Name"; Text[100])
        {
            Caption = 'Payee Name';
            DataClassification = ToBeClassified;
        }
        field(15; "On Behalf Of"; Text[100])
        {
            Caption = 'On Behalf Of';
            DataClassification = ToBeClassified;
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
            trigger OnValidate()
            begin
                TESTFIELD("Bank Account No.");
                TESTFIELD("Posting Date");
                IF "Currency Code" <> '' THEN BEGIN
                    IF BankAccount.GET("Bank Account No.") THEN BEGIN
                        BankAccount.TESTFIELD(BankAccount."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                        "Currency Exchange Rate" := CurrExchRate."Relational Exch. Rate Amount";
                    END;
                END ELSE BEGIN
                    IF BankAccount.GET("Bank Account No.") THEN BEGIN
                        BankAccount.TESTFIELD(BankAccount."Currency Code", '');
                    END;
                END;
            end;

        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(18; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Total Amount" where("Document No." = field("No.")));
        }
        field(19; "Total Amount(LCY)"; Decimal)
        {
            Caption = 'Total Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Total Amount(LCY)" where("Document No." = field("No.")));
        }
        field(20; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."VAT Amount" where("Document No." = field("No.")));
        }
        field(21; "VAT Amount(LCY)"; Decimal)
        {
            Caption = 'VAT Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."VAT Amount(LCY)" where("Document No." = field("No.")));
        }
        field(22; "WithHolding Tax Amount"; Decimal)
        {
            Caption = 'WithHolding Tax Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Withholding Tax Amount" where("Document No." = field("No.")));
        }
        field(23; "WithHolding Tax Amount(LCY)"; Decimal)
        {
            Caption = 'WithHolding Tax Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Withholding Tax Amount(LCY)" where("Document No." = field("No.")));
        }
        field(24; "Withholding VAT Amount"; Decimal)
        {
            Caption = 'Withholding VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Withholding VAT Amount" where("Document No." = field("No.")));
        }
        field(25; "Withholding VAT Amount(LCY)"; Decimal)
        {
            Caption = 'Withholding VAT Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Withholding VAT Amount(LCY)" where("Document No." = field("No.")));
        }
        field(26; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Net Amount" where("Document No." = field("No.")));
        }
        field(27; "Net Amount(LCY)"; Decimal)
        {
            Caption = 'Net Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Net Amount(LCY)" where("Document No." = field("No.")));
        }
        field(28; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Tax Amount" where("Document No." = field("No.")));
        }
        field(29; "Tax Amount(LCY)"; Decimal)
        {
            Caption = 'Tax Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Tax Amount (LCY)" where("Document No." = field("No.")));
        }
        field(30; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(31; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
            trigger OnValidate()
            begin
                "Global Dimension 2 Code" := '';
                "Shortcut Dimension 3 Code" := '';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';

                PaymentLine.RESET;
                PaymentLine.SETRANGE(PaymentLine."Document No.", Rec."No.");
                IF PaymentLine.FINDSET THEN BEGIN
                    REPEAT
                        PaymentLine."Global Dimension 2 Code" := '';
                        PaymentLine."Shortcut Dimension 3 Code" := '';
                        PaymentLine."Shortcut Dimension 4 Code" := '';
                        PaymentLine."Shortcut Dimension 5 Code" := '';
                        PaymentLine."Shortcut Dimension 6 Code" := '';
                        PaymentLine."Shortcut Dimension 7 Code" := '';
                        PaymentLine."Shortcut Dimension 8 Code" := '';
                        PaymentLine.MODIFY;
                    UNTIL PaymentLine.NEXT = 0;
                END;


                PaymentLine.RESET;
                PaymentLine.SETRANGE(PaymentLine."Document No.", "No.");
                IF PaymentLine.FINDSET THEN BEGIN
                    REPEAT
                        PaymentLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        PaymentLine.MODIFY;
                    UNTIL PaymentLine.NEXT = 0;
                END;
            end;
        }
        field(32; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(33; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
        }
        field(34; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(35; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
        }
        field(36; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(37; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(38; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(39; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(40; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ' ,Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(41; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(42; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(43; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(44; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(45; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(46; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(47; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(48; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(49; "Reversal Posting Date"; Date)
        {
            Caption = 'Reversal Posting Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = ToBeClassified;
        }
        field(51; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(52; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(53; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(54; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(55; "Payee Bank Account Name"; Text[100])
        {
            Caption = 'Payee Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(56; "Payee Bank Account No."; Code[20])
        {
            Caption = 'Payee Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(57; "MPESA/Paybill Account No."; Code[20])
        {
            Caption = 'MPESA/Paybill Account No.';
            DataClassification = ToBeClassified;
        }
        field(58; "Payee Bank Code"; Code[20])
        {
            Caption = 'Payee Bank Code';
            DataClassification = ToBeClassified;
        }
        field(59; "Payee Bank Name"; Text[80])
        {
            Caption = 'Payee Bank Name';
            DataClassification = ToBeClassified;
        }

        field(60; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }

        field(64; "Amount to Offset"; Decimal)
        {
            Caption = 'Amount to Offset';
            DataClassification = ToBeClassified;
        }
        field(65; "Amount Not Reimbursed"; Decimal)
        {
            Caption = 'Amount Not Reimbursed';
            DataClassification = ToBeClassified;
        }
        field(66; "Amount Reimbursed"; Decimal)
        {
            Caption = 'Amount Reimbursed';
            DataClassification = ToBeClassified;
        }
        field(67; "Payroll Payment"; Boolean)
        {
            Caption = 'Payroll Payment';
            DataClassification = ToBeClassified;
        }
        field(68; "Cheque Printed"; Boolean)
        {
            Caption = 'Cheque Printed';
            DataClassification = ToBeClassified;
        }
        field(69; "Cheque Printing Date"; Date)
        {
            Caption = 'Cheque Printing Date';
            DataClassification = ToBeClassified;
        }
        field(70; "Payment Voucher Type"; Option)
        {
            Caption = 'Payment Voucher Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Invoice Based",Direct;
            OptionCaption = ',"","Invoice Based",Direct';
        }
        field(71; "Currency Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Currency Exchange Rate';
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            var
                CurrecyExcangeRate: Record "Currency Exchange Rate";
                NewCurrecyExcangeRate: Record "Currency Exchange Rate";
            begin
                TestField("Currency Code");
                TestField("Posting Date");

                CurrecyExcangeRate.Reset();
                CurrecyExcangeRate.SetRange("Currency Code", "Currency Code");
                CurrecyExcangeRate.SetRange("Starting Date", "Posting Date");
                if CurrecyExcangeRate.FindFirst() then begin
                    CurrecyExcangeRate."Relational Adjmt Exch Rate Amt" := "Currency Exchange Rate";
                    CurrecyExcangeRate."Relational Exch. Rate Amount" := "Currency Exchange Rate";
                    CurrecyExcangeRate.Modify();
                end else begin
                    NewCurrecyExcangeRate.Init();
                    NewCurrecyExcangeRate."Currency Code" := "Currency Code";
                    NewCurrecyExcangeRate."Starting Date" := "Posting Date";
                    NewCurrecyExcangeRate."Exchange Rate Amount" := 1;
                    NewCurrecyExcangeRate."Adjustment Exch. Rate Amount" := 1;
                    NewCurrecyExcangeRate."Relational Adjmt Exch Rate Amt" := "Currency Exchange Rate";
                    NewCurrecyExcangeRate."Relational Exch. Rate Amount" := "Currency Exchange Rate";
                    NewCurrecyExcangeRate.Insert();
                end;
                Validate("Currency Code");
                PaymentLine.Reset();
                PaymentLine.SetRange("Document No.", rec."No.");
                if PaymentLine.FindSet() then begin
                    repeat
                        PaymentLine."Currency Code" := rec."Currency Code";
                        PaymentLine."Currency Factor" := rec."Currency Factor";
                        PaymentLine.Validate("Total Amount");
                        PaymentLine.Modify();
                    until PaymentLine.Next() = 0;
                end
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        BankAccount: Record "Bank Account";
        Glaccount: Record "G/L Account";
        ImprestHeader: Record "Imprest Header";
        CustomerAccount: Record Customer;
        VendorAccount: Record Vendor;
        FundsGeneralSetup: Record "Funds General Setup";
        FixedAsset: Record "Fixed Asset";
        HREmployee: Record Employee;
        BankAccountLegderEntry: Record "Bank Account Ledger Entry";
        FundsClaims: Record "Funds Claim Header";
        PaymentLine: Record "Payment Line";
        CurrExchRate: Record "Currency Exchange Rate";
        NoSeriesMgt: Codeunit "No. Series";
    //Approvetable: Record "Approval Entry";
    //approveCU: Codeunit "Approvals Mgmt.";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            if "Payment Type" = "Payment Type"::"Cheque Payment" then begin
                FundsGeneralSetup.get;
                FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Payment Voucher Nos.");
                "No. Series" := FundsGeneralSetup."Payment Voucher Nos.";
                if NoSeriesMgt.AreRelated(FundsGeneralSetup."Payment Voucher Nos.", xRec."No. Series") then
                    "No. Series" := xRec."No. Series";
                "No." := NoSeriesMgt.GetNextNo("No. Series");
            end;
            if "Payment Type" = "Payment Type"::"Cash Payment" then begin
                FundsGeneralSetup.get;
                FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Cash Voucher Nos.");
                "No. Series" := FundsGeneralSetup."Cash Voucher Nos.";
                if NoSeriesMgt.AreRelated(FundsGeneralSetup."Cash Voucher Nos.", xRec."No. Series") then
                    "No. Series" := xRec."No. Series";
                "No." := NoSeriesMgt.GetNextNo("No. Series");
            end;
        end;
        "Document Type" := "Document Type"::Payment;
        "Posting Date" := Today;
        "Document Date" := Today;
        "User ID" := UserId;
        Status := Status::Open;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.", "No.");
        IF PaymentLine.FINDSET THEN
            PaymentLine.DELETEALL;
    end;

    trigger OnRename()
    begin

    end;

}

