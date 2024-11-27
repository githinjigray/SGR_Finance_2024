tableextension 70000 "Purchase Header EXT" extends "Purchase Header"
{
    fields
    {
        field(70000; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70001; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70002; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70003; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70004; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
        }
        field(70005; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
        }
        field(70006; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            DataClassification = ToBeClassified;
        }
        field(70007; "Amount Including VAT(LCY)"; Decimal)
        {
            Caption = 'Amount Including VAT(LCY)';
            DataClassification = ToBeClassified;
        }
        field(70008; "Purchase Order Sent"; Boolean)
        {
            Caption = 'Purchase Order Sent';
            DataClassification = ToBeClassified;
        }
        field(70009; "Request for Quotation Code"; Code[20])
        {
            Caption = 'Request for Quotation Code';
            DataClassification = ToBeClassified;
            TableRelation = "Request for Quotation Header"."No." where(Status = const(Released));
            trigger OnValidate()
            begin
                //Check if the selected vendor was part of the RFQ
                RequestforQuotationVendors.RESET;
                RequestforQuotationVendors.SETRANGE(RequestforQuotationVendors."RFQ Document No.", "Request for Quotation Code");
                RequestforQuotationVendors.SETRANGE(RequestforQuotationVendors."Vendor No.", "Buy-from Vendor No.");
                IF NOT RequestforQuotationVendors.FINDFIRST THEN BEGIN
                    ERROR(Text057, RequestforQuotationVendors."RFQ Document No.");
                END;
                //End Check
                TESTFIELD("Buy-from Vendor No.");
                IF CONFIRM(Text055) THEN BEGIN
                    ProcurementManagement.CreatePurchaseQuoteLinesfromRFQ(Rec, "Request for Quotation Code");
                END ELSE BEGIN
                    ERROR(Text056);
                END;
            end;
        }
        field(70010; "Purchase Order Type"; Enum LPOTypes)
        {
            Caption = 'Purchase Order Types';
            DataClassification = ToBeClassified;
        }
        field(70020; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(70021; "PO sent to Vendor"; Boolean)
        {
            Caption = 'PO sent to Vendor';
            DataClassification = ToBeClassified;
        }
        field(70023; "Delivery Note No."; Code[30])
        {
            Caption = 'Delivery Note No.';
            DataClassification = ToBeClassified;
        }
        field(70024; "Expense Period"; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70025; Archive; Boolean)
        {
            Caption = 'Archive';
            DataClassification = ToBeClassified;
        }
        field(70026; "Archive Reason"; Text[150])
        {
            Caption = 'Archive Reason';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Archived By" := '';
                "Archived By" := UserId;
            end;
        }
        field(70027; "Responsibility CenterS"; Code[20])
        {
            Caption = 'Responsibility CenterS';
            DataClassification = ToBeClassified;
        }
        field(70028; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard), Blocked = const(false));
            trigger OnValidate()
            begin
                rec."Shortcut Dimension 2 Code" := rec."Global Dimension 2 Code";
            end;
        }
        field(70029; "Purchase Type"; Option)
        {
            Caption = 'Purchase Type';
            DataClassification = ToBeClassified;
            OptionMembers = Goods,Services;
            OptionCaption = 'Goods,Services';
        }
        field(70030; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(70070; "PRF No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'PRF No.';
            Editable = false;
        }
        field(70071; "RFQ No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'RFQ No.';
        }

        field(70080; "Document Attachment Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(70081; "Archived By"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Archived By';
        }
        field(70085; "Order From"; Option)
        {
            Caption = 'Order From';
            DataClassification = ToBeClassified;
            OptionMembers = ,Procurement,Stores;
            OptionCaption = ' ,Procurement,Stores';
        }
        // modify(Status)
        // {
        //     visible = true;
        // }
    }
    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;

    trigger OnDelete()
    begin
        IF Status <> Status::Open THEN
            Error('Delete Not Allowed!');
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
        Text055: TextConst ENU = 'Change the RFQ Reference No., the existing purchase quote lines will be deleted. Continue?';
        Text056: TextConst ENU = 'Modify RFQ Reference No. Cancelled.';
        Text057: TextConst ENU = 'The selected vendor is not in list of the vendors assigned to RFQ No.:%1';
}
