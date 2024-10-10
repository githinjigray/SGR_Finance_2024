table 50016 "Imprest Header"
{
    Caption = 'Imprest Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
            OptionCaption = ' , ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
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
            OptionMembers = "",Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer";
            OptionCaption = ',Cheque,EFT,RTGS,MPESA,Cash,"Bank Transfer"';
        }
        field(7; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAccount.Reset();
                BankAccount.SetRange("No.", "Bank Account No.");
                if BankAccount.FindFirst() then begin
                    "Bank Account Name" := "Bank Account Name";
                end;
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
        field(11; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ImprestHeader.RESET;
                ImprestHeader.SETRANGE(ImprestHeader."Reference No.", "Reference No.");
                IF ImprestHeader.FINDSET THEN BEGIN
                    REPEAT
                        IF ImprestHeader."No." <> "No." THEN
                            ERROR(ErrorUsedReferenceNo, ImprestHeader."No.");
                    UNTIL ImprestHeader.NEXT = 0;
                END;
            end;
        }
        field(12; "On Behalf Of"; Text[100])
        {
            Caption = 'On Behalf Of';
            DataClassification = ToBeClassified;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;

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
        field(14; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
        }
        field(15; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Line".Amount where("Document No." = field("No.")));
        }
        field(16; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Line"."Amount(LCY)" where("Document No." = field("No.")));
        }
        field(17; "Imprest Remaining Amount"; Decimal)
        {
            Caption = 'Imprest Remaining Amount';
            DataClassification = ToBeClassified;
        }
        field(18; "Imprest Remaining Amount(LCY)"; Decimal)
        {
            Caption = 'Imprest Remaining Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(19; "Date From"; Date)
        {
            Caption = 'Date From';
            DataClassification = ToBeClassified;
        }
        field(20; "Date To"; Date)
        {
            Caption = 'Date To';
            DataClassification = ToBeClassified;
        }
        field(22; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                "Employee Name" := '';
                "Employee Posting Group" := '';
                Customer.Reset();
                Customer.SetRange(Customer."No.", "Employee No.");
                if Customer.FindFirst() then begin
                    // "Employee Name" := Customer."First Name" + ' ' + Customer."Middle Name" + ' ' + Customer."Last Name";
                    // "HR Employee No." := Customer."No.";
                    // Customer.TESTFIELD(Customer."Imprest Posting Group");
                    // "Employee Posting Group" := Customer."Imprest Posting Group";
                    // "HR Job Grade" := Employee."Job Grade";
                    // "Phone No." := Employee."Phone No.";
                    // "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    // "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    // "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    // "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                    // "Shortcut Dimension 5 Code" := Employee."Shortcut Dimension 5 Code";
                    // "Shortcut Dimension 6 Code" := Employee."Shortcut Dimension 6 Code";
                    // "Responsibility Center" := Employee."Responsibility Center";
                end;
            end;
        }
        field(23; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(24; "Employee Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Employee Posting Group".Code;
            trigger OnValidate()
            begin
            end;
        }
        field(25; Surrendered; Boolean)
        {
            Caption = 'Surrendered';
            DataClassification = ToBeClassified;
        }
        field(26; "Imprest Surrender No."; Code[20])
        {
            Caption = 'Imprest Surrender No.';
            DataClassification = ToBeClassified;
        }
        field(27; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(28; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(29; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(30; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(31; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(32; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(33; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(34; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(35; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(36; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(37; "Surrender status"; Option)
        {
            Caption = 'Surrender status';
            OptionMembers = "Not Surrendered","Partially Surrendered","Fully surrendered";
            OptionCaption = 'Not Surrendered,Partially Surrendered,Fully surrendered';
        }
        field(38; "Depature Time"; Time)
        {
            Caption = 'Depature Time';
            DataClassification = ToBeClassified;
        }
        field(39; "Return Time"; Time)
        {
            Caption = 'Return Time';
            DataClassification = ToBeClassified;
        }
        field(40; Destination; Text[30])
        {
            Caption = 'Destination';
            DataClassification = ToBeClassified;
        }
        field(41; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(42; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(43; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(44; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(45; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(46; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(47; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(48; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(49; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(50; "Reversal Posting Date"; Date)
        {
            Caption = 'Reversal Posting Date';
            DataClassification = ToBeClassified;
        }
        field(51; Reimbursed; Boolean)
        {
            Caption = 'Reimbursed';
            DataClassification = ToBeClassified;
        }
        field(52; "Reimbursment Date"; Date)
        {
            Caption = 'Reimbursment Date';
            DataClassification = ToBeClassified;
        }
        field(53; "Reimbursement No."; Code[30])
        {
            Caption = 'Reimbursement No.';
            DataClassification = ToBeClassified;
        }
        field(54; "CPV No."; Code[30])
        {
            Caption = 'CPV No.';
            DataClassification = ToBeClassified;
        }
        field(55; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            begin
                // Employee.Reset();
                // Employee.SetRange(Employee."User ID", "User ID");
                // if Employee.FindFirst() then begin
                //     "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                //     "Responsibility Center" := Employee."Responsibility Center";
                //     "Employee No." := Employee."No.";
                //     VALIDATE("Employee No.");
                // end;
            end;

        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(57; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
        }
        field(58; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(59; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(60; "HR Job Grade"; Code[30])
        {
            Caption = 'HR Job Grade';
            DataClassification = ToBeClassified;
        }
        field(61; "HR Employee No."; Code[30])
        {
            Caption = 'HR Employee No.';
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
        fieldgroup(DropDown; "No.", "Employee No.", "Employee Name", Description, Amount)
        {

        }
    }
    var
        FundsGeneralSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Employee;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        Pheader: page "Purchase Order";
        HumanResourcesSetup: Record "Human Resources Setup";
        Employee: Record Employee;

        ErrorUsedReferenceNo: TextConst ENU = 'The Reference Number has been used in Document No:%1';

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            FundsGeneralSetup.GET;
            FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Imprest Nos.");
            "No. Series" := FundsGeneralSetup."Imprest Nos.";
            if NoSeriesMgt.AreRelated(FundsGeneralSetup."Imprest Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;
        "Document Type" := "Document Type"::Imprest;
        "Document Date" := TODAY;
        "User ID" := USERID;
        "Posting Date" := TODAY;
        VALIDATE("User ID");
        Status := Status::Open;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);
        ImprestLine.RESET;
        ImprestLine.SETRANGE(ImprestLine."Document No.", "No.");
        IF ImprestLine.FINDSET THEN
            ImprestLine.DELETEALL;

    end;

    trigger OnRename()
    begin

    end;



}
