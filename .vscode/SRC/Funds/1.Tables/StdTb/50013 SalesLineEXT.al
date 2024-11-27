tableextension 50013 "Sales Line EXT" extends "Sales Line"
{
    fields
    {
        field(70000; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70001; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70002; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70003; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70004; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(70005; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
        }
        field(70006; "Service Code"; Code[50])
        {
            Caption = 'Service Code';
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Code"."Transaction Code" where("Transaction Type" = const("service code"));
            trigger OnValidate()
            var
                FundsTransaction: Record "Funds Transaction Code";
            begin
                FundsTransaction.Reset();
                FundsTransaction.SetRange("Transaction Code", "Service Code");
                if FundsTransaction.FindFirst() then begin

                    Type := Type::"G/L Account";
                    Validate(Type);
                    "No." := FundsTransaction."Account No.";
                    Validate("No.");
                    "Unit of Measure" := FundsTransaction."Unit of Measure";
                    Quantity := FundsTransaction.Quantity;
                    Validate(Quantity);
                    "Unit Price" := FundsTransaction."Unit Rate";
                    Validate("Unit Price");
                    "Service Code" := FundsTransaction."Transaction Code";
                    "Service Description" := FundsTransaction.Description;
                    Description := FundsTransaction.Description;
                    if type = Type::"G/L Account" then begin
                        "Gen. Prod. Posting Group" := 'GENERAL';
                    end;
                end;
            end;
        }
        field(70007; "Service Description"; text[250])
        {
            Caption = 'Service Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70010; "Date Of Flight"; Date)
        {
            Caption = 'Date Of Flight';
            DataClassification = ToBeClassified;
        }
        field(70050; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70051; "Alternative Part No. 1"; Code[50])
        {
            Caption = 'Alternative Part No. 1';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70052; "Alternative Part No. 2"; Code[50])
        {
            Caption = 'Alternative Part No. 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70053; "Alternative Part No. 3"; Code[50])
        {
            Caption = 'Serial Number';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70054; "Alternative Part No. 4"; Decimal)
        {
            Caption = 'Total Cost Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
    }
}
