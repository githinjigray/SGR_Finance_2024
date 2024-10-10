table 70500 "Store Requisition Header"
{
    Caption = 'Store Requisition Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
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
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(5; "Required Date"; Date)
        {
            Caption = 'Required Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Requester ID"; Code[50])
        {
            Caption = 'Requester ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; Department; Code[50])
        {
            Caption = 'Department';
            // TableRelation = Departments.Code;
            DataClassification = ToBeClassified;
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Store Requisition Line"."Line Amount" where("Document No." = field("No.")));
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
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                StoreRequisitionLine.RESET;
                StoreRequisitionLine.SETRANGE(StoreRequisitionLine."Document No.", "No.");
                IF StoreRequisitionLine.FINDSET THEN BEGIN
                    REPEAT
                        StoreRequisitionLine.Status := Status;
                        StoreRequisitionLine.MODIFY;
                    UNTIL StoreRequisitionLine.NEXT = 0;
                END;
            end;
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(72; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(73; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(74; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(75; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(76; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(77; "Reversal Date"; Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(78; "Reversal Time"; Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // UserSetup.RESET;
                // UserSetup.SETRANGE(UserSetup."User ID", "User ID");
                // IF UserSetup.FINDFIRST THEN BEGIN
                //     "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                // "Shortcut Dimension 3 Code" := UserSetup."Shortcut Dimension 3 Code";
                // "Shortcut Dimension 4 Code" := UserSetup."Shortcut Dimension 4 Code";
                // "Shortcut Dimension 5 Code" := UserSetup."Shortcut Dimension 5 Code";
                // "Shortcut Dimension 6 Code" := UserSetup."Shortcut Dimension 6 Code";
                // "Shortcut Dimension 7 Code" := UserSetup."Shortcut Dimension 7 Code";
                // "Shortcut Dimension 8 Code" := UserSetup."Shortcut Dimension 8 Code";
                // "Responsibility Center" := UserSetup."Responsibility Center";
                //END;
            end;
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(101; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(200; "Job No."; Code[50])
        {
            Caption = 'Job No.';
            DataClassification = ToBeClassified;
        }
        field(201; "Reference No."; Code[50])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
        }
        field(52137023; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // Employee.RESET;
                // Employee.SETRANGE(Employee."No.", "Employee No.");
                // IF Employee.FINDFIRST THEN begin;
                //     "User ID" := Employee."User ID";
                //     "Employee Name":=Employee."First Name"+' '+Employee."Last Name";
                //     "Responsibility Center" := Employee."Responsibility Center";
                //     Department := Employee.Department;
                // end;
            end;
        }
        field(52137024; "Relational Doc. No."; Code[30])
        {
            Caption = 'Relational Doc. No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(52137025; "Employee Name"; Text[100])
        {
            Caption = 'Incoming Document Entry No.';
            Editable = false;

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Employee: Record Employee;
        UserSetup: Record Employee;
        StoreRequisitionLine: Record "Store Requisition Line";

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            InventorySetup.GET();
            InventorySetup.TESTFIELD(InventorySetup."Stores Requisition Nos.");
            "No. Series" := InventorySetup."Stores Requisition Nos.";
            if NoSeriesMgt.AreRelated(InventorySetup."Stores Requisition Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;

        "Document Date" := TODAY;
        //  "Posting Date" := TODAY;
        "Requester ID" := USERID;
        "User ID" := USERID;
        VALIDATE("User ID");

        // Employee.RESET;
        // Employee.SETRANGE(Employee."No.", "Employee No.");
        // IF Employee.FINDFIRST THEN
        //     "User ID" := Employee."User ID";
        // "Responsibility Center" := Employee."Responsibility Center";
        // Department := Employee.Department;
    end;
}
