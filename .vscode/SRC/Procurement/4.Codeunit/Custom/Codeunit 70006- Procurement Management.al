codeunit 70006 "Procurement Management"
{

    trigger OnRun()
    begin
    end;

    var
        ReqLines: Record "Purchase Line";
        ItemLedgeEntries: Record "Item Ledger Entry";
        RHeader: Record "Purchase Header";
        Txt_001: Label 'Empty Purchase Requisition Line';
        Txt_002: Label 'Empty Request for Quotation Line';
        RequestforQuotationVendor: Record "Request for Quotation Vendors";
        BCSetup: Record "Budget Control Setup";
        Text0001: Label 'You Have exceeded the Budget by ';
        Text0002: Label 'Do you want to Continue?';
        Text0003: Label 'There is no Budget to Check against do you wish to continue?';
        Text0004: Label 'The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3';
        Text0005: Label 'The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3';
        Text0007: Label 'Item Does not Exist';
        Text0008: Label 'Ensure Fixed Asset No %1 has the Maintenance G/L Account';
        Text0009: Label 'Ensure Fixed Asset No %1 has the Acquisition G/L Account';
        Text0010: Label 'No Budget To Check Against';
        Text0011: Label 'The Amount On Purchase Requisition No %1  %2 %3  Exceeds The Budget By %4';
        RequestforQuotationHeader: Record "Request for Quotation Header";
        CompanyInformation: Record "Company Information";
        "LineNo.": Integer;
        LocationCode: Code[10];
        BudgetGL: Code[20];
        Text0012: Label 'Email Sent';
        Txt_003: Label 'The supplier exists in the vendor list';

    procedure CheckPurchaseRequisitionMandatoryFields(PurchaseRequisition: Record "Purchase Requisitions")
    var
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
    begin
        PurchaseRequisitionHeader.TransferFields(PurchaseRequisition);
        PurchaseRequisitionHeader.TestField("Document Date");
        PurchaseRequisitionHeader.TestField(Description);
        // PurchaseRequisitionHeader.TestField("Global Dimension 1 Code");
        // PurchaseRequisitionHeader.TestField("Global Dimension 2 Code");

        //if PurchaseRequisitionHeader."Global Dimension 2 Code" = 'PROJECTS' then
        //   PurchaseRequisitionHeader.TestField("Shortcut Dimension 3 Code");

        //if PurchaseRequisitionHeader."Global Dimension 2 Code" = 'KITTY' then
        //   PurchaseRequisitionHeader.TestField("Shortcut Dimension 4 Code");


        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", PurchaseRequisitionHeader."No.");
        if PurchaseRequisitionLine.FindSet then begin
            repeat
                PurchaseRequisitionLine.TestField("Requisition Code");
                PurchaseRequisitionLine.TestField(Quantity);
            until PurchaseRequisitionLine.Next = 0;
        end else begin
            Error(Txt_001);
        end;
    end;

    procedure CheckRequestforQuotationVendors()
    begin
    end;

    procedure CheckRequestforQuotationMandatoryFields(RequestforQuotation: Record "Request for Quotation Header")
    var
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        RequestforQuotationHeader.TransferFields(RequestforQuotation);
        RequestforQuotationHeader.TestField("Document Date");
        RequestforQuotationHeader.TestField(Description);
        RequestforQuotationHeader.TestField("Global Dimension 1 Code");
        //RequestforQuotationHeader.TestField("Global Dimension 2 Code");
        //RequestforQuotationHeader.TestField("Shortcut Dimension 3 Code");
        //RequestforQuotationHeader.TestField("Shortcut Dimension 4 Code");
        //RequestforQuotationHeader.TestField("Shortcut Dimension 5 Code");


        RequestforQuotationLine.Reset;
        RequestforQuotationLine.SetRange(RequestforQuotationLine."Document No.", RequestforQuotationHeader."No.");
        if RequestforQuotationLine.FindSet then begin
            repeat
                RequestforQuotationLine.TestField("Requisition Code");
                RequestforQuotationLine.TestField("No.");
                RequestforQuotationLine.TestField(Quantity);
                RequestforQuotationLine.TestField(Description);
            // RequestforQuotationLine.TESTFIELD("Global Dimension 1 Code");
            // RequestforQuotationLine.TESTFIELD("Global Dimension 2 Code");

            until RequestforQuotationLine.Next = 0;
        end else begin
            Error(Txt_002);
        end;
    end;

    procedure CheckBidAnalysisMandatoryFields("Bid Analysis": Record "Bid Analysis Header")
    var
        BidAnalysis: Record "Bid Analysis Header";
        BidAnalysisLine: Record "Bid Analysis Vendors";
    begin
    end;

    procedure SendRequestforQuotationToVendor("RFQNo.": Code[20])
    begin
        RequestforQuotationVendor.Reset;
        RequestforQuotationVendor.SetRange(RequestforQuotationVendor."RFQ Document No.", "RFQNo.");
        RequestforQuotationVendor.SetRange(RequestforQuotationVendor."Send Email", true);
        RequestforQuotationVendor.SetFilter(RequestforQuotationVendor."Vendor Email Address", '<>%1', '');
        if RequestforQuotationVendor.FindSet then begin
            repeat
                CreateVendorEmailMessage("RFQNo.", RequestforQuotationVendor."Vendor Email Address", RequestforQuotationVendor."Vendor Name");
            until RequestforQuotationVendor.Next = 0;
        end;
        Message(Text0012);
    end;

    procedure CreatePurchaseQuoteLinesfromRFQ(PurchaseHeader: Record "Purchase Header"; "RequestforQuotationNo.": Code[20])
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        PurchaseLine.Reset;
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet then begin
            PurchaseLine.DeleteAll;
        end;
        Commit;

        "LineNo." := 1000;
        RequestforQuotationLine.Reset;
        RequestforQuotationLine.SetRange("Document No.", "RequestforQuotationNo.");
        RequestforQuotationLine.SetRange(Status, RequestforQuotationLine.Status::Released);
        if RequestforQuotationLine.FindSet then begin
            repeat
                "LineNo." := "LineNo." + 1;
                PurchaseLine2.Init;
                PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Quote;
                PurchaseLine2.Validate("Document Type");
                PurchaseLine2."Document No." := PurchaseHeader."No.";
                PurchaseLine2.Validate("Document No.");
                PurchaseLine2."Line No." := "LineNo.";
                PurchaseLine2.Validate("Line No.");
                PurchaseHeader.TestField("Buy-from Vendor No.");
                PurchaseLine2."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                PurchaseLine2.Validate("Buy-from Vendor No.");
                PurchaseLine2.Type := RequestforQuotationLine.Type;
                PurchaseLine2.Validate(Type);
                PurchaseLine2."No." := RequestforQuotationLine."No.";
                PurchaseLine2.Validate("No.");
                PurchaseLine2."Location Code" := RequestforQuotationLine."Location Code";
                PurchaseLine2.Validate("Location Code");
                PurchaseLine2.Quantity := RequestforQuotationLine.Quantity;
                PurchaseLine2.Validate(Quantity);
                PurchaseLine2."Unit of Measure Code" := RequestforQuotationLine."Unit of Measure Code";
                PurchaseLine2.Validate("Unit of Measure Code");
                PurchaseLine2."Direct Unit Cost" := RequestforQuotationLine."Unit Cost";
                PurchaseLine2.Validate("Direct Unit Cost");
                PurchaseLine2.Description := RequestforQuotationLine.Description;
                PurchaseLine2."Shortcut Dimension 1 Code" := RequestforQuotationLine."Global Dimension 1 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 1 Code");
                PurchaseLine2."Shortcut Dimension 2 Code" := RequestforQuotationLine."Global Dimension 2 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 2 Code");
                PurchaseLine2."Shortcut Dimension 3 Code" := RequestforQuotationLine."Shortcut Dimension 3 Code";
                PurchaseLine2.VALIDATE(PurchaseLine2."Shortcut Dimension 3 Code");
                PurchaseLine2."Shortcut Dimension 4 Code" := RequestforQuotationLine."Shortcut Dimension 4 Code";
                PurchaseLine2.VALIDATE(PurchaseLine2."Shortcut Dimension 4 Code");
                PurchaseLine2."Shortcut Dimension 5 Code" := RequestforQuotationLine."Shortcut Dimension 5 Code";
                PurchaseLine2.VALIDATE(PurchaseLine2."Shortcut Dimension 5 Code");
                PurchaseLine2."Shortcut Dimension 6 Code" := RequestforQuotationLine."Shortcut Dimension 6 Code";
                PurchaseLine2.VALIDATE(PurchaseLine2."Shortcut Dimension 6 Code");
                PurchaseLine2."Shortcut Dimension 7 Code" := RequestforQuotationLine."Shortcut Dimension 7 Code";
                PurchaseLine2.VALIDATE(PurchaseLine2."Shortcut Dimension 7 Code");
                PurchaseLine2."Shortcut Dimension 8 Code" := RequestforQuotationLine."Shortcut Dimension 8 Code";
                PurchaseLine2.VALIDATE(PurchaseLine2."Shortcut Dimension 8 Code");
                PurchaseLine2.Insert;
            until RequestforQuotationLine.Next = 0;
        end;

    end;

    procedure CheckBudgetPurchaseRequisition(var DocumentNo: code[20])
    var
        PurchLine: Record "Purchase Requisition Line";
        PurchHeader: Record "Purchase Requisitions";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Reset;
        BCSetup.findfirst;

        PurchHeader.get(DocumentNo);
        //check if the dates are within the specified range
        if (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") or (PurchHeader."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, PurchHeader."Document Date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.FindSet then begin
            repeat
                //Items
                if PurchLine.Type = PurchLine.Type::Item then begin
                    Items.Reset;
                    if not Items.Get(PurchLine."No.") then
                        Error(Text0007);
                    Items.TestField("Item G/L Budget Account");
                    BudgetGL := Items."Item G/L Budget Account";
                end;

                //Fixed Asset
                if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                    FixedAssets.Reset;
                    FixedAssets.SetRange(FixedAssets."No.", PurchLine."No.");
                    if FixedAssets.FindFirst then begin
                        FAPostingGroup.Reset;
                        FAPostingGroup.SetRange(FAPostingGroup.Code, FixedAssets."FA Posting Group");
                        if FAPostingGroup.FindFirst then
                            if PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Maintenance then begin
                                BudgetGL := FAPostingGroup."Maintenance Expense Account";
                                if BudgetGL = '' then
                                    Error(Text0008, PurchLine."No.");
                            end else begin
                                BudgetGL := FAPostingGroup."Acquisition Cost Account";
                                if BudgetGL = '' then
                                    Error(Text0009, PurchLine."No.");
                            end;
                    end;
                end;

                //G/L Account
                if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
                    BudgetGL := PurchLine."No.";
                    // IF GLAccount.GET(PurchLine."No.") THEN
                    //  GLAccount.TESTFIELD(GLAccount."Budget Controlled",TRUE);
                end;

                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(PurchHeader."Document Date", 2), Date2DMY(PurchHeader."Document Date", 3));
                CurrMonth := Date2DMY(PurchHeader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PurchHeader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PurchHeader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if PurchLine."Global Dimension 1 Code" <> '' then
                    Budget.SetRange(Budget."Global Dimension 1 Code", PurchLine."Global Dimension 1 Code");
                if PurchLine."Global Dimension 2 Code" <> '' then
                    Budget.SetRange(Budget."Global Dimension 2 Code", PurchLine."Global Dimension 2 Code");
                if PurchLine."Shortcut Dimension 3 Code" <> '' then
                    Budget.SetRange(Budget."Budget Dimension 3 Code", PurchLine."Shortcut Dimension 3 Code");
                if PurchLine."Shortcut Dimension 4 Code" <> '' then
                    Budget.SetRange(Budget."Budget Dimension 4 Code", PurchLine."Shortcut Dimension 4 Code");
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments."Document Type" := Commitments."Document Type"::"Purchase Requisition";
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                if PurchLine."Global Dimension 1 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 1 Code", PurchLine."Global Dimension 1 Code");
                if PurchLine."Global Dimension 2 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 2 Code", PurchLine."Global Dimension 2 Code");
                if PurchLine."Shortcut Dimension 3 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 3 Code", PurchLine."Shortcut Dimension 3 Code");
                if PurchLine."Shortcut Dimension 4 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 4 Code", PurchLine."Shortcut Dimension 4 Code");
                if PurchLine."Shortcut Dimension 5 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 5 Code", PurchLine."Shortcut Dimension 5 Code");
                if PurchLine."Shortcut Dimension 6 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 4 Code", PurchLine."Shortcut Dimension 6 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PurchLine."Total Cost(LCY)") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PurchLine."Total Cost"))));
                end else begin
                    //commit Amounts
                    Commitments.Init;
                    Commitments."Line No." := 0;
                    Commitments.Date := Today;
                    Commitments."Posting Date" := PurchHeader."Document Date";
                    Commitments."Document Type" := Commitments."Document Type"::"Purchase Requisition";
                    Commitments."Document No." := PurchHeader."No.";
                    Commitments.Amount := PurchLine."Total Cost(LCY)";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := PurchHeader."Document Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := PurchLine."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := PurchLine."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                    Commitments."Shortcut Dimension 5 Code" := PurchLine."Shortcut Dimension 5 Code";
                    Commitments."Shortcut Dimension 6 Code" := PurchLine."Shortcut Dimension 6 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    //Commitments.Type := Commitments.Type::Vendor;
                    Commitments.Committed := true;
                    if Commitments.Insert then begin
                        PurchLine.Committed := true;
                        PurchLine.Modify;
                    end;
                end;
            until PurchLine.Next = 0;
        end;
    end;

    procedure CancelBudgetCommitmentPurchaseRequisition(DocumentNo: code[20])
    var
        Commitments: Record "Budget Committment";
        EntryNo: Integer;
        PurchLine: Record "Purchase Requisition Line";
        PurchHeader: Record "Purchase Requisitions";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
    begin
        Clear(BudgetAmount);
        BudgetGL := '';
        BCSetup.Reset;
        BCSetup.FindFirst;

        PurchHeader.get(DocumentNo);
        PurchLine.Reset;
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetRange(Committed, true);
        if PurchLine.FindSet then begin
            if PurchLine.Type = PurchLine.Type::Item then
                if Items.Get(PurchLine."No.") then
                    BudgetGL := Items."Item G/L Budget Account"
                else
                    if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
                        if FixedAsset.Get(PurchLine."No.") then
                            FAPostingGroup.Reset;
            FAPostingGroup.SetRange(Code, FixedAsset."FA Posting Group");
            if FAPostingGroup.FindFirst then
                BudgetGL := FAPostingGroup."Acquisition Cost Account"
            else
                if PurchLine.Type = PurchLine.Type::"G/L Account" then
                    BudgetGL := PurchLine."No.";

            repeat
                BudgetAmount := PurchLine."Total Cost";
                Commitments.Reset;
                Commitments.Init;
                Commitments."Line No." := 0;
                Commitments.Date := Today;
                Commitments."Posting Date" := PurchHeader."Document Date";
                Commitments."Document Type" := Commitments."Document Type"::"Purchase Requisition";
                Commitments."Document No." := PurchHeader."No.";
                Commitments.Amount := -BudgetAmount;
                Commitments.Committed := false;
                Commitments."Committed By" := UserId;
                Commitments."Committed Date" := PurchHeader."Document Date";
                Commitments."G/L Account No." := BudgetGL;
                Commitments."Committed Time" := Time;
                Commitments.Cancelled := true;
                Commitments."Cancelled By" := UserId;
                Commitments."Cancelled Date" := Today;
                Commitments."Shortcut Dimension 1 Code" := PurchLine."Global Dimension 1 Code";
                Commitments."Shortcut Dimension 2 Code" := PurchLine."Global Dimension 2 Code";
                Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                Commitments."Shortcut Dimension 5 Code" := PurchLine."Shortcut Dimension 5 Code";
                Commitments."Shortcut Dimension 6 Code" := PurchLine."Shortcut Dimension 6 Code";
                Commitments.Committed := true;
                Commitments.Budget := BCSetup."Current Budget Code";
                if Commitments.Insert then begin
                    PurchLine.Committed := false;
                    PurchLine.Modify;
                end;
            until PurchLine.Next = 0;
        end;
    end;

    procedure CheckBudgetPurchaseOrder(var DocumentNo: Code[20])
    var
        PurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.reset;
        BCSetup.findfirst;

        PurchHeader.get(PurchHeader."Document Type"::Order, DocumentNo);
        //check if the dates are within the specified range
        if (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") or (PurchHeader."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, PurchHeader."Document Date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.FindSet then begin
            repeat
                //Items
                if PurchLine.Type = PurchLine.Type::Item then begin
                    Items.Reset;
                    if not Items.Get(PurchLine."No.") then
                        Error(Text0007);
                    Items.TestField("Item G/L Budget Account");
                    BudgetGL := Items."Item G/L Budget Account";
                end;

                //Fixed Asset
                if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                    FixedAssets.Reset;
                    FixedAssets.SetRange(FixedAssets."No.", PurchLine."No.");
                    if FixedAssets.FindFirst then begin
                        FAPostingGroup.Reset;
                        FAPostingGroup.SetRange(FAPostingGroup.Code, FixedAssets."FA Posting Group");
                        if FAPostingGroup.FindFirst then
                            if PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Maintenance then begin
                                BudgetGL := FAPostingGroup."Maintenance Expense Account";
                                if BudgetGL = '' then
                                    Error(Text0008, PurchLine."No.");
                            end else begin
                                BudgetGL := FAPostingGroup."Acquisition Cost Account";
                                if BudgetGL = '' then
                                    Error(Text0009, PurchLine."No.");
                            end;
                    end;
                end;

                //G/L Account
                if PurchLine.Type = PurchLine.Type::"G/L Account" then begin

                    BudgetGL := PurchLine."No.";
                    // IF GLAccount.GET(PurchLine."No.") THEN
                    //  GLAccount.TESTFIELD(GLAccount."Budget Controlled",TRUE);
                end;

                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(PurchHeader."Document Date", 2), Date2DMY(PurchHeader."Document Date", 3));
                CurrMonth := Date2DMY(PurchHeader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PurchHeader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PurchHeader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if PurchLine."Shortcut Dimension 1 Code" <> '' then
                    Budget.SetRange(Budget."Global Dimension 1 Code", PurchLine."Shortcut Dimension 1 Code");
                if PurchLine."Shortcut Dimension 2 Code" <> '' then
                    Budget.SetRange(Budget."Global Dimension 2 Code", PurchLine."Shortcut Dimension 2 Code");
                if PurchLine."Shortcut Dimension 3 Code" <> '' then
                    Budget.SetRange(Budget."Budget Dimension 3 Code", PurchLine."Shortcut Dimension 3 Code");
                if PurchLine."Shortcut Dimension 4 Code" <> '' then
                    Budget.SetRange(Budget."Budget Dimension 4 Code", PurchLine."Shortcut Dimension 4 Code");
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments."Document Type" := Commitments."Document Type"::"Purchase Order";
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                if PurchLine."Shortcut Dimension 1 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 1 Code");
                if PurchLine."Shortcut Dimension 2 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 2 Code", PurchLine."Shortcut Dimension 2 Code");
                if PurchLine."Shortcut Dimension 3 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 3 Code", PurchLine."Shortcut Dimension 3 Code");
                if PurchLine."Shortcut Dimension 4 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 4 Code", PurchLine."Shortcut Dimension 4 Code");
                if PurchLine."Shortcut Dimension 5 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 5 Code", PurchLine."Shortcut Dimension 5 Code");
                if PurchLine."Shortcut Dimension 6 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 6 Code", PurchLine."Shortcut Dimension 6 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PurchLine."Line Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PurchLine."Line Amount"))));
                end else begin
                    //commit Amounts
                    Commitments.Init;
                    Commitments."Line No." := 0;
                    Commitments.Date := Today;
                    Commitments."Posting Date" := PurchHeader."Document Date";
                    Commitments."Document Type" := Commitments."Document Type"::"Purchase Order";
                    Commitments."Document No." := PurchHeader."No.";
                    Commitments.Amount := PurchLine."Line Amount";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := PurchHeader."Document Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                    Commitments."Shortcut Dimension 5 Code" := PurchLine."Shortcut Dimension 5 Code";
                    Commitments."Shortcut Dimension 6 Code" := PurchLine."Shortcut Dimension 6 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    //Commitments.Type := Commitments.Type::Vendor;
                    Commitments.Committed := true;
                    if Commitments.Insert then begin
                        PurchLine.Committed := true;
                        PurchLine.Modify;
                    end;
                end;
            until PurchLine.Next = 0;
        end;
    end;

    procedure CancelBudgetCommitmentPurchaseOrder(DocumentNo: code[20])
    var
        Commitments: Record "Budget Committment";
        PurchHeader: Record "Purchase Header";
        EntryNo: Integer;
        PurchLine: Record "Purchase Line";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
    begin
        Clear(BudgetAmount);
        BudgetGL := '';
        BCSetup.Reset;
        BCSetup.FindFirst;

        PurchHeader.get(PurchHeader."Document Type"::Order, DocumentNo);
        PurchLine.Reset;
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetRange(Committed, true);
        if PurchLine.FindSet then begin
            if PurchLine.Type = PurchLine.Type::Item then
                if Items.Get(PurchLine."No.") then
                    BudgetGL := Items."Item G/L Budget Account"
                else
                    if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
                        if FixedAsset.Get(PurchLine."No.") then
                            FAPostingGroup.Reset;
            FAPostingGroup.SetRange(Code, FixedAsset."FA Posting Group");
            if FAPostingGroup.FindFirst then
                BudgetGL := FAPostingGroup."Acquisition Cost Account"
            else
                if PurchLine.Type = PurchLine.Type::"G/L Account" then
                    BudgetGL := PurchLine."No.";

            repeat
                BudgetAmount := PurchLine."Line Amount";
                Commitments.Reset;
                Commitments.Init;
                Commitments."Line No." := 0;
                Commitments.Date := Today;
                Commitments."Posting Date" := PurchHeader."Document Date";
                Commitments."Document Type" := Commitments."Document Type"::"Purchase Order";
                Commitments."Document No." := PurchHeader."No.";
                Commitments.Amount := -BudgetAmount;
                Commitments.Committed := false;
                Commitments."Committed By" := UserId;
                Commitments."Committed Date" := PurchHeader."Document Date";
                Commitments."G/L Account No." := BudgetGL;
                Commitments."Committed Time" := Time;
                Commitments.Cancelled := true;
                Commitments."Cancelled By" := UserId;
                Commitments."Cancelled Date" := Today;
                Commitments."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
                Commitments."Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
                Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                Commitments."Shortcut Dimension 5 Code" := PurchLine."Shortcut Dimension 5 Code";
                Commitments."Shortcut Dimension 6 Code" := PurchLine."Shortcut Dimension 6 Code";
                Commitments.Committed := true;
                Commitments.Budget := BCSetup."Current Budget Code";
                if Commitments.Insert then begin
                    PurchLine.Committed := false;
                    PurchLine.Modify;
                end;
            until PurchLine.Next = 0;
        end;
    end;

    procedure CheckIfGLAccountBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked, false);
    end;

    procedure SenderTenderEvaluationEmail(TenderNo: Code[30])
    var
        TenderEvaluators: Record "Tender Evaluators";
    begin
        //SMTP.Get;
        TenderEvaluators.Reset;
        TenderEvaluators.SetRange(TenderEvaluators."Tender No", TenderNo);
        TenderEvaluators.SetFilter(TenderEvaluators."E-Mail", '<>%1', '');
        if TenderEvaluators.FindSet then begin
            repeat
            /*SMTPMail.CreateMessage(SMTP."Sender Name", SMTP."User ID", TenderEvaluators."E-Mail", 'Tender Evaluation - ' + TenderEvaluators."Tender No", '', true);
            SMTPMail.AppendBody('Dear' + ' ' + TenderEvaluators."Evaluator Name" + ',');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('You are invited for the tender evaluation exercise for the mentioned tender as assigned.');
            SMTPMail.AppendBody('__________________________________________________________________________________________________<br>');
            SMTPMail.AppendBody('Regards.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody(' Procurement Department');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
            SMTPMail.Send;*/
            until TenderEvaluators.Next = 0;
        end;
    end;

    procedure CreateEmailToApplicantOnSubmitApplication("RFQNo.": Code[20])
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CurrencyCode: Code[30];
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
    end;

    procedure CreateVendorEmailMessage("RFQNo.": Code[20]; VendorEmail: Text; VendorName: Text)
    var
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
        Customer: Record Customer;
        //SMTPMail: Record "SMTP Mail Setup";
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
    begin
        CompanyInformation.Get;

        EmailBody := '';
        EmailBody := 'Dear ' + VendorName + ',<br><br>';
        EmailBody := EmailBody + 'Find attached RFQ.<br>';
        EmailBody := EmailBody + '<br><br>';
        EmailBody := EmailBody + 'Kind Regards<br><br>';
        EmailBody := EmailBody + CompanyInformation.Name;

        //SMTPMail.Get;
        SenderName := CompanyInformation.Name;
        //SenderAddress := SMTPMail."User ID";
        Subject := "RFQNo.";
        Recipients := VendorEmail;
        RecipientsBCC := '';

        InsertRFQEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, "RFQNo.");
    end;

    local procedure InsertRFQEmailMessage("Sender Name": Text[100]; "Sender Address": Text[80]; Subject: Text[250]; Recipients: Text[250]; "Recipients CC": Text[250]; "Recipients BCC": Text[250]; Body: Text; "DocumentNo.": Code[20]) EmailMessageInserted: Boolean
    var
        ProcurementEmailMessages: Record "Procurement Email Messages";
        EmailBodyText: BigText;
        EmailBodyOutStream: OutStream;
    begin
        EmailMessageInserted := false;

        ProcurementEmailMessages.Init;
        ProcurementEmailMessages."Entry No." := 0;
        ProcurementEmailMessages."Sender Name" := "Sender Name";
        ProcurementEmailMessages."Sender Address" := "Sender Address";
        ProcurementEmailMessages.Subject := Subject;
        ProcurementEmailMessages.Recipients := Recipients;
        ProcurementEmailMessages."Recipients CC" := "Recipients CC";
        ProcurementEmailMessages."Recipients BCC" := "Recipients BCC";
        EmailBodyText.AddText(Body);
        ProcurementEmailMessages.Body.CreateOutStream(EmailBodyOutStream);
        EmailBodyText.Write(EmailBodyOutStream);
        ProcurementEmailMessages.HtmlFormatted := true;
        ProcurementEmailMessages."Created By" := UserId;
        ProcurementEmailMessages."Date Created" := Today;
        ProcurementEmailMessages."Time Created" := Time;
        ProcurementEmailMessages."Document No." := "DocumentNo.";
        if ProcurementEmailMessages.Insert then
            EmailMessageInserted := true;
    end;

    procedure InsertBidAnalysisLines("No.": Code[20])
    var
        RFQVendors: Record "Request for Quotation Vendors";
        BidAnalysisVendors: Record "Bid Analysis Vendors";
        BidAnalysisItems: Record "Bid Analysis Items";
        RequestforQuotationLine: Record "Request for Quotation Line";
        BidAnalysisHeader: Record "Bid Analysis Header";
    begin
        BidAnalysisHeader.Get("No.");

        BidAnalysisVendors.Reset;
        BidAnalysisVendors.SetRange("Document No.", "No.");
        BidAnalysisVendors.DeleteAll;

        BidAnalysisItems.Reset;
        BidAnalysisItems.SetRange("Document No.", "No.");
        BidAnalysisItems.DeleteAll;

        RFQVendors.Reset;
        RFQVendors.SetRange(RFQVendors."RFQ Document No.", BidAnalysisHeader."RFQ No.");
        if RFQVendors.FindSet then begin
            repeat
                BidAnalysisVendors.Init;
                BidAnalysisVendors."Line No." := 0;
                BidAnalysisVendors."Document No." := "No.";
                BidAnalysisVendors."Vendor No." := RFQVendors."Vendor No.";
                if RFQVendors."Vendor No." = '' then
                    BidAnalysisVendors."Vendor No." := Format(RFQVendors.LineNo);
                BidAnalysisVendors."Vendor Name" := RFQVendors."Vendor Name";
                BidAnalysisVendors."Vendor Code" := RFQVendors."Vendor Code";
                BidAnalysisVendors."RFQ No." := BidAnalysisHeader."RFQ No.";
                BidAnalysisVendors.Insert;

                //insert items
                RequestforQuotationLine.Reset;
                RequestforQuotationLine.SetRange("Document No.", BidAnalysisHeader."RFQ No.");
                if RequestforQuotationLine.FindSet then begin
                    repeat
                        BidAnalysisItems.Init;
                        BidAnalysisItems."Document No." := "No.";
                        BidAnalysisItems."Request for Quotation No." := RFQVendors."RFQ Document No.";
                        BidAnalysisItems."Vendor No." := RFQVendors."Vendor No.";
                        if RFQVendors."Vendor No." = '' then
                            BidAnalysisItems."Vendor No." := Format(RFQVendors.LineNo);
                        BidAnalysisItems."Vendor Name" := RFQVendors."Vendor Name";
                        BidAnalysisItems.Type := RequestforQuotationLine.Type;
                        BidAnalysisItems."No." := RequestforQuotationLine."No.";
                        BidAnalysisItems.Name := RequestforQuotationLine.Name;
                        BidAnalysisItems."Vendor Code" := RFQVendors."Vendor Code";
                        BidAnalysisItems.Description := RequestforQuotationLine.Description;
                        BidAnalysisItems.Quantity := RequestforQuotationLine.Quantity;
                        BidAnalysisItems."Unit Of Measure" := RequestforQuotationLine."Unit of Measure Code";
                        BidAnalysisItems."Unit Cost" := RequestforQuotationLine."Unit Cost";
                        BidAnalysisItems."Unit Cost (LCY)" := RequestforQuotationLine."Unit Cost(LCY)";
                        BidAnalysisItems."Total Cost Inc. VAT" := RequestforQuotationLine."Total Cost";
                        BidAnalysisItems."Total Cost Inc. VAT (LCY)" := RequestforQuotationLine."Total Cost(LCY)";
                        BidAnalysisItems.Insert;
                    until RequestforQuotationLine.Next = 0;
                end;
            until RFQVendors.Next = 0;
        end;
    end;

    procedure CheckBudgetLPO(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.reset;
        BCSetup.FindFirst;

        //check if the dates are within the specified range
        if (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") or (PurchHeader."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, PurchHeader."Document Date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.FindSet then begin
            repeat
                //Items
                if PurchLine.Type = PurchLine.Type::Item then begin
                    Items.Reset;
                    if not Items.Get(PurchLine."No.") then
                        Error(Text0007);
                    Items.TestField("Item G/L Budget Account");
                    BudgetGL := Items."Item G/L Budget Account";
                end;

                //Fixed Asset
                if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                    FixedAssets.Reset;
                    FixedAssets.SetRange(FixedAssets."No.", PurchLine."No.");
                    if FixedAssets.FindFirst then begin
                        FAPostingGroup.Reset;
                        FAPostingGroup.SetRange(FAPostingGroup.Code, FixedAssets."FA Posting Group");
                        if FAPostingGroup.FindFirst then
                            if PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Maintenance then begin
                                BudgetGL := FAPostingGroup."Maintenance Expense Account";
                                if BudgetGL = '' then
                                    Error(Text0008, PurchLine."No.");
                            end else begin
                                BudgetGL := FAPostingGroup."Acquisition Cost Account";
                                if BudgetGL = '' then
                                    Error(Text0009, PurchLine."No.");
                            end;
                    end;
                end;

                //G/L Account
                if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
                    BudgetGL := PurchLine."No.";
                    // IF GLAccount.GET(PurchLine."No.") THEN
                    //  GLAccount.TESTFIELD(GLAccount."Budget Controlled",TRUE);
                end;

                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(PurchHeader."Document Date", 2), Date2DMY(PurchHeader."Document Date", 3));
                CurrMonth := Date2DMY(PurchHeader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PurchHeader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PurchHeader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                Budget.SetRange(Budget."Global Dimension 1 Code", PurchLine."Shortcut Dimension 1 Code");
                Budget.SetRange(Budget."Global Dimension 2 Code", PurchLine."Shortcut Dimension 2 Code");
                if PurchLine."Shortcut Dimension 3 Code" <> '' then
                    Budget.SetRange(Budget."Budget Dimension 3 Code", PurchLine."Shortcut Dimension 3 Code");
                if PurchLine."Shortcut Dimension 4 Code" <> '' then
                    Budget.SetRange(Budget."Budget Dimension 4 Code", PurchLine."Shortcut Dimension 4 Code");
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.SetRange(Commitments."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 1 Code");
                Commitments.SetRange(Commitments."Shortcut Dimension 2 Code", PurchLine."Shortcut Dimension 2 Code");
                if PurchLine."Shortcut Dimension 3 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 3 Code", PurchLine."Shortcut Dimension 3 Code");
                if PurchLine."Shortcut Dimension 4 Code" <> '' then
                    Commitments.SetRange(Commitments."Shortcut Dimension 4 Code", PurchLine."Shortcut Dimension 4 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PurchLine."Line Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PurchLine."Line Amount"))));
                end else begin
                    //commit Amounts
                    Commitments.Init;
                    Commitments."Line No." := 0;
                    Commitments.Date := Today;
                    Commitments."Posting Date" := PurchHeader."Document Date";
                    Commitments."Document Type" := Commitments."Document Type"::"Purchase Order";
                    Commitments."Document No." := PurchHeader."No.";
                    Commitments.Amount := PurchLine."Line Amount";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := PurchHeader."Document Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    //Commitments."Type" := Commitments."Type"::Vendor;
                    Commitments.Committed := true;
                    if Commitments.Insert then begin
                        PurchLine.Committed := true;
                        PurchLine.Modify;
                    end;
                end;
            until PurchLine.Next = 0;
        end;
    end;

    procedure PrequalifyVendor(Supplier: Text)
    var
        PrequlificationApplication: Record "Prequlification Application";
        PrequalifiedSuppliers: Record "Prequalified Suppliers";
        SupplierCategory: Record "Supplier Category";
        SupplierCategory2: Record "Supplier Category";
    begin
        PrequlificationApplication.Reset;
        PrequlificationApplication.SetRange(PrequlificationApplication."Supplier Name", Supplier);
        if PrequlificationApplication.FindFirst then begin

            PrequalifiedSuppliers.Reset;
            PrequalifiedSuppliers.SetRange(PrequalifiedSuppliers."VAT Registration No.", PrequlificationApplication."TIN No.");
            if PrequalifiedSuppliers.FindFirst then
                Error(Txt_003);

            Commit;

            PrequalifiedSuppliers.Init;
            PrequalifiedSuppliers."Supplier Name" := PrequlificationApplication."Supplier Name";
            PrequalifiedSuppliers."Procurement Period" := PrequlificationApplication."Procurement Period";
            PrequalifiedSuppliers."Vendor No." := PrequlificationApplication."Vendor No.";
            PrequalifiedSuppliers."E-Mail" := PrequlificationApplication."E-Mail";
            PrequalifiedSuppliers.Prequalified := PrequlificationApplication.Prequalified;
            PrequalifiedSuppliers."Phone No." := PrequlificationApplication."Phone No.";
            PrequalifiedSuppliers."Principal Phone No." := PrequlificationApplication."Principal Phone No.";
            PrequalifiedSuppliers."TIN No." := PrequlificationApplication."TIN No.";
            PrequalifiedSuppliers."Postal Address" := PrequlificationApplication."Postal Address";
            PrequalifiedSuppliers."Postal Code" := PrequlificationApplication."Postal Code";
            PrequalifiedSuppliers.City := PrequlificationApplication.City;
            PrequalifiedSuppliers."Building Name" := PrequlificationApplication."Building Name";
            PrequalifiedSuppliers.Street := PrequlificationApplication.Street;
            PrequalifiedSuppliers.County := PrequlificationApplication.County;
            PrequalifiedSuppliers."County Name" := PrequlificationApplication."County Name";
            PrequalifiedSuppliers.AGPO := PrequlificationApplication.AGPO;
            PrequalifiedSuppliers."AGPO Number" := PrequlificationApplication."AGPO Number";
            PrequalifiedSuppliers."Incorporation Cert. No." := PrequlificationApplication."Incorporation Cert. No.";
            PrequalifiedSuppliers."Incorporation Date" := PrequlificationApplication."Incorporation Date";
            PrequalifiedSuppliers."Bank Code" := PrequlificationApplication."Bank Code";
            PrequalifiedSuppliers."Bank Name" := PrequlificationApplication."Bank Name";
            PrequalifiedSuppliers."Bank Branch Code" := PrequlificationApplication."Bank Branch Code";
            PrequalifiedSuppliers."Bank Branch Name" := PrequlificationApplication."Bank Branch Name";
            PrequalifiedSuppliers."Bank Account Name" := PrequlificationApplication."Bank Account Name";
            PrequalifiedSuppliers."Bank Account No." := PrequlificationApplication."Bank Account No.";
            PrequalifiedSuppliers."VAT Registered" := PrequlificationApplication."VAT Registered";
            PrequalifiedSuppliers."VAT Registration No." := PrequlificationApplication."VAT Registration No.";
            PrequalifiedSuppliers."USER ID" := PrequlificationApplication."USER ID";
            PrequalifiedSuppliers.Prequalified := true;
            PrequalifiedSuppliers."Pre-Qualified By" := UserId;
            PrequalifiedSuppliers."Date Pre-Qualified" := PrequlificationApplication."Date Pre-Qualified";
            PrequalifiedSuppliers.Insert;
        end;
    end;

    procedure CreateStockLevelEmail(PurchaseRequisitionNo: Code[40]; EmailAddress: Text; ItemNo: Code[50])
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        PurchaseHeaders: Record "Purchase Requisitions";
    begin
        //SMTPMailSetup.Get;
        PurchaseHeaders.Get(PurchaseRequisitionNo);

        EmailBody := '';
        EmailBody := EmailBody + 'The following item has its stock level below the set limit.<br>';
        EmailBody := EmailBody + 'Item details:<br>';
        EmailBody := EmailBody + '_______________________________________________________<br>';
        EmailBody := EmailBody + 'Item No.:' + ItemNo + '<br>';
        EmailBody := EmailBody + 'Purchase requisition created:' + PurchaseHeaders."No." + '<br>';
        EmailBody := EmailBody + 'Kindly log into the system and act on the purchase requisition created above.<br><br>';
        EmailBody := EmailBody + 'Kind Regards<br>';
        EmailBody := EmailBody + '_____________________________________________________________________________<br>';
        EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

        SenderName := ' procurement Department';
        //SenderAddress := SMTPMailSetup."User ID";
        Subject := 'Depleted stock level for Item No - ' + ItemNo;
        Recipients := EmailAddress;
        RecipientsBCC := '';

        InsertRFQEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, '');
    end;

    procedure CreateBIDLPO("BidNo.": Code[20])
    var
        BidAnalysisHeader: Record "Bid Analysis Header";
        BidAnalysisItems: Record "Bid Analysis Items";
        PurchaseHeaderBID: Record "Purchase Header";
        PurchaseLineBID: Record "Purchase Line";
        PurchaseHeader2: Record "Purchase Header";
        PurchaseLine2: Record "Purchase Line";
        PurchaseOrderCard: Page "Purchase Order";
        RequisitionLine: Record "Purchase Requisition Line";
        "LPONo.": Code[20];
        CreateLPONumber: Label 'Ae you sure you want to cretae an ORDER from the BID card?';
        GeneralSetup: Record "Purchases & Payables Setup";
        "NoSeriesMgt.": Codeunit "No. Series";
        NoPurchaseLineBIDs: Label 'BID No.not approved';
        LinesNos: Integer;
        PurchaseLineBID2: Record "Purchase Line";
        PHeader: Record "Purchase Header";
        PurchaseLineBIDext: Record "Purchase Line";
    begin
        //Modify exisiting LPO
        BidAnalysisHeader.Reset;
        BidAnalysisHeader.SetRange(BidAnalysisHeader."No.", "BidNo.");
        if BidAnalysisHeader.FindFirst then begin
            PurchaseHeader2.Reset;
            PurchaseHeader2.SetRange(PurchaseHeader2."Expense Period", "BidNo.");
            if PurchaseHeader2.FindFirst then begin
                if PurchaseHeader2.Status = PurchaseHeader2.Status::Open then begin

                    PurchaseLineBIDext.Reset();
                    PurchaseLineBIDext.SetRange(PurchaseLineBIDext."Document No.", PurchaseHeader2."No.");
                    if PurchaseLineBIDext.FindSet() then
                        PurchaseLineBIDext.DeleteAll();

                    PurchaseHeaderBID.Reset;
                    PurchaseHeaderBID.SetRange(PurchaseHeaderBID."No.", PurchaseHeader2."No.");
                    if PurchaseHeaderBID.FindFirst() then begin

                        PurchaseHeaderBID."Buy-from Vendor No." := BidAnalysisHeader."Selected Vendor";
                        PurchaseHeaderBID.Validate(PurchaseHeaderBID."Buy-from Vendor No.");
                        PurchaseHeaderBID."Shortcut Dimension 1 Code" := BidAnalysisHeader."Global Dimension 1 Code";
                        PurchaseHeaderBID."Shortcut Dimension 2 Code" := BidAnalysisHeader."Global Dimension 2 Code";
                        PurchaseHeaderBID."Shortcut Dimension 3 Code" := BidAnalysisHeader."Shortcut Dimension 3 Code";
                        PurchaseHeaderBID."Shortcut Dimension 4 Code" := BidAnalysisHeader."Shortcut Dimension 4 Code";
                        PurchaseHeaderBID."Shortcut Dimension 5 Code" := BidAnalysisHeader."Shortcut Dimension 5 Code";
                        PurchaseHeaderBID."Posting Description" := CopyStr(BidAnalysisHeader.Description, 1, 100);
                        PurchaseHeaderBID.Validate(PurchaseHeaderBID."Shortcut Dimension 1 Code");
                        PurchaseHeaderBID.Validate(PurchaseHeaderBID."Shortcut Dimension 2 Code");
                        PurchaseHeaderBID.Validate(PurchaseHeaderBID."Shortcut Dimension 3 Code");
                        PurchaseHeaderBID.Validate(PurchaseHeaderBID."Shortcut Dimension 4 Code");
                        PurchaseHeaderBID."RFQ No." := BidAnalysisHeader."RFQ No.";
                        RequisitionLine.Reset();
                        RequisitionLine.SetRange(RequisitionLine."Request for Quotation No.", BidAnalysisHeader."RFQ No.");
                        if RequisitionLine.FindFirst() then
                            PurchaseHeaderBID."PRF No." := RequisitionLine."Document No.";
                        if PurchaseHeaderBID.Modify() then begin
                            PHeader.Reset;
                            PHeader.SetRange(PHeader."No.", PurchaseHeader2."No.");
                            if PHeader.FindFirst then begin
                                // PHeader.Validate(PHeader."Shortcut Dimension 1 Code");
                                // PHeader.Validate(PHeader."Shortcut Dimension 2 Code");
                                // PHeader.Validate(PHeader."Shortcut Dimension 3 Code");
                                // PHeader.Validate(PHeader."Shortcut Dimension 4 Code");
                                // PHeader.Modify;
                            end;
                            BidAnalysisItems.Reset;
                            BidAnalysisItems.SetRange(BidAnalysisItems."Document No.", "BidNo.");
                            BidAnalysisItems.SetRange(BidAnalysisItems."Vendor No.", BidAnalysisHeader."Selected Vendor");
                            if BidAnalysisItems.FindSet then begin
                                repeat
                                    PurchaseLineBID2.Reset;
                                    PurchaseLineBID2.SetRange(PurchaseLineBID2."Document No.", PurchaseHeader2."No.");
                                    if PurchaseLineBID2.FindLast then
                                        LinesNos := PurchaseLineBID2."Line No.";

                                    PurchaseLineBID.Init;
                                    PurchaseLineBID."Line No." := LinesNos + 1;
                                    PurchaseLineBID."Document No." := PurchaseHeader2."No.";
                                    PurchaseLineBID."Document Type" := PurchaseLineBID."Document Type"::Order;
                                    PurchaseLineBID.Validate(PurchaseLineBID."Document No.");
                                    PurchaseLineBID.Type := BidAnalysisItems.Type;
                                    PurchaseLineBID."No." := BidAnalysisItems."No.";
                                    PurchaseLineBID.Validate(PurchaseLineBID."No.");
                                    PurchaseLineBID.Description := CopyStr(BidAnalysisItems.Description, 1, 100);
                                    PurchaseLineBID.Quantity := BidAnalysisItems.Quantity;
                                    PurchaseLineBID.Validate(PurchaseLineBID.Quantity);
                                    PurchaseLineBID."Location Code" := BidAnalysisItems."Location Code";
                                    PurchaseLineBID.Validate(PurchaseLineBID."Location Code");
                                    PurchaseLineBID."Direct Unit Cost" := BidAnalysisItems."Unit Cost Incl. VAT";
                                    PurchaseLineBID.Validate(PurchaseLineBID."Direct Unit Cost");
                                    if BidAnalysisItems.Type = BidAnalysisItems.Type::"G/L Account" then begin
                                        PurchaseLineBID."Gen. Bus. Posting Group" := 'LOCAL';
                                        PurchaseLineBID."Gen. Prod. Posting Group" := 'GENERAL';
                                    end;
                                    //PurchaseLineBID."VAT Prod. Posting Group" := BidAnalysisItems."VAT Prod. Posting Group";
                                    //PurchaseLineBID.Validate(PurchaseLineBID."VAT Prod. Posting Group");
                                    PurchaseLineBID."Shortcut Dimension 1 Code" := BidAnalysisHeader."Global Dimension 1 Code";
                                    PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 1 Code");
                                    PurchaseLineBID."Shortcut Dimension 2 Code" := BidAnalysisHeader."Global Dimension 2 Code";
                                    PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 2 Code");
                                    PurchaseLineBID."Shortcut Dimension 3 Code" := BidAnalysisHeader."Shortcut Dimension 3 Code";
                                    PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 3 Code");
                                    PurchaseLineBID."Shortcut Dimension 4 Code" := BidAnalysisHeader."Shortcut Dimension 4 Code";
                                    PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 4 Code");
                                    PurchaseLineBID."Part No." := BidAnalysisItems."Part No.";
                                    PurchaseLineBID."Alternative Part No. 1" := BidAnalysisItems."Alternative Part No. 1";
                                    PurchaseLineBID."Alternative Part No. 2" := BidAnalysisItems."Alternative Part No. 2";
                                    PurchaseLineBID."Alternative Part No. 3" := BidAnalysisItems."Alternative Part No. 3";
                                    PurchaseLineBID."Alternative Part No. 4" := BidAnalysisItems."Alternative Part No. 4";
                                    PurchaseLineBID."Shortcut Dimension 5 Code" := BidAnalysisHeader."Shortcut Dimension 5 Code";
                                    PurchaseLineBID."Shortcut Dimension 6 Code" := BidAnalysisHeader."Shortcut Dimension 6 Code";
                                    PurchaseLineBID."Shortcut Dimension 7 Code" := BidAnalysisHeader."Shortcut Dimension 7 Code";
                                    PurchaseLineBID."Shortcut Dimension 8 Code" := BidAnalysisHeader."Shortcut Dimension 8 Code";
                                    PurchaseLineBID.Insert;
                                until BidAnalysisItems.Next = 0;
                            end;
                        end;
                    end;
                    PurchaseHeader2.Reset;
                    PurchaseHeader2.SetRange("No.", PurchaseHeader2."No.");
                    PurchaseOrderCard.SetTableView(PurchaseHeader2);
                    PurchaseOrderCard.Run;
                end;
            end else begin
                //Create New LPO
                "LPONo." := '';

                if Confirm(CreateLPONumber) then begin

                    GeneralSetup.Get;
                    GeneralSetup.TestField(GeneralSetup."Order Nos.");

                    "LPONo." := "NoSeriesMgt.".GetNextNo(GeneralSetup."Order Nos.", 0D, true);

                    PurchaseHeaderBID.Reset;
                    PurchaseHeaderBID."No." := "LPONo.";
                    PurchaseHeaderBID.Validate(PurchaseHeaderBID."No.");
                    PurchaseHeaderBID."Document Type" := PurchaseHeaderBID."Document Type"::Order;
                    PurchaseHeaderBID."Posting No. Series" := 'P_INV+';
                    PurchaseHeaderBID."Receiving No. Series" := 'P_RCT+';
                    PurchaseHeaderBID."Document Date" := Today;
                    PurchaseHeaderBID."Posting Date" := Today;
                    PurchaseHeaderBID."Buy-from Vendor No." := BidAnalysisHeader."Selected Vendor";
                    PurchaseHeaderBID.Validate(PurchaseHeaderBID."Buy-from Vendor No.");
                    PurchaseHeaderBID."Expense Period" := BidAnalysisHeader."No.";
                    PurchaseHeaderBID."RFQ No." := BidAnalysisHeader."RFQ No.";
                    RequisitionLine.Reset();
                    RequisitionLine.SetRange(RequisitionLine."Request for Quotation No.", BidAnalysisHeader."RFQ No.");
                    if RequisitionLine.FindFirst() then
                        PurchaseHeaderBID."PRF No." := RequisitionLine."Document No.";
                    PurchaseHeaderBID."Shortcut Dimension 1 Code" := BidAnalysisHeader."Global Dimension 1 Code";
                    PurchaseHeaderBID."Shortcut Dimension 2 Code" := BidAnalysisHeader."Global Dimension 2 Code";
                    PurchaseHeaderBID."Shortcut Dimension 3 Code" := BidAnalysisHeader."Shortcut Dimension 3 Code";
                    PurchaseHeaderBID."Shortcut Dimension 4 Code" := BidAnalysisHeader."Shortcut Dimension 4 Code";
                    PurchaseHeaderBID."Shortcut Dimension 5 Code" := BidAnalysisHeader."Shortcut Dimension 5 Code";
                    PurchaseHeaderBID."Posting Description" := CopyStr(BidAnalysisHeader.Description, 1, 100);
                    PurchaseHeaderBID."User ID" := UserId;
                    if PurchaseHeaderBID.Insert then begin
                        PHeader.Reset;
                        PHeader.SetRange(PHeader."No.", "LPONo.");
                        if PHeader.FindFirst then begin
                            PHeader.Validate(PHeader."Shortcut Dimension 1 Code");
                            PHeader.Validate(PHeader."Shortcut Dimension 2 Code");
                            PHeader.Validate(PHeader."Shortcut Dimension 3 Code");
                            PHeader.Validate(PHeader."Shortcut Dimension 4 Code");
                            PHeader.Modify;
                        end;
                        BidAnalysisItems.Reset;
                        BidAnalysisItems.SetRange(BidAnalysisItems."Document No.", "BidNo.");
                        BidAnalysisItems.SetRange(BidAnalysisItems."Vendor No.", BidAnalysisHeader."Selected Vendor");
                        if BidAnalysisItems.FindSet then begin
                            repeat
                                PurchaseLineBID2.Reset;
                                PurchaseLineBID2.SetRange(PurchaseLineBID2."Document No.", "LPONo.");
                                if PurchaseLineBID2.FindLast then
                                    LinesNos := PurchaseLineBID2."Line No.";

                                PurchaseLineBID.Init;
                                PurchaseLineBID."Line No." := LinesNos + 1;
                                PurchaseLineBID."Document No." := "LPONo.";
                                PurchaseLineBID."Document Type" := PurchaseLineBID."Document Type"::Order;
                                PurchaseLineBID.Validate(PurchaseLineBID."Document No.");
                                PurchaseLineBID.Type := BidAnalysisItems.Type;
                                PurchaseLineBID."No." := BidAnalysisItems."No.";
                                PurchaseLineBID.Validate(PurchaseLineBID."No.");
                                PurchaseLineBID.Description := CopyStr(BidAnalysisItems.Description, 1, 100);
                                PurchaseLineBID.Quantity := BidAnalysisItems.Quantity;
                                PurchaseLineBID.Validate(PurchaseLineBID.Quantity);
                                PurchaseLineBID."Location Code" := BidAnalysisItems."Location Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Location Code");
                                PurchaseLineBID."Direct Unit Cost" := BidAnalysisItems."Unit Cost Incl. VAT";
                                PurchaseLineBID.Validate(PurchaseLineBID."Direct Unit Cost");
                                if BidAnalysisItems.Type = BidAnalysisItems.Type::"G/L Account" then begin
                                    PurchaseLineBID."Gen. Bus. Posting Group" := 'LOCAL';
                                    PurchaseLineBID."Gen. Prod. Posting Group" := 'GENERAL';
                                end;
                                //PurchaseLineBID."VAT Prod. Posting Group" := BidAnalysisItems."VAT Prod. Posting Group";
                                //PurchaseLineBID.Validate(PurchaseLineBID."VAT Prod. Posting Group");
                                PurchaseLineBID."Shortcut Dimension 1 Code" := BidAnalysisHeader."Global Dimension 1 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 1 Code");
                                PurchaseLineBID."Shortcut Dimension 2 Code" := BidAnalysisHeader."Global Dimension 2 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 2 Code");
                                PurchaseLineBID."Shortcut Dimension 3 Code" := BidAnalysisHeader."Shortcut Dimension 3 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 3 Code");
                                PurchaseLineBID."Shortcut Dimension 4 Code" := BidAnalysisHeader."Shortcut Dimension 4 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 4 Code");
                                PurchaseLineBID."Shortcut Dimension 5 Code" := BidAnalysisHeader."Shortcut Dimension 5 Code";
                                PurchaseLineBID."Shortcut Dimension 6 Code" := BidAnalysisHeader."Shortcut Dimension 6 Code";
                                PurchaseLineBID."Shortcut Dimension 7 Code" := BidAnalysisHeader."Shortcut Dimension 7 Code";
                                PurchaseLineBID."Shortcut Dimension 8 Code" := BidAnalysisHeader."Shortcut Dimension 8 Code";
                                PurchaseLineBID.Insert;
                            until BidAnalysisItems.Next = 0;
                        end;
                    end;
                    Message('ORDER no.' + "LPONo." + ' successfully created for BID no.' + BidAnalysisHeader."No.");

                    BidAnalysisHeader."LPO No. Assigned" := "LPONo.";
                    BidAnalysisHeader.Modify;

                    PurchaseHeader2.Reset;
                    PurchaseHeader2.SetRange("No.", PurchaseHeaderBID."No.");
                    PurchaseOrderCard.SetTableView(PurchaseHeader2);
                    PurchaseOrderCard.Run;
                end;
            end;
        end else begin
            Message(NoPurchaseLineBIDs);
        end;
    end;

    procedure CreateNewBIDLPO("BidNo.": Code[20])
    var
        BidAnalysisHeader: Record "Bid Analysis Header";
        BidAnalysisItems: Record "Bid Analysis Items";
        PurchaseHeaderBID: Record "Purchase Header";
        PurchaseLineBID: Record "Purchase Line";
        PurchaseHeader2: Record "Purchase Header";
        PurchaseLine2: Record "Purchase Line";
        PurchaseOrderCard: Page "Purchase Order";
        "LPONo.": Code[20];
        CreateLPONumber: Label 'Ae you sure you want to cretae an ORDER from the BID card?';
        GeneralSetup: Record "Purchases & Payables Setup";
        "NoSeriesMgt.": Codeunit "No. Series";
        NoPurchaseLineBIDs: Label 'BID No.not approved';
        LinesNos: Integer;
        PurchaseLineBID2: Record "Purchase Line";
        PHeader: Record "Purchase Header";
        PurchaseLineBIDext: Record "Purchase Line";
        RequisitionLine: Record "Purchase Requisition Line";
    begin

        BidAnalysisHeader.Reset;
        BidAnalysisHeader.SetRange(BidAnalysisHeader."No.", "BidNo.");
        if BidAnalysisHeader.FindFirst then begin
            PurchaseHeader2.Reset;
            PurchaseHeader2.SetRange(PurchaseHeader2."Expense Period", "BidNo.");
            if PurchaseHeader2.FindSet() then begin
                if PurchaseHeader2.Archive <> true then begin
                    repeat
                        Error('Purchase Order %1 must be archived before performing this action', PurchaseHeader2."No.");
                    until PurchaseHeader2.Next() = 0;
                end;

                "LPONo." := '';

                if Confirm(CreateLPONumber) then begin

                    GeneralSetup.Get;
                    GeneralSetup.TestField(GeneralSetup."Order Nos.");

                    "LPONo." := "NoSeriesMgt.".GetNextNo(GeneralSetup."Order Nos.", 0D, true);

                    PurchaseHeaderBID.Reset;
                    PurchaseHeaderBID."No." := "LPONo.";
                    PurchaseHeaderBID.Validate(PurchaseHeaderBID."No.");
                    PurchaseHeaderBID."Document Type" := PurchaseHeaderBID."Document Type"::Order;
                    PurchaseHeaderBID."Posting No. Series" := 'P_INV+';
                    PurchaseHeaderBID."Receiving No. Series" := 'P_RCT+';
                    PurchaseHeaderBID."Document Date" := Today;
                    PurchaseHeaderBID."Posting Date" := Today;
                    PurchaseHeaderBID."Buy-from Vendor No." := BidAnalysisHeader."Selected Vendor";
                    PurchaseHeaderBID.Validate(PurchaseHeaderBID."Buy-from Vendor No.");
                    PurchaseHeaderBID."Expense Period" := BidAnalysisHeader."No.";
                    PurchaseHeaderBID."RFQ No." := BidAnalysisHeader."RFQ No.";
                    RequisitionLine.Reset();
                    RequisitionLine.SetRange(RequisitionLine."Request for Quotation No.", BidAnalysisHeader."RFQ No.");
                    if RequisitionLine.FindFirst() then
                        PurchaseHeaderBID."PRF No." := RequisitionLine."Document No.";
                    PurchaseHeaderBID."Shortcut Dimension 1 Code" := BidAnalysisHeader."Global Dimension 1 Code";
                    PurchaseHeaderBID."Shortcut Dimension 2 Code" := BidAnalysisHeader."Global Dimension 2 Code";
                    PurchaseHeaderBID."Shortcut Dimension 3 Code" := BidAnalysisHeader."Shortcut Dimension 3 Code";
                    PurchaseHeaderBID."Shortcut Dimension 4 Code" := BidAnalysisHeader."Shortcut Dimension 4 Code";
                    PurchaseHeaderBID."Shortcut Dimension 5 Code" := BidAnalysisHeader."Shortcut Dimension 5 Code";
                    PurchaseHeaderBID."Posting Description" := CopyStr(BidAnalysisHeader.Description, 1, 100);
                    PurchaseHeaderBID."User ID" := UserId;
                    if PurchaseHeaderBID.Insert then begin
                        PHeader.Reset;
                        PHeader.SetRange(PHeader."No.", "LPONo.");
                        if PHeader.FindFirst then begin
                            PHeader.Validate(PHeader."Shortcut Dimension 1 Code");
                            PHeader.Validate(PHeader."Shortcut Dimension 2 Code");
                            PHeader.Validate(PHeader."Shortcut Dimension 3 Code");
                            PHeader.Validate(PHeader."Shortcut Dimension 4 Code");
                            PHeader.Modify;
                        end;
                        BidAnalysisItems.Reset;
                        BidAnalysisItems.SetRange(BidAnalysisItems."Document No.", "BidNo.");
                        BidAnalysisItems.SetRange(BidAnalysisItems."Vendor No.", BidAnalysisHeader."Selected Vendor");
                        if BidAnalysisItems.FindSet then begin
                            repeat
                                PurchaseLineBID2.Reset;
                                PurchaseLineBID2.SetRange(PurchaseLineBID2."Document No.", "LPONo.");
                                if PurchaseLineBID2.FindLast then
                                    LinesNos := PurchaseLineBID2."Line No.";

                                PurchaseLineBID.Init;
                                PurchaseLineBID."Line No." := LinesNos + 1;
                                PurchaseLineBID."Document No." := "LPONo.";
                                PurchaseLineBID."Document Type" := PurchaseLineBID."Document Type"::Order;
                                PurchaseLineBID.Validate(PurchaseLineBID."Document No.");
                                PurchaseLineBID.Type := BidAnalysisItems.Type;
                                PurchaseLineBID."No." := BidAnalysisItems."No.";
                                PurchaseLineBID.Validate(PurchaseLineBID."No.");
                                PurchaseLineBID.Description := CopyStr(BidAnalysisItems.Description, 1, 100);
                                PurchaseLineBID.Quantity := BidAnalysisItems.Quantity;
                                PurchaseLineBID.Validate(PurchaseLineBID.Quantity);
                                PurchaseLineBID."Location Code" := BidAnalysisItems."Location Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Location Code");
                                PurchaseLineBID."Direct Unit Cost" := BidAnalysisItems."Unit Cost Incl. VAT";
                                PurchaseLineBID.Validate(PurchaseLineBID."Direct Unit Cost");
                                if BidAnalysisItems.Type = BidAnalysisItems.Type::"G/L Account" then begin
                                    PurchaseLineBID."Gen. Bus. Posting Group" := 'LOCAL';
                                    PurchaseLineBID."Gen. Prod. Posting Group" := 'GENERAL';
                                end;
                                //PurchaseLineBID."VAT Prod. Posting Group" := BidAnalysisItems."VAT Prod. Posting Group";
                                //PurchaseLineBID.Validate(PurchaseLineBID."VAT Prod. Posting Group");
                                PurchaseLineBID."Shortcut Dimension 1 Code" := BidAnalysisHeader."Global Dimension 1 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 1 Code");
                                PurchaseLineBID."Shortcut Dimension 2 Code" := BidAnalysisHeader."Global Dimension 2 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 2 Code");
                                PurchaseLineBID."Shortcut Dimension 3 Code" := BidAnalysisHeader."Shortcut Dimension 3 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 3 Code");
                                PurchaseLineBID."Shortcut Dimension 4 Code" := BidAnalysisHeader."Shortcut Dimension 4 Code";
                                PurchaseLineBID.Validate(PurchaseLineBID."Shortcut Dimension 4 Code");
                                PurchaseLineBID."Shortcut Dimension 5 Code" := BidAnalysisHeader."Shortcut Dimension 5 Code";
                                PurchaseLineBID."Shortcut Dimension 6 Code" := BidAnalysisHeader."Shortcut Dimension 6 Code";
                                PurchaseLineBID."Shortcut Dimension 7 Code" := BidAnalysisHeader."Shortcut Dimension 7 Code";
                                PurchaseLineBID."Shortcut Dimension 8 Code" := BidAnalysisHeader."Shortcut Dimension 8 Code";
                                PurchaseLineBID.Insert;
                            until BidAnalysisItems.Next = 0;
                        end;
                    end;
                    Message('ORDER no.' + "LPONo." + ' successfully created for BID no.' + BidAnalysisHeader."No.");

                    BidAnalysisHeader."LPO No. Assigned" := "LPONo.";
                    BidAnalysisHeader.Modify;

                    PurchaseHeader2.Reset;
                    PurchaseHeader2.SetRange("No.", PurchaseHeaderBID."No.");
                    PurchaseOrderCard.SetTableView(PurchaseHeader2);
                    PurchaseOrderCard.Run;
                end;
            end;
        end else begin
            Message(NoPurchaseLineBIDs);
        end;
    end;

    procedure CreatePurchaseRequisitionEmailOnFullApproval("RequisitionNo.": Code[20])
    var
        PurchaseRequisitions: Record "Purchase Requisitions";
        Customer: Record Customer;
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimesnsionValue: Record "Dimension Value";
    begin
        PurchaseRequisitions.Get("RequisitionNo.");
        PurchaseRequisitions.CalcFields(PurchaseRequisitions.Amount);

        CompanyInformation.Get;
        PurchasesPayablesSetup.Get;

        DimesnsionValue.Reset;
        DimesnsionValue.SetRange(Code, PurchaseRequisitions."Global Dimension 1 Code");
        if DimesnsionValue.FindFirst() then begin

            EmailBody := '';
            EmailBody := EmailBody + 'Dear Procurement Team Member, ' + ',<br><br>';
            EmailBody := EmailBody + 'Here are details of a purchase requisition that has been fully approved for your action : ' + '<br>';
            EmailBody := EmailBody + '_____________________________________________________________________________<br>';
            EmailBody := EmailBody + 'Purchase Requisition No.: ' + PurchaseRequisitions."No." + '<br>';
            EmailBody := EmailBody + 'Employee: ' + PurchaseRequisitions."User ID" + '<br>';
            EmailBody := EmailBody + 'Requisitiin Project: ' + PurchaseRequisitions."Global Dimension 1 Code" + '<br>';
            EmailBody := EmailBody + 'Request Date: ' + Format(PurchaseRequisitions."Document Date") + '<br>';
            EmailBody := EmailBody + 'Amount: ' + Format(PurchaseRequisitions.Amount) + '<br>';
            EmailBody := EmailBody + 'Description: ' + PurchaseRequisitions.Description + '<br>';
            EmailBody := EmailBody + 'Regards ' + '.<br><br>';
            EmailBody := EmailBody + '_____________________________________________________________________________<br>';
            EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

            CompanyInformation.Get;
            SenderName := CompanyInformation.Name;
            Subject := 'Purchase Request - ' + PurchaseRequisitions."User ID" + '-' + Format(PurchaseRequisitions.Amount);
            Recipients := DimesnsionValue."E-Mail";
            RecipientsBCC := '';

            if Recipients <> '' then
                InsertRFQEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, PurchaseRequisitions."No.");


        end;
    end;

    procedure CreatePurchaseRequisitionEmail("RequisitionNo.": Code[20])
    var
        PurchaseRequisitions: Record "Purchase Requisitions";
        Customer: Record Customer;
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchaseRequisitions.Get("RequisitionNo.");
        PurchaseRequisitions.CalcFields(PurchaseRequisitions.Amount);

        CompanyInformation.Get;
        PurchasesPayablesSetup.Get;

        UserSetup.Reset;
        UserSetup.SetRange("User ID", PurchasesPayablesSetup."User to replenish Stock");
        if UserSetup.FindSet then begin
            repeat
                EmailBody := '';
                EmailBody := EmailBody + 'Dear ' + UserSetup."User ID" + ',<br><br>';
                EmailBody := EmailBody + 'Here are details of a purchase requisition that has been submited for your action : ' + '<br>';
                EmailBody := EmailBody + '_____________________________________________________________________________<br>';
                EmailBody := EmailBody + 'Purchase Requisition No.: ' + PurchaseRequisitions."No." + '<br>';
                EmailBody := EmailBody + 'Employee: ' + PurchaseRequisitions."User ID" + '<br>';
                EmailBody := EmailBody + 'Employee Project: ' + PurchaseRequisitions."Global Dimension 1 Code" + '<br>';
                EmailBody := EmailBody + 'Request Date: ' + Format(PurchaseRequisitions."Document Date") + '<br>';
                EmailBody := EmailBody + 'Amount: ' + Format(PurchaseRequisitions.Amount) + '<br>';
                EmailBody := EmailBody + 'Description: ' + PurchaseRequisitions.Description + '<br>';
                EmailBody := EmailBody + 'Find attached Purchase Requisition  ' + '.<br>';
                EmailBody := EmailBody + 'Regards ' + '.<br><br>';
                EmailBody := EmailBody + '_____________________________________________________________________________<br>';
                EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

                CompanyInformation.Get;
                SenderName := CompanyInformation.Name;
                Subject := 'Purchase Requestion - ' + PurchaseRequisitions."User ID" + '-' + Format(PurchaseRequisitions.Amount);
                Recipients := UserSetup."E-Mail";
                RecipientsBCC := '';

                if Recipients <> '' then
                    InsertRFQEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, PurchaseRequisitions."No.");

            until UserSetup.Next = 0;
        end;
    end;

    procedure CreateRejectionEmails(DonNo: Code[20])
    var
        PurchaseRequisitions: Record "Purchase Requisitions";
        StoreRequisition: Record "Store Requisition Header";
        // Imprest: Record "Imprest Header";
        // ImprestSurrender: Record "Imprest Surrender Header";
        // FundsClaim: Record "Funds Claim Header";
        // JourcnalVoucher: Record "Journal Voucher Header";
        // ActivityHeader: Record "Travel Request Header";
        // PaymentVoucher: Record "Payment Header";
        // FundsTransfer: Record "Funds Transfer Header";
        PurchaseHeader: Record "Purchase Header";
        Customer: Record Customer;
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimesnsionValue: Record "Dimension Value";
        ApprovalEntries: Record "Approval Entry";
        ApprovalComments: Record "Approval Comment Line";
        ApprovalCommentLines: Record "Approval Comment Line";
        Emailto: Text;
        Projectcode: Text;
        DocumentType: Text;
    begin

        ApprovalCommentLines.Reset();
        ApprovalCommentLines.SetRange(ApprovalCommentLines."Document No.", DonNo);
        ApprovalCommentLines.SetRange(ApprovalCommentLines."Email Sent", false);
        if ApprovalCommentLines.FindFirst then begin

            CompanyInformation.Get;

            Emailto := '';
            Projectcode := '';
            DocumentType := '';

            PurchaseRequisitions.reset;
            PurchaseRequisitions.SetRange(PurchaseRequisitions."No.", DonNo);
            if PurchaseRequisitions.FindFirst() then begin
                Emailto := PurchaseRequisitions."User ID";
                Projectcode := PurchaseRequisitions."Global Dimension 1 Code";
                DocumentType := 'Purchase requisition';
            end;
            StoreRequisition.Reset();
            StoreRequisition.SetRange(StoreRequisition."No.", DonNo);
            if StoreRequisition.FindFirst() then begin
                Emailto := StoreRequisition."User ID";
                Projectcode := StoreRequisition."Global Dimension 1 Code";
                DocumentType := 'Store Requisition';
            end;
            // Imprest.Reset();
            // Imprest.SetRange(Imprest."No.", DonNo);
            // if Imprest.FindFirst() then begin
            //     Emailto := Imprest."User ID";
            //     Projectcode := Imprest."Global Dimension 1 Code";
            //     DocumentType := 'Imprest Requisition';
            //end;

            // ImprestSurrender.Reset();
            // ImprestSurrender.SetRange(ImprestSurrender."No.", DonNo);
            // if ImprestSurrender.FindFirst() then begin
            //     Emailto := ImprestSurrender."User ID";
            //     Projectcode := ImprestSurrender."Global Dimension 1 Code";
            //     DocumentType := 'Imprest Surrender';
            //end;

            // FundsClaim.Reset();
            // FundsClaim.SetRange(FundsClaim."No.", DonNo);
            // if FundsClaim.FindFirst() then begin
            //     Emailto := FundsClaim."User ID";
            //     Projectcode := FundsClaim."Global Dimension 1 Code";
            //     DocumentType := 'Funds Claim';
            //end;

            // PaymentVoucher.Reset();
            // PaymentVoucher.SetRange(PaymentVoucher."No.", DonNo);
            // if PaymentVoucher.FindFirst() then begin
            //     Emailto := PaymentVoucher."User ID";
            //     Projectcode := PaymentVoucher."Global Dimension 1 Code";
            //     DocumentType := 'Payment Voucher';
            // end;

            // ActivityHeader.Reset();
            // ActivityHeader.SetRange(ActivityHeader."No.", DonNo);
            // if ActivityHeader.FindFirst() then begin
            //     Emailto := ActivityHeader."User ID";
            //     Projectcode := ActivityHeader."Global Dimension 1 Code";
            //     DocumentType := 'Activity Request';
            // end;

            // FundsTransfer.Reset();
            // FundsTransfer.SetRange(FundsTransfer."No.", DonNo);
            // if FundsTransfer.FindFirst() then begin
            //     Emailto := FundsTransfer."User ID";
            //     Projectcode := FundsTransfer."Global Dimension 1 Code";
            //     DocumentType := 'Funds Transfer';
            // end;

            PurchaseHeader.Reset();
            PurchaseHeader.SetRange(PurchaseHeader."No.", DonNo);
            if PurchaseHeader.FindFirst() then begin
                Emailto := PurchaseHeader."User ID";
                Projectcode := PurchaseHeader."Shortcut Dimension 1 Code";
                DocumentType := 'Purchase Order/Purchase Invoice';
            end;

            EmailBody := '';
            EmailBody := EmailBody + 'Dear, ' + Emailto + ',<br><br>';
            EmailBody := EmailBody + 'Here are details of a rejection entry based on the request sent : ' + '<br>';
            EmailBody := EmailBody + '_____________________________________________________________________________<br>';
            EmailBody := EmailBody + 'Document Type: ' + DocumentType + '<br>';
            EmailBody := EmailBody + 'Document No.: ' + ApprovalCommentLines."Document No." + '<br>';
            EmailBody := EmailBody + 'Project Code: ' + Projectcode + '<br>';
            EmailBody := EmailBody + 'Date Time Rejected: ' + Format(ApprovalCommentLines."Date and Time") + '<br>';
            EmailBody := EmailBody + 'Rejected by: ' + ApprovalCommentLines."User ID" + '<br>';
            EmailBody := EmailBody + 'Rejection Comments: ' + ApprovalCommentLines.Comment + ' ' + ApprovalCommentLines."Additional Comments" + '<br>';
            EmailBody := EmailBody + 'Regards ' + '.<br><br>';
            EmailBody := EmailBody + '_____________________________________________________________________________<br>';
            EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

            CompanyInformation.Get;

            if Emailto <> '' then
                UserSetup.Get(Emailto);

            SenderName := CompanyInformation.Name;
            Subject := 'Approval Rejection - ' + ApprovalCommentLines."Document No." +
            '-' + Format(DonNo);
            Recipients := UserSetup."E-Mail";
            RecipientsBCC := '';


            ApprovalCommentLines."Email Sent" := true;
            ApprovalCommentLines.Modify();
            if Recipients <> '' then
                InsertRFQEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, ApprovalCommentLines."Document No.");

        end;
    end;

    procedure CreatePurchaseRequisitionEmailAssigned("RequisitionNo.": Code[20])
    var
        PurchaseRequisitions: Record "Purchase Requisitions";
        Customer: Record Customer;
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[250];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchaseRequisitions.Get("RequisitionNo.");
        PurchaseRequisitions.CalcFields(PurchaseRequisitions.Amount);

        CompanyInformation.Get;
        PurchasesPayablesSetup.Get;

        UserSetup.Reset;
        UserSetup.SetRange("User ID", PurchaseRequisitions."Assigned User ID");
        if UserSetup.FindFirst() then begin

            EmailBody := '';
            EmailBody := EmailBody + 'Dear ' + UserSetup."User ID" + ',<br><br>';
            EmailBody := EmailBody + 'Here are details of a purchase requisition that has been assigned to you for your action : ' + '<br>';
            EmailBody := EmailBody + '_____________________________________________________________________________<br>';
            EmailBody := EmailBody + 'Purchase Requisition No.: ' + PurchaseRequisitions."No." + '<br>';
            EmailBody := EmailBody + 'Employee: ' + PurchaseRequisitions."User ID" + '<br>';
            EmailBody := EmailBody + 'Employee Project: ' + PurchaseRequisitions."Global Dimension 1 Code" + '<br>';
            EmailBody := EmailBody + 'Request Date: ' + Format(PurchaseRequisitions."Document Date") + '<br>';
            EmailBody := EmailBody + 'Amount: ' + Format(PurchaseRequisitions.Amount) + '<br>';
            EmailBody := EmailBody + 'Status: ' + Format(PurchaseRequisitions.Status) + '<br>';
            EmailBody := EmailBody + 'Description: ' + PurchaseRequisitions.Description + '<br>';
            EmailBody := EmailBody + 'Find attached Purchase Requisition  ' + '.<br>';
            EmailBody := EmailBody + 'Regards ' + '.<br><br>';
            EmailBody := EmailBody + '_____________________________________________________________________________<br>';
            EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

            CompanyInformation.Get;
            SenderName := CompanyInformation.Name;
            Subject := 'Purchase Requisition Assignment - ' + Format(PurchaseRequisitions."No.") + '-' + Format(PurchaseRequisitions.Description) + ' ' + Format(PurchaseRequisitions.Amount);
            Recipients := UserSetup."E-Mail";
            RecipientsBCC := '';

            if Recipients <> '' then
                InsertRFQEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, PurchaseRequisitions."No.");

        end;
    end;

    procedure CreatePurchaseHeaderEmailOnFullApproval("DocNo.": Code[20])
    var
        PurchaseHeaders: Record "Purchase Header";
        Customer: Record Customer;
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimesnsionValue: Record "Dimension Value";
    begin
        PurchaseHeaders.Reset();
        PurchaseHeaders.SetRange("No.", "DocNo.");
        if PurchaseHeaders.FindFirst() then begin
            PurchaseHeaders.CalcFields(PurchaseHeaders.Amount);

            CompanyInformation.Get;
            PurchasesPayablesSetup.Get;

            UserSetup.Reset();
            UserSetup.SetRange("User ID", PurchaseHeaders."User ID");
            if UserSetup.FindFirst() then begin
                EmailBody := '';
                EmailBody := EmailBody + 'Dear , ' + UserSetup."User ID" + ',<br><br>';
                EmailBody := EmailBody + 'Here are details of a Purchase Document that has been fully approved for your action : ' + '<br>';
                EmailBody := EmailBody + '_____________________________________________________________________________<br>';
                EmailBody := EmailBody + 'Document Type: ' + format(PurchaseHeaders."Document Type") + '<br>';
                EmailBody := EmailBody + 'No.: ' + PurchaseHeaders."No." + '<br>';
                EmailBody := EmailBody + 'Created By: ' + PurchaseHeaders."User ID" + '<br>';
                EmailBody := EmailBody + ' Project: ' + PurchaseHeaders."Shortcut Dimension 1 Code" + '<br>';
                EmailBody := EmailBody + 'Date: ' + Format(PurchaseHeaders."Posting Date") + '<br>';
                EmailBody := EmailBody + 'Amount: ' + Format(PurchaseHeaders.Amount) + '<br>';
                EmailBody := EmailBody + 'Description: ' + PurchaseHeaders."Posting Description" + '<br>';
                EmailBody := EmailBody + 'Regards ' + '.<br><br>';
                EmailBody := EmailBody + '_____________________________________________________________________________<br>';
                EmailBody := EmailBody + '<i>This is a system generated email, do not reply to this email</i><br>';

                CompanyInformation.Get;
                SenderName := CompanyInformation.Name;
                Subject := 'Purchase Document - ' + PurchaseHeaders."No." + '-' + Format(PurchaseHeaders.Amount);
                Recipients := UserSetup."E-Mail";
                RecipientsBCC := '';

                if Recipients <> '' then
                    InsertRFQEmailMessage(SenderName, SenderAddress, Subject, Recipients, RecipientsCC, RecipientsBCC, EmailBody, PurchaseHeaders."No.");

            end;
        end;
    end;


    /// EXTENDING Standard Code

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValues(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    begin
        PurchLine."Part No." := item."Part No.";
        PurchLine."Alternative Part No. 1" := item."Alternative Part No. 1";
        PurchLine."Alternative Part No. 2" := item."Alternative Part No. 2";
        PurchLine."Alternative Part No. 3" := item."Alternative Part No. 3";
        PurchLine."Alternative Part No. 4" := item."Alternative Part No. 4";
    end;

    /// Exteding Standard Code End

}

