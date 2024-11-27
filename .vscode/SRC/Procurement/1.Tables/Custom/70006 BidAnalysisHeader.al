table 70006 "Bid Analysis Header"
{
    Caption = 'Bid Analysis Header';
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
            Editable = false;//
            DataClassification = ToBeClassified;
        }
        field(3; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = ToBeClassified;
            TableRelation = "Request for Quotation Header"."No." WHERE(Status = FILTER(Released));
            trigger OnValidate()
            var
                Fudstax: Record "Funds Tax Code";
            begin
                BidAnalysisHeader.RESET;
                BidAnalysisHeader.SETRANGE(BidAnalysisHeader."RFQ No.", "RFQ No.");
                IF BidAnalysisHeader.FINDFIRST THEN BEGIN
                    IF BidAnalysisHeader."No." <> "No." THEN
                        ERROR(Text0001, RFQHeader."No.");
                END;

                RFQHeader.RESET;
                RFQHeader.SETRANGE(RFQHeader."No.", "RFQ No.");
                IF RFQHeader.FINDFIRST THEN BEGIN
                    "RFQ Date" := RFQHeader."Closing Date";
                    Description := RFQHeader.Description;
                    "Global Dimension 1 Code" := RFQHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := RFQHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := RFQHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := RFQHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := RFQHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := RFQHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := RFQHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := RFQHeader."Shortcut Dimension 8 Code";
                END;

                BidAnalysisVendors.RESET;
                BidAnalysisVendors.SETRANGE("Document No.", "No.");
                BidAnalysisVendors.DELETEALL;

                BidAnalysisItems.RESET;
                BidAnalysisItems.SETRANGE("Document No.", "No.");
                BidAnalysisItems.DELETEALL;

                RFQVendors.RESET;
                RFQVendors.SETRANGE(RFQVendors."RFQ Document No.", "RFQ No.");
                IF RFQVendors.FINDSET THEN BEGIN
                    REPEAT
                        BidAnalysisVendors.INIT;
                        BidAnalysisVendors."Line No." := 0;
                        BidAnalysisVendors."Document No." := "No.";
                        BidAnalysisVendors."Vendor No." := RFQVendors."Vendor No.";
                        IF RFQVendors."Vendor No." = '' THEN
                            BidAnalysisVendors."Vendor No." := FORMAT(RFQVendors.LineNo);
                        BidAnalysisVendors."Vendor Name" := RFQVendors."Vendor Name";
                        BidAnalysisVendors."Vendor Code" := RFQVendors."Vendor Code";
                        BidAnalysisVendors."RFQ No." := BidAnalysisHeader."RFQ No.";
                        BidAnalysisVendors.INSERT;

                        //insert items
                        RequestforQuotationLine.RESET;
                        RequestforQuotationLine.SETRANGE("Document No.", "RFQ No.");
                        IF RequestforQuotationLine.FINDSET THEN BEGIN
                            REPEAT
                                BidAnalysisItems.INIT;
                                BidAnalysisItems."Line No" := 0;
                                BidAnalysisItems."Document No." := "No.";
                                BidAnalysisItems."Request for Quotation No." := RFQVendors."RFQ Document No.";
                                BidAnalysisItems."Vendor No." := RFQVendors."Vendor No.";
                                IF RFQVendors."Vendor No." = '' THEN
                                    BidAnalysisItems."Vendor No." := FORMAT(RFQVendors.LineNo);
                                BidAnalysisItems."Vendor Name" := RFQVendors."Vendor Name";
                                BidAnalysisItems.Type := RequestforQuotationLine.Type;
                                BidAnalysisItems."No." := RequestforQuotationLine."No.";
                                BidAnalysisItems.Name := RequestforQuotationLine.Name;
                                BidAnalysisItems."Vendor Code" := RFQVendors."Vendor Code";
                                BidAnalysisItems."Part No." := RequestforQuotationLine."Part No.";
                                BidAnalysisItems."Alternative Part No. 1" := RequestforQuotationLine."Alternative Part No. 1";
                                BidAnalysisItems."Alternative Part No. 2" := RequestforQuotationLine."Alternative Part No. 2";
                                BidAnalysisItems."Alternative Part No. 3" := RequestforQuotationLine."Alternative Part No. 3";
                                BidAnalysisItems."Alternative Part No. 4" := RequestforQuotationLine."Alternative Part No. 4";
                                BidAnalysisItems.Description := COPYSTR(RequestforQuotationLine.Description, 1, 250);
                                BidAnalysisItems.Quantity := RequestforQuotationLine.Quantity;
                                BidAnalysisItems."Location Code" := RequestforQuotationLine."Location Code";
                                BidAnalysisItems."Unit Of Measure" := RequestforQuotationLine."Unit of Measure Code";
                                BidAnalysisItems."Unit Cost" := RequestforQuotationLine."Unit Cost";
                                BidAnalysisItems."Unit Cost (LCY)" := RequestforQuotationLine."Unit Cost(LCY)";
                                BidAnalysisItems."Total Cost Exc. VAT" := RequestforQuotationLine."Total Cost";
                                BidAnalysisItems."Total Cost Exc. VAT (LCY)" := RequestforQuotationLine."Total Cost(LCY)";

                                Fudstax.Reset();
                                Fudstax.SetRange(Type, Fudstax.Type::VAT);
                                Fudstax.SetRange("Current VAT", true);
                                if Fudstax.FindFirst() then begin
                                    BidAnalysisItems."VAT Prod. Posting Group" := Fudstax."Tax Code";
                                    BidAnalysisItems.Validate("VAT Prod. Posting Group");
                                end;
                                BidAnalysisItems.INSERT;
                            UNTIL RequestforQuotationLine.NEXT = 0;
                        END;
                    UNTIL RFQVendors.NEXT = 0;
                END;
            end;
        }
        field(4; "Selected Vendor"; Code[20])
        {
            Caption = 'Selected Vendor';
            DataClassification = ToBeClassified;
            TableRelation = "Bid Analysis Vendors"."Vendor No." where("Document No." = field("RFQ No."));
            trigger OnValidate()
            begin
                "Vendor Name" := '';

                IF VendorList.GET("Selected Vendor") THEN
                    "Vendor Name" := VendorList.Name;
            end;
        }
        field(5; "Vendor Name"; Text[150])
        {
            Caption = 'Vendor Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(10; "RFQ Date"; Date)
        {
            Caption = 'RFQ Date';
            Editable = false;
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
        field(60; "Reason for Selection of Vendor"; Text[250])
        {
            Caption = 'Reason for Selection of Vendor';
            DataClassification = ToBeClassified;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,"Pending Approval",Released,Rejected,Closed;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Closed';
            DataClassification = ToBeClassified;
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
        field(103; "LPO No. Assigned"; Code[50])
        {
            Caption = 'LPO No. Assigned';
            //Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("No." = field("LPO No. Assigned"));
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
        RFQHeader: Record "Request for Quotation Header";
        BidAnalysisHeader: Record "Bid Analysis Header";
        BidAnalysisVendors: Record "Bid Analysis Vendors";
        BidAnalysisItems: Record "Bid Analysis Items";
        RequestforQuotationLine: Record "Request for Quotation Line";
        RFQVendors: Record "Request for Quotation Vendors";
        VendorList: Record Vendor;
        Text0001: TextConst ENU = 'RFQ No exists under BID Analysis no: %1';

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            "Purchases&PayablesSetup".GET;
            "Purchases&PayablesSetup".TESTFIELD("Purchases&PayablesSetup"."Bid Analysis No.");
            "No. Series" := "Purchases&PayablesSetup"."Bid Analysis No.";
            if NoSeriesMgt.AreRelated("Purchases&PayablesSetup"."Bid Analysis No.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;

        "Document Date" := TODAY;
        "User ID" := USERID;
    end;
}
