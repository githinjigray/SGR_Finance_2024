codeunit 70012 QueriesESS
{
    var
        tbl_HrPortalUsers: Record HRPortalUsers;
        tbl_employee: Record Employee;
        tbl_Imprest_surrender: Record "Imprest Surrender Header";
        tbl_Imprest_surrender_Lines: Record "Imprest Surrender Line";
        tbl_store_header: Record "Store Requisition Header";
        tbl_Purchase_Requisitions: Record "Purchase Requisitions";
        storeReqs: Record "Store Requisition Header";
        storeReqLines: Record "Store Requisition Line";
        purchasePurchaseLines: Record "Purchase Requisition Line";
        departments: Record "Dimension Value";
        item: Record Item;
        location: Record Location;
        staffClaimHeader: Record "Funds Claim Header";
        staffClaimLine: Record "Funds Claim Line";
        paymentHeader: Record "Payment Header";
        paymentLine: Record "Payment Line";
        imprestHeader: Record "Imprest Header";
        imprestLine: Record "Imprest Line";
        approvalEntries: Record "Approval Entry";
        approvalLines: Record "Approval Comment Line";
        transactionTypes: Record "Funds Transaction Code";
        fundsTransferHeader: Record "Funds Transfer Header";
        fundsTransderLine: Record "Funds Transfer Line";
        fixedAsset: Record "Fixed Asset";
        itemTable: Record Item;
        GLACcount: Record "G/L Account";
        purchReqCodes: Record "Purchase Requisition Codes";
        currency: Record Currency;
        ItemLedgerEntry: Record "Item Ledger Entry";



    procedure loginUser(empNumber: Code[30]; password: Text) data: Text
    var
        sunsurrImprest: Decimal;
    begin
        tbl_HrPortalUsers.Reset();
        tbl_HrPortalUsers.SetRange(employeeNo, empNumber);
        tbl_HrPortalUsers.SetRange(password, password);
        tbl_employee.Reset();
        tbl_employee.SetRange("No.", empNumber);
        if tbl_HrPortalUsers.FindSet() and tbl_employee.FindSet() then begin
            imprestHeader.Reset();
            imprestHeader.SetRange("Employee No.", empNumber);
            imprestHeader.SetRange("Document Type", paymentHeader."Document Type"::Imprest);
            imprestHeader.SetRange(Reversed, false);
            imprestHeader.SetRange("Surrender status", imprestHeader."Surrender status"::"Not Surrendered");
            imprestHeader.SetRange(Posted, true);
            if imprestHeader.FindSet() then begin
                repeat
                    imprestHeader.CalcFields("Amount(LCY)");
                    sunsurrImprest := sunsurrImprest + imprestHeader."Amount(LCY)";
                until imprestHeader.Next() = 0;
            end;
            data := 'success**** ' + tbl_HrPortalUsers.employeeName + '****' + tbl_employee."Social Security No." + '****' + Format(tbl_employee.Gender) + '****'
            + tbl_HrPortalUsers.employeeNo + '****' + tbl_HrPortalUsers.password + '****' + Format(tbl_HrPortalUsers.changedPassword) + '****'
            + Format(tbl_employee."Company E-Mail") + '****' + tbl_employee."Global Dimension 1 Code" + '****' + tbl_employee."Global Dimension 2 Code" + '****' + tbl_employee."Mobile Phone No." + '****' + Format(sunsurrImprest);
        end;
        exit(data);
    end;

    procedure FnResetPassword(emailaddress: Text) passChangestatus: Text
    var
        DynasoftPortalUser: Record HRPortalUsers;
        RandomDigit: Text;
        Body: Text;
    begin
        DynasoftPortalUser.Reset;
        DynasoftPortalUser.SetRange("Authentication Email", emailaddress);
        DynasoftPortalUser.SetRange(DynasoftPortalUser.State, DynasoftPortalUser.State::Enabled);
        if DynasoftPortalUser.FindSet then begin
            RandomDigit := CreateGuid;
            RandomDigit := DelChr(RandomDigit, '=', '{}-01');
            RandomDigit := CopyStr(RandomDigit, 1, 8);
            DynasoftPortalUser.password := RandomDigit;
            DynasoftPortalUser."Last Modified Date" := Today;
            DynasoftPortalUser.changedPassword := false;
            // DynasoftPortalUser.changedPassword := DynasoftPortalUser."record type"::Customer;
            if DynasoftPortalUser.Modify(true) then begin
                passChangestatus := 'success*Password Reset Successfully';
                ResetSendEmail(emailaddress);
            end else begin
                passChangestatus := 'danger*The Password was Not Modified';
            end;
        end else begin
            passChangestatus := 'emailnotfound*Email Address is Missing';
        end;
    end;

    procedure ResetSendEmail(emailaddress: Text)
    var
        DynasoftPortalUser: Record HRPortalUsers;
        SMTPMailSetup: Record "Email Account";
        Email2: Text;
        Body: Text;
        SMTP: Codeunit "Email Message";
        emailhdr: Text;
        emailBody: Text;
    begin
        DynasoftPortalUser.Reset;
        DynasoftPortalUser.SetRange("Authentication Email", emailaddress);
        if DynasoftPortalUser.FindSet then begin

            emailBody := 'Dear ' + DynasoftPortalUser.employeeName + ',<BR><BR>' +
               'Your Password for the account <b>' + ' ' + Format(DynasoftPortalUser."Authentication Email") + ' ' + '</b> has been Reset Successfully.Kindly Change your Password on Login<BR>' +
               'Use the following link to acess the employee self service Portal.' + ' ' + '<b><a href="#">Employee Portal</a></b><BR>Your New Credentials are:'
               + '<BR>'
               + 'Username:' + ' <b>' + DynasoftPortalUser."Authentication Email" + '</b><BR>Password:' + ' <b>' + DynasoftPortalUser.password + '</b>';

            emailhdr := 'Employee Password Reset';

            SendEmailNotification(emailaddress, emailhdr, emailBody);

        end;
    end;

    procedure fnGetEmployeeDetail(empNumber: Code[30]) data: Text
    begin
        tbl_employee.Reset();
        tbl_employee.SetRange("No.", empNumber);
        if tbl_employee.FindSet() then begin
            repeat
                data += tbl_employee."Company E-Mail" + '*' + tbl_employee."Phone No." + '*' + tbl_employee."Social Security No." + '::::';
            until tbl_employee.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnImprestSurrenders(empNumber: Code[30]) data: Text
    begin
        tbl_Imprest_surrender.Reset();
        tbl_Imprest_surrender.SetRange("Employee No.", empNumber);
        if tbl_Imprest_surrender.FindSet() then begin
            repeat
                tbl_Imprest_surrender.CalcFields(Amount);
                data += tbl_Imprest_surrender."No." + '*' + tbl_Imprest_surrender."Imprest No." + '*' + Format(tbl_Imprest_surrender."Document Date")
                 + '*' + Format(tbl_Imprest_surrender."Amount") + '*' + Format(tbl_Imprest_surrender.Status) + '::::';
            until tbl_Imprest_surrender.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnImprestSurrendersSingle(empNumber: Code[30]; appNo: code[50]) data: Text
    begin
        tbl_Imprest_surrender.Reset();
        tbl_Imprest_surrender.SetRange("Employee No.", empNumber);
        tbl_Imprest_surrender.SetRange("No.", appNo);
        if tbl_Imprest_surrender.FindSet() then begin
            repeat
                tbl_Imprest_surrender.CalcFields(Amount);
                data += tbl_Imprest_surrender."No." + '*' + tbl_Imprest_surrender."Imprest No." + '*' + Format(tbl_Imprest_surrender."Document Date")
                 + '*' + Format(tbl_Imprest_surrender.Amount) + '*' + Format(tbl_Imprest_surrender.Status) + '*' + Format(tbl_Imprest_surrender."Currency Code") + '::::';
            until tbl_Imprest_surrender.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnImprestSurrendersLines(appNo: Code[30]) data: Text
    begin
        tbl_Imprest_surrender_Lines.Reset();
        tbl_Imprest_surrender_Lines.SetRange("Document No.", appNo);
        if tbl_Imprest_surrender_Lines.FindSet() then begin
            repeat
                data += Format(tbl_Imprest_surrender_Lines."Line No.") + '*' + Format(tbl_Imprest_surrender_Lines."Imprest Code Description") + '*'
                 + Format(tbl_Imprest_surrender_Lines."Amount Advanced") + '*'
                 + Format(tbl_Imprest_surrender_Lines."Actual Spent") + '*'
                 + Format(tbl_Imprest_surrender_Lines."Receipt No.") + '::::';
            until tbl_Imprest_surrender_Lines.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnCurrencies() data: Text
    begin
        currency.Reset();
        if currency.FindSet() then begin
            repeat
                data += Format(currency.Code) + '*' + Format(currency.Description) + '::::';
            until currency.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnPurchaseRequisitions(empNumber: Code[30]) data: Text
    var
        docDate: Text;
    begin
        tbl_Purchase_Requisitions.Reset();
        tbl_Purchase_Requisitions.SetRange("Employee No.", empNumber);
        if tbl_Purchase_Requisitions.FindSet() then begin
            repeat
                tbl_Purchase_Requisitions.CalcFields(Amount);
                //docDate := Format(Date2DMY(tbl_Purchase_Requisitions."Document Date", 1)) + '/' + format(Date2DMY(tbl_Purchase_Requisitions."Document Date", 2)) + '/' + format(Date2DMY(tbl_Purchase_Requisitions."Document Date", 3));
                data += tbl_Purchase_Requisitions."No." + '*' + Format(tbl_Purchase_Requisitions.Description) + '*' + Format(tbl_Purchase_Requisitions.Status) + '*' + Format(tbl_Purchase_Requisitions."Document Date")
                 + '*' + Format(tbl_Purchase_Requisitions."Amount") + '*' + Format(tbl_Purchase_Requisitions.Description) +
                 '*' + Format(tbl_Purchase_Requisitions."Requisition Type") + '*' + Format(tbl_Purchase_Requisitions."Purchase Type") + '*' + Format(tbl_Purchase_Requisitions."Currency Code") +
                  '*' + Format(tbl_Purchase_Requisitions."Global Dimension 1 Code") + '*' + Format(tbl_Purchase_Requisitions."Global Dimension 2 Code") +
                  '*' + Format(tbl_Purchase_Requisitions."Shortcut Dimension 3 Code") + '*' + Format(tbl_Purchase_Requisitions."Shortcut Dimension 5 Code") + '*' + Format(tbl_Purchase_Requisitions."Reference Document No.") + '::::';
            until tbl_Purchase_Requisitions.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnPurchaseRequisitionsSingle(empNumber: Code[30]; appNo: code[50]) data: Text
    var
        docDate: Text;
    begin
        tbl_Purchase_Requisitions.Reset();
        tbl_Purchase_Requisitions.SetRange("Employee No.", empNumber);
        tbl_Purchase_Requisitions.SetRange("No.", appNo);
        if tbl_Purchase_Requisitions.FindSet() then begin
            repeat
                tbl_Purchase_Requisitions.CalcFields(Amount);
                //docDate := Format(Date2DMY(tbl_Purchase_Requisitions."Document Date", 1)) + '/' + format(Date2DMY(tbl_Purchase_Requisitions."Document Date", 2)) + '/' + format(Date2DMY(tbl_Purchase_Requisitions."Document Date", 3));
                data += tbl_Purchase_Requisitions."No." + '*' + Format(tbl_Purchase_Requisitions.Description) + '*' + Format(tbl_Purchase_Requisitions.Status) + '*' + Format(tbl_Purchase_Requisitions."Requested Receipt Date")
                 + '*' + Format(tbl_Purchase_Requisitions.Amount) + '*' + Format(tbl_Purchase_Requisitions."Requisition Type") + '*' + Format(tbl_Purchase_Requisitions."Purchase Type") + '*' + Format(tbl_Purchase_Requisitions."Currency Code") +
                  '*' + Format(tbl_Purchase_Requisitions."Global Dimension 1 Code") + '*' + Format(tbl_Purchase_Requisitions."Global Dimension 2 Code") +
                  '*' + Format(tbl_Purchase_Requisitions."Shortcut Dimension 3 Code") + '*' + Format(tbl_Purchase_Requisitions."Shortcut Dimension 4 Code") + '*' + Format(tbl_Purchase_Requisitions."Reference Document No.") + '*' + Format(tbl_Purchase_Requisitions."Currency Code") + '*' + Format(tbl_Purchase_Requisitions."Purchase Type");
            until tbl_Purchase_Requisitions.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnStoreRequisitions(empNumber: Code[30]) data: Text
    var
        docDate: Text;
        reqDate: Text;
    begin
        storeReqs.Reset();
        storeReqs.SetRange("Employee No.", empNumber);
        if storeReqs.FindSet() then begin
            repeat
                storeReqs.CalcFields(Amount);
                //docDate := Format(Date2DMY(storeReqs."Document Date", 1)) + '/' + format(Date2DMY(storeReqs."Document Date", 2)) + '/' + format(Date2DMY(storeReqs."Document Date", 3));
                //reqDate := Format(Date2DMY(storeReqs."Required Date", 1)) + '/' + format(Date2DMY(storeReqs."Required Date", 2)) + '/' + format(Date2DMY(storeReqs."Required Date", 3));
                data += storeReqs."No." + '*' + Format(docDate)
                 + '*' + Format(storeReqs.Amount) + '*' + Format(storeReqs.Status) + '*' + Format(storeReqs.Description) +
                 '*' + Format(reqDate) + '*' + Format(storeReqs."Required Date") + '*' + Format(storeReqs.Department) + Format(storeReqs."Global Dimension 1 Code") + '*' + Format(storeReqs."Global Dimension 2 Code") +
                  '*' + Format(storeReqs."Shortcut Dimension 3 Code") + '*' + Format(storeReqs."Shortcut Dimension 4 Code") + '*' + Format(storeReqs."Reference No.") + '::::';
            until storeReqs.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnStoreRequisitionsSingle(empNumber: Code[30]; appNo: code[50]) data: Text
    var
        docDate: Text;
        reqDate: Text;
    begin
        storeReqs.Reset();
        storeReqs.SetRange("Employee No.", empNumber);
        storeReqs.SetRange("No.", appNo);
        if storeReqs.FindSet() then begin
            repeat
                storeReqs.CalcFields(Amount);
                //docDate := Format(Date2DMY(storeReqs."Document Date", 1)) + '/' + format(Date2DMY(storeReqs."Document Date", 2)) + '/' + format(Date2DMY(storeReqs."Document Date", 3));
                //reqDate := Format(Date2DMY(storeReqs."Required Date", 1)) + '/' + format(Date2DMY(storeReqs."Required Date", 2)) + '/' + format(Date2DMY(storeReqs."Required Date", 3));
                data += storeReqs."No." + '*' + Format(docDate)
                 + '*' + Format(storeReqs.Amount) + '*' + Format(storeReqs.Status) + '*' + Format(storeReqs.Description) +
                 '*' + Format(reqDate) + '*' + Format(storeReqs."Global Dimension 1 Code") + '*' + Format(storeReqs."Global Dimension 2 Code") +
                  '*' + Format(storeReqs."Shortcut Dimension 3 Code") + '*' + Format(storeReqs."Shortcut Dimension 4 Code") + '*' + Format(storeReqs."Reference No.") + '*' + Format(storeReqs."Required Date");
            until storeReqs.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnStoreRequisitionLines(appNo: Code[30]) data: Text
    begin
        storeReqLines.Reset();
        storeReqLines.SetRange("Document No.", appNo);
        if storeReqLines.FindSet() then begin
            repeat
                data += Format(storeReqLines."Line No.") + '*' + storeReqLines."Item No." + '*' + Format(storeReqLines.Quantity)
                 + '*' + Format(storeReqLines.Description) + '*' + Format(storeReqLines."Location Code") + '*' + Format(storeReqLines."Unit Cost") + '::::';
            until storeReqLines.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnPurchaseRequisitionLines(appNo: Code[30]) data: Text
    begin
        purchasePurchaseLines.Reset();
        purchasePurchaseLines.SetRange("Document No.", appNo);
        if purchasePurchaseLines.FindSet() then begin
            repeat
                data += Format(purchasePurchaseLines."Line No.") + '*' + Format(purchasePurchaseLines.Quantity)
                 + '*' + Format(purchasePurchaseLines.Name) + '*' + Format(purchasePurchaseLines.Type) + '*'
                 + Format(purchasePurchaseLines."Requisition Type") + '*'
                 + Format(purchasePurchaseLines."Location Code") + '*'
                 + Format(purchasePurchaseLines."Requisition Type") + '*'
                 + Format(purchasePurchaseLines."Total Amount") + '*'
                 + Format(purchasePurchaseLines."Estimated Unit Cost") + '*'
                 + Format(purchasePurchaseLines.Description)
                 + '*'
                 + Format(purchasePurchaseLines."No.") + '*'
                 + Format(purchasePurchaseLines."Estimated Unit Cost") + '::::';
            until purchasePurchaseLines.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnGetDepartments(dmValueType: Option; Blocked: boolean; gblDmNo: Integer) data: Text
    begin
        departments.Reset();
        departments.setrange("Dimension Value Type", dmValueType);
        departments.setrange(Blocked, Blocked);
        departments.setrange("Global Dimension No.", gblDmNo);
        if departments.FindSet() then begin
            repeat
                data += Format(departments.Code) + '*' + Format(departments.Name) + '::::';
            until departments.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnGetDepartments2(dmValueType: Option; Blocked: boolean; gblDmNo: Integer) data: Text
    begin
        departments.Reset();
        departments.setrange("Dimension Value Type", dmValueType);
        departments.setrange(Blocked, Blocked);
        departments.setrange("Global Dimension No.", gblDmNo);
        //departments.SetRange("Global Dimension 1 Code", glblDmCode);
        if departments.FindSet() then begin
            repeat
                data += Format(departments.Code) + '*' + Format(departments.Name) + '::::';
            until departments.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnGetItems() data: Text
    begin
        item.Reset();
        item.SetRange(Blocked, false);
        if item.FindSet() then begin
            repeat
                data += Format(item."No.") + '*' + Format(item.Description) + '::::';
            until item.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnGetInventory(itemNo: Code[50]; location: Code[50]) data: Text
    var
        AvailableInventory: Integer;

    begin
        AvailableInventory := 0;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", itemNo);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", location);
        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                AvailableInventory := AvailableInventory + ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        Exit(Format(AvailableInventory));
    end;

    procedure fnGetItemPart(itemNo: Code[50]) data: Text
    begin
        item.Reset();
        item.SetRange("No.", itemNo);
        if item.FindSet() then begin
            repeat
                data += Format(item."Part No.") + '*' + Format(item."Alternative Item No.") + '*' + Format(item."Alternative Part No. 1") +
                '*' + Format(item."Alternative Part No. 2") + '*' + Format(item."Alternative Part No. 3") + '*' + Format(item."Alternative Part No. 4") + '*' + Format(item."Unit Cost") + '::::';
            until item.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnGetLocations() data: Text
    begin
        location.Reset();
        if location.FindSet() then begin
            repeat
                data += Format(location.Code) + '*' + Format(location.Name) + '::::';
            until location.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnStaffClaims(empNumber: Code[30]; docType: Option) data: Text
    var
        docDate: Text;
    begin
        staffClaimHeader.Reset();
        staffClaimHeader.SetRange("Payee No.", empNumber);
        staffClaimHeader.SetRange("Document Type", docType);
        if staffClaimHeader.FindSet() then begin
            repeat
                staffClaimHeader.CalcFields(Amount);
                //docDate := Format(Date2DMY(staffClaimHeader."Document Date", 1)) + '/' + format(Date2DMY(staffClaimHeader."Document Date", 2)) + '/' + format(Date2DMY(staffClaimHeader."Document Date", 3));
                data += staffClaimHeader."No." + '*' + Format(docDate)
                 + '*' + Format(staffClaimHeader.Amount) + '*' + Format(staffClaimHeader.Status) + '*' + Format(staffClaimHeader.Description) +
                 '*' + Format(staffClaimHeader."Global Dimension 1 Code") + '::::';
            until staffClaimHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnStaffClaimsSingle(empNumber: Code[30]; docType: Option; appNo: code[50]) data: Text
    var
        docDate: Text;
    begin
        staffClaimHeader.Reset();
        staffClaimHeader.SetRange("Payee No.", empNumber);
        staffClaimHeader.SetRange("Document Type", docType);
        staffClaimHeader.SetRange("No.", appNo);
        if staffClaimHeader.FindSet() then begin
            repeat
                StaffClaimHeader.CalcFields(Amount);
                //docDate := Format(Date2DMY(staffClaimHeader."Document Date", 1)) + '/' + format(Date2DMY(staffClaimHeader."Document Date", 2)) + '/' + format(Date2DMY(staffClaimHeader."Document Date", 3));
                data += staffClaimHeader."No." + '*' + Format(docDate)
                 + '*' + Format(staffClaimHeader.Amount) + '*' + Format(staffClaimHeader.Status) + '*' + Format(staffClaimHeader.Description) +
                 '*' + Format(staffClaimHeader."Global Dimension 1 Code") + '*' + Format(staffClaimHeader."Currency Code") + '::::';
            until staffClaimHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnPaymentHeader(empNumber: Code[30]; docType: Option) data: Text
    var
        docDate: Text;
    begin
        paymentHeader.Reset();
        paymentHeader.SetRange("Payee No.", empNumber);
        paymentHeader.SetRange("Document Type", docType);
        if paymentHeader.FindSet() then begin
            repeat
                //docDate := Format(Date2DMY(paymentHeader."Document Date", 1)) + '/' + format(Date2DMY(paymentHeader."Document Date", 2)) + '/' + format(Date2DMY(paymentHeader."Document Date", 3));
                data += paymentHeader."No." + '*' + Format(docDate)
                 + '*' + Format(paymentHeader."Total Amount") + '*' + Format(paymentHeader.Status) + '*' + Format(paymentHeader.Description) +
                 '*' + Format(paymentHeader."Global Dimension 1 Code") + '::::';
            until paymentHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnPettycashHeader(empNumber: Code[30]; docType: Option) data: Text
    var
        docDate: Text;
    begin
        fundsTransferHeader.Reset();
        fundsTransferHeader.SetRange("Transfer To", empNumber);
        fundsTransferHeader.SetRange("Document Type", docType);
        if fundsTransferHeader.FindSet() then begin
            repeat
                //docDate := Format(Date2DMY(fundsTransferHeader."Document Date", 1)) + '/' + format(Date2DMY(fundsTransferHeader."Document Date", 2)) + '/' + format(Date2DMY(fundsTransferHeader."Document Date", 3));
                data += fundsTransferHeader."No." + '*' + Format(docDate)
                 + '*' + Format(fundsTransferHeader."Amount To Transfer") + '*' + Format(fundsTransferHeader.Status) + '*' + Format(fundsTransferHeader.Description) +
                 '*' + Format(fundsTransferHeader."Global Dimension 1 Code") + '::::';
            until paymentHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnStaffClaimLines(appNo: Code[30]) data: Text
    begin
        staffClaimLine.Reset();
        staffClaimLine.SetRange("Document No.", appNo);
        if staffClaimLine.FindSet() then begin
            repeat
                data += Format(staffClaimLine."Line No.") + '*' + Format(staffClaimLine."Funds Claim Code Description") + '*' + Format(staffClaimLine.Amount) + '::::';
            until staffClaimLine.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnPettyCashLines(appNo: Code[30]) data: Text
    begin
        fundsTransderLine.Reset();
        fundsTransderLine.SetRange("Document No.", appNo);
        if fundsTransderLine.FindSet() then begin
            repeat
                data += Format(fundsTransderLine."Line No.") + '*' + Format(fundsTransderLine.Description) + '*' + Format(fundsTransderLine.Amount) + '::::';
            until fundsTransderLine.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnPaymentLines(appNo: Code[30]) data: Text
    begin
        paymentLine.Reset();
        paymentLine.SetRange("Document No.", appNo);
        if paymentLine.FindSet() then begin
            repeat
                data += Format(paymentLine."Line No.") + '*' + Format(paymentLine.Description) + '::::';
            until paymentLine.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnImprestHeader(empNumber: Code[30]) data: Text
    var
        fromDate: Text;
        toDate: Text;
    begin
        imprestHeader.Reset();
        imprestHeader.SetRange("Employee No.", empNumber);
        if imprestHeader.FindSet() then begin
            repeat
                imprestHeader.CalcFields(Amount);
                //fromDate := Format(Date2DMY(imprestHeader."Date From", 1)) + '/' + format(Date2DMY(imprestHeader."Date From", 2)) + '/' + format(Date2DMY(imprestHeader."Date From", 3));
                //toDate := Format(Date2DMY(imprestHeader."Date To", 1)) + '/' + format(Date2DMY(imprestHeader."Date To", 2)) + '/' + format(Date2DMY(imprestHeader."Date To", 3));
                data += imprestHeader."No." + '*' + Format(fromDate) + '*' + Format(toDate) + '*' + Format(imprestHeader.Amount) + '*' + Format(imprestHeader.Status) + '*' + Format(imprestHeader.Description) +
                 '*' + Format(imprestHeader.Destination) + '*' + Format(imprestHeader."Global Dimension 1 Code") + '*' + Format(imprestHeader."Global Dimension 2 Code") +
                  '*' + Format(imprestHeader."Shortcut Dimension 3 Code") + '*' + Format(imprestHeader."Shortcut Dimension 5 Code") + '::::';
            until imprestHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnImprestHeaderSingle(empNumber: Code[30]; appNo: code[50]) data: Text
    var
        fromDate: Text;
        toDate: Text;
    begin
        imprestHeader.Reset();
        imprestHeader.SetRange("Employee No.", empNumber);
        imprestHeader.SetRange("No.", appNo);
        if imprestHeader.FindSet() then begin
            repeat
                imprestHeader.CalcFields(Amount);
                fromDate := Format(Date2DMY(imprestHeader."Date From", 1)) + '/' + format(Date2DMY(imprestHeader."Date From", 2)) + '/' + format(Date2DMY(imprestHeader."Date From", 3));
                toDate := Format(Date2DMY(imprestHeader."Date To", 1)) + '/' + format(Date2DMY(imprestHeader."Date To", 2)) + '/' + format(Date2DMY(imprestHeader."Date To", 3));
                data += imprestHeader."No." + '*' + Format(fromDate) + '*' + Format(toDate) + '*' + Format(imprestHeader.Amount) + '*' + Format(imprestHeader.Status) + '*' + Format(imprestHeader.Description) +
                 '*' + Format(imprestHeader.Destination) + '*' + Format(imprestHeader."Currency Code") + '*' + Format(imprestHeader."Global Dimension 1 Code") + '*' + Format(imprestHeader."Global Dimension 2 Code") +
                  '*' + Format(imprestHeader."Shortcut Dimension 3 Code") + '*' + Format(imprestHeader."Shortcut Dimension 4 Code") + '*' + Format(imprestHeader."Shortcut Dimension 5 Code") + '::::';
            until imprestHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnImprestLines(appNo: Code[30]) data: Text
    begin
        imprestLine.Reset();
        imprestLine.SetRange("Document No.", appNo);
        if imprestLine.FindSet() then begin
            repeat
                data += Format(imprestLine."Line No.") + '*' + Format(imprestLine.quantity) + '*' + Format(imprestLine."Imprest Code Description") + '*' + Format(imprestLine.Amount) + '*' + Format(imprestLine."Imprest Code Description") + '*' + Format(imprestLine."Unit Cost") + '::::';
            until imprestLine.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnApprovalEntries(appNo: Code[30]) data: Text
    begin
        approvalEntries.Reset();
        approvalEntries.SetRange("Document No.", appNo);
        if approvalEntries.FindSet() then begin
            repeat
                data += Format(approvalEntries."Sequence No.") + '*' + Format(approvalEntries.Status) + '*' + Format(approvalEntries."Sender ID") + '*'
                + Format(approvalEntries."Amount (LCY)") + '*' + Format(imprestLine."Account Name") + '*'
                 + Format(approvalEntries."Date-Time Sent for Approval") + '*' + Format(approvalEntries."Due Date") + '*' + Format(approvalEntries.Comment) +
                  '*' + Format(approvalEntries."Approver ID") + '*' + Format(approvalEntries."Sender Name") + '*' + Format(approvalEntries."Approver Name") + '::::';
            until approvalEntries.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnApprovalCommentLine(appNo: Code[30]) data: Text
    begin
        approvalEntries.Reset();
        approvalEntries.SetRange("Document No.", appNo);
        approvalEntries.SetRange(Comment, true);
        if approvalEntries.FindSet() then begin
            approvalLines.Reset();
            approvalLines.SetRange("Document No.", appNo);
            approvalLines.SetRange("Table ID", approvalEntries."Table ID");
            approvalLines.SetRange("Record ID to Approve", approvalEntries."Record ID to Approve");
            approvalLines.SetRange("Workflow Step Instance ID", approvalEntries."Workflow Step Instance ID");
            approvalLines.SetRange("User ID", approvalEntries."Approver ID");
            if approvalLines.FindSet() then begin
                repeat
                    data += Format(approvalLines.Comment) + '::::';
                until approvalLines.Next() = 0;
            end;
            Exit(data);
        end;

    end;

    procedure fnOpenImprests(employeeNo: Code[50]) data: Text
    begin
        imprestHeader.Reset();
        imprestHeader.SetRange("Employee No.", employeeNo);
        imprestHeader.SetRange("Document Type", paymentHeader."Document Type"::Imprest);
        imprestHeader.SetRange(Posted, true);
        if imprestHeader.FindSet() then begin
            repeat
                imprestHeader.CalcFields("Amount(LCY)");
                data += Format(imprestHeader."No.") + '*' + Format(imprestHeader.Description) + '*' + Format(imprestHeader."Document Type") + '*' + Format(imprestHeader."Amount(LCY)") + '::::';
            until imprestHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnUnSurrenderedImprests(employeeNo: Code[50]) data: Text
    begin
        imprestHeader.Reset();
        imprestHeader.SetRange("Employee No.", employeeNo);
        imprestHeader.SetRange("Document Type", paymentHeader."Document Type"::Imprest);
        imprestHeader.SetRange(Reversed, false);
        imprestHeader.SetRange("Surrender status", imprestHeader."Surrender status"::"Not Surrendered");
        imprestHeader.SetRange(Posted, true);
        if imprestHeader.FindSet() then begin
            repeat
                imprestHeader.CalcFields("Amount(LCY)");
                data += Format(imprestHeader."No.") + '*' + Format(imprestHeader.Description) + '*' + Format(imprestHeader."Document Type") + '*' + Format(imprestHeader."Amount(LCY)") + '::::';
            until imprestHeader.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fntransactionCodes(transactionType: option) data: Text
    begin
        transactionTypes.Reset();
        transactionTypes.SetRange("Transaction Type", transactionType);
        if transactionTypes.FindSet() then begin
            repeat
                data += Format(transactionTypes."Transaction Code") + '*' + Format(transactionTypes.Description) + '::::';
            until transactionTypes.Next() = 0;
        end;
        Exit(data);
    end;

    procedure fnGetProcurementLineItems(reqType: Integer) data: Text
    begin


        if (reqType = 1) then begin

            purchReqCodes.Reset();
            purchReqCodes.SetRange("Requisition Type", purchReqCodes."Requisition Type"::Service);
            if purchReqCodes.FindSet() then begin
                repeat
                    data += Format(purchReqCodes.Description) + '*' + Format(purchReqCodes.Description) + '::::';
                until purchReqCodes.next = 0;
            end;
            Exit(data);
        end;
        if (reqType = 2) then begin
            item.Reset();
            item.SetRange(Blocked, false);
            if item.FindSet() then begin
                repeat
                    data += Format(item."No.") + '*' + Format(item.Description) + '*' + Format(item."Part No.") + '*' + Format(item."Alternative Item No.") +
                    '*' + Format(item."Alternative Part No. 1") + '*' + Format(item."Alternative Part No. 2") + '*' + Format(item."Alternative Part No. 3") +
                    '*' + Format(item."Alternative Part No. 4") + '::::';
                until item.next = 0;
            end;
            Exit(data);
        end;
        if (reqType = 3) then begin
            fixedAsset.Reset();
            if fixedAsset.FindSet() then begin
                repeat
                    data += Format(fixedAsset."No.") + '*' + Format(fixedAsset.Description) + '::::';
                until fixedAsset.next = 0;
            end;
            Exit(data);
        end;

    end;




    procedure SendEmailNotification(recepient: Text; emailSubject: Text; emailBody: Text)
    var
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
    begin
        EmailMessage.Create(recepient, emailSubject, emailBody, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;
}
