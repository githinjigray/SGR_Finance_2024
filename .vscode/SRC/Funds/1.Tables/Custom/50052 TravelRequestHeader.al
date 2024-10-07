table 50052 "Travel Request Header"
{
    Caption = 'Travel Request Header';

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
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
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

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(5; "Payment Mode"; Option)
        {
            Caption = 'Payment Mode';
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = ' ,Cheque,EFT,RTGS,MPESA,Cash';
            OptionMembers = " ",Cheque,EFT,RTGS,MPESA,Cash;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(6; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Normal,Petty Cash,Express,Cash Purchase,Mobile';
            OptionMembers = Normal,"Petty Cash",Express,"Cash Purchase",Mobile;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(7; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                BankAccount.Reset;
                BankAccount.SetRange("No.", "Bank Account No.");
                if BankAccount.FindFirst then begin
                    "Bank Account Name" := BankAccount.Name;
                    "Currency Code" := BankAccount."Currency Code";
                    Validate("Currency Code");
                end;
            end;
        }
        field(8; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Bank Account Balance"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No.")));
            Caption = 'Bank Account Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cheque Type"; Option)
        {
            Caption = 'Cheque Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Computer Cheque,Manual Cheque';
            OptionMembers = " ","Computer Cheque","Manual Cheque";

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(11; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                ImprestHeader.Reset;
                ImprestHeader.SetRange(ImprestHeader."Reference No.", "Reference No.");
                if ImprestHeader.FindSet then begin
                    repeat
                        if ImprestHeader."No." <> "No." then
                            Error("ErrorUsedReferenceNo.", ImprestHeader."No.");
                    until ImprestHeader.Next = 0;
                end;
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
                TestStatusOpen(true);

                if "Currency Code" <> '' then begin
                    if BankAccount.Get("Bank Account No.") then begin
                        BankAccount.TestField(BankAccount."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    end;
                end else begin
                    if BankAccount.Get("Bank Account No.") then begin
                        BankAccount.TestField(BankAccount."Currency Code", '');
                    end;
                end;
            end;
        }
        field(17; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
        }
        field(18; Amount; Decimal)
        {
            CalcFormula = Sum("Travel Request Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Travel Request Line"."Amount(LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Imprest Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Imprest Remaining Amount(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Date From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Imprest,Petty Cash,Funds Claim';
            OptionMembers = " ",Imprest,"Petty Cash","Funds Claim";
        }
        field(40; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Account Type" = CONST(Employee));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);

                Employee.Reset;

                "Employee Name" := '';
                "Employee Posting Group" := '';
                Employee.Reset;
                Employee.SetRange(Employee."No.", "Employee No.");
                if Employee.FindFirst then begin
                    "Employee Name" := Employee.Name;
                    "HR Employee No." := Employee."No.";
                    //  Employee.TESTFIELD(Employee."Customer Posting Group");
                    "Employee Posting Group" := Employee."Customer Posting Group";
                    //"HR Job Grade":=Employee."Job Grade";
                    "Phone No." := Employee."Phone No.";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    // "Shortcut Dimension 3 Code":=Employee."Shortcut Dimension 3 Code";
                    "Responsibility Center" := Employee."Responsibility Center";
                    // "HR Employee No." := "Employee No.";
                end;
            end;
        }
        field(41; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; "Employee Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Employee Posting Group".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(43; Surrendered; Boolean)
        {
            Caption = 'Surrendered';
            DataClassification = ToBeClassified;
        }
        field(44; "Imprest Surrender No."; Code[20])
        {
            Caption = 'Imprest Surrender No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Imprest Surrender Header"."No.";
        }
        field(49; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Description := UpperCase(Description);
            end;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Delete the previous dimensions
                //"Global Dimension 2 Code":='';
                //"Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';

                ImprestLine.Reset;
                ImprestLine.SetRange(ImprestLine."Document No.", "No.");
                if ImprestLine.FindSet then begin
                    repeat
                        // ImprestLine."Global Dimension 2 Code":='';
                        //ImprestLine."Shortcut Dimension 3 Code":='';
                        ImprestLine."Shortcut Dimension 4 Code" := '';
                        ImprestLine."Shortcut Dimension 5 Code" := '';
                        ImprestLine."Shortcut Dimension 6 Code" := '';
                        ImprestLine."Shortcut Dimension 7 Code" := '';
                        ImprestLine."Shortcut Dimension 8 Code" := '';
                        ImprestLine.Modify;
                    until ImprestLine.Next = 0;
                end;
                //End delete the previous dimensions

                ImprestLine.Reset;
                ImprestLine.SetRange(ImprestLine."Document No.", "No.");
                if ImprestLine.FindSet then begin
                    repeat
                        ImprestLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        ImprestLine.Modify;
                    until ImprestLine.Next = 0;
                end;
            end;
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Responsibility Center".Code;
        }
        field(59; "Surrender status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Not Surrendered,Partially Surrendered,Fully surrendered';
            OptionMembers = "Not Surrendered","Partially Surrendered","Fully surrendered";
        }
        field(60; "Depature Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Return Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(62; Destination; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(72; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(75; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(76; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(78; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80; "Reversal Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(81; Reimbursed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Reimbursment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Reimbursement No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(84; "CPV No."; Code[30])
        {
            CalcFormula = Lookup("Payment Line"."Document No." WHERE("Payee No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Payment Header"."No." WHERE("No." = FIELD("CPV No."));
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                // UserSetup.Reset;
                // UserSetup.SetRange(UserSetup."User ID", "User ID");
                // if UserSetup.FindFirst then begin
                //     // UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
                //     // UserSetup.TESTFIELD(UserSetup."Global Dimension 2 Code");
                //     "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                //     /*  "Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
                //       "Shortcut Dimension 4 Code":=UserSetup."Shortcut Dimension 4 Code";
                //       "Shortcut Dimension 5 Code":=UserSetup."Shortcut Dimension 5 Code";
                //       "Shortcut Dimension 6 Code":=UserSetup."Shortcut Dimension 6 Code";
                //       "Shortcut Dimension 7 Code":=UserSetup."Shortcut Dimension 7 Code";
                //       "Shortcut Dimension 8 Code":=UserSetup."Shortcut Dimension 8 Code";*/
                //     "Responsibility Center" := UserSetup."Responsibility Center";
                //     "Employee No." := UserSetup."No.";
                //     Validate("Employee No.");
                // end;

            end;
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(101; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(105; "HR Job Grade"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(106; "HR Employee No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Employee No.", "Employee Name", Description)
        {
        }
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", "No.");
        if ImprestLine.FindSet then
            ImprestLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            FundsSetup.Get;
            FundsSetup.TestField(FundsSetup."Travel Request No.");
            NoSeriesMgt.GetNextNo(FundsSetup."Travel Request No.", Today, false);
        end;

        "Document Type" := "Document Type"::Imprest;
        "Document Date" := Today;
        "User ID" := UserId;
        "Posting Date" := Today;
        Validate("User ID");
        Type := Type::Imprest;
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        Employee: Record Customer;
        "ErrorUsedReferenceNo.": Label 'The Reference Number has been used in Document No:%1';
        HumanResourcesSetup: Record "Human Resources Setup";
        UserSetup: Record Employee;

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if ImprestHeader.Get("No.") then begin
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
    end;
}

