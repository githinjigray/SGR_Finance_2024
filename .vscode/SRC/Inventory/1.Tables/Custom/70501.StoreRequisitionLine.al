table 70501 "Store Requisition Line"
{
    Caption = 'Store Requisition Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Item;
            OptionCaption = 'Item';
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No." WHERE(Blocked = CONST(false));
            trigger OnValidate()
            begin
                Item.RESET;
                Item.GET("Item No.");
                "Unit of Measure Code" := Item."Base Unit of Measure";
                VALIDATE("Unit of Measure Code");
                "Unit Cost" := Item."Unit Cost";
                VALIDATE("Unit Cost");
                "Item Description" := Item.Description;
                Description := Item.Description;
                "Location Code" := Item."Location Code";
                "Part No." := item."Part No.";
                "Alternative Part No. 1" := Item."Alternative Part No. 1";
                "Alternative Part No. 2" := Item."Alternative Part No. 2";
                "Alternative Part No. 3" := Item."Alternative Part No. 3";
                "Alternative Part No. 4" := Item."Alternative Part No. 4";
                VALIDATE("Location Code");

                //If Location Code selected on header
                // StoreRequisitionHeader.RESET;
                // IF StoreRequisitionHeader.GET("Document No.") THEN BEGIN
                //     "Location Code" := StoreRequisitionHeader."Location Code";
                //     VALIDATE("Location Code");
                // END;
            end;
        }
        field(5; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location."Code";
            trigger OnValidate()
            begin
                TESTFIELD("Item No.");
                AvailableInventory := 0;
                Inventory := 0;
                Quantity := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "Item No.");
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", "Location Code");
                IF ItemLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        AvailableInventory := AvailableInventory + ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                END;
                Inventory := AvailableInventory;
            end;

        }
        field(6; Inventory; Decimal)
        {
            Caption = 'Inventory';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD("Location Code");
                IF Inventory < Quantity THEN BEGIN
                    ERROR(Text_0085, "Item No.", "Location Code", Inventory, "Unit of Measure Code");
                END;
                "Line Amount" := "Unit Cost" * Quantity;

                "Quantity to Issue" := Quantity;
            end;
        }
        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(12; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(13; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(15; "Quantity to Issue"; Decimal)
        {
            Caption = 'Quantity to Issue';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Quantity to Issue" > Quantity THEN ERROR(Text_0086);

                IF "Quantity to Issue" > Inventory THEN ERROR(Text_0087);

                "Line Amount" := "Unit Cost" * Quantity;
            end;
        }
        field(16; "Reason for Quantity to issue"; Text[150])
        {
            Caption = 'Reason for Quantity to issue';
            DataClassification = ToBeClassified;
        }
        field(17; Committed; Boolean)
        {
            Caption = 'Committed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(18; "Gen. Bus. Posting Group"; Code[30])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
        }
        field(19; "Gen. Prod. Posting Group"; Code[30])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
        }
        field(49; Description; Text[150])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Posted';
            DataClassification = ToBeClassified;
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
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
        }
        field(75; "Item Description"; Text[80])
        {
            Caption = 'Item Description';
            DataClassification = ToBeClassified;
        }
        field(70013; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(70014; "Alternative Part No. 1"; Code[50])
        {
            Caption = 'Alternative Part No. 1';
            DataClassification = ToBeClassified;
        }
        field(70015; "Alternative Part No. 2"; Code[50])
        {
            Caption = 'Alternative Part No. 2';
            DataClassification = ToBeClassified;
        }
        field(70016; "Alternative Part No. 3"; Code[50])
        {
            Caption = 'Serial Number';
            DataClassification = ToBeClassified;
        }
        field(70017; "Alternative Part No. 4"; Decimal)
        {
            Caption = 'Total Cost Value';
            DataClassification = ToBeClassified;
        }
        field(70018; "S/No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            TableRelation = "Item Ledger Entry"."Entry No." where("Item No." = field("Item No."), Open = filter(true), "Serial No." = filter(<> ''));
            trigger OnValidate()
            var
                ItemLedgerEntry2: Record "Item Ledger Entry";
            begin
                TESTFIELD("Item No.");
                AvailableInventory := 0;
                Inventory := 0;
                Quantity := 0;

                ItemLedgerEntry2.Reset();
                ItemLedgerEntry2.SetRange("Entry No.", "S/No.");
                if ItemLedgerEntry2.FindFirst() then
                    "Alternative Part No. 3" := ItemLedgerEntry2."Serial No.";
                "Lot No." := ItemLedgerEntry2."Lot No.";

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "Item No.");
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", "Location Code");
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Entry No.", "S/No.");
                IF ItemLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        AvailableInventory := AvailableInventory + ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                END;
                Inventory := AvailableInventory;
            end;
        }
        field(70019; "Lot No."; Code[50])
        {
            Caption = 'Lot No.';
            DataClassification = ToBeClassified;
            //TableRelation = "Item Ledger Entry"."Lot No." where("Item No." = field("Item No."), Open = const(true), "Lot No." = filter(<> ''));
            trigger OnLookup()
            var
                ItemLedger: Record "Item Ledger Entry";
                ItemLedgerPage: Page "Item Ledger Entries";
            begin
                ItemLedger.RESET;
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE(Open, TRUE);
                ItemLedger.SetFilter("Lot No.", '<>%1', '');
                CLEAR(ItemLedgerPage);
                ItemLedgerPage.SETRECORD(ItemLedger);
                ItemLedgerPage.SETTABLEVIEW(ItemLedger);
                ItemLedgerPage.LOOKUPMODE(TRUE);
                IF ItemLedgerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    ItemLedgerPage.GETRECORD(ItemLedger);
                    "Lot No." := ItemLedger."Lot No.";
                END ELSE BEGIN

                END;
            end;
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
        Item: Record Item;
        StoreRequisitionHeader: Record "Store Requisition Header";
        AvailableInventory: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";
        Text_0080: TextConst ENU = 'You cannot create a new store requisition, you have an open document no. %1 ,use this document before creating a new one.';
        Text_0081: TextConst ENU = 'You cannot delete the store requisition no. %1. The status must be open, current status is %2';
        Text_0082: TextConst ENU = 'You cannot modify the store requisition no. %1. The status must be open, current status is %2';
        Text_0085: TextConst ENU = 'The quantity requested cannot be more than the current inventory for item no. %1 in location %2. The current inventory is %3 %4.';
        Text_0086: TextConst ENU = 'Quantity to issue cannot be more than what has been requested.';
        Text_0087: TextConst ENU = 'The current stock is less than the quantity you can issue';


    procedure OpenItemTrackingLines()
    var
        Job: Record Job;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        TestField(Type, Type::Item);
        TestField("Item No.");
        TestField("Quantity to Issue");
        // if "Job Contract Entry No." <> 0 then
        //     Error(Text048, TableCaption(), Job.TableCaption());

        // IsHandled := false;
        // OnBeforeCallItemTracking(Rec, IsHandled);
        // if not IsHandled then
        //     SalesLineReserve.CallItemTracking(Rec);
    end;
}
