table 70025 "Prequlification Application"
{
    Caption = 'Prequlification Application';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Supplier Name"; Text[200])
        {
            Caption = 'Supplier Name';
            DataClassification = ToBeClassified;
        }
        field(2; "Procurement Period"; Text[50])
        {
            Caption = 'Procurement Period';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Period"."Period name";
        }
        field(3; "Supplier Category"; Code[20])
        {
            Caption = 'Supplier Category';
            DataClassification = ToBeClassified;
        }
        field(4; "Supplier Category Description"; Text[200])
        {
            Caption = 'Supplier Category Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(6; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(7; Prequalified; Boolean)
        {
            Caption = 'Prequalified';
            DataClassification = ToBeClassified;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'General Contact Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(9; "TIN No."; Code[30])
        {
            Caption = 'TIN No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Postal Address"; Text[30])
        {
            Caption = 'Postal Address';
            DataClassification = ToBeClassified;
        }
        field(11; "Postal Code"; Code[20])
        {
            Caption = 'Postal Code';
            DataClassification = ToBeClassified;
        }
        field(12; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(13; "Building Name"; Text[100])
        {
            Caption = 'Building Name';
            DataClassification = ToBeClassified;
        }
        field(14; Street; Text[100])
        {
            Caption = 'Street';
            DataClassification = ToBeClassified;
        }
        field(15; County; Code[20])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
            //TableRelation = County.Code;
            trigger OnValidate()
            begin
                // "County Name" := '';
                // CountyCodes.Reset();
                // CountyCodes.SetRange(CountyCodes.Code, County);
                // if CountyCodes.FindFirst() then begin
                //     "County Name" := CountyCodes.Name;
                // end;
            end;
        }
        field(16; "County Name"; Text[100])
        {
            Caption = 'County Name';
            Editable = false;
        }
        field(17; AGPO; Option)
        {
            Caption = 'AGPO';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
        field(18; "AGPO Number"; Code[50])
        {
            Caption = 'AGPO Number';
            DataClassification = ToBeClassified;
        }
        field(19; "Incorporation Cert. No."; Code[50])
        {
            Caption = 'Incorporation Cert. No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Incorporation Date"; Date)
        {
            Caption = 'Incorporation Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Code"."Bank Code";
            trigger OnValidate()
            begin
                "Bank Name" := '';
                BankCodes.Reset();
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst() then begin
                    "Bank Name" := BankCodes."Bank Name";
                end;
            end;
        }
        field(22; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branch"."Bank Branch Code";
            trigger OnValidate()
            begin
                "Bank Branch Name" := '';
                BankBranches.Reset();
                BankBranches.SetRange(BankBranches."Bank Branch Code", "Bank Branch Code");
                if BankBranches.FindFirst() then begin
                    "Bank Branch Name" := BankBranches."Bank Branch Name";
                end
            end;
        }
        field(24; "Bank Branch Name"; Text[100])
        {
            Caption = 'Bank Branch Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(27; "VAT Registered"; Option)
        {
            Caption = 'VAT Registered';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
        field(28; "VAT Registration No."; Code[30])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;
        }
        field(29; "Document No."; Code[30])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

        }
        field(40; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "USER ID"; Code[30])
        {
            Caption = 'USER ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Pre-Qualified By"; Code[30])
        {
            Caption = 'Pre-Qualified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Date Pre-Qualified"; Date)
        {
            Caption = 'Date Pre-Qualified';
            DataClassification = ToBeClassified;
        }
        field(53; Int; Integer)
        {
            Caption = 'Int';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(54; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(55; "Principal Phone No."; Text[30])
        {
            Caption = 'Principal Contact Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(56; "Vendor Declaration Submitted"; Option)
        {
            Caption = 'Vendor Declaration Submitted';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
        field(57; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Supplier Name", Int)
        {
            Clustered = true;
        }
    }
    var
        // CountyCodes: Record County;
        BankCodes: Record "Bank Code";
        BankBranches: Record "Bank Branch";
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";
        PurchSetup: Record "Purchases & Payables Setup";
        VendorDocs: Record "Vendor Required Documents";
        NoSeriesMgt: Codeunit "No. Series";
        lINENO: Integer;

    trigger OnInsert()
    begin
        PurchSetup.get;
        PurchSetup.TESTFIELD(PurchSetup."Tender Doc No.");
        "No. Series" := PurchSetup."Tender Doc No.";
        if NoSeriesMgt.AreRelated(PurchSetup."Tender Doc No.", xRec."No. Series") then
            "No. Series" := xRec."No. Series";
        "Document No." := NoSeriesMgt.GetNextNo("No. Series");
        "User ID" := UserId;

        ProcurementUploadDocuments2.RESET;
        ProcurementUploadDocuments2.SETRANGE(ProcurementUploadDocuments2.Type, ProcurementUploadDocuments2.Type::"Pre-qualification");
        IF ProcurementUploadDocuments2.FINDSET THEN BEGIN
            REPEAT
                lINENO := lINENO + 1;
                VendorDocs.INIT;
                VendorDocs."Line No" := lINENO;
                VendorDocs.Code := "Document No.";
                VendorDocs."Document Code" := ProcurementUploadDocuments2."Document Code";
                VendorDocs."Document Description" := ProcurementUploadDocuments2."Document Description";
                VendorDocs."Document Attached" := FALSE;
                VendorDocs.INSERT;
            UNTIL ProcurementUploadDocuments2.NEXT = 0;
        END;
    end;
}
