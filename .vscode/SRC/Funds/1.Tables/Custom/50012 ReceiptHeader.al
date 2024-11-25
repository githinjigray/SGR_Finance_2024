table 50012 "Receipt Header"
{
    Caption = 'Receipt Header';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                FundsGeneralSetup.get;
                FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Receipt Nos.");
                "No. Series" := FundsGeneralSetup."Receipt Nos.";
                if NoSeriesMgt.AreRelated(FundsGeneralSetup."Receipt Nos.", xRec."No. Series") then
                    "No. Series" := xRec."No. Series";
                "No." := NoSeriesMgt.GetNextNo("No. Series");
            end;
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
        field(5; "Payment Mode"; Option)
        {
            Caption = 'Payment Mode';
            DataClassification = ToBeClassified;
            OptionMembers = "",Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer";
            OptionCaption = ',Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer"';
        }
        field(6; "Receipt Type"; Option)
        {
            Caption = 'Receipt Type';
            DataClassification = ToBeClassified;
            OptionMembers = Bank,"G/L Account",Vendor;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Receipt Type" = CONST(Bank)) "Bank Account"."No."
            ELSE
            IF ("Receipt Type" = CONST("G/L Account")) "G/L Account"."No." WHERE("Account Type" = CONST(Posting), "Direct Posting" = CONST(true))
            ELSE
            IF ("Receipt Type" = CONST(Vendor)) Vendor."No.";
            trigger OnValidate()
            begin
                TESTFIELD("Posting Date");
                "Account Name" := '';
                "Currency Code" := '';
                "Currency Factor" := 0;

                ReceiptLine.Reset();
                ReceiptLine.SetRange("Document No.", Rec."No.");
                ReceiptLine.DeleteAll();

                IF "Receipt Type" = "Receipt Type"::Bank THEN BEGIN
                    BankAccount.RESET;
                    BankAccount.SETRANGE(BankAccount."No.", "Account No.");
                    IF BankAccount.FINDFIRST THEN BEGIN
                        "Account Name" := BankAccount.Name;
                        "Currency Code" := BankAccount."Currency Code";
                        VALIDATE("Currency Code");
                    END;
                END;

                IF "Receipt Type" = "Receipt Type"::"G/L Account" THEN BEGIN
                    GLAccount.RESET;
                    GLAccount.SETRANGE("No.", "Account No.");
                    IF GLAccount.FINDFIRST THEN BEGIN
                        "Account Name" := GLAccount.Name;
                    END;
                END;

                IF "Receipt Type" = "Receipt Type"::Vendor THEN BEGIN
                    Vendor.RESET;
                    Vendor.SETRANGE("No.", "Account No.");
                    IF Vendor.FINDFIRST THEN BEGIN
                        "Account Name" := Vendor.Name;
                    END;
                END;
            end;
        }
        field(8; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Account Balance"; Decimal)
        {
            Caption = 'Account Balance';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(10; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Received From"; Text[100])
        {
            Caption = 'Received From';
            DataClassification = ToBeClassified;
        }
        field(12; "On Behalf of"; Text[100])
        {
            Caption = 'On Behalf of';
            DataClassification = ToBeClassified;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD("Account No.");
                TESTFIELD("Posting Date");
                IF "Currency Code" <> '' THEN BEGIN
                    IF BankAccount.GET("Account No.") THEN BEGIN
                        BankAccount.TESTFIELD(BankAccount."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    END;
                END ELSE BEGIN
                    IF BankAccount.GET("Account No.") THEN BEGIN
                        BankAccount.TESTFIELD(BankAccount."Currency Code", '');
                    END;
                END;
                IF "Amount Received" <> 0 THEN
                    VALIDATE("Amount Received");
            end;
        }
        field(14; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                Validate("Amount Received");
                ReceiptLine.Reset();
                ReceiptLine.SetRange("Document No.", rec."No.");
                if ReceiptLine.findset then begin
                    ReceiptLine."Currency Factor" := rec."Currency Factor";
                    ReceiptLine.Validate(Amount);
                    ReceiptLine.Modify();

                end
            end;
        }

        field(15; "Amount Received"; Decimal)
        {
            Caption = 'Amount Received';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    "Amount Received(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount Received", "Currency Factor"));
                END ELSE BEGIN
                    "Amount Received(LCY)" := "Amount Received";
                END;
            end;
        }
        field(16; "Amount Received(LCY)"; Decimal)
        {
            Caption = 'Amount Received(LCY)';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(17; "Total Line Amount"; Decimal)
        {
            Caption = 'Total Line Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Receipt Line"."Net Amount" where("Document No." = field("No.")));

        }
        field(18; "Total Line Amount(LCY)"; Decimal)
        {
            Caption = 'Total Line Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Receipt Line"."Net Amount(LCY)" where("Document No." = field("No.")));
        }
        field(19; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
            DataClassification = ToBeClassified;
        }
        field(22; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(23; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(24; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(25; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(26; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(27; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(28; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(29; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
            trigger OnValidate()
            begin
                ReceiptLine.RESET;
                ReceiptLine.SETRANGE(ReceiptLine."Document No.", "No.");
                IF ReceiptLine.FINDSET THEN BEGIN
                    REPEAT
                        ReceiptLine.Status := Status;
                        ReceiptLine.MODIFY;
                    UNTIL ReceiptLine.NEXT = 0;
                END;
            end;
        }
        field(30; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(31; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(32; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(33; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(34; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(35; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(36; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(37; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(38; "Reversal Posting Date"; Date)
        {
            Caption = 'Reversal Posting Date';
            DataClassification = ToBeClassified;
        }
        field(39; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(40; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(41; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(43; "Posted to Cheque Buffer"; Boolean)
        {
            Caption = 'Posted to Cheque Buffer';
            DataClassification = ToBeClassified;
        }
        field(44; "Cheque Bank Code"; Code[20])
        {
            Caption = 'Cheque Bank Code';
            DataClassification = ToBeClassified;
        }
        field(45; "Cheque Bank Name"; Text[80])
        {
            Caption = 'Cheque Bank Name';
            DataClassification = ToBeClassified;
        }
        field(46; "Cheque Branch Code"; Code[20])
        {
            Caption = 'Cheque Branch Code';
            DataClassification = ToBeClassified;
        }
        field(47; "Cheque Branch Name"; Text[80])
        {
            Caption = 'Cheque Branch Name';
            DataClassification = ToBeClassified;
        }
        field(48; "Customer Email Address"; Text[50])
        {
            Caption = 'Customer Email Address';
            DataClassification = ToBeClassified;
        }
        field(49; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Document Type")
        {
            Clustered = true;
        }
    }
    var
        FundsGeneralSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        BankAccount: Record "Bank Account";
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
        ReceiptLine: Record "Receipt Line";
        CurrExchRate: Record "Currency Exchange Rate";
        ReceiptsHeader: Record "Receipt Header";
        Text002: Label 'cannot be specified without %1';

    trigger OnInsert()
    begin
        "Document Date" := Today;
        "User ID" := UserId;
        Status := Status::Open;
    end;

    procedure InitInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then
            if "No." = '' then begin
                FundsGeneralSetup.get;
                FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Receipt Nos.");
                "No. Series" := FundsGeneralSetup."Receipt Nos.";
                if NoSeriesMgt.AreRelated(FundsGeneralSetup."Receipt Nos.", xRec."No. Series") then
                    "No. Series" := xRec."No. Series";
                "No." := NoSeriesMgt.GetNextNo("No. Series");
            end;
    end;
}
