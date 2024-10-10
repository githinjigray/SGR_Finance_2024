table 50020 "Funds Claim Header"
{
    Caption = 'Funds Claim Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
            DataClassification = ToBeClassified;
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
        field(6; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer";
            OptionCaption = ',Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer"';
        }
        field(7; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;

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
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(9; "Bank Account Balance"; Decimal)
        {
            Caption = 'Bank Account Balance';
            Editable = false;
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

            trigger OnValidate()
            begin
                BankAccountLedgerEntry.RESET;
                BankAccountLedgerEntry.SETRANGE(BankAccountLedgerEntry."External Document No.", "Reference No.");
                IF BankAccountLedgerEntry.FINDFIRST THEN BEGIN
                    //ERROR(ErrorUsedReferenceNumber,BankAccountLedgerEntry."Document No.");
                END;
            end;
        }
        field(12; "Payee Type"; Option)
        {
            Caption = 'Payee Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Employee;
            OptionCaption = ' ,Employee';
        }
        field(13; "Payee No."; Code[20])
        {
            Caption = 'Payee No.';
            TableRelation = Employee."No.";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Payee Name" := '';
                Employee.RESET;
                Employee.SETRANGE(Employee."No.", "Payee No.");
                IF Employee.FINDFIRST THEN BEGIN
                    "Payee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    FundsClaimLine.RESET;
                    FundsClaimLine.SETRANGE(FundsClaimLine."Document No.", "No.");
                    FundsClaimLine.SETRANGE(FundsClaimLine."Account Type", FundsClaimLine."Account Type"::Employee);
                    IF FundsClaimLine.FINDSET THEN BEGIN
                        REPEAT
                            FundsClaimLine."Payee No." := Employee."No.";
                            FundsClaimLine."Payee Name" := "Payee Name";
                        UNTIL FundsClaimLine.NEXT = 0;
                    END;

                END;
                VALIDATE("Payee Name");
            end;
        }
        field(14; "Payee Name"; Text[100])
        {
            Caption = 'Payee Name';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                "Payee Name" := UPPERCASE("Payee Name");
            end;
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
            TableRelation = Currency;
            trigger OnValidate()
            begin
                TESTFIELD("Bank Account No.");
                TESTFIELD("Posting Date");
                IF "Currency Code" <> '' THEN BEGIN
                    if "Posting Date" <> 0D then
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code")
                    else
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                END;
            end;
        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
        }
        field(18; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Funds Claim Line".Amount where("Document No." = field("No.")));
        }
        field(19; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Funds Claim Line"."Amount(LCY)" where("Document No." = field("No.")));
        }
        field(20; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Funds Claim Line"."Net Amount" where("Document No." = field("No.")));
        }
        field(21; "Net Amount(LCY)"; Decimal)
        {
            Caption = 'Net Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Funds Claim Line"."Net Amount(LCY)" where("Document No." = field("No.")));
        }
        field(22; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Description := UPPERCASE(Description);
            end;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
            trigger OnValidate()
            begin
                //Delete the previous dimensions
                "Global Dimension 2 Code" := '';
                "Shortcut Dimension 3 Code" := '';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';
                FundsClaimLine.RESET;
                FundsClaimLine.SETRANGE(FundsClaimLine."Document No.", "No.");
                IF FundsClaimLine.FINDSET THEN BEGIN
                    REPEAT
                        FundsClaimLine."Global Dimension 2 Code" := '';
                        FundsClaimLine."Shortcut Dimension 3 Code" := '';
                        FundsClaimLine."Shortcut Dimension 4 Code" := '';
                        FundsClaimLine."Shortcut Dimension 5 Code" := '';
                        FundsClaimLine."Shortcut Dimension 6 Code" := '';
                        FundsClaimLine."Shortcut Dimension 7 Code" := '';
                        FundsClaimLine."Shortcut Dimension 8 Code" := '';
                        FundsClaimLine.MODIFY;
                    UNTIL FundsClaimLine.NEXT = 0;
                END;
                //End delete the previous dimensions

                FundsClaimLine.RESET;
                FundsClaimLine.SETRANGE(FundsClaimLine."Document No.", "No.");
                IF FundsClaimLine.FINDSET THEN BEGIN
                    REPEAT
                        FundsClaimLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        FundsClaimLine.MODIFY;
                    UNTIL FundsClaimLine.NEXT = 0;
                END;
            end;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(25; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(26; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(27; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(28; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(29; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(30; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(31; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(32; "Service Provider"; Code[30])
        {
            Caption = 'Service Provider';
            DataClassification = ToBeClassified;
        }
        field(33; "Service Provider Name"; Text[100])
        {
            Caption = 'Service Provider Name';
            DataClassification = ToBeClassified;
        }
        field(34; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';

            trigger OnValidate()
            begin
                FundsClaimLine.RESET;
                FundsClaimLine.SETRANGE(FundsClaimLine."Document No.", "No.");
                IF FundsClaimLine.FINDSET THEN BEGIN
                    REPEAT
                        FundsClaimLine.Status := Status;
                        FundsClaimLine.MODIFY;
                    UNTIL FundsClaimLine.NEXT = 0;
                END;
            end;
        }
        field(35; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(36; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(37; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(38; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(39; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(40; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(41; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(42; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(43; "Reversal Posting Date"; Date)
        {
            Caption = 'Reversal Posting Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(44; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // UserSetup.RESET;
                // UserSetup.SETRANGE(UserSetup."User ID", "User ID");
                // IF UserSetup.FINDFIRST THEN BEGIN
                //     // UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
                //     // UserSetup.TESTFIELD(UserSetup."Global Dimension 2 Code");
                //     "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                //     "Shortcut Dimension 3 Code" := UserSetup."Shortcut Dimension 3 Code";
                //     "Shortcut Dimension 4 Code" := UserSetup."Shortcut Dimension 4 Code";
                //     "Shortcut Dimension 5 Code" := UserSetup."Shortcut Dimension 5 Code";
                //     "Shortcut Dimension 6 Code" := UserSetup."Shortcut Dimension 6 Code";
                //     "Shortcut Dimension 7 Code" := UserSetup."Shortcut Dimension 7 Code";
                //     "Shortcut Dimension 8 Code" := UserSetup."Shortcut Dimension 8 Code";
                //     "Payee No." := UserSetup."No.";
                //     "Responsibility Center" := UserSetup."Responsibility Center";
                //     VALIDATE("Payee No.");
                // END;
            end;
        }
        field(45; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(46; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(47; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Payee No.", "Payee Name", Description, Amount)
        {

        }
    }
    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
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
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        UserSetup: Record Employee;
    // HRLookup: Record "HR Lookup Values";

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            FundsSetup.GET;
            FundsSetup.TESTFIELD("Funds Claim Nos.");
            "No. Series" := FundsSetup."Funds Claim Nos.";
            if NoSeriesMgt.AreRelated(FundsSetup."Funds Claim Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;
        "Document Type" := "Document Type"::Refund;
        "Document Date" := TODAY;
        "Posting Date" := TODAY;
        "User ID" := USERID;
        VALIDATE("User ID");
        Status := Status::Open;

        // FundsSetup.GET;
        // "Bank Account No." := FundsSetup."Funds Claim Account";
        // VALIDATE("Bank Account No.");
    end;

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);
        FundsClaimLine.RESET;
        FundsClaimLine.SETRANGE(FundsClaimLine."Document No.", "No.");
        IF FundsClaimLine.FINDSET THEN
            FundsClaimLine.DELETEALL;
    end;

}
