table 50023 "Journal Voucher Header"
{
    Caption = 'Journal Voucher Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "JV No."; Code[30])
        {
            Caption = 'JV No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document date"; Date)
        {
            Caption = 'Document date';
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
        }
        field(7; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; "JV Lines Cont"; Integer)
        {

            Caption = 'JV Lines Cont';
            FieldClass = FlowField;
            CalcFormula = count("Journal Voucher Lines" WHERE("JV No." = FIELD("JV No.")));
        }
        field(9; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Journal Voucher Lines"."Amount (LCY)" WHERE("Amount (LCY)" = FILTER(<> 0), "JV No." = FIELD("JV No.")));
        }
        field(10; "Total Debits"; Decimal)
        {
            Caption = 'Total Debits';
            FieldClass = FlowField;
            CalcFormula = Sum("Journal Voucher Lines".Amount WHERE(Amount = FILTER(> 0), "JV No." = FIELD("JV No.")));
        }
        field(11; "Total Credits"; Decimal)
        {
            Caption = 'Total Credits';
            FieldClass = FlowField;
            CalcFormula = Sum("Journal Voucher Lines".Amount WHERE(Amount = FILTER(< 0), "JV No." = FIELD("JV No.")));
        }
        field(12; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(13; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(14; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(15; "Posted By"; Code[30])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
        }
        field(16; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(17; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
        }
        field(18; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
        }
        field(19; "Reversed By"; Code[30])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
        }
        field(31; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(32; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(33; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
        }
        field(34; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(35; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
        }
        field(36; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(40; "New Journal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Journal Date';
        }
    }
    keys
    {
        key(PK; "JV No.")
        {
            Clustered = true;
        }
    }

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        FundsUserSetup: Record "Funds User Setup";
        //FundsManagement: Codeunit "Funds Management";
        JTemplate: Code[30];
        JBatch: Code[30];

    trigger OnInsert()
    begin
        IF "JV No." = '' THEN BEGIN
            FundsSetup.GET;
            FundsSetup.TESTFIELD(FundsSetup."JV Nos.");
            NoSeriesMgt.GetNextNo(FundsSetup."JV Nos.", Today, false);
        END;

        "Document date" := TODAY;
        "User ID" := USERID;
        "Posting Date" := TODAY;
        VALIDATE("User ID");
        Status := Status::Open;
    end;
}
