table 70001 "Purchase Requisition Line"
{
    Caption = 'Purchase Requisition Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;//
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Requisition Type"; Option)
        {
            Caption = 'Requisition Type';
            OptionMembers = Service,Item,"Fixed Asset";
            OptionCaption = 'Service,Item,Fixed Asset';
            DataClassification = ToBeClassified;
        }
        field(5; "Requisition Code"; Code[50])
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
                RequisitionCodes.Reset();
                RequisitionCodes.SetRange(RequisitionCodes."Requisition Code", "Requisition Code");
                IF RequisitionCodes.findfirst THEN BEGIN
                    "Type" := RequisitionCodes."Type";
                    "No." := RequisitionCodes."No.";
                    VALIDATE("No.");
                END;
                IF Item.GET("Requisition Code") THEN BEGIN
                    "Type" := Type::Item;
                    "No." := Item."No.";
                    VALIDATE("No.");
                END;
                IF FixedAsset.GET("Requisition Code") THEN BEGIN
                    "Type" := Type::"Fixed Asset";
                    "No." := FixedAsset."No.";
                    VALIDATE("No.");
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

                IF "Type" = "Type"::"G/L Account" THEN BEGIN
                    IF "G/LAccount".GET("No.") THEN
                        Name := "G/LAccount".Name;
                    Description := "G/LAccount".Name;
                END;

                IF "Type" = "Type"::Item THEN BEGIN
                    IF Item.GET("No.") THEN
                        Name := Item.Description;
                    Description := Item.Description;
                    "Location Code" := Item."Location Code";
                    "Market Price" := Item."Market Price";
                    "Unit of Measure" := Item."Base Unit of Measure";
                    "Part No." := item."Part No.";
                    "Alternative Part No. 1" := Item."Alternative Part No. 1";
                    "Alternative Part No. 2" := Item."Alternative Part No. 2";
                    "Alternative Part No. 3" := Item."Alternative Part No. 3";
                    "Alternative Part No. 4" := Item."Alternative Part No. 4";
                    AvailableInventory := 0;
                    Inventory := 0;
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

                IF "Type" = "Type"::"Fixed Asset" THEN BEGIN
                    IF FixedAsset.GET("No.") THEN
                        Name := FixedAsset.Description;
                    Description := FixedAsset.Description;
                    "Location Code" := FixedAsset."FA Location Code";
                END;
            end;
        }
        field(8; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Delivery Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(11; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(12; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                VALIDATE("Total Cost");
            end;
        }
        field(13; "Market Price"; Decimal)
        {
            Caption = 'Market Price';
            DataClassification = ToBeClassified;
        }
        field(14; Inventory; Decimal)
        {
            Caption = 'Inventory';
            DataClassification = ToBeClassified;
        }
        field(15; Budget; Code[30])
        {
            Caption = 'Budget';
            DataClassification = ToBeClassified;
        }
        field(16; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group"."Code";
            trigger OnValidate()
            begin
                VALIDATE("Total Cost");
            end;
        }
        field(17; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Total Cost(LCY)" := "Total Cost";
                IF "Currency Code" <> '' THEN BEGIN
                    "Total Cost(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Total Cost", "Currency Factor"));
                END;
            end;
        }
        field(18; "VAT Amount(LCY)"; Decimal)
        {
            Caption = 'VAT Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(19; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(20; "Total Amount(LCY)"; Decimal)
        {
            Caption = 'Total Amount(LCY)';
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
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Estimated Unit Cost"; Decimal)
        {
            Caption = 'Estimated Unit Cost';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                TESTFIELD(Quantity);
                "Estimated Unit Cost(LCY)" := 0;
                "Total Cost" := 0;
                "Estimated Unit Cost(LCY)" := "Estimated Unit Cost";
                IF "Currency Code" <> '' THEN BEGIN
                    "Estimated Unit Cost(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Estimated Unit Cost", "Currency Factor"));
                END;
                "Total Cost" := Quantity * "Estimated Unit Cost";
                VALIDATE("Total Cost");
            end;
        }
        field(24; "Estimated Unit Cost(LCY)"; Decimal)
        {
            Caption = 'Estimated Unit Cost(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Total Cost(LCY)" := 0;
                "Total Amount" := 0;
                "Total Amount(LCY)" := 0;
                "VAT Amount" := 0;
                "VAT Amount(LCY)" := 0;

                "Total Cost(LCY)" := "Total Cost";
                "Total Amount" := "Total Cost";
                "Total Amount(LCY)" := "Total Cost";
                IF "Currency Code" <> '' THEN BEGIN
                    "Total Cost(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Total Cost", "Currency Factor"));
                    "Total Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Total Cost", "Currency Factor"));
                END;

                IF "VAT Prod. Posting Group" <> '' THEN BEGIN
                    VATPostingSetup.RESET;
                    VATPostingSetup.SETRANGE(VATPostingSetup."VAT Prod. Posting Group", "VAT Prod. Posting Group");
                    IF VATPostingSetup.FINDFIRST THEN BEGIN
                        "VAT Amount" := (VATPostingSetup."VAT %" / 100) * "Total Cost";
                        "VAT Amount(LCY)" := (VATPostingSetup."VAT %" / 100) * "Total Cost(LCY)";
                        "Total Amount" := "Total Cost" + "VAT Amount";
                        "Total Amount(LCY)" := "Total Cost(LCY)" + "VAT Amount(LCY)";
                    END;
                END;
            end;
        }
        field(26; "Total Cost(LCY)"; Decimal)
        {
            Caption = 'Total Cost(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Employee No."; Code[30])
        {
            Caption = 'Employee No.';
            Editable = false;
            // FieldClass = FlowField;
            //CalcFormula = lookup("Purchase Requisitions"."Employee No." WHERE("No." = FIELD("Document No.")));
        }
        field(36; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
            //FieldClass = FlowField;
            //CalcFormula = lookup("Purchase Requisitions"."Employee Name" WHERE("No." = FIELD("Document No.")));
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
        field(60; "Expnse Description"; Text[100])
        {
            Caption = 'Expnse Description';
            DataClassification = ToBeClassified;
        }
        field(61; "Budget Line"; Text[100])
        {
            Caption = 'Budget Line';
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            //Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Closed,Submitted;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Closed,Submitted';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin



            end;
        }
        field(71; Closed; Boolean)
        {
            Caption = 'Closed';
            //Editable = false;
            DataClassification = ToBeClassified;
        }
        field(75; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(80; "Request for Quotation No."; Code[20])
        {
            Caption = 'Request for Quotation No.';
            //Editable = false;
            DataClassification = ToBeClassified;
        }
        field(81; "Request for Quotation Line"; Integer)
        {
            Caption = 'Request for Quotation Line';
            //Editable = false;
            DataClassification = ToBeClassified;
        }
        field(82; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            //Editable = false;
            DataClassification = ToBeClassified;
        }
        field(83; "Purchase Order Line"; Integer)
        {
            Caption = 'Purchase Order Line';
            //Editable = false;
            DataClassification = ToBeClassified;
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(100; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionMembers = " ","Acquisition Cost",Maintenance;
            OptionCaption = ' ,Acquisition Cost,Maintenance';
            DataClassification = ToBeClassified;
        }
        field(101; "Type (Attributes)"; Option)
        {
            Caption = 'Type (Attributes)';
            OptionMembers = "Purchase Requisition",LPO,"Procurement Planning",RFQ;
            OptionCaption = 'Purchase Requisition,LPO,Procurement Planning,RFQ';
            DataClassification = ToBeClassified;
        }
        field(102; Archived; Boolean)
        {
            Caption = 'Archived';
            DataClassification = ToBeClassified;
        }
        field(200; "Reference No."; Code[100])
        {
            Caption = 'Reference No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Requisitions"."Reference Document No." WHERE("No." = FIELD("Document No.")));
        }
        field(201; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Requisitions"."Document Date" WHERE("No." = FIELD("Document No.")));
        }
        field(235; "Employee Number"; Code[30])
        {
            Caption = 'Employee No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Requisitions"."Employee No." WHERE("No." = FIELD("Document No.")));
        }
        field(236; "Employee Names"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Requisitions"."Employee Name" WHERE("No." = FIELD("Document No.")));
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
        "G/LAccount": Record "G/L Account";
        VATPostingSetup: Record "VAT Posting Setup";
        Item: Record Item;

        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        AvailableInventory: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        FixedAsset: Record "Fixed Asset";
        CurrExchRate: Record "Currency Exchange Rate";


    trigger OnInsert()
    begin
        PurchaseRequisitionHeader.Reset();
        PurchaseRequisitionHeader.SetRange("No.", "Document No.");
        if PurchaseRequisitionHeader.FindFirst then begin

            "Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := PurchaseRequisitionHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := PurchaseRequisitionHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := PurchaseRequisitionHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := PurchaseRequisitionHeader."Shortcut Dimension 6 Code";
        end;

    end;
}
