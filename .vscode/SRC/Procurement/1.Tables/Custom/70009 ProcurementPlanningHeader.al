table 70009 "Procurement Planning Header"
{
    Caption = 'Procurement Planning Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(11; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Financial Year"; Text[100])
        {
            Caption = 'Financial Year';
            DataClassification = ToBeClassified;
        }
        field(25; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(26; Budget; Code[10])
        {
            Caption = 'Budget';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(27; "Budget Description"; Text[50])
        {
            Caption = 'Budget Description';
            DataClassification = ToBeClassified;
        }
        field(28; "Procurement Plan No."; Code[30])
        {
            Caption = 'Procurement Plan No.';
            DataClassification = ToBeClassified;
        }
        field(30; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(31; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(32; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;
        }
        field(33; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
        }
        field(34; "G/L Budget Line A/C"; Code[30])
        {
            Caption = 'G/L Budget Line A/C';
            DataClassification = ToBeClassified;
        }
        field(35; "Budget Amount"; Decimal)
        {
            Caption = 'Budget Amount';
            DataClassification = ToBeClassified;
        }
        field(40; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(41; "Procurement Plan Type"; Option)
        {
            Caption = 'Procurement Plan Type';
            OptionMembers = Items,Service,"Fixed Asset";
            OptionCaption = 'Items,Service,Fixed Asset';
            DataClassification = ToBeClassified;
        }
        field(42; "Procurement Plan GrouTINg"; Code[30])
        {
            Caption = 'Procurement Plan GrouTINg';
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
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
    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PurchSetup.GET();
            PurchSetup.TESTFIELD(PurchSetup."Procurement Plan Nos");
            "No. Series" := PurchSetup."Procurement Plan Nos";
            if NoSeriesMgt.AreRelated(PurchSetup."Procurement Plan Nos", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;
        "Document Date" := Today;
        "User ID" := UserId;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";//
}
