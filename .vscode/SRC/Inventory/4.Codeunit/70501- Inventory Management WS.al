codeunit 70501 "Inventory Management WS"
{

    trigger OnRun()
    begin
    end;

    var
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_/-.%20abcdefghijklmnopqrstuvwxy z{}[]';
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        StoreRequisition: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        InventorySetup: Record "Inventory Setup";
        InventoryUserSetup: Record "Inventory User Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit "No. Series";
        ApprovalsMgmt: Codeunit "Procurement Approval Manager";
        InventoryApprovalManager: Codeunit "Inventory Approval Manager";
        Text_0001: Label 'The inventory is insufficient';
        DocumentMgmt: Codeunit "Document Mgmt.";
        //EmployeeAccountWS: Codeunit "Employee Account WS";
        StoreRequisitionApproval: Codeunit "Store Requisition Approval";
        PortalApproval: Codeunit "Portal Approvals";

    [Scope('Cloud')]
    procedure FormatText(OldText: Text) NewText: Text
    begin
        NewText := '';
        NewText := DELCHR(OldText, '=', DELCHR(OldText, '=', TxtCharsToKeep));
    end;

    [Scope('Cloud')]
    procedure GetStoresRequisitions(EmployeeNo: Code[20]) Result: Text
    begin
        StoreRequisition.RESET;
        StoreRequisition.SETRANGE("Employee No.", EmployeeNo);
        IF StoreRequisition.FindSet() THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"No":"' + StoreRequisition."No." + '",';
                Result += '"DocumentDate":"' + FORMAT(StoreRequisition."Document Date") + '",';
                Result += '"PostingDateDate":"' + FORMAT(StoreRequisition."Posting Date") + '",';
                Result += '"RequiredDate":"' + FORMAT(StoreRequisition."Required Date") + '",';
                Result += '"RequesterID":"' + StoreRequisition."Requester ID" + '",';
                Result += '"LocationCode":"' + StoreRequisition."Location Code" + '",';
                Result += '"Amount":"' + FORMAT(StoreRequisition.Amount) + '",';
                Result += '"Description":"' + FORMAT(StoreRequisition.Description) + '",';
                Result += '"ApprovalComment":"' + FormatText(Format(PortalApproval.GetRejectionComments(StoreRequisition."No."))) + '",';
                Result += '"GlobalDimension1Code":"' + FORMAT(StoreRequisition."Global Dimension 1 Code") + '",';
                Result += '"GlobalDimension2Code":"' + FORMAT(StoreRequisition."Global Dimension 2 Code") + '",';
                Result += '"ShortcutDimension3Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 3 Code") + '",';
                Result += '"ShortcutDimension4Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 4 Code") + '",';
                Result += '"ShortcutDimension5Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 5 Code") + '",';
                Result += '"ShortcutDimension6Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 6 Code") + '",';
                Result += '"ShortcutDimension7Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 7 Code") + '",';
                Result += '"ShortcutDimension8Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 8 Code") + '",';
                Result += '"ResponsibilityCenter":"' + FORMAT(StoreRequisition."Responsibility Center") + '",';
                Result += '"Status":"' + FORMAT(StoreRequisition.Status) + '"';
                Result += '},';
            UNTIL StoreRequisition.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"No":"",';
            Result += '"DocumentDate":"",';
            Result += '"DocumentDate":"' + FORMAT(StoreRequisition."Document Date") + '",';
            Result += '"PostingDateDate":"' + FORMAT(StoreRequisition."Posting Date") + '",';
            Result += '"RequiredDate":"' + FORMAT(StoreRequisition."Required Date") + '",';
            Result += '"RequesterID":"' + StoreRequisition."Requester ID" + '",';
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
    procedure GetStoresRequisition(DocumentNo: Code[20]) Result: Text
    begin
        StoreRequisition.RESET;
        StoreRequisition.SETRANGE("No.", DocumentNo);
        IF StoreRequisition.FindSet() THEN BEGIN
            Result += '{';
            Result += '"No":"' + StoreRequisition."No." + '",';
            Result += '"DocumentDate":"' + FORMAT(StoreRequisition."Document Date") + '",';
            Result += '"PostingDateDate":"' + FORMAT(StoreRequisition."Posting Date") + '",';
            Result += '"RequiredDate":"' + FORMAT(StoreRequisition."Required Date") + '",';
            Result += '"RequesterID":"' + StoreRequisition."Requester ID" + '",';
            Result += '"LocationCode":"' + StoreRequisition."Location Code" + '",';
            Result += '"Amount":"' + FORMAT(StoreRequisition.Amount) + '",';
            Result += '"Description":"' + FORMAT(StoreRequisition.Description) + '",';
            Result += '"ApprovalComment":"' + FormatText(Format(PortalApproval.GetRejectionComments(StoreRequisition."No."))) + '",';
            Result += '"GlobalDimension1Code":"' + FORMAT(StoreRequisition."Global Dimension 1 Code") + '",';
            Result += '"GlobalDimension2Code":"' + FORMAT(StoreRequisition."Global Dimension 2 Code") + '",';
            Result += '"ShortcutDimension3Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 3 Code") + '",';
            Result += '"ShortcutDimension4Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 4 Code") + '",';
            Result += '"ShortcutDimension5Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 5 Code") + '",';
            Result += '"ShortcutDimension6Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 6 Code") + '",';
            Result += '"ShortcutDimension7Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 7 Code") + '",';
            Result += '"ShortcutDimension8Code":"' + FORMAT(StoreRequisition."Shortcut Dimension 8 Code") + '",';
            Result += '"ResponsibilityCenter":"' + FORMAT(StoreRequisition."Responsibility Center") + '",';
            Result += '"Status":"' + FORMAT(StoreRequisition.Status) + '"';
            Result += '}';
        END ELSE BEGIN
            Result := '{';
            Result += '"No":"",';
            Result += '"DocumentDate":"",';
            Result += '"DocumentDate":"' + FORMAT(StoreRequisition."Document Date") + '",';
            Result += '"PostingDateDate":"' + FORMAT(StoreRequisition."Posting Date") + '",';
            Result += '"RequiredDate":"' + FORMAT(StoreRequisition."Required Date") + '",';
            Result += '"RequesterID":"' + StoreRequisition."Requester ID" + '",';
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
    procedure GetStoresRequisitionLines(DocumentNo: Code[20]) Result: Text
    begin
        StoreRequisitionLine.RESET;
        StoreRequisitionLine.SETRANGE("Document No.", DocumentNo);
        IF StoreRequisitionLine.FindSet() THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"LineNo":' + FORMAT(StoreRequisitionLine."Line No.") + ',';
                Result += '"DocumentNo":"' + StoreRequisitionLine."Document No." + '",';
                Result += '"Type":"' + FORMAT(StoreRequisitionLine.Type) + '",';
                Result += '"ItemNo":"' + FORMAT(StoreRequisitionLine."Item No.") + '",';
                Result += '"ItemDescription":"' + FORMAT(StoreRequisitionLine."Item Description") + '",';
                Result += '"LineLocationCode":"' + StoreRequisitionLine."Location Code" + '",';
                Result += '"LineDescription":"' + StoreRequisitionLine.Description + '",';
                Result += '"Inventory":' + FormatText(FORMAT(StoreRequisitionLine.Inventory)) + ',';
                Result += '"Quantity":' + FormatText(FORMAT(StoreRequisitionLine.Quantity)) + ',';
                Result += '"UnitCost":' + FormatText(FORMAT(StoreRequisitionLine."Unit Cost")) + ',';
                Result += '"LineTotalCost":' + FormatText(FORMAT(StoreRequisitionLine."Line Amount")) + ',';
                Result += '"LineAmount":' + FormatText(FORMAT(StoreRequisitionLine."Line Amount")) + ',';
                Result += '"UOM":"' + FORMAT(StoreRequisitionLine."Unit of Measure Code") + '",';
                Result += '"LineGlobalDimension1Code":"' + FORMAT(StoreRequisitionLine."Global Dimension 1 Code") + '",';
                Result += '"LineGlobalDimension2Code":"' + FORMAT(StoreRequisitionLine."Global Dimension 2 Code") + '",';
                Result += '"LineShortcutDimension3Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 3 Code") + '",';
                Result += '"LineShortcutDimension4Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 4 Code") + '",';
                Result += '"LineShortcutDimension5Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 5 Code") + '",';
                Result += '"LineShortcutDimension6Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 6 Code") + '",';
                Result += '"LineShortcutDimension7Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 7 Code") + '",';
                Result += '"LineShortcutDimension8Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 8 Code") + '",';
                Result += '"ResponsibilityCenter":"' + FORMAT(StoreRequisitionLine."Responsibility Center") + '",';
                Result += '"LineStatus":"' + FORMAT(StoreRequisitionLine.Status) + '"';
                Result += '},';
            UNTIL StoreRequisitionLine.NEXT = 0;
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
            Result += '"LineTotaltCost":0,';
            Result += '"LineAmount":0,';
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
    procedure GetStoresRequisitionLine(LineNo: integer; DocumentNo: Code[20]) Result: Text
    begin
        StoreRequisitionLine.RESET;
        StoreRequisitionLine.SETRANGE("Line No.", LineNo);
        StoreRequisitionLine.SETRANGE("Document No.", DocumentNo);
        IF StoreRequisitionLine.FindFirst() THEN BEGIN
            Result += '{';
            Result += '"LineNo":' + FORMAT(StoreRequisitionLine."Line No.") + ',';
            Result += '"DocumentNo":"' + StoreRequisitionLine."Document No." + '",';
            Result += '"Type":"' + FORMAT(StoreRequisitionLine.Type) + '",';
            Result += '"ItemNo":"' + FORMAT(StoreRequisitionLine."Item No.") + '",';
            Result += '"ItemDescription":"' + FORMAT(StoreRequisitionLine."Item Description") + '",';
            Result += '"LineLocationCode":"' + StoreRequisitionLine."Location Code" + '",';
            Result += '"LineDescription":"' + StoreRequisitionLine.Description + '",';
            Result += '"Inventory":' + FormatText(FORMAT(StoreRequisitionLine.Inventory)) + ',';
            Result += '"Quantity":' + FormatText(FORMAT(StoreRequisitionLine.Quantity)) + ',';
            Result += '"UnitCost":' + FormatText(FORMAT(StoreRequisitionLine."Unit Cost")) + ',';
            Result += '"LineTotalCost":' + FormatText(FORMAT(StoreRequisitionLine."Line Amount")) + ',';
            Result += '"LineAmount":' + FormatText(FORMAT(StoreRequisitionLine."Line Amount")) + ',';
            Result += '"UOM":"' + FORMAT(StoreRequisitionLine."Unit of Measure Code") + '",';
            Result += '"LineGlobalDimension1Code":"' + FORMAT(StoreRequisitionLine."Global Dimension 1 Code") + '",';
            Result += '"LineGlobalDimension2Code":"' + FORMAT(StoreRequisitionLine."Global Dimension 2 Code") + '",';
            Result += '"LineShortcutDimension3Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 3 Code") + '",';
            Result += '"LineShortcutDimension4Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 4 Code") + '",';
            Result += '"LineShortcutDimension5Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 5 Code") + '",';
            Result += '"LineShortcutDimension6Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 6 Code") + '",';
            Result += '"LineShortcutDimension7Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 7 Code") + '",';
            Result += '"LineShortcutDimension8Code":"' + FORMAT(StoreRequisitionLine."Shortcut Dimension 8 Code") + '",';
            Result += '"ResponsibilityCenter":"' + FORMAT(StoreRequisitionLine."Responsibility Center") + '",';
            Result += '"LineStatus":"' + FORMAT(StoreRequisitionLine.Status) + '"';
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
            Result += '"LineTotaltCost":0,';
            Result += '"LineAmount":0,';
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
    procedure GetItemUnitOfMeasures() Result: Text
    begin
        ItemUOM.RESET;
        IF ItemUOM.FINDSET THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"Code":"' + ItemUOM.Code + '",';
                Result += '"Description":"' + FORMAT(ItemUOM.Code) + '"';
                Result += '},';
            UNTIL ItemUOM.NEXT = 0;
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
    procedure GetItemUOMs(ItemNo: Code[20]) Result: Text
    begin
        ItemUOM.RESET;
        ItemUOM.SetRange("Item No.", ItemNo);
        IF ItemUOM.FINDSET THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"Code":"' + ItemUOM.Code + '",';
                Result += '"Description":"' + FORMAT(ItemUOM.Code) + '"';
                Result += '},';
            UNTIL ItemUOM.NEXT = 0;
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
    procedure GetItems() Result: Text
    begin
        Item.RESET;
        Item.Setrange(Blocked, false);
        IF Item.FINDSET THEN BEGIN
            Result := '[';
            REPEAT
                Result += '{';
                Result += '"No":"' + Item."No." + '",';
                Result += '"Description":"' + FormatText(FORMAT(Item.Description)) + '"';
                Result += '},';
            UNTIL Item.NEXT = 0;
            Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
            Result += ']';
        END ELSE BEGIN
            Result := '[{';
            Result += '"No":"",';
            Result += '"Description":""';
            Result += '}]';
        END;
    end;

    [Scope('Cloud')]
    procedure CheckStoreRequisitionExists("StoreRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]) StoreRequisitionExist: Boolean
    begin
        StoreRequisitionExist := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        StoreRequisition.SetRange(StoreRequisition."Employee No.", "EmployeeNo.");
        if StoreRequisition.FindFirst then begin
            StoreRequisitionExist := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CheckOpenStoreRequisitionExists("EmployeeNo.": Code[20]) OpenStoreRequisitionExist: Boolean
    begin
        OpenStoreRequisitionExist := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."Employee No.", "EmployeeNo.");
        StoreRequisition.SetRange(StoreRequisition.Status, StoreRequisition.Status::Open);
        if StoreRequisition.FindFirst then begin
            OpenStoreRequisitionExist := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CreateStoreRequisition("EmployeeNo.": Code[20]) "StoreRequisitionNo.": Code[20]
    var
        "DocNo.": Code[20];
    begin
        "StoreRequisitionNo." := '';

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        InventorySetup.Reset;
        InventorySetup.Get;

        "DocNo." := NoSeriesMgt.GetNextNo(InventorySetup."Stores Requisition Nos.", 0D, true);
        if "DocNo." <> '' then begin
            StoreRequisition.Init;
            StoreRequisition."No." := "DocNo.";
            StoreRequisition."Document Date" := Today;
            StoreRequisition."Employee No." := "EmployeeNo.";
            StoreRequisition.Validate(StoreRequisition."Employee No.");
            StoreRequisition."User ID" := UserId;
            if StoreRequisition.Insert then begin
                "StoreRequisitionNo." := "DocNo.";
            end;

            //insert document link
           // DocumentMgmt.InsertStoreRequisitionDocuments("DocNo.");
            //end insert document link
        end;
    end;

    [Scope('Cloud')]
    procedure ModifyStoreRequisition("StoreRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]; RequiredDate: Date; RequesterID: Code[20]; Description: Text[100]; LocationCode: Code[10]; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]) StoreRequisitionModified: Boolean
    begin
        StoreRequisitionModified := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        if StoreRequisition.FindFirst then begin
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition."Requester ID" := RequesterID;
            StoreRequisition.Description := Description;
            StoreRequisition."Location Code" := LocationCode;
            StoreRequisition."Global Dimension 1 Code" := GlobalDimension1Code;
            StoreRequisition.Validate(StoreRequisition."Global Dimension 1 Code");
            StoreRequisition."Global Dimension 2 Code" := GlobalDimension2Code;
            StoreRequisition.Validate(StoreRequisition."Global Dimension 2 Code");
            StoreRequisition."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
            StoreRequisition."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
            StoreRequisition."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
            StoreRequisition."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
            StoreRequisition."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
            StoreRequisition."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
            if StoreRequisition.Modify then
                StoreRequisitionModified := true;
        end;
    end;

    [Scope('Cloud')]
    procedure GetStoreRequisitionAmount("StoreRequisitionNo.": Code[20]) StoreRequisitionAmount: Decimal
    begin
        StoreRequisitionAmount := 0;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisition.CalcFields(Amount);
            StoreRequisitionAmount := StoreRequisition.Amount;
        end;
    end;

    [Scope('Cloud')]
    procedure GetStoreRequisitionStatus("StoreRequisitionNo.": Code[20]) StoreRequisitionStatus: Text
    begin
        StoreRequisitionStatus := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisitionStatus := Format(StoreRequisition.Status);
        end;
    end;

    [Scope('Cloud')]
    procedure GetStoreRequisitionGlobalDimension1Code("StoreRequisitionNo.": Code[20]) GlobalDimension1Code: Text
    begin
        GlobalDimension1Code := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            GlobalDimension1Code := StoreRequisition."Global Dimension 1 Code";
        end;
    end;

    [Scope('Cloud')]
    procedure GetStoreRequisitionGlobalDimension2Code("StoreRequisitionNo.": Code[20]) GlobalDimension2Code: Text
    begin
        GlobalDimension2Code := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            GlobalDimension2Code := StoreRequisition."Global Dimension 2 Code";
        end;
    end;

    [Scope('Cloud')]
    procedure CreateStoreRequisitionLine("StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; LocationCode: Code[10]; Quantity: Decimal; UOM: Code[10]; Description: Text; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]) StoreRequisitionLineCreated: Boolean
    begin
        StoreRequisitionLineCreated := false;

        StoreRequisition.Reset;
        StoreRequisition.Get("StoreRequisitionNo.");

        StoreRequisitionLine.Init;
        StoreRequisitionLine."Line No." := 0;
        StoreRequisitionLine."Document No." := "StoreRequisitionNo.";
        StoreRequisitionLine.Type := StoreRequisitionLine.Type::Item;
        StoreRequisitionLine."Item No." := "ItemNo.";
        StoreRequisitionLine.Validate(StoreRequisitionLine."Item No.");
        StoreRequisitionLine."Location Code" := LocationCode;
        StoreRequisitionLine.Validate(StoreRequisitionLine."Location Code");
        StoreRequisitionLine.Quantity := Quantity;
        StoreRequisitionLine."Unit of Measure Code" := UOM;
        StoreRequisitionLine.Validate(StoreRequisitionLine."Unit of Measure Code");
        StoreRequisitionLine.Inventory := GetAvailableInventory("ItemNo.", UOM, LocationCode);
        StoreRequisitionLine.Description := Description;
        StoreRequisitionLine."Global Dimension 1 Code" := GlobalDimension1Code;
        StoreRequisitionLine."Global Dimension 2 Code" := GlobalDimension2Code;
        StoreRequisitionLine."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
        StoreRequisitionLine."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
        StoreRequisitionLine."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
        StoreRequisitionLine."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
        StoreRequisitionLine."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
        StoreRequisitionLine."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
        if StoreRequisitionLine.Insert then begin
            StoreRequisitionLineCreated := true;
        end;
    end;

    [Scope('Cloud')]
    procedure ModifyStoreRequisitionLine("LineNo.": Integer; "StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; LocationCode: Code[10]; Quantity: Decimal; UOM: Code[10]; Description: Text; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]) StoreRequisitionLineModified: Boolean
    begin
        StoreRequisitionLineModified := false;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Line No.", "LineNo.");
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
        if StoreRequisitionLine.FindFirst then begin
            StoreRequisitionLine.Type := StoreRequisitionLine.Type::Item;
            StoreRequisitionLine."Item No." := "ItemNo.";
            StoreRequisitionLine.Validate(StoreRequisitionLine."Item No.");
            StoreRequisitionLine."Location Code" := LocationCode;
            StoreRequisitionLine.Validate(StoreRequisitionLine."Location Code");
            StoreRequisitionLine.Quantity := Quantity;
            StoreRequisitionLine.Validate(StoreRequisitionLine.Quantity);
            StoreRequisitionLine."Unit of Measure Code" := UOM;
            StoreRequisitionLine.Validate(StoreRequisitionLine."Unit of Measure Code");
            StoreRequisitionLine.Inventory := GetAvailableInventory("ItemNo.", UOM, LocationCode);
            StoreRequisitionLine.Description := Description;
            StoreRequisitionLine."Global Dimension 1 Code" := GlobalDimension1Code;
            StoreRequisitionLine."Global Dimension 2 Code" := GlobalDimension2Code;
            StoreRequisitionLine."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
            StoreRequisitionLine."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
            StoreRequisitionLine."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
            StoreRequisitionLine."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
            StoreRequisitionLine."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
            StoreRequisitionLine."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
            if StoreRequisitionLine.Modify then begin
                StoreRequisitionLineModified := true;
            end;
        end;
    end;

    [Scope('Cloud')]
    procedure DeleteStoreRequisitionLine("LineNo.": Integer; "StoreRequisitionNo.": Code[20]) StoreRequisitionLineDeleted: Boolean
    begin
        StoreRequisitionLineDeleted := false;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Line No.", "LineNo.");
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
        if StoreRequisitionLine.FindFirst then begin
            if StoreRequisitionLine.Delete then begin
                StoreRequisitionLineDeleted := true;
            end;
        end;
    end;

    [Scope('Cloud')]
    procedure GetAvailableInventory("ItemNo.": Code[20]; UnitOfMeasure: Code[10]; LocationCode: Code[10]) AvailableInventory: Decimal
    var
        AvailableInventoryInBaseUOM: Decimal;
    begin
        AvailableInventory := 0;
        AvailableInventoryInBaseUOM := 0;

        Item.Reset;
        Item.Get("ItemNo.");

        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Item No.", "ItemNo.");
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Location Code", LocationCode);
        if ItemLedgerEntry.FindSet then begin
            repeat
                AvailableInventoryInBaseUOM := AvailableInventoryInBaseUOM + ItemLedgerEntry.Quantity;
            until ItemLedgerEntry.Next = 0;
        end;

        if UnitOfMeasure <> Item."Base Unit of Measure" then begin
            ItemUnitOfMeasure.Reset;
            ItemUnitOfMeasure.SetRange(ItemUnitOfMeasure."Item No.", Item."No.");
            ItemUnitOfMeasure.SetRange(ItemUnitOfMeasure.Code, UnitOfMeasure);
            if ItemUnitOfMeasure.FindFirst then begin
                AvailableInventory := AvailableInventoryInBaseUOM / ItemUnitOfMeasure."Qty. per Unit of Measure";
            end;
        end else begin
            AvailableInventory := AvailableInventoryInBaseUOM;
        end;
    end;

    [Scope('Cloud')]
    procedure CheckStoreRequisitionLinesExist("StoreRequisitionNo.": Code[20]) StoreRequisitionLinesExist: Boolean
    begin
        StoreRequisitionLinesExist := false;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
        if StoreRequisitionLine.FindFirst then begin
            StoreRequisitionLinesExist := true;
        end;
    end;

    [Scope('Cloud')]
    procedure ValidateStoreRequisitionLines("StoreRequisitionNo.": Code[20]) StoreRequisitionLinesError: Text
    var
        "StoreRequisitionLineNo.": Integer;
    begin
        StoreRequisitionLinesError := '';
        "StoreRequisitionLineNo." := 0;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
        if StoreRequisitionLine.FindSet then begin
            repeat
                "StoreRequisitionLineNo." := "StoreRequisitionLineNo." + 1;
                if StoreRequisitionLine."Item No." = '' then begin
                    StoreRequisitionLinesError := 'Item no. missing on Store requisition line no.' + Format("StoreRequisitionLineNo.") + ', it cannot be zero or empty';
                    break;
                end;

            until StoreRequisitionLine.Next = 0;
        end;
    end;

    [Scope('Cloud')]
    procedure CheckStoreRequisitionApprovalWorkflowEnabled("StoreRequisitionNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then
            ApprovalWorkflowEnabled := StoreRequisitionApproval.CheckStoreRequisitionApprovalWorkflowEnabled(StoreRequisition);
    end;

    [Scope('Cloud')]
    procedure SendStoreRequisitionApprovalRequest("StoreRequisitionNo.": Code[20]) StoreRequisitionApprovalRequestSent: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionApprovalRequestSent := false;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisitionApproval.OnSendStoreRequisitionForApproval(StoreRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", StoreRequisition."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                StoreRequisitionApprovalRequestSent := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CancelStoreRequisitionApprovalRequest("StoreRequisitionNo.": Code[20]) StoreRequisitionApprovalRequestCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionApprovalRequestCanceled := false;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisitionApproval.OnCancelStoreRequisitionForApproval(StoreRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", StoreRequisition."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    StoreRequisitionApprovalRequestCanceled := true;
            end;
        end;
    end;

    [Scope('Cloud')]
    procedure ReopenStoreRequisition("StoreRequisitionNo.": Code[20]) StoreRequisitionOpened: Boolean
    begin
        StoreRequisitionOpened := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        if StoreRequisition.FindFirst then begin
            InventoryApprovalManager.ReOpenStoreRequisitionHeader(StoreRequisition);
            StoreRequisitionOpened := true;
        end;
    end;

    [Scope('Cloud')]
    procedure CancelStoreRequisitionBudgetCommitment("StoreRequisitionNo.": Code[20]) StoreRequisitionBudgetCommitmentCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionBudgetCommitmentCanceled := false;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisitionBudgetCommitmentCanceled := true;
        end;
    end;
}

