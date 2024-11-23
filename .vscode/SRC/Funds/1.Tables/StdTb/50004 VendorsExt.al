tableextension 50004 "Vendors Ext" extends Vendor
{
    fields
    {
        field(70000; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Code"."Bank Code";
            trigger OnValidate()
            begin
                "Bank Name" := '';
                BankCodes.RESET;
                BankCodes.SETRANGE(BankCodes."Bank Code", "Bank Code");
                IF BankCodes.FINDFIRST THEN BEGIN
                    BankCodes.TESTFIELD(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                END;
            end;
        }
        field(70001; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70002; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branch"."Bank Branch Code";
            trigger OnValidate()
            begin
                "Bank Branch Name" := '';
                BankBranches.RESET;
                BankBranches.SETRANGE(BankBranches."Bank Code", "Bank Code");
                BankBranches.SETRANGE(BankBranches."Bank Branch Code", "Bank Branch Code");
                IF BankBranches.FINDFIRST THEN BEGIN
                    BankBranches.TESTFIELD(BankBranches."Bank Branch Name");
                    "Bank Branch Name" := BankBranches."Bank Branch Name";
                END;
            end;

        }
        field(70003; "Bank Branch Name"; Text[100])
        {
            Caption = 'Bank Branch Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70004; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(70005; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(70006; "MPESA/Paybill Account No."; Text[30])
        {
            Caption = 'MPESA/Paybill Account No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(70008; "Vendor Creation Date"; Date)
        {
            Caption = 'Vendor Creation Date';
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(70009; "VAT Registered"; Boolean)
        {
            Caption = 'VAT Registered';
            DataClassification = ToBeClassified;
        }
        field(70010; "VAT Registration Nos."; Code[30])
        {
            Caption = 'VAT Registration Nos.';
            DataClassification = ToBeClassified;
        }
        field(70011; "Date of Incorporation"; Date)
        {
            Caption = 'Date of Incorporation';
            DataClassification = ToBeClassified;
        }
        field(70012; "Incorporation Certificate No."; Code[30])
        {
            Caption = 'Incorporation Certificate No.';
            DataClassification = ToBeClassified;
        }
        field(70013; AGPO; Option)
        {
            Caption = 'AGPO';
            OptionMembers = "N/A",Youth,Women,PWD;
            OptionCaption = 'N/A,Youth,Women,PWD';
        }
        field(70014; Building; Text[50])
        {
            Caption = 'Building';
            DataClassification = ToBeClassified;
        }
        field(70015; "County Code"; Code[30])
        {
            Caption = 'County Code';
            DataClassification = ToBeClassified;
        }
        field(70016; "County Name"; Text[80])
        {
            Caption = 'County Name';
            DataClassification = ToBeClassified;
        }
        field(70017; Street; Text[50])
        {
            Caption = 'Street';
            DataClassification = ToBeClassified;
        }
        field(70018; "Supplier Category Code"; Code[20])
        {
            Caption = 'Supplier Category Code';
            DataClassification = ToBeClassified;
        }
        field(70027; "Old Account No."; Code[30])
        {
            Caption = 'Old Account No.';
            DataClassification = ToBeClassified;
        }
        field(70028; "Pre-Qualified"; Boolean)
        {
            Caption = 'Pre-Qualified';
            DataClassification = ToBeClassified;
        }
        field(70029; "Principal Phone No."; Text[30])
        {
            Caption = 'Principal Contact Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(70030; "Reason for Blacklisting"; Text[2000])
        {
            Caption = 'Reason for Blacklisting comments';
            DataClassification = ToBeClassified;

        }
        field(70031; " TIN No."; Code[50])
        {
            Caption = ' TIN No.';
            DataClassification = ToBeClassified;

        }
        field(70032; "Swift Code"; Code[50])
        {
            Caption = 'Swift Code';
            DataClassification = ToBeClassified;

        }


    }
    var
        BankCodes: Record "Bank Code";
        BankBranches: Record "Bank Branch";

    trigger OnAfterInsert()
    begin

        "Created By" := UserId;
        "Vendor Creation Date" := Today;

    end;
}
