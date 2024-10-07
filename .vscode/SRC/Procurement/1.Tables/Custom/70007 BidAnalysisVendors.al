table 70007 "Bid Analysis Vendors"
{
    Caption = 'Bid Analysis Vendors';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            begin
                "Vendor Name" := '';
                Vendor.RESET;
                IF Vendor.GET("Vendor No.") THEN BEGIN
                    "Vendor Name" := Vendor.Name;
                END;
            end;
        }
        field(4; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Vendor Code"; Integer)
        {
            Caption = 'Vendor Code';
            DataClassification = ToBeClassified;
        }
        field(6; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Purchase Quote No."; Code[20])
        {
            Caption = 'Purchase Quote No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                PurchaseHeader.RESET;
                PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Quote);
                PurchaseHeader.SETRANGE(PurchaseHeader."No.", "Purchase Quote No.");
                PurchaseHeader.SETRANGE(PurchaseHeader."Buy-from Vendor No.", "Vendor No.");
                IF PurchaseHeader.FINDFIRST THEN BEGIN
                    PurchaseHeader.CALCFIELDS(PurchaseHeader.Amount, PurchaseHeader."Amount Including VAT");
                    "Purchase Quote Date" := PurchaseHeader."Order Date";
                    "Quote Amount Excl VAT" := PurchaseHeader.Amount;
                    "VAT Amount" := PurchaseHeader."Amount Including VAT" - PurchaseHeader.Amount;
                    "Quote Amount Incl VAT" := PurchaseHeader."Amount Including VAT";
                    MODIFY;
                END;
            end;
        }
        field(11; "Purchase Quote Date"; Date)
        {
            Caption = 'Purchase Quote Date';
            DataClassification = ToBeClassified;
        }
        field(14; "Quote Currency"; Code[10])
        {
            Caption = 'Quote Currency';
            DataClassification = ToBeClassified;
        }
        field(15; "Quote Amount Excl VAT"; Decimal)
        {
            Caption = 'Quote Amount Excl VAT';
            DataClassification = ToBeClassified;
        }
        field(16; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = ToBeClassified;
        }
        field(17; "Quote Amount Incl VAT"; Decimal)
        {
            Caption = 'Quote Amount Incl VAT';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(20; Award; Boolean)
        {
            Caption = 'Award';
            DataClassification = ToBeClassified;
        }
        field(40; "Meets Specifications"; Option)
        {
            Caption = 'Meets Specifications';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
        field(41; "Delivery/Lead Time"; Text[100])
        {
            Caption = 'Delivery/Lead Time';
            DataClassification = ToBeClassified;
        }
        field(42; "Payment Terms"; Code[20])
        {
            Caption = 'Payment Terms';
            DataClassification = ToBeClassified;
        }
        field(49; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Closed;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Closed';
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
        Vendor: Record Vendor;
        PurchaseHeader:Record "Purchase Header";
}
