table 50051 "Bank Branch"
{
    Caption = 'Bank Branch';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Code"."Bank Code";
            trigger OnValidate()
            begin
                "Bank Name" := '';
                BankCodesList.Reset();
                BankCodesList.SetRange("Bank Code", "Bank Code");
                if BankCodesList.FindFirst() then begin
                    "Bank Name" := BankCodesList."Bank Name";
                end;
            end;
        }
        field(2; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Bank Branch Name"; Text[100])
        {
            Caption = 'Bank Branch Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Branch Physical Location"; Text[100])
        {
            Caption = 'Branch Physical Location';
            DataClassification = ToBeClassified;
        }
        field(6; "Branch Postal Code"; Code[20])
        {
            Caption = 'Branch Postal Code';
            DataClassification = ToBeClassified;
        }
        field(7; "Branch Address"; Text[50])
        {
            Caption = 'Branch Address';
            DataClassification = ToBeClassified;
        }
        field(8; "Branch Phone No."; Code[50])
        {
            Caption = 'Branch Phone No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Branch Mobile No."; Code[50])
        {
            Caption = 'Branch Mobile No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Branch Email Address"; Text[100])
        {
            Caption = 'Branch Email Address';
            DataClassification = ToBeClassified;
        }
        field(11; Bank; Text[30])
        {
            Caption = 'Bank';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Bank Branch Code", "Bank Code")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Bank Name", "Bank Branch Code", "Bank Branch Name")
        {

        }
    }
    var
        BankCodesList: Record "Bank Code";
}
