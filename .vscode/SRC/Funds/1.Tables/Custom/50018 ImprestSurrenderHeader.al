table 50018 "Imprest Surrender Header"
{
    Caption = 'Imprest Surrender Header';
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
            OptionCaption = ',Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
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
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                "Employee Name" := '';

                IF Customer.GET("Employee No.") THEN BEGIN
                    "Employee Name" := Customer.Name;
                END;
            end;
        }
        field(6; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Imprest No."; Code[20])
        {
            Caption = 'Imprest No.';
            DataClassification = ToBeClassified;
            TableRelation = "Imprest Header"."No."
            WHERE("Employee No." = FIELD("Employee No."),
            Posted = CONST(true), Reversed = CONST(false), "Surrender status" = FILTER("Not Surrendered"));

            trigger OnValidate()
            begin
                TESTFIELD("Employee No.");
                //Reset Imprest Surrender
                ImprestSurrenderLine.RESET;
                ImprestSurrenderLine.SETRANGE(ImprestSurrenderLine."Document No.", "No.");
                IF ImprestSurrenderLine.FINDSET THEN BEGIN
                    ImprestSurrenderLine.DELETEALL;
                END;

                "Imprest Date" := 0D;
                "Global Dimension 1 Code" := '';
                "Global Dimension 2 Code" := '';
                "Shortcut Dimension 3 Code" := '';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';
                "Responsibility Center" := '';
                //End Reset Imprest Surrender

                COMMIT;

                IF "Imprest No." <> '' THEN BEGIN
                    IF ImprestHeader.GET("Imprest No.") THEN BEGIN
                        ImprestHeader.CALCFIELDS(ImprestHeader.Amount);
                        "Actual Advanced" := ImprestHeader.Amount;
                        "Imprest Date" := ImprestHeader."Posting Date";
                        "Currency Code" := ImprestHeader."Currency Code";
                        Description := ImprestHeader.Description;
                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                        "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                        "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
                        "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
                        "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
                        "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
                        "Responsibility Center" := ImprestHeader."Responsibility Center";

                        ImprestLine.RESET;
                        ImprestLine.SETRANGE(ImprestLine."Document No.", ImprestHeader."No.");
                        ImprestLine.SETFILTER(ImprestLine.Amount, '>%1', 0);
                        IF ImprestLine.FINDSET THEN BEGIN
                            REPEAT
                                ImprestSurrenderLine.RESET;
                                ImprestSurrenderLine."Line No." := 0;
                                ImprestSurrenderLine."Document No." := "No.";
                                //ImprestSurrenderLine."Document Type":=ImprestSurrenderLine."Document Type"::"Imprest Surrender";
                                ImprestSurrenderLine."Imprest Code" := ImprestLine."Imprest Code";
                                ImprestSurrenderLine."Imprest Code Description" := ImprestLine."Imprest Code Description";
                                ImprestSurrenderLine."Account Type" := ImprestLine."Account Type";
                                ImprestSurrenderLine."Account No." := ImprestLine."Account No.";
                                ImprestSurrenderLine."Account Name" := ImprestLine."Account Name";
                                ImprestSurrenderLine."Posting Group" := ImprestLine."Posting Group";
                                ImprestSurrenderLine.Description := ImprestLine.Description;
                                ImprestSurrenderLine."Currency Code" := ImprestLine."Currency Code";
                                ImprestSurrenderLine."Amount Advanced" := ImprestLine.Amount;
                                ImprestSurrenderLine."Amount Advanced (LCY)" := ImprestLine."Amount(LCY)";
                                ImprestSurrenderLine."Actual Spent" := ImprestLine.Amount;
                                ImprestSurrenderLine."Actual Spent(LCY)" := ImprestLine."Amount(LCY)";
                                ImprestSurrenderLine."Global Dimension 1 Code" := ImprestLine."Global Dimension 1 Code";
                                ImprestSurrenderLine."Global Dimension 2 Code" := ImprestLine."Global Dimension 2 Code";
                                ImprestSurrenderLine."Shortcut Dimension 3 Code" := ImprestLine."Shortcut Dimension 3 Code";
                                ImprestSurrenderLine."Shortcut Dimension 4 Code" := ImprestLine."Shortcut Dimension 4 Code";
                                ImprestSurrenderLine."Shortcut Dimension 5 Code" := ImprestLine."Shortcut Dimension 5 Code";
                                ImprestSurrenderLine."Shortcut Dimension 6 Code" := ImprestLine."Shortcut Dimension 6 Code";
                                ImprestSurrenderLine."Shortcut Dimension 7 Code" := ImprestLine."Shortcut Dimension 7 Code";
                                ImprestSurrenderLine."Shortcut Dimension 8 Code" := ImprestLine."Shortcut Dimension 8 Code";
                                ImprestSurrenderLine."Responsibility Center" := ImprestLine."Responsibility Center";
                                ImprestSurrenderLine."FA Depreciation Book" := ImprestLine."FA Depreciation Book";
                                ImprestSurrenderLine."Employee No." := ImprestHeader."Employee No.";
                                ImprestSurrenderLine."Employee Name" := ImprestHeader."Employee Name";
                                ImprestSurrenderLine.INSERT;
                            UNTIL ImprestLine.NEXT = 0;
                        END;
                    END;
                END;
            end;
        }
        field(8; "Imprest Date"; Date)
        {
            Caption = 'Imprest Date';
            DataClassification = ToBeClassified;
        }
        field(9; Type; Option)
        {
            Caption = 'Imprest Date';
            DataClassification = ToBeClassified;
            OptionMembers = "",,Imprest,"Petty Cash";
            OptionCaption = ' ,Imprest,Petty Cash';
        }
        field(10; "On Behalf Of"; Text[100])
        {
            Caption = 'On Behalf Of';
            DataClassification = ToBeClassified;
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
            trigger OnValidate()
            begin
                TESTFIELD("Imprest No.");
                TESTFIELD("Posting Date");
                IF "Currency Code" <> '' THEN BEGIN
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                END;
            end;
        }
        field(12; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Imprest Surrender Line"."Amount Advanced" WHERE("Document No." = field("No.")));

        }
        field(14; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Surrender Line"."Amount Advanced (LCY)" WHERE("Document No." = field("No.")));
        }
        field(15; "Actual Spent"; Decimal)
        {
            Caption = 'Actual Spent';
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Surrender Line"."Actual Spent" WHERE("Document No." = FIELD("No.")));
        }
        field(16; "Actual Spent(LCY)"; Decimal)
        {
            Caption = 'Actual Spent(LCY)';
            fieldclass = flowfield;
            CalcFormula = Sum("Imprest Surrender Line"."Actual Spent(LCY)" WHERE("Document No." = FIELD("No.")));
        }
        field(17; "Cash Receipt Amount"; Decimal)
        {
            Caption = 'Cash Receipt Amount';
            DataClassification = ToBeClassified;
        }
        field(18; "Cash Receipt Amount(LCY)"; Decimal)
        {
            Caption = 'Cash Receipt Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(19; Difference; Decimal)
        {
            Caption = 'Difference';
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Surrender Line".Difference WHERE("Document No." = FIELD("No.")));
        }
        field(20; "Difference(LCY)"; Decimal)
        {
            Caption = 'Difference(LCY)';
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Surrender Line"."Difference(LCY)" WHERE("Document No." = FIELD("No.")));
        }
        field(21; "Actual Surrenderd"; Decimal)
        {
            Caption = 'Actual Surrenderd';
            DataClassification = ToBeClassified;
        }
        field(22; "Actual Advanced"; Decimal)
        {
            Caption = 'Actual Advanced';
            DataClassification = ToBeClassified;
        }
        field(23; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Description := UPPERCASE(Description);
            end;
        }
        field(24; "Global Dimension 1 Code"; Code[20])
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
                ImprestSurrenderLine.RESET;
                ImprestSurrenderLine.SETRANGE(ImprestSurrenderLine."Document No.", "No.");
                IF ImprestSurrenderLine.FINDSET THEN BEGIN
                    REPEAT
                        ImprestSurrenderLine."Global Dimension 2 Code" := '';
                        ImprestSurrenderLine."Shortcut Dimension 3 Code" := '';
                        ImprestSurrenderLine."Shortcut Dimension 4 Code" := '';
                        ImprestSurrenderLine."Shortcut Dimension 5 Code" := '';
                        ImprestSurrenderLine."Shortcut Dimension 6 Code" := '';
                        ImprestSurrenderLine."Shortcut Dimension 7 Code" := '';
                        ImprestSurrenderLine."Shortcut Dimension 8 Code" := '';
                        ImprestSurrenderLine.MODIFY;
                    UNTIL ImprestSurrenderLine.NEXT = 0;
                END;
                //End delete the previous dimensions

                ImprestSurrenderLine.RESET;
                ImprestSurrenderLine.SETRANGE(ImprestSurrenderLine."Document No.", "No.");
                IF ImprestSurrenderLine.FINDSET THEN BEGIN
                    REPEAT
                        ImprestSurrenderLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        ImprestSurrenderLine."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        ImprestSurrenderLine.MODIFY;
                    UNTIL ImprestSurrenderLine.NEXT = 0;
                END;
            end;
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
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(32; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(33; "Refund Amount"; Decimal)
        {
            Caption = 'Refund Amount';
            DataClassification = ToBeClassified;
        }
        field(34; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';

            trigger OnValidate()
            begin
                ImprestSurrenderLine.RESET;
                ImprestSurrenderLine.SETRANGE(ImprestSurrenderLine."Document No.", "No.");
                IF ImprestSurrenderLine.FINDSET THEN BEGIN
                    REPEAT
                        ImprestSurrenderLine.Status := Status;
                        ImprestSurrenderLine.MODIFY;
                    UNTIL ImprestSurrenderLine.NEXT = 0;
                END;
            end;
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
        field(44; "Petty Cash No."; Code[30])
        {
            Caption = 'Petty Cash No.';
            DataClassification = ToBeClassified;
        }
        field(45; "Petty Cash"; Boolean)
        {
            Caption = 'Petty Cash';
            DataClassification = ToBeClassified;
        }
        field(46; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                // Employee.RESET;
                // Employee.SETRANGE(Employee."User ID", "User ID");
                // IF Employee.FINDFIRST THEN BEGIN
                //     Employee.TESTFIELD(Employee."Global Dimension 1 Code");
                //     Employee.TESTFIELD(Employee."Global Dimension 2 Code");
                //     "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                //     "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                //     "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                //     "Shortcut Dimension 5 Code" := Employee."Shortcut Dimension 5 Code";
                //     "Shortcut Dimension 6 Code" := Employee."Shortcut Dimension 6 Code";
                //     "Shortcut Dimension 7 Code" := Employee."Shortcut Dimension 7 Code";
                //     "Shortcut Dimension 8 Code" := Employee."Shortcut Dimension 8 Code";
                // END;
            end;
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
        field(50; "HR Employee No."; Code[30])
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
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderLine: Record "Imprest Surrender Line";
        CurrExchRate: Record "Currency Exchange Rate";

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            FundsSetup.GET;
            FundsSetup.TESTFIELD(FundsSetup."Imprest Surrender Nos.");
            "No. Series" := FundsSetup."Imprest Surrender Nos.";
            if NoSeriesMgt.AreRelated(FundsSetup."Imprest Surrender Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;
        "Document Type" := "Document Type"::"Imprest Surrender";
        "Document Date" := TODAY;
        "Posting Date" := Today;
        "User ID" := USERID;
        VALIDATE("User ID");
        Status := Status::Open;
    end;

    trigger OnDelete()
    begin
        ImprestSurrenderLine.RESET;
        ImprestSurrenderLine.SETRANGE("Document No.", "No.");
        IF ImprestSurrenderLine.FINDSET THEN
            ImprestSurrenderLine.DELETEALL;
    end;

}
