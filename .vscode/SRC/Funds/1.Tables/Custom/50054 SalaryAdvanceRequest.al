table 50054 "Salary Advance Request"
{
    Caption = 'Salary Advance Request';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
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
        field(5; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                if "Currency Code" <> '' then begin
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                end else begin

                end;
            end;
        }
        field(6; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                "Amount(LCY)" := Amount;


                //IF "Repayment Amount"<>0 THEN
                "Repayment Amount" := Amount / "Period to Repay";
            end;
        }
        field(8; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
        }
        field(9; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Employee.Reset;

                "Employee Name" := '';
                "Employee Posting Group" := '';
                Employee.Reset;
                Employee.SetRange(Employee."No.", "Employee No.");
                // if Employee.FindFirst then begin
                //     "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //     "Employee Posting Group" := Employee."Employee Posting Group";
                //     "HR Job Grade" := Employee."Job Grade";
                //     "Phone No." := Employee."Phone No.";
                //     "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                //     "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                //     "Responsibility Center" := Employee."Responsibility Center";
                // end;
            end;
        }
        field(10; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Employee Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Employee Posting Group".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(12; Surrendered; Boolean)
        {
            Caption = 'Surrendered';
            DataClassification = ToBeClassified;
        }
        field(13; "Imprest Surrender No."; Code[20])
        {
            Caption = 'Imprest Surrender No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Imprest Surrender Header"."No.";
        }
        field(14; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Description := UpperCase(Description);
            end;
        }
        field(15; "Period to Repay"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(16; "Repayment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
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
                //     "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                //     "Shortcut Dimension 3 Code" := UserSetup."Shortcut Dimension 3 Code";
                //     "Shortcut Dimension 4 Code" := UserSetup."Shortcut Dimension 4 Code";
                //     "Shortcut Dimension 5 Code" := UserSetup."Shortcut Dimension 5 Code";
                //     "Shortcut Dimension 6 Code" := UserSetup."Shortcut Dimension 6 Code";
                //     "Shortcut Dimension 7 Code" := UserSetup."Shortcut Dimension 7 Code";
                //     "Shortcut Dimension 8 Code" := UserSetup."Shortcut Dimension 8 Code";
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
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "No.", Field40, Field41, Field49)
    //     {
    //     }
    // }

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
            FundsSetup.TestField(FundsSetup."Travel Advance Nos.");
            NoSeriesMgt.GetNextNo(FundsSetup."Travel Advance Nos.", Today, false);
        end;


        "Document Date" := Today;
        "User ID" := UserId;
        "Posting Date" := Today;
        Validate("User ID");
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
        Employee: Record Employee;
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

