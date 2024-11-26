table 70000 "Purchase Requisitions"
{
    Caption = 'Purchase Requisitions';
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
        field(3; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            DataClassification = ToBeClassified;
        }
        field(4; Budget; Code[30])
        {
            Caption = 'Budget';
            DataClassification = ToBeClassified;
        }
        field(12; "Mission Proposal No."; Code[20])
        {
            Caption = 'Mission Proposal No.';
            DataClassification = ToBeClassified;
        }
        field(17; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Requisition Line"."VAT Amount" WHERE("Document No." = FIELD("No.")));
        }
        field(18; "VAT Amount(LCY)"; Decimal)
        {
            Caption = 'VAT Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Requisition Line"."VAT Amount(LCY)" WHERE("Document No." = FIELD("No.")));
        }
        field(19; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Requisition Line"."Total Amount" WHERE("Document No." = FIELD("No.")));
        }
        field(20; "Total Amount(LCY)"; Decimal)
        {
            Caption = 'Total Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Requisition Line"."Total Amount(LCY)" WHERE("Document No." = FIELD("No.")));
        }
        field(21; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            trigger OnValidate()
            var
            begin
                "Currency Factor" := CurrExchRate.ExchangeRate("Document Date", "Currency Code");
            end;
        }
        field(22; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Requisition Line"."Total Cost" WHERE("Document No." = FIELD("No.")));

        }
        field(24; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Requisition Line"."Total Cost(LCY)" WHERE("Document No." = FIELD("No.")));
        }
        field(49; Description; Text[200])
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
            CaptionClass = '1,2,8';//
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
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
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Closed,Submitted;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Closed,Submitted';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                PurchaseRequisitionLine.RESET;
                PurchaseRequisitionLine.SETRANGE(PurchaseRequisitionLine."Document No.", "No.");
                IF PurchaseRequisitionLine.FINDSET THEN BEGIN
                    REPEAT
                        Employee.RESET;
                        // Employee.SETRANGE(Employee."User ID", "User ID");
                        IF Employee.FINDFIRST THEN BEGIN
                            PurchaseRequisitionLine."Employee No." := Employee."No.";
                            PurchaseRequisitionLine."Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        END;
                        PurchaseRequisitionLine.Status := Status;
                        PurchaseRequisitionLine.MODIFY;
                    UNTIL PurchaseRequisitionLine.NEXT = 0;
                END;

                If Status = Status::Approved then begin
                    ProcurementManagement.CreatePurchaseRequisitionEmailOnFullApproval("No.");
                end;

            end;
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
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
        field(200; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            DataClassification = ToBeClassified;
            trigger onvalidate()
            var
            begin
                Employee.get("Employee No.");
                "Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
                //"Responsibility Center" := Employee."Responsibility Center";
            end;
        }
        field(201; "Reference Document No."; Code[30])
        {
            Caption = 'Reference Document No.';
            DataClassification = ToBeClassified;
        }
        field(202; "Replenishment PR"; Boolean)
        {
            Caption = 'Replenishment PR';
            DataClassification = ToBeClassified;
        }
        field(203; "Requisition Type"; Option)
        {
            Caption = 'Requisition Type';
            OptionMembers = " ",Program,"Office Supply";
            OptionCaption = ' ,Program,Office Supply';
            DataClassification = ToBeClassified;
        }
        field(204; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(205; "Purchase Type"; Option)
        {
            Caption = 'Purchase Type';
            DataClassification = ToBeClassified;
            OptionMembers = Goods,Services;
            OptionCaption = 'Goods,Services';
        }
        field(206; "Assigned User ID"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assigned User ID';
            TableRelation = "User Setup"."User ID";
        }
        field(207; "Assigned By"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assigned By';
            Editable = false;
        }
        field(208; "Assigned"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Assigned';
            Editable = false;
        }
        field(209; "Job No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job No.';
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
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        BudgetControlSetup: Record "Budget Control Setup";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        Employee: Record Employee;

        PurchaseRequisitionHeader: Record "Purchase Requisitions";

        ProcurementManagement: Codeunit "Procurement Management";
        CurrExchRate: Record "Currency Exchange Rate";

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            "Purchases&PayablesSetup".GET;
            "Purchases&PayablesSetup".TESTFIELD("Purchases&PayablesSetup"."Purchase Requisition Nos.");
            "No. Series" := "Purchases&PayablesSetup"."Purchase Requisition Nos.";
            if NoSeriesMgt.AreRelated("Purchases&PayablesSetup"."Purchase Requisition Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;

        "Document Date" := TODAY;
        "Requested Receipt Date" := TODAY;
        "User ID" := USERID;

        // BudgetControlSetup.GET;
        // Budget := BudgetControlSetup."Current Budget Code";
        // VALIDATE(Budget);
    end;

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);
        PurchaseRequisitionLine.RESET;
        PurchaseRequisitionLine.SETRANGE(PurchaseRequisitionLine."Document No.", "No.");
        IF PurchaseRequisitionLine.FINDSET THEN
            PurchaseRequisitionLine.DELETEALL;
    end;
}
