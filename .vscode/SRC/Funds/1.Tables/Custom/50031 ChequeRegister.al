table 50031 "Cheque Register"
{
    Caption = 'Cheque Register';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Bank Account"; Code[10])
        {
            Caption = 'Bank Account';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
            begin
                if "Bank Account" <> '' then begin
                    BankAccount.Get("Bank Account");
                    "Bank Account Name" := BankAccount."Name";
                end else
                    "Bank Account Name" := '';
            end;
        }
        field(4; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Last Cheque No."; Code[10])
        {
            Caption = 'Last Cheque No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Cheque Book Number"; Code[30])
        {
            Caption = 'Cheque Book Number';
            DataClassification = ToBeClassified;
        }
        field(7; "No of Leaves"; Integer)
        {
            Caption = 'No of Leaves';
            DataClassification = ToBeClassified;
        }
        field(8; "Cheque Number From"; Code[10])
        {
            Caption = 'Cheque Number From';
            DataClassification = ToBeClassified;
        }
        field(9; "Cheque Number To."; Code[10])
        {
            Caption = 'Cheque Number To.';
            DataClassification = ToBeClassified;
        }
        field(10; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(13; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(14; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Balance; Decimal)
        {
            Caption = 'Balance';
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account")));
            editable = false;
        }
        field(16; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Cheque Register Lines"."Total Amount" where("Document No." = field("No.")));
            editable = false;
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
        if "No." = '' then begin
            FundsGeneralSetup.get;
            FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Cheque Register No.");
            "No. Series" := FundsGeneralSetup."Cheque Register No.";
            if NoSeriesMgt.AreRelated(FundsGeneralSetup."Cheque Register No.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
        "Document Date" := Today;
        "User ID" := UserId;
        Validate("User ID");
        Status := Status::Open;
    end;

    var
        FundsGeneralSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
