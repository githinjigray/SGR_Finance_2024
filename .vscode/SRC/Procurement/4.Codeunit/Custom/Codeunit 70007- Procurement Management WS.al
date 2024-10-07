codeunit 70007 "Procurement Management WS"
{

    trigger OnRun()
    begin
    end;

    var
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789%20-._abcdefghijklmnopqrstuvwxyz ';
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        PurchaseHeader: Record "Purchase Header";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        PurchaseRequisitionCodes: Record "Purchase Requisition Codes";
        BudgetControlSetup: Record "Budget Control Setup";
        // DocumentMgmt: Codeunit 51535100;
        Employee: Record Employee;
        Location: Record "Location";
        NoSeriesMgt: Codeunit "No. Series";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        // EmployeeAccountWS: Codeunit "Employee Account WS";
        ProcurementApprovalManager: Codeunit "Procurement Approval Manager";
        ProcurementManagement: Codeunit "Procurement Management";
        PortalApproval: Codeunit "Portal Approvals";

    [Scope('Cloud')]
    procedure FormatText(OldText: Text) NewText: Text
    begin
        NewText := '';
        NewText := DELCHR(OldText, '=', DELCHR(OldText, '=', TxtCharsToKeep));
    end;

    [Scope('Cloud')]
    procedure GetItems() Result: Text
    begin
        Item.RESET;
        Item.Setrange(Blocked, false);
        IF Item.FINDSET THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"Code":"' + Item."No." + '",';
                Result += '"Description":"' + FormatText(FORMAT(Item.Description)) + '"';
                Result += '},';
            UNTIL Item.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"Code":"",';
            Result += '"Description":""';
            Result += '}]';
        END;
    end;

    [Scope('Cloud')]
    procedure GetFixedAssets() Result: Text
    begin
        FixedAsset.RESET;
        IF FixedAsset.FINDSET THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"Code":"' + FixedAsset."No." + '",';
                Result += '"Description":"' + FormatText(FORMAT(FixedAsset.Description)) + '"';
                Result += '},';
            UNTIL FixedAsset.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"Code":"",';
            Result += '"Description":""';
            Result += '}]';
        END;
    end;

    [Scope('Cloud')]
    procedure GetLocationCodes() Result: Text
    begin
        Location.RESET;
        Location.SetRange("Use As In-Transit", false);
        IF Location.FINDSET THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"Code":"' + Location.Code + '",';
                Result += '"Name":"' + FORMAT(Location.Name) + '"';
                Result += '},';
            UNTIL Location.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"Code":"",';
            Result += '"Name":""';
            Result += '}]';
        END;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionCodes(RequisitionType: Text[20]) Result: Text
    var
        RequisitionTypeOption: Enum "Requisition Types";
    begin

        Evaluate(RequisitionTypeOption, RequisitionType);

        PurchaseRequisitionCodes.RESET;
        PurchaseRequisitionCodes.SetRange("Requisition Type", RequisitionTypeOption);
        IF PurchaseRequisitionCodes.FINDSET THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"Code":"' + FORMAT(PurchaseRequisitionCodes."Requisition Code") + '",';
                Result += '"Description":"' + FORMAT(PurchaseRequisitionCodes."Requisition Code") + '"';
                Result += '},';
            UNTIL PurchaseRequisitionCodes.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"Code":"",';
            Result += '"Description":""';
            Result += '}]';
        END;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitions(EmployeeNo: Code[20]) Result: Text
    begin
        PurchaseRequisition.RESET;
        PurchaseRequisition.SETRANGE("Employee No.", EmployeeNo);
        IF PurchaseRequisition.FindSet() THEN BEGIN
            Result := '[';
            REPEAT
                PurchaseRequisition.CalcFields(Amount);
                Result += '{';
                Result += '"No":"' + PurchaseRequisition."No." + '",';
                Result += '"DocumentDate":"' + FORMAT(PurchaseRequisition."Document Date", 0, '<day,2>/<month,2>/<year>') + '",';
                Result += '"RequestedReceiptDate":"' + FORMAT(PurchaseRequisition."Requested Receipt Date", 0, '<day,2>/<month,2>/<year>') + '",';
                Result += '"Amount":"' + FormatText(FORMAT(PurchaseRequisition.Amount)) + '",';
                Result += '"Description":"' + FORMAT(PurchaseRequisition.Description) + '",';
                Result += '"ApprovalComment":"' + FormatText(Format(PortalApproval.GetRejectionComments(PurchaseRequisition."No."))) + '",';
                Result += '"GlobalDimension1Code":"' + FORMAT(PurchaseRequisition."Global Dimension 1 Code") + '",';
                Result += '"GlobalDimension2Code":"' + FORMAT(PurchaseRequisition."Global Dimension 2 Code") + '",';
                Result += '"ShortcutDimension3Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 3 Code") + '",';
                Result += '"ShortcutDimension4Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 4 Code") + '",';
                Result += '"ShortcutDimension5Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 5 Code") + '",';
                Result += '"ShortcutDimension6Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 6 Code") + '",';
                Result += '"ShortcutDimension7Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 7 Code") + '",';
                Result += '"ShortcutDimension8Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 8 Code") + '",';
                Result += '"ResponsibilityCenter":"' + FORMAT(PurchaseRequisition."Responsibility Center") + '",';
                Result += '"Status":"' + FORMAT(PurchaseRequisition.Status) + '"';
                Result += '},';
            UNTIL PurchaseRequisition.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"No":"",';
            Result += '"DocumentDate":"",';
            Result += '"RequestedReceiptDate":"",';
            Result += '"LocationCode":"",';
            Result += '"Amount":0,';
            Result += '"Description":"",';
            Result += '"GlobalDimension1Code":"",';
            Result += '"GlobalDimension2Code":"",';
            Result += '"ShortcutDimension3Code":"",';
            Result += '"ShortcutDimension4Code":"",';
            Result += '"ShortcutDimension5Code":"",';
            Result += '"ShortcutDimension6Code":"",';
            Result += '"ShortcutDimension7Code":"",';
            Result += '"ShortcutDimension8Code":"",';
            Result += '"ResponsibilityCenter":"",';
            Result += '"Status":""';
            Result += '}]';
        END;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionByNo(DocumentNo: Code[20]) Result: Text
    begin
        PurchaseRequisition.RESET;
        PurchaseRequisition.SETRANGE("No.", DocumentNo);
        IF PurchaseRequisition.FindFirst() THEN BEGIN
            PurchaseRequisition.CalcFields(Amount);
            Result += '{';
            Result += '"No":"' + PurchaseRequisition."No." + '",';
            Result += '"DocumentDate":"' + FORMAT(PurchaseRequisition."Document Date", 0, '<day,2>/<month,2>/<year>') + '",';
            Result += '"RequestedReceiptDate":"' + FORMAT(PurchaseRequisition."Requested Receipt Date", 0, '<day,2>/<month,2>/<year>') + '",';
            Result += '"Amount":"' + FormatText(FORMAT(PurchaseRequisition.Amount)) + '",';
            Result += '"Description":"' + FORMAT(PurchaseRequisition.Description) + '",';
            Result += '"ApprovalComment":"' + FormatText(Format(PortalApproval.GetRejectionComments(PurchaseRequisition."No."))) + '",';
            Result += '"GlobalDimension1Code":"' + FORMAT(PurchaseRequisition."Global Dimension 1 Code") + '",';
            Result += '"GlobalDimension2Code":"' + FORMAT(PurchaseRequisition."Global Dimension 2 Code") + '",';
            Result += '"ShortcutDimension3Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 3 Code") + '",';
            Result += '"ShortcutDimension4Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 4 Code") + '",';
            Result += '"ShortcutDimension5Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 5 Code") + '",';
            Result += '"ShortcutDimension6Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 6 Code") + '",';
            Result += '"ShortcutDimension7Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 7 Code") + '",';
            Result += '"ShortcutDimension8Code":"' + FORMAT(PurchaseRequisition."Shortcut Dimension 8 Code") + '",';
            Result += '"ResponsibilityCenter":"' + FORMAT(PurchaseRequisition."Responsibility Center") + '",';
            Result += '"Status":"' + FORMAT(PurchaseRequisition.Status) + '"';
            Result += '}';
        END ELSE BEGIN
            Result := '{';
            Result += '"No":"",';
            Result += '"DocumentDate":"",';
            Result += '"RequestedReceiptDate":"",';
            Result += '"LocationCode":"",';
            Result += '"Amount":0,';
            Result += '"Description":"",';
            Result += '"GlobalDimension1Code":"",';
            Result += '"GlobalDimension2Code":"",';
            Result += '"ShortcutDimension3Code":"",';
            Result += '"ShortcutDimension4Code":"",';
            Result += '"ShortcutDimension5Code":"",';
            Result += '"ShortcutDimension6Code":"",';
            Result += '"ShortcutDimension7Code":"",';
            Result += '"ShortcutDimension8Code":"",';
            Result += '"ResponsibilityCenter":"",';
            Result += '"Status":""';
            Result += '}';
        END;
    end;

    [Scope('Cloud')]
    procedure GetRequisitionName(RequisitionCode: Code[20]) Name: Text
    var
        Item: Record Item;
        Service: Record "Purchase Requisition Codes";
        FA: Record "Fixed Asset";
    begin

        Name := '';

        //Item
        Item.reset;
        Item.SetRange("No.", RequisitionCode);
        if Item.FindFirst() then begin
            Name := FormatText(Item.Description);
        end;

        //FA
        FA.reset;
        FA.SetRange("No.", RequisitionCode);
        if FA.FindFirst() then begin
            Name := FormatText(FA.Description);
        end;

        //Services
        Service.reset;
        Service.SetRange(Service."Requisition Code", RequisitionCode);
        if Service.FindFirst() then begin
            Name := FormatText(Service.Description);
        end;

    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionLines(DocumentNo: Code[20]) Result: Text
    begin
        PurchaseRequisitionLine.RESET;
        PurchaseRequisitionLine.SETRANGE("Document No.", DocumentNo);
        IF PurchaseRequisitionLine.FindSet() THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"LineNo":' + FORMAT(PurchaseRequisitionLine."Line No.") + ',';
                Result += '"DocumentNo":"' + PurchaseRequisitionLine."Document No." + '",';
                Result += '"RequisitionType":"' + FORMAT(PurchaseRequisitionLine."Requisition Type") + '",';
                Result += '"RequisitionCode":"' + FORMAT(PurchaseRequisitionLine."Requisition Code") + '",';
                Result += '"RequisitionName":"' + FORMAT(GetRequisitionName(PurchaseRequisitionLine."Requisition Code")) + '",';
                Result += '"Type":"' + FORMAT(PurchaseRequisitionLine.Type) + '",';
                Result += '"No":"' + FORMAT(PurchaseRequisitionLine."No.") + '",';
                Result += '"Name":"' + FORMAT(PurchaseRequisitionLine.Name) + '",';
                Result += '"LineLocationCode":"' + PurchaseRequisitionLine."Location Code" + '",';
                Result += '"LineDescription":"' + PurchaseRequisitionLine.Description + '",';
                Result += '"Inventory":' + FormatText(FORMAT(PurchaseRequisitionLine.Inventory)) + ',';
                Result += '"Quantity":' + FormatText(FORMAT(PurchaseRequisitionLine.Quantity)) + ',';
                Result += '"UnitCost":' + FormatText(FORMAT(PurchaseRequisitionLine."Estimated Unit Cost")) + ',';
                Result += '"TotalLineCost":' + FormatText(FORMAT(PurchaseRequisitionLine."Total Cost")) + ',';
                Result += '"LineGlobalDimension1Code":"' + FORMAT(PurchaseRequisitionLine."Global Dimension 1 Code") + '",';
                Result += '"LineGlobalDimension2Code":"' + FORMAT(PurchaseRequisitionLine."Global Dimension 2 Code") + '",';
                Result += '"LineShortcutDimension3Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 3 Code") + '",';
                Result += '"LineShortcutDimension4Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 4 Code") + '",';
                Result += '"LineShortcutDimension5Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 5 Code") + '",';
                Result += '"LineShortcutDimension6Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 6 Code") + '",';
                Result += '"LineShortcutDimension7Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 7 Code") + '",';
                Result += '"LineShortcutDimension8Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 8 Code") + '",';
                Result += '"ResponsibilityCenter":"' + FORMAT(PurchaseRequisitionLine."Responsibility Center") + '",';
                Result += '"LineStatus":"' + FORMAT(PurchaseRequisitionLine.Status) + '"';
                Result += '},';
            UNTIL PurchaseRequisitionLine.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"LineNo":0,';
            Result += '"DocumentNo":"",';
            Result += '"Type":"",';
            Result += '"RequisitionType":"",';
            Result += '"RequisitionCode":"",';
            Result += '"No":"",';
            Result += '"Name":"",';
            Result += '"ItemDescription":"",';
            Result += '"UOM":"",';
            Result += '"LineLocationCode":"",';
            Result += '"Inventory":0,';
            Result += '"Quantity":0,';
            Result += '"UnitCost":0,';
            Result += '"TotalLineCost":0,';
            Result += '"LineDescription":"",';
            Result += '"LineGlobalDimension1Code":"",';
            Result += '"LineGlobalDimension2Code":"",';
            Result += '"LineShortcutDimension3Code":"",';
            Result += '"LineShortcutDimension4Code":"",';
            Result += '"LineShortcutDimension5Code":"",';
            Result += '"LineShortcutDimension6Code":"",';
            Result += '"LineShortcutDimension7Code":"",';
            Result += '"LineShortcutDimension8Code":"",';
            Result += '"ResponsibilityCenter":"",';
            Result += '"LineStatus":""';
            Result += '}]';
        END;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionLine(LineNo: integer; DocumentNo: Code[20]) Result: Text
    begin
        Result := '';
        PurchaseRequisitionLine.RESET;
        PurchaseRequisitionLine.SETRANGE("Line No.", LineNo);
        PurchaseRequisitionLine.SETRANGE("Document No.", DocumentNo);
        IF PurchaseRequisitionLine.FindSet() THEN BEGIN
            Result += '{';
            Result += '"LineNo":' + FORMAT(PurchaseRequisitionLine."Line No.") + ',';
            Result += '"DocumentNo":"' + PurchaseRequisitionLine."Document No." + '",';
            Result += '"RequisitionType":"' + FORMAT(PurchaseRequisitionLine."Requisition Type") + '",';
            Result += '"RequisitionCode":"' + FORMAT(PurchaseRequisitionLine."Requisition Code") + '",';
            Result += '"RequisitionName":"' + FORMAT(GetRequisitionName(PurchaseRequisitionLine."Requisition Code")) + '",';
            Result += '"Type":"' + FORMAT(PurchaseRequisitionLine.Type) + '",';
            Result += '"No":"' + FORMAT(PurchaseRequisitionLine."No.") + '",';
            Result += '"Name":"' + FORMAT(PurchaseRequisitionLine.Name) + '",';
            Result += '"LineLocationCode":"' + PurchaseRequisitionLine."Location Code" + '",';
            Result += '"LineDescription":"' + PurchaseRequisitionLine.Description + '",';
            Result += '"Inventory":' + FormatText(FORMAT(PurchaseRequisitionLine.Inventory)) + ',';
            Result += '"Quantity":' + FormatText(FORMAT(PurchaseRequisitionLine.Quantity)) + ',';
            Result += '"UnitCost":' + FormatText(FORMAT(PurchaseRequisitionLine."Estimated Unit Cost")) + ',';
            Result += '"TotalLineCost":' + FormatText(FORMAT(PurchaseRequisitionLine."Total Cost")) + ',';
            Result += '"LineGlobalDimension1Code":"' + FORMAT(PurchaseRequisitionLine."Global Dimension 1 Code") + '",';
            Result += '"LineGlobalDimension2Code":"' + FORMAT(PurchaseRequisitionLine."Global Dimension 2 Code") + '",';
            Result += '"LineShortcutDimension3Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 3 Code") + '",';
            Result += '"LineShortcutDimension4Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 4 Code") + '",';
            Result += '"LineShortcutDimension5Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 5 Code") + '",';
            Result += '"LineShortcutDimension6Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 6 Code") + '",';
            Result += '"LineShortcutDimension7Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 7 Code") + '",';
            Result += '"LineShortcutDimension8Code":"' + FORMAT(PurchaseRequisitionLine."Shortcut Dimension 8 Code") + '",';
            Result += '"ResponsibilityCenter":"' + FORMAT(PurchaseRequisitionLine."Responsibility Center") + '",';
            Result += '"LineStatus":"' + FORMAT(PurchaseRequisitionLine.Status) + '"';
            Result += '}';
        END ELSE BEGIN
            Result := '{';
            Result += '"LineNo":0,';
            Result += '"DocumentNo":"",';
            Result += '"Type":"",';
            Result += '"RequisitionType":"",';
            Result += '"RequisitionCode":"",';
            Result += '"No":"",';
            Result += '"Name":"",';
            Result += '"ItemDescription":"",';
            Result += '"UOM":"",';
            Result += '"LineLocationCode":"",';
            Result += '"Inventory":0,';
            Result += '"Quantity":0,';
            Result += '"UnitCost":0,';
            Result += '"TotalLineCost":0,';
            Result += '"LineDescription":"",';
            Result += '"LineGlobalDimension1Code":"",';
            Result += '"LineGlobalDimension2Code":"",';
            Result += '"LineShortcutDimension3Code":"",';
            Result += '"LineShortcutDimension4Code":"",';
            Result += '"LineShortcutDimension5Code":"",';
            Result += '"LineShortcutDimension6Code":"",';
            Result += '"LineShortcutDimension7Code":"",';
            Result += '"LineShortcutDimension8Code":"",';
            Result += '"ResponsibilityCenter":"",';
            Result += '"LineStatus":""';
            Result += '}';
        END;
    end;

    [Scope('Cloud')]
    procedure CheckPurchaseRequisitionExists("PurchaseRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]) PurchaseRequisitionExist: Boolean
    begin
        PurchaseRequisitionExist := false;
        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."No.", "PurchaseRequisitionNo.");
        PurchaseRequisition.SetRange(PurchaseRequisition."Employee No.", "EmployeeNo.");
        if PurchaseRequisition.FindFirst then begin
            PurchaseRequisitionExist := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CheckOpenPurchaseRequisitionExists("EmployeeNo.": Code[20]) OpenPurchaseRequisitionExist: Boolean
    begin
        OpenPurchaseRequisitionExist := false;
        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."Employee No.", "EmployeeNo.");
        PurchaseRequisition.SetRange(PurchaseRequisition.Status, PurchaseRequisition.Status::Open);
        if PurchaseRequisition.FindFirst then begin
            OpenPurchaseRequisitionExist := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CreatePurchaseRequisition("EmployeeNo.": Code[20]) "PurchaseRequisitionNo.": Code[20]
    var
        "DocNo.": Code[20];
    begin
        "PurchaseRequisitionNo." := '';

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Purchase Requisition Nos.", 0D, true);
        if "DocNo." <> '' then begin
            PurchaseRequisition.Init;
            PurchaseRequisition."No." := "DocNo.";
            PurchaseRequisition."Document Date" := Today;
            PurchaseRequisition."Employee No." := "EmployeeNo.";
            PurchaseRequisition.Validate("Employee No.");
            // PurchaseRequisition."User ID" := EmployeeAccountWS.GetEmployeeUserID("EmployeeNo.");
            PurchaseRequisition.Validate("User ID");
            if PurchaseRequisition.Insert then begin
                "PurchaseRequisitionNo." := "DocNo.";
            end;

            //insert document link
            // DocumentMgmt.InsertPurchaseRequisitionDocuments("DocNo.");
            //end insert document link
        end;
    end;

    [Scope('Cloud')]
    procedure ModifyPurchaseRequisition("PurchaseRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]; RequestedReceiptDate: Date; LocationCode: Code[10]; Description: Text[100]; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]; ResponsibilityCenter: Code[50]) PurchaseRequisitionModified: Boolean
    begin
        PurchaseRequisitionModified := false;

        //check supporting documents attached
        // DocumentMgmt.CheckDocumentAttached("PurchaseRequisitionNo.");

        if RequestedReceiptDate = 0D then
            RequestedReceiptDate := Today;

        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."No.", "PurchaseRequisitionNo.");
        if PurchaseRequisition.FindFirst then begin
            PurchaseRequisition."Requested Receipt Date" := RequestedReceiptDate;
            // PurchaseRequisition."Location Code" := LocationCode;
            // PurchaseRequisition.Validate(PurchaseRequisition."Location Code");
            PurchaseRequisition.Description := Description;
            PurchaseRequisition."Global Dimension 1 Code" := GlobalDimension1Code;
            PurchaseRequisition.VALIDATE(PurchaseRequisition."Global Dimension 1 Code");
            PurchaseRequisition."Global Dimension 2 Code" := GlobalDimension2Code;
            PurchaseRequisition.VALIDATE(PurchaseRequisition."Global Dimension 2 Code");
            PurchaseRequisition."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
            PurchaseRequisition."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
            PurchaseRequisition."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
            PurchaseRequisition."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
            PurchaseRequisition."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
            PurchaseRequisition."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
            PurchaseRequisition."Responsibility Center" := ResponsibilityCenter;
            PurchaseRequisition.Description := Description;
            if PurchaseRequisition.Modify then begin
                //check budget
                BudgetControlSetup.Reset();
                if BudgetControlSetup.FindFirst() then begin
                    if BudgetControlSetup.Mandatory then
                        ProcurementManagement.CheckBudgetPurchaseRequisition("PurchaseRequisitionNo.");
                end;
                //end check
                PurchaseRequisitionModified := true;
            end;
            ;
        end;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionAmount("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionAmount: Decimal
    begin
        PurchaseRequisitionAmount := 0;

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            PurchaseRequisition.CalcFields(Amount);
            PurchaseRequisitionAmount := PurchaseRequisition.Amount;
        end;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionStatus("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionStatus: Text
    begin
        PurchaseRequisitionStatus := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            PurchaseRequisitionStatus := Format(PurchaseRequisition.Status);
        end;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionGlobalDimension1Code("PurchaseRequisitionNo.": Code[20]) GlobalDimension1Code: Text
    begin
        GlobalDimension1Code := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            GlobalDimension1Code := PurchaseRequisition."Global Dimension 1 Code";
        end;
    end;

    [Scope('Cloud')]
    procedure GetPurchaseRequisitionGlobalDimension2Code("PurchaseRequisitionNo.": Code[20]) GlobalDimension2Code: Text
    begin
        GlobalDimension2Code := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            GlobalDimension2Code := PurchaseRequisition."Global Dimension 2 Code";
        end;
    end;

    [Scope('Cloud')]
    procedure CreatePurchaseRequisitionLine("PurchaseRequisitionNo.": Code[20]; RequisitionType: Code[20]; RequisitionCode: Code[50]; LocationCode: Code[10]; Quantity: Integer; UnitCost: Decimal; Description: Text; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]) PurchaseRequisitionLineCreated: Boolean
    begin
        PurchaseRequisitionLineCreated := false;

        PurchaseRequisition.Reset;
        PurchaseRequisition.Get("PurchaseRequisitionNo.");

        PurchaseRequisitionLine.Init;
        PurchaseRequisitionLine."Line No." := 0;
        PurchaseRequisitionLine."Document No." := "PurchaseRequisitionNo.";
        if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Service)) then
            PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Service;
        if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Item)) then
            PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Item;
        if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::"Fixed Asset")) then
            PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::"Fixed Asset";
        PurchaseRequisitionLine."Requisition Code" := RequisitionCode;
        PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Requisition Code");
        PurchaseRequisitionLine."Document Date" := Today;
        PurchaseRequisitionLine."Location Code" := LocationCode;
        PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Location Code");
        PurchaseRequisitionLine.Quantity := Quantity;
        PurchaseRequisitionLine.Validate(PurchaseRequisitionLine.Quantity);
        PurchaseRequisitionLine."Estimated Unit Cost" := UnitCost;
        PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Estimated Unit Cost");
        PurchaseRequisitionLine."Estimated Unit Cost(LCY)" := UnitCost;
        PurchaseRequisitionLine."Total Cost" := UnitCost * Quantity;
        PurchaseRequisitionLine."Total Cost(LCY)" := UnitCost * Quantity;
        //PurchaseRequisitionLine."Total Amount":=UnitCost*Quantity;
        PurchaseRequisitionLine.Description := Description;
        PurchaseRequisitionLine."Global Dimension 1 Code" := GlobalDimension1Code;
        PurchaseRequisitionLine."Global Dimension 2 Code" := GlobalDimension2Code;
        PurchaseRequisitionLine."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
        PurchaseRequisitionLine."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
        PurchaseRequisitionLine."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
        PurchaseRequisitionLine."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
        PurchaseRequisitionLine."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
        PurchaseRequisitionLine."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
        if PurchaseRequisitionLine.Insert then begin
            PurchaseRequisitionLineCreated := true;
        end;
    end;

    [Scope('Cloud')]
    procedure ModifyPurchaseRequisitionLine("LineNo.": Integer; "PurchaseRequisitionNo.": Code[20]; RequisitionType: Code[20]; RequisitionCode: Code[50]; LocationCode: Code[10]; Quantity: Integer; UnitCost: Decimal; Description: Text; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]) PurchaseRequisitionLineModified: Boolean
    begin
        PurchaseRequisitionLineModified := false;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Line No.", "LineNo.");
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindFirst then begin
            if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Service)) then
                PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Service;
            if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Item)) then
                PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Item;
            if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::"Fixed Asset")) then
                PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::"Fixed Asset";
            PurchaseRequisitionLine."Requisition Code" := RequisitionCode;
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Requisition Code");
            PurchaseRequisitionLine."Location Code" := LocationCode;
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Location Code");
            PurchaseRequisitionLine.Quantity := Quantity;
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine.Quantity);
            PurchaseRequisitionLine."Estimated Unit Cost" := UnitCost;
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Estimated Unit Cost");
            PurchaseRequisitionLine."Estimated Unit Cost(LCY)" := UnitCost;
            PurchaseRequisitionLine."Total Cost(LCY)" := UnitCost * Quantity;
            // PurchaseRequisitionLine."Total Amount":=UnitCost*Quantity;
            PurchaseRequisitionLine."Total Cost" := UnitCost * Quantity;
            PurchaseRequisitionLine.Description := Description;
            PurchaseRequisitionLine."Global Dimension 1 Code" := GlobalDimension1Code;
            PurchaseRequisitionLine."Global Dimension 2 Code" := GlobalDimension2Code;
            PurchaseRequisitionLine."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
            PurchaseRequisitionLine."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
            PurchaseRequisitionLine."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
            PurchaseRequisitionLine."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
            PurchaseRequisitionLine."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
            PurchaseRequisitionLine."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
            if PurchaseRequisitionLine.Modify then begin
                PurchaseRequisitionLineModified := true;
            end;
        end;
    end;

    [Scope('Cloud')]
    procedure DeletePurchaseRequisitionLine("LineNo.": Integer; "PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionLineDeleted: Boolean
    begin
        PurchaseRequisitionLineDeleted := false;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Line No.", "LineNo.");
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindFirst then begin
            if PurchaseRequisitionLine.Delete then begin
                PurchaseRequisitionLineDeleted := true;
            end;
        end;
    end;

    [Scope('Cloud')]
    procedure CheckPurchaseRequisitionLinesExist("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionLinesExist: Boolean
    begin
        PurchaseRequisitionLinesExist := false;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindFirst then begin
            PurchaseRequisitionLinesExist := true;
        end;
    end;

    [Scope('Cloud')]
    procedure ValidatePurchaseRequisitionLines("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionLinesError: Text
    var
        "PurchaseRequisitionLineNo.": Integer;
    begin
        PurchaseRequisitionLinesError := '';
        "PurchaseRequisitionLineNo." := 0;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindSet then begin
            repeat
                "PurchaseRequisitionLineNo." := "PurchaseRequisitionLineNo." + 1;
                if PurchaseRequisitionLine."Requisition Code" = '' then begin
                    PurchaseRequisitionLinesError := 'Requisition code missing on purchase requisition line no.' + Format("PurchaseRequisitionLineNo.") + ', it cannot be zero or empty';
                    break;
                end;

            until PurchaseRequisitionLine.Next = 0;
        end;
    end;

    [Scope('Cloud')]
    procedure CheckPurchaseRequisitionApprovalWorkflowEnabled("PurchaseRequisitionNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then
            ApprovalWorkflowEnabled := ProcurementApprovalManager.CheckPurchaseRequisitionApprovalsWorkflowEnabled(PurchaseRequisition);
    end;

    [Scope('Cloud')]
    procedure SendPurchaseRequisitionApprovalRequest("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionApprovalRequestSent: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        PurchaseRequisitionApprovalRequestSent := false;

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            ProcurementApprovalManager.OnSendPurchaseRequisitionForApproval(PurchaseRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseRequisition."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                PurchaseRequisitionApprovalRequestSent := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CancelPurchaseRequisitionApprovalRequest("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionApprovalRequestCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        PurchaseRequisitionApprovalRequestCanceled := false;

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            ProcurementApprovalManager.OnCancelPurchaseRequisitionApprovalRequest(PurchaseRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseRequisition."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then begin
                    BudgetControlSetup.get;
                    if BudgetControlSetup.Mandatory then
                        ProcurementManagement.CancelBudgetCommitmentPurchaseRequisition("PurchaseRequisitionNo.");
                    PurchaseRequisitionApprovalRequestCanceled := true;
                end;

            end;
        end;
    end;

    [Scope('Cloud')]
    procedure ReopenPurchaseRequisition("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionOpened: Boolean
    begin
        PurchaseRequisitionOpened := false;
        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."No.", "PurchaseRequisitionNo.");
        if PurchaseRequisition.FindFirst then begin
            ProcurementApprovalManager.ReOpenPurchaseRequisitionHeader(PurchaseRequisition);
            PurchaseRequisitionOpened := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CancelPurchaseRequisitionBudgetCommitment("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionBudgetCommitmentCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        PurchaseRequisitionBudgetCommitmentCanceled := false;

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            PurchaseRequisitionBudgetCommitmentCanceled := true;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckPurchaseApprovalPossible', '', false, false)]
    local procedure CheckDefaultsOnPurchaseHeaderAppRequest(var PurchaseHeader: Record "Purchase Header")
    var
        InvtSetup: Record "Inventory Setup";
        PurchLine: Record "Purchase Line";
        NothingToReleaseErrLbl: Label 'There is nothing to release on Purchase %1 %2.';
        PurchasesLine: Record "Purchase Line";
    begin
        PurchasesLine.Reset();
        PurchasesLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchasesLine.FindSet() then begin
            repeat
                PurchasesLine.TestField("No.");
                PurchasesLine.TestField(Quantity);
                //PurchasesLine.TestField("Shortcut Dimension 1 Code");
                //PurchasesLine.TestField("Shortcut Dimension 2 Code");
                //PurchasesLine.TestField("Shortcut Dimension 3 Code");
                // PurchasesLine.TestField("Shortcut Dimension 4 Code");
                // PurchasesLine.TestField("Shortcut Dimension 5 Code");
                if PurchasesLine.Type = PurchasesLine.Type::"G/L Account" then
                    PurchasesLine.TestField("Gen. Prod. Posting Group");
            until PurchasesLine.Next() = 0;
        end


    end;

}

