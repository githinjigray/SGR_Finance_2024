report 50513 "Sales Order Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/SalesOrder.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(ExpensePeriod_PurchaseHeader; "Sales Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ApprovalStatus; ApprovalStatus)
            {
            }
            column(ApprovedBy; ApprovedBy)
            {
            }
            column(EmailGenerated; EmailGenerated)
            {
            }
            column(InvoiceEmail; InvoiceEmail)
            {
            }
            column(RegionDimension; RegionDimension)
            {
            }
            column(EmployeeTitle; EmployeeTitle)
            {
            }
            column(ApprovalDate; ApprovalDate)
            {
            }
            column(ApproverTitle; ApproverTitle)
            {
            }
            column(PurchaseType_PurchaseHeader; "Sales Header"."Document Type")
            {
            }
            column(ShortcutDimension1Code_PurchaseHeader; "Sales Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension3Code_PurchaseHeader; "Sales Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PurchaseHeader; "Sales Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_PurchaseHeader; "Sales Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_PurchaseHeader; "Sales Header"."Shortcut Dimension 6 Code")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Sales Header"."Sell-to Customer Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Sales Header"."Sell-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Sales Header"."Sell-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Sales Header"."Sell-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Sales Header"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Sales Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Sales Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Sales Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Sales Header"."Ship-to Address 2")
            {
            }
            column(UserID_PurchaseHeader; "Sales Header".SystemCreatedBy)
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; Departments)
            {
            }
            column(ShortcutDimension3Code_PurchaseHeaders; "Sales Header"."Shortcut Dimension 3 Code")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyMail)
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Web; CompanyInfo.Website)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Sales Header"."Date Of Flight")
            {
            }
            column(PostingDate_PurchaseHeader; "Sales Header"."Posting Date")
            {
            }
            column(No_PurchaseHeader; "Sales Header"."No.")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Sales Header"."Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Sales Header"."Currency Code")
            {
            }
            column(Amount_PurchaseHeader; "Sales Header".Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Sales Header"."Amount Including VAT")
            {
            }
            column(TotalDiscountAmount; 0)
            {
            }
            column(PropertyNo; PropertyNo)
            {
            }
            column(propertyname; propertyname)
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(NoPrinted; "Sales Header"."No. Printed")
            {
            }
            column(LNo; LNo)
            {
            }
            column(PaymentTermsCodesNEW; "Sales Header"."Payment Terms Code")
            {
            }
            column(DueDate_PurchaseHeader; "Sales Header"."Due Date")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(PhoneNumber; PhoneNumber)
            {
            }
            column(EmailAddress; EmailAddress)
            {
            }
            column(DeliverTo; DeliverTo)
            {
            }
            column(VendorVATNo; VendorVATNo)
            {

            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(LineNo_PurchaseLine; "Sales Line"."Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Sales Line"."Line Amount")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Sales Line"."Unit Price")
                {
                }
                column(Quantity_PurchaseLine; "Sales Line".Quantity)
                {
                }
                column(No_PurchaseLine; AccountNo)
                {
                }
                column(Description_PurchaseLine; "Sales Line".Description)
                {
                }
                column(Remarks_PurchaseLine; DescptiionRemarks)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Sales Line"."Unit of Measure Code")
                {
                }
                column(LineDiscount_PurchaseLine; "Sales Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Sales Line"."Line Discount Amount")
                {
                }
                column(VAT; "Sales Line"."VAT %")
                {
                }
                column(LocationCode; "Sales Line"."Location Code")
                {
                }
                column(Remarks; "Sales Line"."Description 2")
                {
                }
                column(Part_No_; "Part No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                    AccountNo := "Sales Line"."No.";
                    // if ("Sales Line".Type = "Sales Line".Type::Item) and
                    // ("Sales Line"."Part No." <> '') then
                    //     AccountNo := "Sales Line"."Part No.";

                    DescptiionRemarks := '';
                    DescptiionRemarks := "Sales Line"."Description 2";
                    if "Sales Line"."Description 2" = '' then
                        DescptiionRemarks := "Sales Line".Description;

                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(ApprovalType; ApprovalType)
                {
                }
                dataitem(Employee; Employee)
                {
                    //DataItemLink = "Employee User ID" = FIELD("Approver ID");
                    // column(EmployeeFirstName; Employee."First Name")
                    // {
                    // }
                    // column(EmployeeMiddleName; Employee."Middle Name")
                    // {
                    // }
                    // column(EmployeeLastName; Employee."Last Name")
                    // {
                    // }
                    // column(EmployeeSignature; Employee."Signature")
                    // {
                    // }
                    // column(JobTitle_Employee; Employee."Job Title")
                    // {
                    // }
                    // trigger OnPreDataItem()
                    // begin
                    //     Employee.SetRange("User ID", ApproverID);
                    // end;

                    trigger OnAfterGetRecord()
                    begin
                        ApprovalType := '';
                        ApprovalEntry2.Reset();
                        ApprovalEntry2.SetRange("Document No.", "Approval Entry"."Document No.");
                        ApprovalEntry2.SetRange(Status, ApprovalEntry2.Status::Approved);
                        if ApprovalEntry2.FindLast() then begin
                            ApprovalType := 'Approver';
                        end;

                        // WorkflowStepInstanceArchive.RESET;
                        // WorkflowStepInstanceArchive.SETRANGE(WorkflowStepInstanceArchive."Workflow Code", "Approval Entry"."Approval Code");
                        // WorkflowStepInstanceArchive.SETRANGE(WorkflowStepInstanceArchive."Function Name", 'CREATEAPPROVALREQUESTS');
                        // IF WorkflowStepInstanceArchive.FINDFIRST THEN BEGIN
                        //     WorkflowStepArgumentArchive.RESET;
                        //     WorkflowStepArgumentArchive.SETRANGE(WorkflowStepArgumentArchive.ID, WorkflowStepInstanceArchive.Argument);
                        //     IF WorkflowStepArgumentArchive.FINDFIRST THEN BEGIN
                        //         WorkflowUserGroupMember.RESET;
                        //         WorkflowUserGroupMember.SETRANGE(WorkflowUserGroupMember."Workflow User Group Code", WorkflowStepArgumentArchive."Workflow User Group Code");
                        //         WorkflowUserGroupMember.SETRANGE(WorkflowUserGroupMember."User Name", "Approval Entry"."Approver ID");
                        //         IF WorkflowUserGroupMember.FINDFIRST THEN BEGIN
                        //             IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Reviewer THEN
                        //                 ApprovalType := 'Reviewer';
                        //             IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Approver THEN
                        //                 ApprovalType := 'Approver';
                        //             IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Authorizer THEN
                        //                 ApprovalType := 'Authorizer';
                        //         END;
                        //     END;
                        // END;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyAddress := CompanyInfo.Address + ' ' + CompanyInfo."Address 2";

                // CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, "Amount Including VAT", '');


                GeneralLedgerSetup.Get;
                if "Currency Code" = '' then "Currency Code" := GeneralLedgerSetup."LCY Code";

                PreparedBy := '';
                EmployeeTitle := '';

                // Employees.Reset;
                // Employees.SetRange(Employees."User ID", "Sales Header".SystemCreatedBy);
                // if Employees.FindFirst then begin
                //     PreparedBy := Employees."First Name" + ' ' + Employees."Last Name";
                //     EmployeeTitle := Employees."HR Job Title";
                // end;


                PhoneNumber := '';
                EmailAddress := '';
                ApprovalStatus := '';
                ApprovedBy := '';
                //ApproverSignature:='';
                EmailGenerated := '';
                RegionDimension := '';
                InvoiceEmail := '';
                PropertyNo := '';
                VendorVATNo := '';
                PropertyNo := CompanyInfo."VAT Registration No.";
                CompanyMail := '';

                TestField("Order From");

                if "Sales Header"."Order From" = "Sales Header"."Order From"::Procurement then
                    CompanyMail := GeneralLedgerSetup."Procurement Email" else
                    if "Sales Header"."Order From" = "Sales Header"."Order From"::Stores then
                        CompanyMail := GeneralLedgerSetup."Stores Email";

                Customers.Reset();
                Customers.SetRange("No.", "Sales Header"."Sell-to Customer No.");
                if Customers.FindFirst() then
                    VendorVATNo := Customers."VAT Registration No.";

                DimensionValue.Reset();
                DimensionValue.SetRange(DimensionValue.Code, "Sales Header"."Shortcut Dimension 1 Code");
                if DimensionValue.FindFirst() then begin
                    EmailGenerated := DimensionValue."LPO Corr. E-Mail";
                    RegionDimension := DimensionValue.Region;
                    InvoiceEmail := DimensionValue."Invoice Corr. E-Mail";
                end;

                if "Sales Header".Status = "Sales Header".Status::Released then
                    ApprovalStatus := 'APPROVED';

                Customers.Reset;
                Customers.SetRange(Customers."No.", "Sales Header"."Sell-to Customer No.");
                if Customers.FindFirst then begin
                    PhoneNumber := Customers."Phone No.";
                    EmailAddress := Customers."E-Mail";
                end;




                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Sales Header"."Shortcut Dimension 2 Code");
                if DimensionValue.FindFirst then begin
                    Departments := DimensionValue.Name;
                end;

                ApprovalEntry2.RESET;
                ApprovalEntry2.SETRANGE(ApprovalEntry2."Document No.", "Sales Header"."No.");
                ApprovalEntry2.SETRANGE(ApprovalEntry2.Status, ApprovalEntry2.Status::Approved);
                IF ApprovalEntry2.FINDLAST THEN BEGIN
                    ApproverID := ApprovalEntry2."Approver ID";
                    ApprovalDate := ApprovalEntry2."Last Date-Time Modified";

                    // Employees.Reset;
                    // Employees.SetRange(Employees."User ID", ApprovalEntry2."Approver ID");
                    // if Employees.FindFirst then begin
                    //     ApprovedBy := Employees."First Name" + ' ' + Employees."Last Name";
                    //     ApproverTitle := Employees."HR Job Title";
                    // end;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        PurchaseOrderCaption = 'Purchase Order';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Employees: Record Employee;
        Customers: Record Customer;
        CompanyAddress: Text;
        NumberText: array[2] of Text[120];
        CheckReport: Report Check;
        LNo: Integer;
        PreparedBy: Text;
        ApproverName: Text;
        EmailAddress: Text;
        PhoneNumber: Text;
        PropertyNo: Code[50];
        PurchaseLine: Record "Sales Line";
        propertyname: Text;
        Departments: Text;
        DimensionValue: Record "Dimension Value";
        PreparedByTitle: Text;
        ApprovalStatus: Text;
        DeliverTo: Text;
        EmployeeTitle: Text;
        ApprovalEntry2: Record "Approval Entry";
        ApprovedBy: Text;
        ApproverTitle: text;
        ApprovalDate: DateTime;
        ApproverID: code[50];
        ApprovalType: text;
        WorkflowStepInstanceArchive: Record "Workflow Step Instance Archive";
        WorkflowStepArgumentArchive: Record "Workflow Step Argument Archive";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        EmailGenerated: Text;
        DescptiionRemarks: Text;
        RegionDimension: Text;
        InvoiceEmail: text;
        VendorVATNo: Text;
        CompanyMail: Text;
        AccountNo: Code[50];
}

