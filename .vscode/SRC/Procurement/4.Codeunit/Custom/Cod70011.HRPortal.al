codeunit 70011 HRPortal
{

    var
        HRPortalUsers: Record HRPortalUsers;
        Employee: Record Employee;
        purchaseRequisition: Record "Purchase Requisitions";
        storeRequisition: Record "Store Requisition Header";
        storeRequisitionLine: Record "Store Requisition Line";
        purchaseRequisitionLine: Record "Purchase Requisition Line";
        staffClaimHeader: Record "Funds Claim Header";
        staffClaimLine: Record "Funds Claim Line";
        paymentHeader: Record "Payment Header";
        paymentLine: Record "Payment Line";
        imprestHeader: Record "Imprest Header";
        imprestLine: Record "Imprest Line";
        RecordLink: Record "Record Link";
        surrenderHeader: Record "Imprest Surrender Header";
        surrenderLine: Record "Imprest Surrender Line";
        fundsTransferHeader: Record "Funds Transfer Header";
        fundsTransderLine: Record "Funds Transfer Line";
        fixedAsset: Record "Fixed Asset";
        itemTable: Record Item;
        GLACcount: Record "G/L Account";
        ApprovalsMgmt: codeunit "Approvals Mgmt.";
        PostImprest: Codeunit "Imprest Post";
        ImprestApprovalManager: Codeunit "Imprest Approval Manager";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        PostImprestSurrender: Codeunit ImprestSurrenderPost;
        IMprestSurrenderApprovalManager: Codeunit "Imprest Surrender Approval";
        PurchaseRequisitionApprovalG: Codeunit "Purchase Requisition Approval";
        ProcurementManagementG: Codeunit "Procurement Management";
        ApprovalsMgmtStore: CodeUnit "Store Requisition Approval";
        InventoryManagement: Codeunit "Inventory Management";
        PostFundsClaim: Codeunit "Funds Claim Post";
        FundsClaimApprovalManager: Codeunit "Funds Claim Approval";

    //LeavePlanner:Record HR






    procedure resetPassword("employeeNumber-idNumber": Code[20]) status: Text
    begin
        status := 'danger*Account not found';
        Employee.Reset;
        Employee.SetRange(Employee."No.", "employeeNumber-idNumber");
        if Employee.FindSet then begin
            status := myResetPass(Employee);
        end else begin
            Employee.Reset;
            //Employee.SetRange(Employee."National ID No.", "employeeNumber-idNumber");
            if Employee.FindSet then begin
                status := myResetPass(Employee);
            end else begin
                status := 'danger*Account with the given credentials does not exist';
            end;
        end;
    end;

    local procedure myResetPass(Employee: Record Employee) status: Text
    var
        employeeEmail: Text;
        password: Integer;
        passwordOk: Boolean;
        SMTPMailSetup: Record "Email Account";
    begin
        employeeEmail := Employee."Company E-Mail";
        if employeeEmail = '' then begin
            status := 'danger*You have not added company email to the selected employee. Kindly update and try again';
        end else begin
            passwordOk := false;
            repeat
                password := Random(9999);
                if password > 1000 then
                    passwordOk := true;
            until passwordOk = true;
            HRPortalUsers.Reset;
            HRPortalUsers.SetRange(HRPortalUsers.employeeNo, Employee."No.");
            if HRPortalUsers.FindSet then begin
                HRPortalUsers.password := Format(password);
                HRPortalUsers.changedPassword := false;
                HRPortalUsers."Last Modified Date" := Today;
                HRPortalUsers.Modify(true);
            end else begin
                HRPortalUsers.Init;
                HRPortalUsers.employeeNo := Employee."No.";
                //  HRPortalUsers.IdNo := Employee."National ID No.";
                HRPortalUsers."Authentication Email" := Employee."Company E-Mail";
                HRPortalUsers.password := Format(password);
                HRPortalUsers.State := HRPortalUsers.State::Enabled;
                HRPortalUsers.changedPassword := false;
                HRPortalUsers.employeeName := Employee."First Name" + ' ' + Employee."Last Name";
                HRPortalUsers."Last Modified Date" := Today;
                HRPortalUsers.Insert(true);
            end;
            SendEmailNotification(HRPortalUsers."Authentication Email", 'Password Reset', 'Your one time password is <strong>' + Format(password) + '</strong>');
            status := 'success*We have sent a one time password to your email (' + employeeEmail + '). Use it to log in to your account';
        end;
    end;

    procedure changePassword(employeeNo: Code[50]; currentPassword: Text; newPassword: Text; confirmPassword: Text) status: Text
    var
        HRPortalUsers: Record HRPortalUsers;
        employeeEmail: Text;
    begin
        status := 'danger*Your password could not be changed. Please try again';
        if newPassword = confirmPassword then begin
            HRPortalUsers.Reset;
            HRPortalUsers.SetRange(employeeNo, employeeNo);
            HRPortalUsers.SetRange(password, currentPassword);
            if HRPortalUsers.FindSet then begin
                if StrLen(newPassword) > 3 then begin
                    if newPassword = confirmPassword then begin
                        HRPortalUsers.password := newPassword;
                        HRPortalUsers.changedPassword := true;
                        HRPortalUsers."Last Modified Date" := Today;
                        if HRPortalUsers.Modify(true) then begin
                            status := 'success*Your password was successfully updated';
                        end else begin
                            status := 'danger*Your password could not be changed. Please try again';
                        end;
                    end else begin
                        status := 'danger*New Password and confirm new password do not match!!!';
                    end;
                end else begin
                    status := 'danger*The password you entered as your new password is too short. It should be atleast 4 characters';
                end;
            end else begin
                Employee.Reset;
                Employee.SetRange("No.", employeeNo);
                if Employee.FindSet then begin
                    employeeEmail := Employee."Company E-Mail";
                    if employeeEmail = '' then begin
                        status := 'danger*You have not been assisned a company email company email. Kindly contact ICT.';
                    end else begin
                        // passwordOk := false;
                        // repeat
                        //     password := Random(9999);
                        //     if password > 1000 then
                        //         passwordOk := true;
                        // until passwordOk = true;
                        HRPortalUsers.Reset;
                        HRPortalUsers.SetRange(employeeNo, employeeNo);
                        if HRPortalUsers.FindSet then begin
                            HRPortalUsers.password := Format(newPassword);
                            HRPortalUsers.changedPassword := false;
                            HRPortalUsers."Last Modified Date" := Today;
                            HRPortalUsers.Modify(true);
                        end else begin
                            HRPortalUsers.Init;
                            HRPortalUsers.employeeNo := Employee."No.";
                            //HRPortalUsers.IdNo := Employee."National ID No.";
                            HRPortalUsers."Authentication Email" := Employee."Company E-Mail";
                            HRPortalUsers.password := Format(newPassword);
                            HRPortalUsers.State := HRPortalUsers.State::Enabled;
                            HRPortalUsers.employeeName := Employee."First Name" + ' ' + Employee."Last Name";
                            HRPortalUsers.changedPassword := true;
                            HRPortalUsers."Last Modified Date" := Today;
                            HRPortalUsers.Insert(true);
                        end;

                        status := 'success*Your portal credentials have been created succesfully. Please proceed to login';

                        SendEmailNotification(HRPortalUsers."Authentication Email", 'Employee Password Reset', 'Your one time password is <strong>' + Format(newPassword) + '</strong>');

                    end;
                end else begin
                    status := 'danger*You are not configured as an employee. Kindly contact ICT.';
                end;
            end;

        end else begin
            status := 'danger*New Password and confirm new password do not match!!!';
        end;

        exit(status);
    end;

    procedure createStoreRequisition(employeeNo: Code[50]; requisitionNo: Code[50]; description: Text; department: Code[100]; requiredDate: Date; busnCode: code[50]; airplaneCode: code[50]; tprojectCode: code[50]; refDoc: Text) status: Text
    var
        myType: Text;

    begin
        if requisitionNo = '' THEN BEGIN
            storeRequisition.Init();
            storeRequisition."Employee No." := employeeNo;
            storeRequisition.Validate("Employee No.");
            storeRequisition.Description := description;
            if department <> '' then begin
                storeRequisition."Global Dimension 1 Code" := department;
                storeRequisition.Validate("Global Dimension 1 Code");
            end;

            if busnCode <> '' then
                storeRequisition."Global Dimension 2 Code" := busnCode;
            if airplaneCode <> '' then
                storeRequisition."Shortcut Dimension 3 Code" := airplaneCode;
            if tprojectCode <> '' then
                storeRequisition."Shortcut Dimension 4 Code" := tprojectCode;
            storeRequisition."Required Date" := requiredDate;
            storeRequisition."Reference No." := refDoc;
            if storeRequisition.Insert(true) then begin
                status := 'success*Requisition has been created succesfully*' + storeRequisition."No.";
            end else begin
                status := 'danger*An error occured while submitting your store requisition';
            end;

        END else begin
            storeRequisition.Reset();
            storeRequisition.setrange("No.", requisitionNo);
            if storeRequisition.FindSet(true) then begin
                storeRequisition.Description := description;
                if department <> '' then begin
                    storeRequisition."Global Dimension 1 Code" := department;
                    storeRequisition.Validate("Global Dimension 1 Code");
                end;

                if busnCode <> '' then
                    storeRequisition."Global Dimension 2 Code" := busnCode;
                if airplaneCode <> '' then
                    storeRequisition."Shortcut Dimension 3 Code" := airplaneCode;
                if tprojectCode <> '' then
                    storeRequisition."Shortcut Dimension 4 Code" := tprojectCode;
                storeRequisition."Required Date" := requiredDate;
                storeRequisition."Reference No." := refDoc;
                if storeRequisition.modify(true) then begin
                    status := 'success*Requisition has been modified succesfully*' + storeRequisition."No.";
                end else begin
                    status := 'danger*An error occured while submitting your store requisition';
                end;

            end else begin
                status := 'danger*Store requition was not found';
            end;
        end;


        exit(status);
    end;

    procedure createStoreRequisitionLine(requisitionNo: Code[50]; item: Code[50]; location: code[50]; quantity: Integer) status: Text
    var
        myType: Text;

    begin
        storeRequisition.Reset();
        storeRequisition.setrange("No.", requisitionNo);
        if storeRequisition.FindSet(true) then begin
            storeRequisitionLine.Init();
            storeRequisitionLine."Document No." := requisitionNo;
            storeRequisitionLine."Item No." := item;
            storeRequisitionLine.Validate("Item No.");
            storeRequisitionLine."Location Code" := location;
            storeRequisitionLine.Validate("Location Code");
            storeRequisitionLine.Quantity := quantity;
            if storeRequisitionLine.Insert(true) then begin
                status := 'success*Requisition  item has been added succesfully*' + storeRequisition."No.";
            end else begin
                status := 'danger*An error occured while submitting your store requisition item';
            end;
        end else begin
            status := 'danger*Store requition was not found';
        end;
        exit(status);
    end;

    procedure sendStoreRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        storeRequisition1: Record "Store Requisition Header";

    begin
        storeRequisition.Reset();
        storeRequisition.setrange("No.", requisitionNo);
        storeRequisition.setrange("Employee No.", employeeNo);
        if storeRequisition.FindSet(true) then begin
            If ApprovalsMgmtStore.CheckStoreRequisitionApprovalWorkflowEnabled(storeRequisition) THEN begin
                InventoryManagement.CheckStoreRequisitionMandatoryFields(storeRequisition, FALSE);
                ApprovalsMgmtStore.OnSendStoreRequisitionForApproval(storeRequisition);
                status := 'success*The Store Requisition was successfully sent for approval';
                // if storeRequisition1.Get(requisitionNo) then begin
                //     IF storeRequisition1.Status = storeRequisition1.Status::"Pending Approval" THEN BEGIN
                //         status := 'success*The Store Requisition was successfully sent for approval';
                //     END ELSE BEGIN
                //         status := 'danger*The Store Requisition could not be sent for approval, kindly try again!';
                //     END;
                // end;
            end else begin
                status := 'danger*Approval WOrkflow for Store Requisition not enabled. Kindly contact ICT.';
            end;


        end else begin
            status := 'danger*Store Requisition was not found';
        end;
        exit(status);

    end;

    procedure cancelStoreRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        storeRequisition1: Record "Store Requisition Header";


    begin
        storeRequisition.Reset();
        storeRequisition.setrange("No.", requisitionNo);
        storeRequisition.setrange("Employee No.", employeeNo);
        if storeRequisition.FindSet(true) then begin
            ApprovalsMgmtStore.OnCancelStoreRequisitionForApproval(storeRequisition);
            WorkflowWebhookMgt.FindAndCancel(storeRequisition.RECORDID);
            status := 'success*The Store Requisition has been cancelled succesfully.';
            // if storeRequisition1.Get(requisitionNo) then begin
            //     IF storeRequisition1.Status = storeRequisition1.Status::Open THEN BEGIN
            //         status := 'success*The Store Requisition has been cancelled succesfully.';
            //     END ELSE BEGIN
            //         status := 'danger*The Store Requisition could not be cancelled, kindly try again!';
            //     END;
            // end;

        end else begin
            status := 'danger*Store Requisition was not found';
        end;
        exit(status);

    end;

    procedure deleteRequisitionLine(requisitionNo: Code[50]; lineNumber: Integer) status: Text
    var
        myType: Text;

    begin
        storeRequisitionLine.Reset();
        storeRequisitionLine.setrange("Document No.", requisitionNo);
        storeRequisitionLine.setrange("Line No.", lineNumber);
        if storeRequisitionLine.FindSet(true) then begin
            if storeRequisitionLine.Delete(true) then begin
                status := 'success*Store Requisition item has been added deleted';
            end else begin
                status := 'danger*An error occured while deleting your store requisition item';
            end;
        end else begin
            status := 'danger*Store requition item  was not found';
        end;
        exit(status);
    end;

    procedure createPurchaseRequisition(employeeNo: Code[50]; requisitionNo: Code[50]; description: Text; department: code[50]; busnCode: code[50]; airplaneCode: code[50]; projectCode: code[50]; curr: code[50]; trcptDate: Date; refDoc: Text; purchaseType: Integer) status: Text
    var
        myType: Text;
    begin

        if requisitionNo = '' THEN BEGIN
            purchaseRequisition.Init();
            purchaseRequisition."Employee No." := employeeNo;
            purchaseRequisition.Validate("Employee No.");
            purchaseRequisition.Description := description;
            if department <> '' then
                purchaseRequisition."Global Dimension 1 Code" := department;
            if busnCode <> '' then
                purchaseRequisition."Global Dimension 2 Code" := busnCode;
            if airplaneCode <> '' then
                purchaseRequisition."Shortcut Dimension 3 Code" := airplaneCode;
            if projectCode <> '' then
                purchaseRequisition."Shortcut Dimension 4 Code" := projectCode;
            purchaseRequisition."Currency Code" := curr;
            purchaseRequisition."Purchase Type" := purchaseType;
            purchaseRequisition."Requested Receipt Date" := trcptDate;
            purchaseRequisition."Reference Document No." := refDoc;
            if purchaseRequisition.Insert(true) then begin
                status := 'success*Requisition has been created succesfully*' + purchaseRequisition."No.";
            end else begin
                status := 'danger*An error occured while submitting your purchase requisition';
            end;

        END else begin
            purchaseRequisition.Reset();
            purchaseRequisition.setrange("No.", requisitionNo);
            if purchaseRequisition.FindSet(true) then begin
                purchaseRequisition.Description := description;
                if department <> '' then
                    purchaseRequisition."Global Dimension 1 Code" := department;
                if busnCode <> '' then
                    purchaseRequisition."Global Dimension 2 Code" := busnCode;
                if airplaneCode <> '' then
                    purchaseRequisition."Shortcut Dimension 3 Code" := airplaneCode;
                if projectCode <> '' then
                    purchaseRequisition."Shortcut Dimension 4 Code" := projectCode;
                purchaseRequisition."Currency Code" := curr;
                purchaseRequisition."Requested Receipt Date" := trcptDate;
                purchaseRequisition."Reference Document No." := refDoc;
                if purchaseRequisition.Modify(true) then begin
                    status := 'success*Requisition has been modified succesfully*' + purchaseRequisition."No.";
                end else begin
                    status := 'danger*An error occured while submitting your purchase requisition';
                end;

            end else begin
                status := 'danger*Purchase requition was not found';
            end;
        end;
    end;

    procedure createPurchaseRequisitionLine(requisitionNo: Code[50]; reqType: Option; typee: Option; quantity: Integer; deliveryLocation: Code[50]; item: Code[50]; unitCost: Decimal) status: Text
    var
        myType: Text;

    begin
        purchaseRequisition.Reset();
        purchaseRequisition.setrange("No.", requisitionNo);
        if purchaseRequisition.FindSet(true) then begin
            purchaseRequisitionLine.Init();
            purchaseRequisitionLine."Document No." := requisitionNo;
            if (reqType = 1) then
                purchaseRequisitionLine."Requisition Type" := purchaseRequisitionLine."Requisition Type"::Service;
            if (reqType = 2) then
                purchaseRequisitionLine."Requisition Type" := purchaseRequisitionLine."Requisition Type"::Item;
            if (reqType = 3) then
                purchaseRequisitionLine."Requisition Type" := purchaseRequisitionLine."Requisition Type"::"Fixed Asset";
            purchaseRequisitionLine.Validate("Requisition Type");
            purchaseRequisitionLine."Requisition Code" := item;
            purchaseRequisitionLine.Validate("Requisition Code");
            purchaseRequisitionLine."Location Code" := deliveryLocation;
            purchaseRequisitionLine.Quantity := quantity;
            purchaseRequisitionLine.Validate(Quantity);
            purchaseRequisitionLine."Estimated Unit Cost" := unitCost;
            purchaseRequisitionLine.Validate("Estimated Unit Cost");
            //purchaseRequisitionLine.Description := description;
            if purchaseRequisitionLine.Insert(true) then begin
                status := 'success*Purchase item has been added succesfully*' + storeRequisition."No.";
            end else begin
                status := 'danger*An error occured while submitting your purchase requisition item';
            end;

        end else begin
            status := 'danger*Purchase requition was not found';
        end;
        exit(status);
    end;

    procedure sendPurchaseRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        purchaseRequisition1: Record "Purchase Header";

    begin
        purchaseRequisition.Reset();
        purchaseRequisition.setrange("No.", requisitionNo);
        purchaseRequisition.setrange("Employee No.", employeeNo);
        if purchaseRequisition.FindSet(true) then begin
            ProcurementManagementG.CheckPurchaseRequisitionMandatoryFields(purchaseRequisition);
            If PurchaseRequisitionApprovalG.CheckPurchaseRequisitionApprovalWorkflowEnabled(purchaseRequisition) THEN begin

                PurchaseRequisitionApprovalG.OnSendPurchaseRequisitionForApproval(purchaseRequisition);
                // if purchaseRequisition1.Get(requisitionNo) then begin
                //     IF purchaseRequisition1.Status = purchaseRequisition1.Status::"Pending Approval" THEN BEGIN
                //         status := 'success*The Purchase Requisition was successfully sent for approval';
                //     END ELSE BEGIN
                //         status := 'danger*The Purchase Requisition could not be sent for approval, kindly try again!';
                //     END;
                // end;
                status := 'success*The Purchase Requisition was successfully sent for approval';
            end else begin
                status := 'danger*Approval Workflow for Purchase Requisition not enabled. Kindly contact ICT.';
            end;


        end else begin
            status := 'danger*Purchase Requisition was not found';
        end;
        exit(status);

    end;

    procedure cancelPurchaseRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        purchaseRequisition1: Record "Purchase Header";

    begin
        purchaseRequisition.Reset();
        purchaseRequisition.setrange("No.", requisitionNo);
        purchaseRequisition.setrange("Employee No.", employeeNo);
        if purchaseRequisition.FindSet(true) then begin
            PurchaseRequisitionApprovalG.OnCancelPurchaseRequisitionForApproval(purchaseRequisition);
            WorkflowWebhookMgt.FindAndCancel(purchaseRequisition.RecordId);
            status := 'success*The Purchase Requisition has been cancelled succesfully.';
            // if purchaseRequisition1.Get(requisitionNo) then begin
            //     IF purchaseRequisition1.Status = purchaseRequisition1.Status::Open THEN BEGIN
            //         status := 'success*The Purchase Requisition has been cancelled succesfully.';
            //     END ELSE BEGIN
            //         status := 'danger*The Purchase Requisition could not be cancelled, kindly try again!';
            //     END;
            // end;

        end else begin
            status := 'danger*Purchase Requisition was not found';
        end;
        exit(status);

    end;

    procedure deletePurchaseLine(requisitionNo: Code[50]; lineNumber: Integer) status: Text
    var
        myType: Text;

    begin
        purchaseRequisitionLine.Reset();
        purchaseRequisitionLine.setrange("Document No.", requisitionNo);
        purchaseRequisitionLine.setrange("Line No.", lineNumber);
        if purchaseRequisitionLine.FindSet(true) then begin
            if purchaseRequisitionLine.Delete(true) then begin
                status := 'success*Purchase item  item has been deleted';
            end else begin
                status := 'danger*An error occured while deleting your purchase item';
            end;
        end else begin
            status := 'danger*Purchase item was not found';
        end;
        exit(status);
    end;

    procedure createStaffClaim(employeeNo: Code[50]; description: Text; requisitionNo: Code[50]; docType: Option; curr: code[50]) status: Text
    var
        myType: Text;
    begin
        if requisitionNo = '' THEN BEGIN
            staffClaimHeader.Init();
            staffClaimHeader."Document Type" := docType;
            staffClaimHeader."Payee No." := employeeNo;
            staffClaimHeader.Validate("Payee No.");
            staffClaimHeader.Description := description;
            staffClaimHeader."Currency Code" := curr;
            if staffClaimHeader.Insert(true) then begin
                status := 'success*Staff Claim has been created succesfully*' + staffClaimHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your Staff Claim';
            end;

        END else begin
            staffClaimHeader.Reset();
            staffClaimHeader.setrange("No.", requisitionNo);
            staffClaimHeader.SetRange("Document Type", docType);
            if staffClaimHeader.FindSet(true) then begin
                staffClaimHeader.Description := description;
                if staffClaimHeader.modify(true) then begin
                    status := 'success*Staff Claim has been modified succesfully*' + staffClaimHeader."No.";
                end else begin
                    status := 'danger*An error occured while submitting your Staff Claim';
                end;

            end else begin
                status := 'danger*Staff Claim was not found';
            end;
        end;


        exit(status);
    end;

    procedure createStaffClaimLine(requisitionNo: Code[50]; amount: Decimal; transType: code[70]) status: Text
    var
        myType: Text;

    begin
        staffClaimHeader.Reset();
        staffClaimHeader.setrange("No.", requisitionNo);
        if staffClaimHeader.FindSet(true) then begin
            staffClaimLine.Init();
            staffClaimLine."Document No." := requisitionNo;
            staffClaimLine.Amount := amount;
            staffClaimLine.Validate(Amount);
            staffClaimLine."Funds Claim Code" := transType;
            staffClaimLine.Validate("Funds Claim Code");
            //purchaseRequisitionLine.Description := description;
            if staffClaimLine.Insert(true) then begin
                status := 'success*Staff Claim has been added succesfully';
            end else begin
                status := 'danger*An error occured while submitting your Staff Claim item';
            end;

        end else begin
            status := 'danger*Staff Claim was not found';
        end;
        exit(status);
    end;

    procedure sendStaffRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        staffClaimHeader1: Record "Funds Claim Header";

    begin
        staffClaimHeader.Reset();
        staffClaimHeader.setrange("No.", requisitionNo);
        staffClaimHeader.setrange("Payee No.", employeeNo);
        if staffClaimHeader.FindSet(true) then begin
            If FundsClaimApprovalManager.CheckFundsClaimApprovalWorkflowEnabled(staffClaimHeader) THEN begin
                FundsClaimApprovalManager.OnSendFundsClaimForApproval(staffClaimHeader);
                status := 'success*The Staff Claim was successfully sent for approval';
                // if staffClaimHeader1.Get(requisitionNo) then begin
                //     IF staffClaimHeader1.Status = staffClaimHeader1.Status::"Pending Approval" THEN BEGIN
                //         status := 'success*The Staff Claim was successfully sent for approval';
                //     END ELSE BEGIN
                //         status := 'danger*The Staff Claim could not be sent for approval, kindly try again!';
                //     END;
                // end;
            end else begin
                status := 'danger*Approval Workflow for Staff Claim not enabled. Kindly contact ICT.';
            end;


        end else begin
            status := 'danger*Staff Claim was not found';
        end;
        exit(status);

    end;

    procedure cancelStaffRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        staffClaimHeader1: Record "Funds Claim Header";

    begin
        staffClaimHeader.Reset();
        staffClaimHeader.setrange("No.", requisitionNo);
        staffClaimHeader.setrange("Payee No.", employeeNo);
        if staffClaimHeader.FindSet(true) then begin
            FundsClaimApprovalManager.OnCancelFundsClaimForApproval(staffClaimHeader);
            //WorkflowWebhookMgt.FindAndCancel(purchaseRequisition.RecordId);
            status := 'success*The Staff Claim has been cancelled succesfully.';
            // if staffClaimHeader1.Get(requisitionNo) then begin
            //     IF staffClaimHeader1.Status = staffClaimHeader1.Status::Open THEN BEGIN
            //         status := 'success*The Staff Claim has been cancelled succesfully.';
            //     END ELSE BEGIN
            //         status := 'danger*The Staff Claim could not be cancelled, kindly try again!';
            //     END;
            // end;

        end else begin
            status := 'danger*Staff Claim was not found';
        end;
        exit(status);

    end;

    procedure deleteStaffLine(requisitionNo: Code[50]; lineNumber: Integer) status: Text
    var
        myType: Text;

    begin
        staffClaimLine.Reset();
        staffClaimLine.setrange("Document No.", requisitionNo);
        staffClaimLine.setrange("Line No.", lineNumber);
        if staffClaimLine.FindSet(true) then begin
            if staffClaimLine.Delete(true) then begin
                status := 'success*Staff calaim  item has been deleted';
            end else begin
                status := 'danger*An error occured while deleting your staff claim item';
            end;
        end else begin
            status := 'danger*Staff Claim item was not found';
        end;
        exit(status);
    end;

    procedure createPaymentHeader(employeeNo: Code[50]; description: Text; requisitionNo: Code[50]; docType: Option) status: Text
    var
        myType: Text;
    begin
        if requisitionNo = '' THEN BEGIN
            paymentHeader.Init();
            paymentHeader."Document Type" := docType;
            paymentHeader."Payee No." := employeeNo;
            paymentHeader.Validate("Payee No.");
            paymentHeader.Description := description;
            if paymentHeader.Insert(true) then begin
                status := 'success*Staff Claim has been created succesfully*' + paymentHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your Staff Claim';
            end;

        END else begin
            paymentHeader.Reset();
            paymentHeader.setrange("No.", requisitionNo);
            paymentHeader.SetRange("Document Type", docType);
            if paymentHeader.FindSet(true) then begin
                paymentHeader.Description := description;
                if paymentHeader.modify(true) then begin
                    status := 'success*Staff Claim has been modified succesfully*' + paymentHeader."No.";
                end else begin
                    status := 'danger*An error occured while submitting your Staff Claim';
                end;

            end else begin
                status := 'danger*Staff Claim was not found';
            end;
        end;
        exit(status);
    end;

    procedure createPaymentLine(requisitionNo: Code[50]; description: Text; amount: Decimal) status: Text
    var
        myType: Text;

    begin
        paymentHeader.Reset();
        paymentHeader.setrange("No.", requisitionNo);
        if paymentLine.FindSet(true) then begin
            paymentLine.Init();
            paymentLine."Document No." := requisitionNo;
            fundsTransderLine.Amount := amount;
            fundsTransderLine.Validate(Amount);
            paymentLine.Description := description;
            //purchaseRequisitionLine.Description := description;
            if paymentLine.Insert(true) then begin
                status := 'success*Staff Claim has been added succesfully';
            end else begin
                status := 'danger*An error occured while submitting your Staff Claim item';
            end;

        end else begin
            status := 'danger*Staff Claim was not found';
        end;
        exit(status);
    end;

    procedure createPettyCashHeader(employeeNo: Code[50]; description: Text; requisitionNo: Code[50]; docType: Option; payMode: Option; refNo: Text) status: Text
    var
        myType: Text;
    begin
        if requisitionNo = '' THEN BEGIN
            fundsTransferHeader.Init();
            fundsTransferHeader."Document Type" := docType;
            fundsTransferHeader."Transfer To" := employeeNo;
            fundsTransferHeader.Validate("Transfer To");
            fundsTransferHeader.Description := description;
            fundsTransferHeader."Payment Mode" := payMode;
            fundsTransferHeader."Reference No." := refNo;
            if fundsTransferHeader.Insert(true) then begin
                status := 'success*Petty cash has been created succesfully*' + fundsTransferHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your Petty Cash';
            end;

        END else begin
            fundsTransferHeader.Reset();
            fundsTransferHeader.setrange("No.", requisitionNo);
            fundsTransferHeader.SetRange("Document Type", docType);
            if fundsTransferHeader.FindSet(true) then begin
                fundsTransferHeader.Description := description;
                fundsTransferHeader."Payment Mode" := payMode;
                fundsTransferHeader."Reference No." := refNo;
                if fundsTransferHeader.modify(true) then begin
                    status := 'success*Petty Cash has been modified succesfully*' + fundsTransferHeader."No.";
                end else begin
                    status := 'danger*An error occured while submitting your Petty Cash';
                end;

            end else begin
                status := 'danger*Petty Cash was not found';
            end;
        end;
        exit(status);
    end;

    procedure createPettyCashLine(requisitionNo: Code[50]; description: Text; amount: Decimal) status: Text
    var
        myType: Text;

    begin
        fundsTransferHeader.Reset();
        fundsTransferHeader.setrange("No.", requisitionNo);
        if fundsTransferHeader.FindSet(true) then begin
            fundsTransderLine.Init();
            fundsTransderLine."Document No." := requisitionNo;
            fundsTransderLine.Amount := amount;
            fundsTransderLine.Validate(Amount);
            fundsTransderLine.Description := description;
            if fundsTransderLine.Insert(true) then begin
                status := 'success*Petty cash has been added succesfully';
            end else begin
                status := 'danger*An error occured while submitting your Petty cash item';
            end;

        end else begin
            status := 'danger*Petty cash was not found';
        end;
        exit(status);
    end;

    procedure deletePaymentLine(requisitionNo: Code[50]; lineNumber: Integer) status: Text
    var
        myType: Text;

    begin
        paymentLine.Reset();
        paymentLine.setrange("Document No.", requisitionNo);
        paymentLine.setrange("Line No.", lineNumber);
        if paymentLine.FindSet(true) then begin
            if paymentLine.Delete(true) then begin
                status := 'success*Pyamnet  item has been deleted';
            end else begin
                status := 'danger*An error occured while deleting your payment item';
            end;
        end else begin
            status := 'danger*Payment was not found';
        end;
        exit(status);
    end;

    procedure deletePettycashLine(requisitionNo: Code[50]; lineNumber: Integer) status: Text
    var
        myType: Text;

    begin
        fundsTransderLine.Reset();
        fundsTransderLine.setrange("Document No.", requisitionNo);
        fundsTransderLine.setrange("Line No.", lineNumber);
        if fundsTransderLine.FindSet(true) then begin
            if fundsTransderLine.Delete(true) then begin
                status := 'success*Petty cash  item has been deleted';
            end else begin
                status := 'danger*An error occured while deleting your petty cash item';
            end;
        end else begin
            status := 'danger*Petty cash item was not found';
        end;
        exit(status);
    end;

    procedure createImprestHeader(employeeNo: Code[50]; requisitionNo: Code[50]; description: Text; fromDate: Date; toDate: Date; department: code[50]; busnCode: code[50]; airplaneCode: code[50]; tprojectCode: code[50]; curr: code[50]) status: Text
    var
        myType: Text;
    begin
        if requisitionNo = '' THEN BEGIN
            imprestHeader.Init();
            imprestHeader."Employee No." := employeeNo;
            imprestHeader.Validate("Employee No.");
            imprestHeader.Description := description;
            imprestHeader."Date From" := fromDate;
            imprestHeader."Date To" := toDate;
            if department <> '' then
                imprestHeader."Global Dimension 1 Code" := department;
            if busnCode <> '' then
                imprestHeader."Global Dimension 2 Code" := busnCode;
            if airplaneCode <> '' then
                imprestHeader."Shortcut Dimension 3 Code" := airplaneCode;
            if tprojectCode <> '' then
                imprestHeader."Shortcut Dimension 4 Code" := tprojectCode;
            imprestHeader."Currency Code" := curr;
            if imprestHeader.Insert(true) then begin
                status := 'success*Imprest has been created succesfully*' + imprestHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your Imprest';
            end;

        END else begin
            imprestHeader.Reset();
            imprestHeader.setrange("No.", requisitionNo);
            if imprestHeader.FindSet(true) then begin
                imprestHeader.Description := description;
                imprestHeader.Description := description;
                imprestHeader."Date From" := fromDate;
                imprestHeader."Date To" := toDate;
                if department <> '' then
                    imprestHeader."Global Dimension 1 Code" := department;
                if busnCode <> '' then
                    imprestHeader."Global Dimension 2 Code" := busnCode;
                if airplaneCode <> '' then
                    imprestHeader."Shortcut Dimension 3 Code" := airplaneCode;
                if tprojectCode <> '' then
                    imprestHeader."Shortcut Dimension 4 Code" := tprojectCode;
                imprestHeader."Currency Code" := curr;
                if imprestHeader.modify(true) then begin
                    status := 'success*Imprest has been modified succesfully*' + imprestHeader."No.";
                end else begin
                    status := 'danger*An error occured while submitting your Imprest';
                end;

            end else begin
                status := 'danger*Staff Claim was not found';
            end;
        end;
        exit(status);
    end;

    procedure createImprestLine(requisitionNo: Code[50]; transactionType: code[50]; unitCost: Decimal; quantity: Decimal) status: Text
    var
        myType: Text;

    begin
        imprestHeader.Reset();
        imprestHeader.setrange("No.", requisitionNo);
        if imprestHeader.FindSet(true) then begin
            imprestLine.Init();
            imprestLine."Document No." := requisitionNo;
            imprestLine."Imprest Code" := transactionType;
            imprestLine.Quantity := quantity;
            imprestLine.Validate(Quantity);
            imprestLine.Validate("Imprest Code");
            imprestLine."Unit Cost" := unitCost;
            imprestLine.Validate("Unit Cost");

            if imprestLine.Insert(true) then begin
                status := 'success*Imprest Line has been added succesfully';
            end else begin
                status := 'danger*An error occured while submitting your Imprest Line';
            end;

        end else begin
            status := 'danger*Imprest was not found';
        end;
        exit(status);
    end;

    procedure deleteImprestLine(requisitionNo: Code[50]; lineNumber: Integer) status: Text
    var
        myType: Text;

    begin
        imprestLine.Reset();
        imprestLine.setrange("Document No.", requisitionNo);
        imprestLine.setrange("Line No.", lineNumber);
        if imprestLine.FindSet(true) then begin
            if imprestLine.Delete(true) then begin
                status := 'success*Imprest Line has been deleted';
            end else begin
                status := 'danger*An error occured while deleting your Imprest Line';
            end;
        end else begin
            status := 'danger*Imprest was not found';
        end;
        exit(status);
    end;

    procedure sendImprestRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        imprestHeader1: Record "Imprest Header";

    begin
        imprestHeader.Reset();
        imprestHeader.setrange("No.", requisitionNo);
        imprestHeader.setrange("Employee No.", employeeNo);
        if imprestHeader.FindSet(true) then begin
            If ImprestApprovalManager.CheckImprestHeaderApprovalWorkflowEnabled(imprestHeader) THEN begin
                PostImprest.CheckImprestMandatoryFields(imprestHeader."No.");
                IF ImprestApprovalManager.CheckImprestHeaderApprovalWorkflowEnabled(imprestHeader) THEN
                    ImprestApprovalManager.OnSendImprestHeaderForApproval(imprestHeader);
                status := 'success*The imprest requisition was successfully sent for approval';
                // if imprestHeader1.Get(requisitionNo) then begin
                //     IF imprestHeader1.Status = imprestHeader1.Status::"Pending Approval" THEN BEGIN
                //         status := 'success*The imprest requisition was successfully sent for approval';
                //     END ELSE BEGIN
                //         status := 'danger*The imprest requisition could not be sent for approval, kindly try again!';
                //     END;
                // end;
            end else begin
                status := 'danger*APprovel WOrkflow for Imprest Requisition not enabled. Kindly contact ICT.';
            end;


        end else begin
            status := 'danger*Imprest was not found';
        end;
        exit(status);

    end;

    procedure cancelImprestRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        imprestHeader1: Record "Imprest Header";

    begin
        imprestHeader.Reset();
        imprestHeader.setrange("No.", requisitionNo);
        imprestHeader.setrange("Employee No.", employeeNo);
        if imprestHeader.FindSet(true) then begin
            ImprestApprovalManager.OnCancelImprestHeaderForApproval(imprestHeader);
            WorkflowWebhookMgt.FindAndCancel(imprestHeader.RECORDID);
            status := 'success*The imprest approval has been cancelled succesfully.';
            // if imprestHeader1.Get(requisitionNo) then begin
            //     IF imprestHeader1.Status = imprestHeader1.Status::Open THEN BEGIN
            //         status := 'success*The imprest approval has been cancelled succesfully.';
            //     END ELSE BEGIN
            //         status := 'danger*The imprest requisition could not be cancelled, kindly try again!';
            //     END;
            // end;

        end else begin
            status := 'danger*Imprest was not found';
        end;
        exit(status);

    end;

    procedure createSurrender(employeeNo: Code[50]; requisitionNo: Code[50]; imprestNumber: code[50]) status: Text
    var
        myType: Text;
    begin

        if requisitionNo = '' THEN BEGIN
            surrenderHeader.Init();
            surrenderHeader."Employee No." := employeeNo;
            surrenderHeader.Validate("Employee No.");
            surrenderHeader."Imprest No." := imprestNumber;
            surrenderHeader.Validate("Imprest No.");
            if surrenderHeader.Insert(true) then begin
                surrenderHeader.Validate("Imprest No.");
                status := 'success*Requisition has been created succesfully*' + surrenderHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your imprest surrender';
            end;

        END else begin
            surrenderHeader.Reset();
            surrenderHeader.setrange("No.", requisitionNo);
            if surrenderHeader.FindSet(true) then begin
                surrenderHeader."Imprest No." := imprestNumber;
                surrenderHeader.validate("Imprest No.");
                if surrenderHeader.Insert(true) then begin
                    status := 'success*Imprest Surrender has been modified succesfully*' + surrenderHeader."No.";
                end else begin
                    status := 'danger*An error occured while submitting your imprest surrender';
                end;

            end else begin
                status := 'danger*Imprest surrender was not found';
            end;
        end;
    end;

    procedure createSurrenderLine(requisitionNo: Code[50]; lineNo: Integer; actualSpent: Decimal) status: Text
    var
        myType: Text;

    begin
        surrenderHeader.Reset();
        surrenderHeader.setrange("No.", requisitionNo);
        if surrenderHeader.FindSet(true) then begin
            surrenderLine.Reset();
            surrenderLine.setrange("Document No.", requisitionNo);
            surrenderLine.setrange("Line No.", lineNo);
            if surrenderLine.FindSet() then begin
                surrenderLine."Actual Spent" := actualSpent;
                if surrenderLine.Modify(true) then begin
                    status := 'success*Imprest surrender expense has been added succesfully'
                end else begin
                    status := 'danger*An error occured while submitting your Imprest surrender expense';
                end;
            end else begin
                status := 'danger*Imprest surrender Line was not found';
            end;
        end else begin
            status := 'danger*Imprest surrender Header was not found';
        end;
        exit(status);
    end;

    procedure sendSurrenderRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        surrenderHeader1: Record "Imprest Surrender Header";

    begin
        surrenderHeader.Reset();
        surrenderHeader.setrange("No.", requisitionNo);
        surrenderHeader.setrange("Employee No.", employeeNo);
        if surrenderHeader.FindSet(true) then begin
            PostImprestSurrender.CheckImprestSurrenderMandatoryFields(surrenderHeader."No.");
            IF IMprestSurrenderApprovalManager.CheckImprestsurrenderApprovalWorkflowEnabled(surrenderHeader) THEN begin
                IMprestSurrenderApprovalManager.OnSendImprestsurrenderForApproval(surrenderHeader);
                status := 'success*The imprest surrender approval has been sent succesfully.';
                // if surrenderHeader1.Get(requisitionNo) then begin
                //     IF surrenderHeader1.Status = surrenderHeader1.Status::"Pending Approval" THEN BEGIN
                //         status := 'success*The imprest surrender approval has been sent succesfully.';
                //     END ELSE BEGIN
                //         status := 'danger*The imprest surrender could not be sent, kindly try again!';
                //     END;

                // end;
            end else begin
                status := 'danger*The imprest surrender workflow not enabled!';
            end;

        end else begin
            status := 'danger*Imprest surrenderwas not found';
        end;
        exit(status);

    end;

    procedure cancelSurrenderRequisitionApproval(requisitionNo: Code[50]; employeeNo: code[50]) status: Text
    var
        myType: Text;
        surrenderHeader1: Record "Imprest Surrender Header";

    begin
        surrenderHeader.Reset();
        surrenderHeader.setrange("No.", requisitionNo);
        surrenderHeader.setrange("Employee No.", employeeNo);
        if surrenderHeader.FindSet(true) then begin
            IMprestSurrenderApprovalManager.OnCancelImprestsurrenderForApproval(surrenderHeader);
            WorkflowWebhookMgt.FindAndCancel(surrenderHeader.RECORDID);
            status := 'success*The imprest surrender approval has been cancelled succesfully.';
            // IF surrenderHeader1.Status = surrenderHeader1.Status::Open THEN BEGIN
            //     status := 'success*The imprest surrender approval has been cancelled succesfully.';
            // END ELSE BEGIN
            //     status := 'danger*The imprest surrender could not be cancelled, kindly try again!';
            // END;

        end else begin
            status := 'danger*Imprest surrenderwas not found';
        end;
        exit(status);

    end;

    procedure deleteSurrenderLine(requisitionNo: Code[50]; lineNumber: Integer) status: Text
    var
        myType: Text;

    begin
        surrenderLine.Reset();
        surrenderLine.setrange("Document No.", requisitionNo);
        surrenderLine.setrange("Line No.", lineNumber);
        if surrenderLine.FindSet(true) then begin
            if surrenderLine.Delete(true) then begin
                status := 'success*Imprest Surrender has been deleted';
            end else begin
                status := 'danger*An error occured while deleting your Imprest Surrender Line';
            end;
        end else begin
            status := 'danger*Imprest surrender linewas not found';
        end;
        exit(status);
    end;

    procedure createStoreDocumentLink(applicationNo: Code[50]; FileLink: Text; FileName: Text) status: Text
    var
        myType: Text;
        RecordIDNumber: RecordId;

    begin
        IF RecordLink."Link ID" = 0 THEN BEGIN
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := USERID;
            RecordLink.Created := CREATEDATETIME(TODAY, TIME);
            storeRequisition.RESET;
            storeRequisition.SetRange("No.", applicationNo);
            IF storeRequisition.FIND('=') THEN
                RecordIDNumber := storeRequisition.RECORDID;
            RecordLink."Record ID" := RecordIDNumber;
            IF RecordLink.INSERT(TRUE) THEN BEGIN
                status := 'success*Link successfully created';
            END ELSE BEGIN
                status := 'error*An error occured during the process of creating link';
            END
        END;
    end;

    procedure DeleteStoreDocumentLink(applicationNo: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        // Create Document Link to Sharepoint **************************
        storeRequisition.reset();
        storeRequisition.setrange("No.", applicationNo);
        if storeRequisition.FindSet(true) THEN begin
            RecordLink.Reset;
            RecordLink.setrange("Record ID", storeRequisition.RecordId);
            RecordLink.setrange(Description, filename);
            if RecordLink.FindSet(true) then begin
                if RecordLink.Delete(true) then begin
                    status := 'success*The document was successfully deleted';
                end else begin
                    status := 'error*An error occured during the process of deleting link';
                end;
            end;

        end else begin
            status := 'error*An error occured during the process of deleting the link. Link could not be found.';
        end;

    end;

    procedure createPurchaseDocumentLink(applicationNo: Code[50]; FileLink: Text; FileName: Text) status: Text
    var
        myType: Text;
        RecordIDNumber: RecordId;

    begin
        IF RecordLink."Link ID" = 0 THEN BEGIN
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := USERID;
            RecordLink.Created := CREATEDATETIME(TODAY, TIME);
            purchaseRequisition.RESET;
            purchaseRequisition.SetRange("No.", applicationNo);
            IF purchaseRequisition.FIND('=') THEN
                RecordIDNumber := purchaseRequisition.RECORDID;
            RecordLink."Record ID" := RecordIDNumber;
            IF RecordLink.INSERT(TRUE) THEN BEGIN
                status := 'success*Link successfully created';
            END ELSE BEGIN
                status := 'error*An error occured during the process of creating link';
            END
        END;
    end;

    procedure DeletePurchaseDocumentLink(applicationNo: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        // Create Document Link to Sharepoint **************************
        purchaseRequisition.reset();
        purchaseRequisition.setrange("No.", applicationNo);
        if purchaseRequisition.FindSet(true) THEN begin
            RecordLink.Reset;
            RecordLink.setrange("Record ID", purchaseRequisition.RecordId);
            RecordLink.setrange(Description, filename);
            if RecordLink.FindSet(true) then begin
                if RecordLink.Delete(true) then begin
                    status := 'success*The document was successfully deleted';
                end else begin
                    status := 'error*An error occured during the process of deleting link';
                end;
            end;

        end else begin
            status := 'error*An error occured during the process of deleting the link. Link could not be found.';
        end;

    end;

    procedure createSurrenderDocumentLink(applicationNo: Code[50]; FileLink: Text; FileName: Text) status: Text
    var
        myType: Text;
        RecordIDNumber: RecordId;

    begin
        IF RecordLink."Link ID" = 0 THEN BEGIN
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := USERID;
            RecordLink.Created := CREATEDATETIME(TODAY, TIME);
            surrenderHeader.RESET;
            surrenderHeader.SetRange("No.", applicationNo);
            IF surrenderHeader.FIND('=') THEN
                RecordIDNumber := surrenderHeader.RECORDID;
            RecordLink."Record ID" := RecordIDNumber;
            IF RecordLink.INSERT(TRUE) THEN BEGIN
                status := 'success*Link successfully created';
            END ELSE BEGIN
                status := 'error*An error occured during the process of creating link';
            END
        END;
    end;

    procedure DeleteSurrenderDocumentLink(applicationNo: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        // Create Document Link to Sharepoint **************************
        surrenderHeader.reset();
        surrenderHeader.setrange("No.", applicationNo);
        if surrenderHeader.FindSet(true) THEN begin
            RecordLink.Reset;
            RecordLink.setrange("Record ID", surrenderHeader.RecordId);
            RecordLink.setrange(Description, filename);
            if RecordLink.FindSet(true) then begin
                if RecordLink.Delete(true) then begin
                    status := 'success*The document was successfully deleted';
                end else begin
                    status := 'error*An error occured during the process of deleting link';
                end;
            end;

        end else begin
            status := 'error*An error occured during the process of deleting the link. Link could not be found.';
        end;

    end;

    procedure createImprestDocumentLink(applicationNo: Code[50]; FileLink: Text; FileName: Text) status: Text
    var
        myType: Text;
        RecordIDNumber: RecordId;

    begin
        IF RecordLink."Link ID" = 0 THEN BEGIN
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := USERID;
            RecordLink.Created := CREATEDATETIME(TODAY, TIME);
            imprestHeader.RESET;
            imprestHeader.SetRange("No.", applicationNo);
            IF imprestHeader.FIND('=') THEN
                RecordIDNumber := imprestHeader.RECORDID;
            RecordLink."Record ID" := RecordIDNumber;
            IF RecordLink.INSERT(TRUE) THEN BEGIN
                status := 'success*Link successfully created';
            END ELSE BEGIN
                status := 'error*An error occured during the process of creating link';
            END
        END;
    end;

    procedure createPettyCashDocumentLink(applicationNo: Code[50]; FileLink: Text; FileName: Text) status: Text
    var
        myType: Text;
        RecordIDNumber: RecordId;

    begin
        IF RecordLink."Link ID" = 0 THEN BEGIN
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := USERID;
            RecordLink.Created := CREATEDATETIME(TODAY, TIME);
            fundsTransferHeader.RESET;
            fundsTransferHeader.SetRange("No.", applicationNo);
            IF fundsTransferHeader.FIND('=') THEN
                RecordIDNumber := fundsTransferHeader.RECORDID;
            RecordLink."Record ID" := RecordIDNumber;
            IF RecordLink.INSERT(TRUE) THEN BEGIN
                status := 'success*Link successfully created';
            END ELSE BEGIN
                status := 'error*An error occured during the process of creating link';
            END
        END;
    end;

    procedure DeleteImprestDocumentLink(applicationNo: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        // Create Document Link to Sharepoint **************************
        imprestHeader.reset();
        imprestHeader.setrange("No.", applicationNo);
        if imprestHeader.FindSet(true) THEN begin
            RecordLink.Reset;
            RecordLink.setrange("Record ID", imprestHeader.RecordId);
            RecordLink.setrange(Description, filename);
            if RecordLink.FindSet(true) then begin
                if RecordLink.Delete(true) then begin
                    status := 'success*The document was successfully deleted';
                end else begin
                    status := 'error*An error occured during the process of deleting link';
                end;
            end;

        end else begin
            status := 'error*An error occured during the process of deleting the link. Link could not be found.';
        end;

    end;

    procedure createStaffClaimDocumentLink(applicationNo: Code[50]; FileLink: Text; FileName: Text) status: Text
    var
        myType: Text;
        RecordIDNumber: RecordId;

    begin
        IF RecordLink."Link ID" = 0 THEN BEGIN
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := USERID;
            RecordLink.Created := CREATEDATETIME(TODAY, TIME);
            staffClaimHeader.Reset();
            staffClaimHeader.SetRange("No.", applicationNo);
            IF staffClaimHeader.FIND('=') THEN
                RecordIDNumber := staffClaimHeader.RECORDID;
            RecordLink."Record ID" := RecordIDNumber;
            IF RecordLink.INSERT(TRUE) THEN BEGIN
                status := 'success*Link successfully created';
            END ELSE BEGIN
                status := 'error*An error occured during the process of creating link';
            END
        END;
    end;

    procedure DeleteStaffClaimDocumentLink(applicationNo: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        // Create Document Link to Sharepoint **************************
        staffClaimHeader.reset();
        staffClaimHeader.setrange("No.", applicationNo);
        if staffClaimHeader.FindSet(true) THEN begin
            RecordLink.Reset;
            RecordLink.setrange("Record ID", staffClaimHeader.RecordId);
            RecordLink.setrange(Description, filename);
            if RecordLink.FindSet(true) then begin
                if RecordLink.Delete(true) then begin
                    status := 'success*The document was successfully deleted';
                end else begin
                    status := 'error*An error occured during the process of deleting link';
                end;
            end;

        end else begin
            status := 'error*An error occured during the process of deleting the link. Link could not be found.';
        end;

    end;

    procedure DeletePettyCashDocumentLink(applicationNo: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        // Create Document Link to Sharepoint **************************
        fundsTransferHeader.RESET;
        fundsTransferHeader.SetRange("No.", applicationNo);
        fundsTransferHeader.SetRange("Document Type", fundsTransferHeader."Document Type"::Refund);
        if fundsTransferHeader.FindSet(true) THEN begin
            RecordLink.Reset;
            RecordLink.setrange("Record ID", fundsTransferHeader.RecordId);
            RecordLink.setrange(Description, filename);
            if RecordLink.FindSet(true) then begin
                if RecordLink.Delete(true) then begin
                    status := 'success*The document was successfully deleted';
                end else begin
                    status := 'error*An error occured during the process of deleting link';
                end;
            end;

        end else begin
            status := 'error*An error occured during the process of deleting the link. Link could not be found.';
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
