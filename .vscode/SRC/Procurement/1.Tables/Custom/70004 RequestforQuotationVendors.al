table 70004 "Request for Quotation Vendors"
{
    Caption = 'Request for Quotation Vendors';
    DataClassification = ToBeClassified;

    fields
    {
        field(9; LineNo; Integer)
        {
            Caption = 'LineNo';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(10; "RFQ Document No."; Code[20])
        {
            Caption = 'RFQ Document No.';//
            DataClassification = ToBeClassified;
        }
        field(11; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            begin
                "Vendor Name" := '';
                "Vendor Email Address" := '';
                "E-Mail" := '';
                IF Vendor.GET("Vendor No.") THEN BEGIN
                    "Vendor Name" := Vendor.Name;
                    "Vendor Email Address" := Vendor."E-Mail";
                    "E-Mail" := Vendor."E-Mail";
                END;

            end;
        }
        field(12; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(13; "Vendor Email Address"; Text[100])
        {
            Caption = 'Vendor Email Address';
            DataClassification = ToBeClassified;
        }
        field(14; "RFQ Type"; Option)
        {
            Caption = 'RFQ Type';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            DataClassification = ToBeClassified;
        }
        field(15; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            DataClassification = ToBeClassified;
        }
        field(16; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
        field(17; "Not listed Vendor"; Text[80])
        {
            Caption = 'Not listed Vendor';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Vendor No." := '';

                IF "Vendor No." <> '' THEN
                    VALIDATE("Vendor No.");

                "Vendor Name" := "Not listed Vendor";

                RFQVendor.RESET;
                RFQVendor.SETRANGE(RFQVendor."RFQ Document No.", "RFQ Document No.");
                IF RFQVendor.FINDFIRST THEN BEGIN
                    "Vendor Code" := RFQVendor.LineNo + 1;
                END;
            end;
        }
        field(18; "Vendor Code"; Integer)
        {
            Caption = 'Vendor Code';
            DataClassification = ToBeClassified;
        }
        field(19; "Send Email"; Boolean)
        {
            Caption = 'Send Email';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; LineNo, "RFQ Document No.")
        {
            Clustered = true;
        }
    }
    var
        Vendor: Record Vendor;
        RFQVendor: Record "Request for Quotation Vendors";
}
