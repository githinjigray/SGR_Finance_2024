table 70018 "Purchase Requisition Codes"
{
    Caption = 'Purchase Requisition Codes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Requisition Type"; Enum "Requisition Types")
        {
            Caption = 'Requisition Type';
            DataClassification = ToBeClassified;
        }
        field(2; "Requisition Code"; Code[20])
        {
            Caption = 'Requisition Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Enum "Purchase Line Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"."No." WHERE("Direct Posting" = CONST(true));
            trigger OnValidate()
            begin
                Name := '';
                IF Type = Type::"G/L Account" THEN BEGIN
                    GLAccount.RESET;
                    IF GLAccount.GET("No.") THEN BEGIN
                        Name := GLAccount.Name;
                    END;
                END;
            end;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Requisition Type", "Requisition Code")
        {
            Clustered = true;
        }
    }
    var
        GLAccount: Record "G/L Account";
}
