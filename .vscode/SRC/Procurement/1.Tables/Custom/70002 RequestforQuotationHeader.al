table 70002 "Request for Quotation Header"
{
    Caption = 'Request for Quotation Header';
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
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(3; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = RFQ,RFP;
            OptionCaption = 'RFQ,RFP';
            DataClassification = ToBeClassified;
        }
        field(6; "RFQ Date"; Date)
        {
            Caption = 'RFQ Date';
            DataClassification = ToBeClassified;
        }
        field(7; "RFQ Enquiries Email"; Text[100])
        {
            Caption = 'RFQ Enquiries Email Address';
            DataClassification = ToBeClassified;
        }
        field(21; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency."Code";
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
            CalcFormula = Sum("Request for Quotation Line"."Total Cost" WHERE("Document No." = FIELD("No.")));
        }
        field(24; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            FieldClass = FlowField;
            CalcFormula = Sum("Request for Quotation Line"."Total Cost(LCY)" WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(26; "Supplier Category"; Code[20])
        {
            Caption = 'Supplier Category';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category"."Code";
            trigger OnValidate()
            begin
                IF "Supplier Category" <> '' THEN BEGIN
                    "Category Name" := '';

                    ItemCategory.RESET;
                    ItemCategory.SETRANGE(Code, "Supplier Category");
                    IF ItemCategory.FINDFIRST THEN
                        "Category Name" := ItemCategory.Description;


                    RequestforQuotationVendors.RESET;
                    RequestforQuotationVendors.SETRANGE(RequestforQuotationVendors."RFQ Document No.", "No.");
                    IF RequestforQuotationVendors.FINDSET THEN
                        RequestforQuotationVendors.DELETEALL;

                    COMMIT;

                    PrequalifiedSuppliers.RESET;
                    IF PrequalifiedSuppliers.FINDSET THEN BEGIN
                        REPEAT
                            SupplierCategory.RESET;
                            SupplierCategory.SETRANGE(SupplierCategory."Document Number", PrequalifiedSuppliers."Supplier Name");
                            SupplierCategory.SETRANGE(SupplierCategory."Supplier Category", "Supplier Category");
                            IF SupplierCategory.FINDFIRST THEN BEGIN
                                RequestforQuotationVendors.INIT;
                                RequestforQuotationVendors.LineNo := 0;
                                RequestforQuotationVendors."RFQ Document No." := "No.";
                                RequestforQuotationVendors."Vendor Code" := PrequalifiedSuppliers."No.";
                                RequestforQuotationVendors."Vendor No." := PrequalifiedSuppliers."Vendor No.";
                                RequestforQuotationVendors."Vendor Name" := PrequalifiedSuppliers."Supplier Name";
                                RequestforQuotationVendors."Vendor Email Address" := PrequalifiedSuppliers."E-Mail";
                                RequestforQuotationVendors."Send Email" := true;
                                RequestforQuotationVendors.INSERT;
                            END;
                        UNTIL PrequalifiedSuppliers.NEXT = 0;
                    END;
                END;
            end;
        }
        field(27; "Category Name"; Text[200])
        {
            Caption = 'Category Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(30; "Time"; Time)
        {
            Caption = 'Time';
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
            OptionMembers = Open,"Pending Approval",Released,Rejected,Closed;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Closed';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                RequestforQuotationLine.RESET;
                RequestforQuotationLine.SETRANGE(RequestforQuotationLine."Document No.", "No.");
                IF RequestforQuotationLine.FINDSET THEN BEGIN
                    REPEAT
                        RequestforQuotationLine.Status := Status;
                        RequestforQuotationLine.MODIFY;
                    UNTIL RequestforQuotationLine.NEXT = 0;
                END;

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
        field(200; "Send RFQ via Email"; Boolean)
        {
            Caption = 'Send RFQ via Email';
            DataClassification = ToBeClassified;
        }
        field(201; "Email Body"; Text[250])
        {
            Caption = 'Email Body';
            DataClassification = ToBeClassified;
        }
        field(205; "Edit in Outlook Client"; Boolean)
        {
            Caption = 'Edit in Outlook Client';
            DataClassification = ToBeClassified;
        }
        field(206; "AGPO Certificate"; Option)
        {
            Caption = 'AGPO Certificate';
            OptionMembers = Mandatory,"Not Mandatory";
            OptionCaption = 'Mandatory,Not Mandatory';
            DataClassification = ToBeClassified;
        }
        field(207; "Business Registration Cert."; Option)
        {
            Caption = 'Business Registration Cert.';
            OptionMembers = Mandatory,"Not Mandatory";
            OptionCaption = 'Mandatory,Not Mandatory';
            DataClassification = ToBeClassified;
        }
        field(208; "Tax Compliance Cert."; Option)
        {
            Caption = 'Tax Compliance Cert.';
            OptionMembers = Mandatory,"Not Mandatory";
            OptionCaption = 'Mandatory,Not Mandatory';
            DataClassification = ToBeClassified;
        }
        field(209; "Confidential Bus.Questionnaire"; Option)
        {
            Caption = 'Confidential Bus.Questionnaire';
            OptionMembers = Mandatory,"Not Mandatory";
            OptionCaption = 'Mandatory,Not Mandatory';
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
    var
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        BudgetControlSetup: Record "Budget Control Setup";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        RequestforQuotationLine: record "Request for Quotation Line";
        ItemCategory: Record "Item Category";
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
        PrequalifiedSuppliers: Record "Prequalified Suppliers";
        SupplierCategory: Record "Supplier Category";
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";

        VendorDocs: Record "Vendor Required Documents";

        lINENO: Integer;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            "Purchases&PayablesSetup".GET;
            "Purchases&PayablesSetup".TESTFIELD("Purchases&PayablesSetup"."Request for Quotation Nos.");
            "No. Series" := "Purchases&PayablesSetup"."Request for Quotation Nos.";
            if NoSeriesMgt.AreRelated("Purchases&PayablesSetup"."Request for Quotation Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;


        ProcurementUploadDocuments2.RESET;
        //ProcurementUploadDocuments2.SETRANGE(ProcurementUploadDocuments2.Type, ProcurementUploadDocuments2.Type::);
        IF ProcurementUploadDocuments2.FINDSET THEN BEGIN
            REPEAT
                lINENO := lINENO + 1;
                VendorDocs.INIT;
                VendorDocs."Line No" := lINENO;
                VendorDocs.Code := "No.";
                VendorDocs."Document Code" := ProcurementUploadDocuments2."Document Code";
                VendorDocs."Document Description" := ProcurementUploadDocuments2."Document Description";
                VendorDocs."Document Attached" := FALSE;
                VendorDocs.INSERT;
            UNTIL ProcurementUploadDocuments2.NEXT = 0;
        END;

        "Document Date" := TODAY;
        "RFQ Date" := Today;
        "User ID" := USERID;
        VALIDATE("User ID");
    end;

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);
        RequestforQuotationLine.RESET;
        RequestforQuotationLine.SETRANGE(RequestforQuotationLine."Document No.", "No.");
        IF RequestforQuotationLine.FINDSET THEN
            RequestforQuotationLine.DELETEALL;

    end;
}
