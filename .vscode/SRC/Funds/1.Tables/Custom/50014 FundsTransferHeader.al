table 50014 "Funds Transfer Header"
{
    Caption = 'Funds Transfer Header';
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
        field(5; "Payment Mode"; Option)
        {
            Caption = 'Payment Mode';
            DataClassification = ToBeClassified;
            OptionMembers = "",Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer";
            OptionCaption = ',Cheque,EFT,RTGS,MPESA,Cash,Bank Transfer';
        }
        field(6; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer";
            OptionCaption = ',Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer"';
        }
        field(7; "Bank Account No."; Code[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            begin
                "Bank Account Name" := '';
                "Currency Code" := '';
                VALIDATE("Currency Code");

                BankAccount.RESET;
                BankAccount.SETRANGE(BankAccount."No.", "Bank Account No.");
                IF BankAccount.FINDFIRST THEN BEGIN
                    "Bank Account Name" := BankAccount.Name;
                    "Currency Code" := BankAccount."Currency Code";
                    VALIDATE("Currency Code");
                END;
            end;
        }
        field(8; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Bank Account Balance"; Decimal)
        {
            Caption = 'Bank Account Balance';
            DataClassification = ToBeClassified;
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
        }
        field(12; "Tranfer Type"; Option)
        {
            Caption = 'Tranfer Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Bank,"Petty Cash Reimbursment";
            OptionCaption = ',Bank,Petty Cash Reimbursment';
        }
        field(13; "Posting Type"; Option)
        {
            Caption = 'Posting Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Paying Bank","Recepient Bank";
            OptionCaption = ',Paying Bank,Recepient Bank';
        }
        field(14; "Transfer To"; Text[100])
        {
            Caption = 'Transfer To';
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
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                        "Currency Exchange Rate" := CurrExchRate."Relational Exch. Rate Amount";
                    END;
                END ELSE BEGIN
                    IF BankAccount.GET("Bank Account No.") THEN BEGIN
                    END;
                END
            end;
        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
        }
        field(18; "Amount To Transfer"; Decimal)
        {
            Caption = 'Amount To Transfer';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    "Amount To Transfer(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount To Transfer", "Currency Factor"));
                END ELSE BEGIN
                    "Amount To Transfer(LCY)" := "Amount To Transfer";
                END;
            end;
        }
        field(19; "Amount To Transfer(LCY)"; Decimal)
        {
            Caption = 'Amount To Transfer(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Post Lumpsum"; Boolean)
        {
            Caption = 'Post Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(21; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Funds Transfer Line".Amount WHERE("Document No." = FIELD("No.")));

        }
        field(22; "Line Amount(LCY)"; Decimal)
        {
            Caption = 'Line Amount(LCY)';
            FieldClass = FlowField;
            CalcFormula = Sum("Funds Transfer Line"."Amount(LCY)" WHERE("Document No." = FIELD("No.")));
        }
        field(23; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(25; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(26; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(27; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(28; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(29; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(30; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(31; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(32; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(33; Payee; Text[100])
        {
            Caption = 'Payee';
            DataClassification = ToBeClassified;
        }
        field(34; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(35; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(36; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(37; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(38; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(39; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(40; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(41; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(42; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(43; "Reversal Posting Date"; Date)
        {
            Caption = 'Reversal Posting Date';
            DataClassification = ToBeClassified;
        }
        field(44; "Petty Cash Account"; Code[20])
        {
            Caption = 'Petty Cash Account';
            DataClassification = ToBeClassified;
        }
        field(45; "Petty Cash Account Name"; Text[100])
        {
            Caption = 'Petty Cash Account Name';
            DataClassification = ToBeClassified;
        }
        field(46; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(47; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(48; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
        }
        field(49; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(50; "Currency Exchange Rate"; Decimal)
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
                Validate("Amount To Transfer");
                FundsTransferLine.Reset();
                FundsTransferLine.SetRange("Document No.", rec."No.");
                if FundsTransferLine.FindSet() then begin
                    repeat
                        FundsTransferLine."Currency Code" := rec."Currency Code";
                        FundsTransferLine."Currency Factor" := rec."Currency Factor";
                        FundsTransferLine.Validate(Amount);
                        FundsTransferLine.Modify();
                    until FundsTransferLine.Next() = 0;
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
    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            FundsSetup.GET;
            FundsSetup.TESTFIELD("Funds Transfer Nos.");
            "No. Series" := FundsSetup."Funds Transfer Nos.";
            if NoSeriesMgt.AreRelated(FundsSetup."Funds Transfer Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;
        "Document Type" := "Document Type"::"Funds Transfer";
        "Document Date" := TODAY;
        "User ID" := USERID;
        "Posting Date" := TODAY;
        "Tranfer Type" := "Tranfer Type"::Bank;
        Status := Status::Open;
    end;

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);
        FundsTransferLine.RESET;
        FundsTransferLine.SETRANGE(FundsTransferLine."Document No.", "No.");
        IF FundsTransferLine.FINDSET THEN
            FundsTransferLine.DELETEALL;
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        FundsTransferLine: Record "Funds Transfer Line";
        BankAccount: Record "Bank Account";
        CurrExchRate: Record "Currency Exchange Rate";

}
