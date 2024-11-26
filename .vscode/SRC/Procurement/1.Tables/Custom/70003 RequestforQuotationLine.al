table 70003 "Request for Quotation Line"
{
    Caption = 'Request for Quotation Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "Requisition Type"; Option)
        {
            Caption = 'Requisition Type';
            OptionMembers = Service,Item,"Fixed Asset";
            OptionCaption = 'Service,Item,Fixed Asset';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Requisition Code" := '';
                Description := '';
                "Location Code" := '';
                Quantity := 0;
                "Market Price" := 0;
                "Unit Cost" := 0;
                "Unit Cost(LCY)" := 0;
                //"Unit of Measure":='';
                "Global Dimension 1 Code" := '';
                "Global Dimension 2 Code" := '';
                "Shortcut Dimension 3 Code" := '';
                "Shortcut Dimension 4 Code" := '';
                "Shortcut Dimension 5 Code" := '';
                "Shortcut Dimension 6 Code" := '';
                "Shortcut Dimension 7 Code" := '';
                "Shortcut Dimension 8 Code" := '';
                "Total Cost" := 0;
                "Total Cost(LCY)" := 0;
            end;
        }
        field(5; "Requisition Code"; Code[20])
        {
            Caption = 'Requisition Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Requisition Type" = CONST(Service)) "Purchase Requisition Codes"."Requisition Code" WHERE("Requisition Type" = CONST(Service))
            ELSE
            IF ("Requisition Type" = CONST("Fixed Asset")) "Fixed Asset"."No."
            ELSE
            IF ("Requisition Type" = CONST(Item)) Item."No.";
            trigger OnValidate()
            begin
                IF ("Requisition Type" = "Requisition Type"::Service) THEN BEGIN
                    IF RequisitionCodes.GET("Requisition Type", "Requisition Code") THEN BEGIN
                        Type := RequisitionCodes.Type;
                        "No." := RequisitionCodes."No.";
                        VALIDATE("No.");
                    END;
                END;

                IF ("Requisition Type" = "Requisition Type"::Item) THEN BEGIN
                    Item.RESET;
                    Item.SETRANGE(Item."No.", "Requisition Code");
                    IF Item.FINDFIRST THEN BEGIN
                        Type := Type::Item;
                        "No." := "Requisition Code";
                        VALIDATE("No.");
                    END;
                END;

                IF ("Requisition Type" = "Requisition Type"::"Fixed Asset") THEN BEGIN
                    FixedAsset.RESET;
                    FixedAsset.SETRANGE(FixedAsset."No.", "Requisition Code");
                    IF FixedAsset.FINDFIRST THEN BEGIN
                        Type := Type::"Fixed Asset";
                        "No." := "Requisition Code";
                        VALIDATE("No.");
                    END;
                END;
            end;
        }
        field(6; "Type"; Enum "Purchase Line Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;

        }
        field(7; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"."No." WHERE("Direct Posting" = CONST(true))
            ELSE
            IF (Type = CONST(Item)) Item."No." WHERE(Blocked = CONST(false));
            trigger OnValidate()
            begin
                Name := '';
                Description := '';
                "Location Code" := '';

                IF Type = Type::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("No.") THEN begin
                        Name := GLAccount.Name;
                        Description := GLAccount.Name;
                    end;
                END;

                IF Type = Type::Item THEN BEGIN
                    IF Item.GET("No.") THEN
                        Name := Item.Description;
                    Description := Item.Description;
                    "Location Code" := Item."Location Code";
                    "Market Price" := Item."Market Price";
                    "Unit of Measure Code" := Item."Base Unit of Measure";
                    AvailableInventory := 0;
                    Inventory := 0;
                    "Part No." := Item."Part No.";
                    "Alternative Part No. 1" := Item."Alternative Part No. 1";
                    "Alternative Part No. 2" := Item."Alternative Part No. 2";
                    "Alternative Part No. 3" := Item."Alternative Part No. 3";
                    // Quantities:=0;
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "No.");
                    IF ItemLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            AvailableInventory := AvailableInventory + ItemLedgerEntry.Quantity;
                        UNTIL ItemLedgerEntry.NEXT = 0;
                    END;
                    Inventory := AvailableInventory;
                END;

                IF Type = Type::"Fixed Asset" THEN BEGIN
                    IF FixedAsset.GET("No.") THEN
                        Name := FixedAsset.Description;
                    Description := FixedAsset.Description;
                    "Location Code" := FixedAsset."FA Location Code";
                END;
            end;
        }
        field(8; Name; Text[250])
        {
            Caption = 'Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = ToBeClassified;
        }
        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
        }
        field(12; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(21; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(22; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(23; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = ToBeClassified;
        }
        field(24; "Unit Cost(LCY)"; Decimal)
        {
            Caption = 'Unit Cost(LCY)';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(25; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = ToBeClassified;
        }
        field(26; "Total Cost(LCY)"; Decimal)
        {
            Caption = 'Total Cost(LCY)';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(27; "Market Price"; Decimal)
        {
            Caption = 'Market Price';
            DataClassification = ToBeClassified;
        }
        field(39; Committed; Boolean)
        {
            Caption = 'Committed';
            DataClassification = ToBeClassified;
        }
        field(40; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
        }
        field(49; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,"Pending Approval",Released,Rejected,Closed;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Closed';
            DataClassification = ToBeClassified;
        }
        field(80; "Purchase Requisition No."; Code[20])
        {
            Caption = 'Purchase Requisition No.';
            DataClassification = ToBeClassified;
        }
        field(81; "Purchase Requisition Line"; Integer)
        {
            Caption = 'Purchase Requisition Line';
            DataClassification = ToBeClassified;
        }
        field(82; "Type (Attributes)"; Option)
        {
            Caption = 'Type (Attributes)';
            OptionMembers = "Purchase Requisition",LPO,"Procurement Planning",RFQ;
            OptionCaption = 'Purchase Requisition,LPO,Procurement Planning,RFQ';
            DataClassification = ToBeClassified;
        }
        field(70050; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(70051; "Alternative Part No. 1"; Code[50])
        {
            Caption = 'Alternative Part No. 1';
            DataClassification = ToBeClassified;
        }
        field(70052; "Alternative Part No. 2"; Code[50])
        {
            Caption = 'Alternative Part No. 2';
            DataClassification = ToBeClassified;
        }
        field(70053; "Alternative Part No. 3"; Code[50])
        {
            Caption = 'Serial Number';
            DataClassification = ToBeClassified;
        }
        field(70054; "Alternative Part No. 4"; Decimal)
        {
            Caption = 'Total Cost Value';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No.", "Document No.")
        {
            Clustered = true;
        }
    }
    var
        RequisitionCodes: Record "Purchase Requisition Codes";
        Item: record item;
        FixedAsset: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        AvailableInventory: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";
        Inventory: Decimal;
}
