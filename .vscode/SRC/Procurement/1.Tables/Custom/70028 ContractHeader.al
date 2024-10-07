table 70028 "Contract Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Customer,Vendor,Employee';
            OptionMembers = " ",Customer,Vendor,Employee;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = IF ("Account Type" = CONST(Employee)) Employee
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer;

            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::Customer then begin
                    if Cust.Get("Account No.") then begin
                        Name := Cust.Name;
                        Address := Cust.Address;
                        City := Cust.City;
                    end;
                end;

                if "Account Type" = "Account Type"::Vendor then begin
                    if Vendors.Get("Account No.") then begin
                        Name := Vendors.Name;
                        Address := Vendors.Address;
                        City := Vendors.City;
                    end;
                end;

                if "Account Type" = "Account Type"::Employee then begin
                    if Employee.Get("Account No.") then begin
                        Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        Address := Employee.Address;
                        City := Employee.City;
                    end;
                end;
            end;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
            end;
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(12; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
            DataClassification = ToBeClassified;
        }
        field(13; "Commencement Date"; Date)
        {
            Caption = 'Commencement Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // Duration := Dates.DetermineAge("Commencement Date", "Expiry Date");
            end;
        }
        field(14; "Expiry Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // Duration := Dates.DetermineAge("Commencement Date", "Expiry Date");
            end;
        }
        field(15; Duration; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(17; Comment; Boolean)
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Contract Status"; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Draft,Under Legal,Active,Pending,Terminated,Archived';
            OptionMembers = Draft,"Under Legal",Active,Pending,Terminated,Archived;

            trigger OnValidate()
            var
                ServLedgEntry: Record "Service Ledger Entry";
                AnyServItemInOtherContract: Boolean;
            begin
            end;
        }
        field(19; "Change Status"; Option)
        {
            Caption = 'Change Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Locked';
            OptionMembers = Open,Locked;
        }
        field(20; "Responsible Person"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Contract,MOU,Addendum';
            OptionMembers = " ",Contract,MOU,Addendum;
        }
        field(22; "Expiry Notification Period"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(51; "Global Dimension 1 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 1 Code"),
                                                               "Global Dimension No." = CONST(1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(53; "Global Dimension 2 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 2 Code"),
                                                               "Global Dimension No." = CONST(2)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(199; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(201; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(202; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(203; "Approval Comment"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(204; "Rejected By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(205; "Rejected DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(299; "Incoming Document Entry No."; Integer)
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
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GeneralSetup.Get;
            GeneralSetup.TestField(GeneralSetup."Contract Request Nos");
            NoSeriesMgt.GetNextNo(GeneralSetup."Contract Request Nos", Today, false);
        end;

        "Document Date" := Today;
        "Created By" := UserId;
        "Created DateTime" := CurrentDateTime;
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        GeneralSetup: Record "Purchases & Payables Setup";
        Cust: Record Customer;
        Vendors: Record Vendor;
        Employee: Record Employee;
    // Dates: Codeunit Dates;
}

