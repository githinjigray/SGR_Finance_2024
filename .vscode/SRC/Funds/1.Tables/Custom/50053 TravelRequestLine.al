table 50053 "Travel Request Line"
{
    Caption = 'Travel Request Line';

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            TableRelation = "Travel Request Header"."No.";
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(4; "Transaction Code"; Code[50])
        {
            Caption = 'Transaction Code';
            TableRelation = IF (Type = CONST(Imprest)) "Funds Transaction Code"."Transaction Code" WHERE("Transaction Type" = CONST(Imprest))
            ELSE
            IF (Type = CONST("Purchase Requisition")) "Purchase Requisition Codes"."Requisition Code" WHERE("Requisition Type" = CONST(Service));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);

                "Account Type" := "Account Type"::"G/L Account";
                "Account No." := '';
                "Posting Group" := '';
                "Code Description" := '';

                if Type = Type::Imprest then begin
                    FundsTransactionCodes.Reset;
                    FundsTransactionCodes.SetRange(FundsTransactionCodes."Transaction Code", "Transaction Code");
                    if FundsTransactionCodes.FindFirst then begin
                        "Account Type" := FundsTransactionCodes."Account Type";
                        "Account No." := FundsTransactionCodes."Account No.";
                        "Posting Group" := FundsTransactionCodes."Posting Group";
                        "Code Description" := FundsTransactionCodes.Description;
                    end;
                end;

                if Type = Type::"Purchase Requisition" then begin
                    PurchaseRequisitionCodes.Reset;
                    PurchaseRequisitionCodes.SetRange(PurchaseRequisitionCodes."Requisition Code", "Transaction Code");
                    if PurchaseRequisitionCodes.FindFirst then begin
                        "Account Type" := "Account Type"::"G/L Account";
                        "Account No." := PurchaseRequisitionCodes."No.";
                        "Code Description" := FundsTransactionCodes.Description;
                    end;
                end;

                Validate("Account No.");
            end;
        }
        field(5; "Code Description"; Text[100])
        {
            Caption = 'Code Description';
            Editable = false;
        }
        field(6; "Account Type"; Enum "Account Type")
        {
            Caption = 'Account Type';
            Editable = false;
            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(7; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No." WHERE("Direct Posting" = CONST(true))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor."No."
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee."No.";

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);

                "Account Name" := '';
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    if "G/LAccount".Get("Account No.") then begin
                        "Account Name" := "G/LAccount".Name;
                    end;
                end;

                if "Account Type" = "Account Type"::Customer then begin
                    if Customer.Get("Account No.") then begin
                        "Account Name" := Customer.Name;
                    end;
                end;

                if "Account Type" = "Account Type"::Vendor then begin
                    if Vendor.Get("Account No.") then begin
                        "Account Name" := Vendor.Name;
                    end;
                end;

                if "Account Type" = "Account Type"::Employee then begin
                    if Employee.Get("Account No.") then begin
                        "Account Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    end;
                end;


                if "Account Type" = "Account Type"::"Fixed Asset" then begin
                    if FixedAsset.Get("Account No.") then begin
                        "Account Name" := FixedAsset.Description;
                    end;
                    DepreciationBook.Reset;
                    DepreciationBook.SetRange(DepreciationBook."FA No.", "Account No.");
                    if DepreciationBook.FindFirst then begin
                        "FA Depreciation Book" := DepreciationBook."Depreciation Book Code";
                    end;
                end;
            end;
        }
        field(8; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(9; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group".Code
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group".Code
            ELSE
            IF ("Account Type" = CONST(Employee)) "Employee Posting Group".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(20; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Imprest Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
            Caption = 'Posting Date';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Validate(Amount);
            end;
        }
        field(21; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(22; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(23; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
                if "Currency Code" <> '' then begin
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                end;

                if "Currency Code" <> '' then begin
                    "Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                end else begin
                    "Amount(LCY)" := Amount;
                end;
            end;
        }
        field(24; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(39; "Budget Committed"; Boolean)
        {
            Caption = 'Committed';
        }
        field(40; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
        }
        field(41; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted,Reversed;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(72; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
        field(79; "FA Depreciation Book"; Code[30])
        {
        }
        field(80; "Expense Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                "Expense Acc. Name" := '';
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    if "G/LAccount".Get("Expense Account No.") then begin
                        "Expense Acc. Name" := "G/LAccount".Name;
                    end;
                end;
            end;
        }
        field(81; "Expense Acc. Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(100; "Activity Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Transaction Code" := '';
                "Code Description" := '';
                Amount := 0;
                "Amount(LCY)" := 0;
                "From City" := '';
                "To City" := '';
                City := '';
                "Account No." := '';
                "Account Name" := '';
            end;
        }
        field(101; "From City"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "To City"; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount := 0;
                "Amount(LCY)" := 0;

                TestField("From City");
                if "To City" = "From City" then begin
                    Error(Error001);
                end;

                AlowanceMatrix.Reset;
                AlowanceMatrix.SetRange(AlowanceMatrix."Allowance Code", "Transaction Code");
                AlowanceMatrix.SetRange(AlowanceMatrix."Job Group", "HR Job Grade");
                AlowanceMatrix.SetRange(AlowanceMatrix."Traveling From", "From City");
                AlowanceMatrix.SetRange(AlowanceMatrix."Traveling To", "To City");
                if AlowanceMatrix.FindFirst then begin
                    Amount := AlowanceMatrix.Amount;
                    Validate(Amount);
                end;
            end;
        }
        field(103; "HR Job Grade"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(104; City; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Imprest Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,DSA';
            OptionMembers = Normal,DSA;
        }
        field(106; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(107; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Imprest,Purchase Requisition';
            OptionMembers = " ",Imprest,"Purchase Requisition";
        }
        field(108; Days; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestStatusOpen(true);
    end;

    trigger OnInsert()
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", "Document No.");
        if ImprestHeader.FindFirst then begin
            Description := ImprestHeader.Description;
            "Document Type" := "Document Type"::Imprest;
            "Posting Date" := ImprestHeader."Posting Date";
            "Currency Code" := ImprestHeader."Currency Code";
            // "Currency Factor":=ImprestHeader."Currency Factor";
            "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := ImprestHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := ImprestHeader."Shortcut Dimension 6 Code";
            "Shortcut Dimension 7 Code" := ImprestHeader."Shortcut Dimension 7 Code";
            "Shortcut Dimension 8 Code" := ImprestHeader."Shortcut Dimension 8 Code";
            "HR Job Grade" := ImprestHeader."HR Job Grade";
            "Employee No" := ImprestHeader."Employee No.";
        end;
    end;

    var
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        DepreciationBook: Record "FA Depreciation Book";
        AlowanceMatrix: Record "Allowance Matrix";
        //CityCodes: Record "HR Job Lookup Value";
        Error001: Label 'To City should be different From city';
        Error002: Label 'Imprest code exists for this date. Cannot be twice on the same day';
        CurrencyFactor: Decimal;
        txt1: Label 'error %1';
        PurchaseRequisitionCodes: Record "Purchase Requisition Codes";

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestHeader.Get("Document No.");
        if AllowApproverEdit then begin
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", ImprestHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            ApprovalEntry.SetRange(ApprovalEntry."Approver ID", UserId);
            if not ApprovalEntry.FindFirst then begin
                ImprestHeader.TestField(Status, ImprestHeader.Status::Open);
            end;
        end else begin
            ImprestHeader.TestField(Status, ImprestHeader.Status::Open);
        end;
    end;
}

