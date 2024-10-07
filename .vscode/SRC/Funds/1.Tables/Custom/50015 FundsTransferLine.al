table 50015 "Funds Transfer Line"
{
    Caption = 'Funds Transfer Line';
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
        field(4; "Money Transfer Code"; Code[50])
        {
            Caption = 'Money Transfer Code';
            DataClassification = ToBeClassified;
        }
        field(5; "Money Transfer Description"; Text[250])
        {
            Caption = 'Money Transfer Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Bank Account","Petty Cash",Surrender,"Petty Cash Payment","Journal Voucher","Medical Claim";
            OptionCaption = ' ,Bank Account,Petty Cash,Surrender,Petty Cash Payment,Journal Voucher,Medical Claim';
            trigger OnValidate()
            BEGIN
                "Account Name" := '';
                "Account No." := '';
                Description := '';
                Amount := 0;
                "Amount(LCY)" := 0;
                "Money Transfer Description" := '';
            END;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = if ("Transaction type" = const("bank account")) "Bank Account"."No." else
            if ("Transaction type" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                "Account Name" := '';
                Description := '';

                FundsTransferHeader.RESET;
                FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", "Document No.");
                FundsTransferHeader.SETRANGE(FundsTransferHeader."Bank Account No.", "Account No.");
                IF FundsTransferHeader.FINDFIRST THEN BEGIN
                    ERROR(SimilarBank);
                END;

                BankAccount.RESET;
                BankAccount.SETRANGE(BankAccount."No.", "Account No.");
                IF BankAccount.FINDFIRST THEN BEGIN
                    "Account Name" := BankAccount.Name;
                    FundsTransferHeader.RESET;
                    FundsTransferHeader.SETRANGE(FundsTransferHeader."No.", "Document No.");
                    IF FundsTransferHeader.FINDFIRST THEN BEGIN
                        FundsTransferHeader.Payee := BankAccount.Name;
                    END;
                END;

                GLAccount.RESET;
                GLAccount.SETRANGE(GLAccount."No.", "Account No.");
                IF GLAccount.FINDFIRST THEN BEGIN
                    "Account Name" := GLAccount.Name;
                END;


                IF "Account Type" = "Account Type"::"Petty Cash" THEN BEGIN
                    ImprestHeader.RESET;
                    ImprestHeader.SETRANGE(ImprestHeader."No.", "Account No.");
                    IF ImprestHeader.FINDFIRST THEN BEGIN
                        ImprestHeader.CALCFIELDS(ImprestHeader.Amount);
                        "Account Name" := ImprestHeader."Employee Name";
                        Description := ImprestHeader.Description;
                        "Money Transfer Description" := ImprestHeader.Description;
                        Amount := ImprestHeader.Amount;
                        VALIDATE(Amount);
                    END;
                END;


                IF "Account Type" = "Account Type"::"Journal Voucher" THEN BEGIN
                    JournalVoucherHeader.RESET;
                    JournalVoucherHeader.SETRANGE(JournalVoucherHeader."JV No.", "Account No.");
                    IF JournalVoucherHeader.FINDFIRST THEN BEGIN
                        JournalVoucherHeader.CALCFIELDS(JournalVoucherHeader."Total Debits");
                        "Account Name" := JournalVoucherHeader.Description;
                        Description := JournalVoucherHeader.Description;
                        "Money Transfer Description" := JournalVoucherHeader.Description;
                        Amount := JournalVoucherHeader."Total Debits";
                        VALIDATE(Amount);
                    END;
                END;
                IF "Account Type" = "Account Type"::"Petty Cash Payment" THEN BEGIN
                    PaymentHeader.RESET;
                    PaymentHeader.SETRANGE(PaymentHeader."No.", "Account No.");
                    IF PaymentHeader.FINDFIRST THEN BEGIN
                        PaymentHeader.CALCFIELDS(PaymentHeader."Net Amount");
                        "Account Name" := PaymentHeader."Payee Name";
                        Description := PaymentHeader.Description;
                        "Money Transfer Description" := PaymentHeader.Description;
                        Amount := PaymentHeader."Net Amount";
                        VALIDATE(Amount);
                    END;
                END;


                IF "Account Type" = "Account Type"::"Medical Claim" THEN BEGIN
                    FundsClaimHeader.RESET;
                    FundsClaimHeader.SETRANGE(FundsClaimHeader."No.", "Account No.");
                    IF FundsClaimHeader.FINDFIRST THEN BEGIN
                        FundsClaimHeader.CALCFIELDS(FundsClaimHeader."Net Amount");
                        "Account Name" := FundsClaimHeader."Payee Name";
                        Description := FundsClaimHeader.Description;
                        "Money Transfer Description" := FundsClaimHeader.Description;
                        Amount := FundsClaimHeader."Net Amount";
                        VALIDATE(Amount);
                    END;
                END;

                IF "Account Type" = "Account Type"::Surrender THEN BEGIN
                    ImprestSurrenderHeader.RESET;
                    ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Account No.");
                    IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
                        ImprestSurrenderHeader.CALCFIELDS(ImprestSurrenderHeader."Cash Receipt Amount");
                        ImprestSurrenderHeader.CALCFIELDS(ImprestSurrenderHeader."Refund Amount");
                        "Account Name" := ImprestSurrenderHeader."Employee Name";
                        Description := ImprestSurrenderHeader.Description;
                        "Money Transfer Description" := ImprestSurrenderHeader.Description;
                        IF ImprestSurrenderHeader."Cash Receipt Amount" <> 0 THEN
                            Amount := (ImprestSurrenderHeader."Cash Receipt Amount") * -1;
                        IF ImprestSurrenderHeader."Refund Amount" <> 0 THEN
                            Amount := ImprestSurrenderHeader."Refund Amount";
                        VALIDATE(Amount);
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
                FundsTransferHeader.RESET;
                IF FundsTransferHeader.GET("Document No.") THEN BEGIN
                    IF FundsTransferHeader."Currency Code" <> '' THEN BEGIN
                        "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(FundsTransferHeader."Posting Date", FundsTransferHeader."Currency Code", Amount, FundsTransferHeader."Currency Factor"));
                    END ELSE BEGIN
                        "Amount(LCY)" := Amount;
                    END;
                END;

            end;
        }
        field(15; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(18; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(19; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(20; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(21; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(22; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(23; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(24; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(25; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(26; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(27; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(28; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(29; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(30; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(31; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(32; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(33; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(34; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bank Account","G/L Account";
            OptionCaption = 'Bank Account,G/L Account';
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
        FundsTransferHeader: Record "Funds Transfer Header";
        PaymentHeader: Record "Payment Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        FundsClaimHeader: Record "Funds Claim Header";
        BankAccount: Record "Bank Account";
        JournalVoucherHeader: Record "Journal Voucher Header";
        ImprestHeader: Record "Imprest Header";
        CurrExchRate: Record "Currency Exchange Rate";
        GLAccount: Record "G/L Account";
        SimilarBank: TextConst ENU = 'This account is similar to account where money is being received from';
}
