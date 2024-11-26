table 70010 "Procurement Planning Line"
{
    Caption = 'Procurement Planning Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(12; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset";
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset';
            DataClassification = ToBeClassified;
        }
        field(13; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No.";
            trigger OnValidate()
            begin
                CASE Type OF
                    Type::"G/L Account":
                        BEGIN
                            GLAcc.GET("No.");
                            Description := GLAcc.Name;
                        END;
                    Type::Item:
                        BEGIN
                            Item.GET("No.");
                            "Unit of Measure" := Item."Base Unit of Measure";
                            // "Estimated cost":=Item."Market Price";
                            Description := Item.Description;
                        END;
                    Type::"Fixed Asset":
                        BEGIN
                            FA.GET("No.");
                            Description := FA.Description;
                        END;
                END;

            end;
        }
        field(14; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(15; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
        field(16; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Unit of Measure".Code;
            DataClassification = ToBeClassified;
        }
        field(17; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(18; "Procurement Method"; Option)
        {
            Caption = 'Procurement Method';
            OptionMembers = Open,Restricted,Direct,RFQ,"Low Value";
            OptionCaption = 'Open,Restricted,Direct,RFQ,Low Value';
            DataClassification = ToBeClassified;
        }
        field(19; "Source of Funds"; Option)
        {
            Caption = 'Source of Funds';
            OptionMembers = " ",Budget,Donor;
            OptionCaption = ' ,Budget,Donor';
            DataClassification = ToBeClassified;
        }
        field(20; "Estimated cost"; Decimal)
        {
            Caption = 'Estimated cost';
            DataClassification = ToBeClassified;
        }
        field(21; "Time Process"; Date)
        {
            Caption = 'Time Process';
            DataClassification = ToBeClassified;
        }
        field(22; "Invite/Advertise Tender"; Date)
        {
            Caption = 'Invite/Advertise Tender';
            DataClassification = ToBeClassified;
        }
        field(23; "Open Tender Date"; Date)
        {
            Caption = 'Open Tender Date';
            DataClassification = ToBeClassified;
        }
        field(24; "Evaluate Tender Date"; Date)
        {
            Caption = 'Evaluate Tender Date';
            DataClassification = ToBeClassified;
        }
        field(25; "Committee Award Approval Date"; Date)
        {
            Caption = 'Committee Award Approval Date';
            DataClassification = ToBeClassified;
        }
        field(26; "Notification of Award Date"; Date)
        {
            Caption = 'Notification of Award Date';
            DataClassification = ToBeClassified;
        }
        field(27; "Contract Signing Date"; Date)
        {
            Caption = 'Contract Signing Date';
            DataClassification = ToBeClassified;
        }
        field(28; "Total time to Contract sign"; DateFormula)
        {
            Caption = 'Total time to Contract sign';
            DataClassification = ToBeClassified;
        }
        field(29; "Time of Completion of Contract"; DateFormula)
        {
            Caption = 'Time of Completion of Contract';
            DataClassification = ToBeClassified;
        }
        field(30; "Procurement Plan No."; Code[30])
        {
            Caption = 'Procurement Plan No.';
            DataClassification = ToBeClassified;
        }
        field(31; "Expected Date of Delivery"; Date)
        {
            Caption = 'Expected Date of Delivery';
            DataClassification = ToBeClassified;
        }
        field(35; "Open Tender Days"; Integer)
        {
            Caption = 'Open Tender Days';
            DataClassification = ToBeClassified;
        }
        field(36; "Evaluate Tender Days"; Integer)
        {
            Caption = 'Evaluate Tender Days';
            DataClassification = ToBeClassified;
        }
        field(37; "Committee Award Approval Days"; Integer)
        {
            Caption = 'Committee Award Approval Days';
            DataClassification = ToBeClassified;
        }
        field(38; "Notification of Award Days"; Integer)
        {
            Caption = 'Notification of Award Days';
            DataClassification = ToBeClassified;
        }
        field(39; "Contract Signing Days"; Integer)
        {
            Caption = 'Contract Signing Days';
            DataClassification = ToBeClassified;
        }
        field(50; "Procurement Plan Type"; Option)
        {
            Caption = 'Procurement Plan Type';
            OptionMembers = Items,Service,"Fixed Asset";
            OptionCaption = 'Items,Service,Fixed Asset';
            DataClassification = ToBeClassified;
        }
        field(51; "Procurement Plan GrouTINg"; Code[30])
        {
            Caption = 'Procurement Plan GrouTINg';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Procurement Plan Type" = FILTER(Items)) "Inventory Posting Group".Code
            ELSE
            IF ("Procurement Plan Type" = FILTER(Service)) "Purchase Requisition Codes"."Requisition Code"
            ELSE
            IF ("Procurement Plan Type" = FILTER("Fixed Asset")) "FA Posting Group".Code;
            trigger OnValidate()
            begin
                "G/L Budget Line A/C" := '';

                IF "Procurement Plan Type" = "Procurement Plan Type"::Items THEN BEGIN
                    InventoryPostingGroup.RESET;
                    InventoryPostingGroup.SETRANGE(InventoryPostingGroup.Code, "Procurement Plan GrouTINg");
                    IF InventoryPostingGroup.FINDFIRST THEN BEGIN
                        "G/L Budget Line A/C" := InventoryPostingGroup."Budget G/L Account";
                        VALIDATE("G/L Budget Line A/C");
                    END;
                END;

                IF "Procurement Plan Type" = "Procurement Plan Type"::Service THEN BEGIN
                    PurchaseRequisitionCodes.RESET;
                    PurchaseRequisitionCodes.SETRANGE(PurchaseRequisitionCodes."Requisition Code", "Procurement Plan GrouTINg");
                    IF PurchaseRequisitionCodes.FINDFIRST THEN BEGIN
                        "G/L Budget Line A/C" := PurchaseRequisitionCodes."No.";
                        VALIDATE("G/L Budget Line A/C");
                    END;
                END;

                IF "Procurement Plan Type" = "Procurement Plan Type"::"Fixed Asset" THEN BEGIN
                    FAPostingGroup.RESET;
                    FAPostingGroup.SETRANGE(FAPostingGroup.Code, "Procurement Plan GrouTINg");
                    IF FAPostingGroup.FINDFIRST THEN BEGIN
                        "G/L Budget Line A/C" := FAPostingGroup."Acquisition Cost Account";
                        VALIDATE("G/L Budget Line A/C");
                    END;
                END;

            end;
        }
        field(52; "G/L Budget Line A/C"; Code[30])
        {
            Caption = 'G/L Budget Line A/C';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
            trigger OnValidate()
            begin
                IF "G/L Budget Line A/C" <> '' THEN BEGIN
                    GLAcc.GET("G/L Budget Line A/C");
                    Description := GLAcc.Name;
                END;
            end;
        }
        field(53; "Budget Amount"; Decimal)
        {
            Caption = 'Budget Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("Budget Name" = FIELD(Budget), "G/L Account No." = FIELD("G/L Budget Line A/C")));
        }
        field(80; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(81; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(82; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(83; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(84; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(85; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
        }
        field(86; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(87; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
        }
        field(88; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(89; "Type (Attributes)"; Option)
        {
            Caption = 'Type (Attributes)';
            OptionMembers = "Purchase Requisition",LPO,"Procurement Planning";
            OptionCaption = 'Purchase Requisition,LPO,Procurement Planning';
            DataClassification = ToBeClassified;
        }
        field(90; Budget; Code[30])
        {
            Caption = 'Budget';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    begin
        ProcurementPlanningHeader.RESET;
        ProcurementPlanningHeader.SETRANGE(ProcurementPlanningHeader."No.", "Document No.");
        IF ProcurementPlanningHeader.FINDFIRST THEN BEGIN
            ProcurementPlanningHeader.TestField(ProcurementPlanningHeader.Budget);
            //ProcurementPlanningHeader.TestField(ProcurementPlanningHeader."Procurement Plan No.");
            //"Procurement Plan No." := ProcurementPlanningHeader."Procurement Plan No.";
            Budget := ProcurementPlanningHeader.Budget;
        END;

        "Type (Attributes)" := "Type (Attributes)"::"Procurement Planning";

    end;

    var
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FA: Record "Fixed Asset";
        InventoryPostingGroup: Record "Inventory Posting Group";
        PurchaseRequisitionCodes: Record "Purchase Requisition Codes";
        FAPostingGroup: Record "FA Posting Group";
        ProcurementPlanningHeader: Record "Procurement Planning Header";
}
