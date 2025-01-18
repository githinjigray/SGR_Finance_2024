report 50078 "Purchase Order Archive."
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Purchase Order Archive.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header Archive")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
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
            column(ShortcutDimension1Code_PurchaseHeader; "Purchase Header"."Shortcut Dimension 1 Code")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Purchase Header"."Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Purchase Header"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Purchase Header"."Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Purchase Header"."Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Purchase Header"."Pay-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Purchase Header"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Purchase Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Purchase Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; Departments)
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
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Web; CompanyInfo.Website)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header"."Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Purchase Header"."Currency Code")
            {
            }
            column(Amount_PurchaseHeader; "Purchase Header".Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Purchase Header"."Amount Including VAT")
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
            column(NoPrinted; "Purchase Header"."No. Printed")
            {
            }
            column(LNo; LNo)
            {
            }
            column(PaymentTermsCodesNEW; "Purchase Header"."Payment Terms Code")
            {
            }
            column(DueDate_PurchaseHeader; "Purchase Header"."Due Date")
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
            dataitem("Purchase Line"; "Purchase Line Archive")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Remarks_PurchaseLine; DescptiionRemarks)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure Code")
                {
                }
                column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Purchase Line"."Line Discount Amount")
                {
                }
                column(VAT; "Purchase Line"."VAT %")
                {
                }
                column(LocationCode; "Purchase Line"."Location Code")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(approved));
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
                    // DataItemLink = "Employee User ID" = FIELD("Approver ID");
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

                        WorkflowStepInstanceArchive.RESET;
                        WorkflowStepInstanceArchive.SETRANGE(WorkflowStepInstanceArchive."Workflow Code", "Approval Entry"."Approval Code");
                        WorkflowStepInstanceArchive.SETRANGE(WorkflowStepInstanceArchive."Function Name", 'CREATEAPPROVALREQUESTS');
                        IF WorkflowStepInstanceArchive.FINDFIRST THEN BEGIN
                            WorkflowStepArgumentArchive.RESET;
                            WorkflowStepArgumentArchive.SETRANGE(WorkflowStepArgumentArchive.ID, WorkflowStepInstanceArchive.Argument);
                            IF WorkflowStepArgumentArchive.FINDFIRST THEN BEGIN
                                WorkflowUserGroupMember.RESET;
                                WorkflowUserGroupMember.SETRANGE(WorkflowUserGroupMember."Workflow User Group Code", WorkflowStepArgumentArchive."Workflow User Group Code");
                                WorkflowUserGroupMember.SETRANGE(WorkflowUserGroupMember."User Name", "Approval Entry"."Approver ID");
                                IF WorkflowUserGroupMember.FINDFIRST THEN BEGIN
                                    IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Reviewer THEN
                                        ApprovalType := 'Reviewer';
                                    IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Approver THEN
                                        ApprovalType := 'Approver';
                                    IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Authorizer THEN
                                        ApprovalType := 'Authorizer';
                                END;
                            END;
                        END;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyAddress := CompanyInfo.Address + ' ' + CompanyInfo."Address 2";

                // CheckReport.InitTextVariable;
                // CheckReport.FormatNoText(NumberText, "Amount Including VAT", '');


                GeneralLedgerSetup.Get;
                if "Currency Code" = '' then "Currency Code" := GeneralLedgerSetup."LCY Code";

                PreparedBy := '';
                EmployeeTitle := '';

                Employees.Reset;
                //Employees.SetRange(Employees."User ID", "Purchase Header"."User ID");
                if Employees.FindFirst then begin
                    PreparedBy := Employees."First Name" + ' ' + Employees."Last Name";
                    // EmployeeTitle := Employees."HR Job Title";
                end;


                PhoneNumber := '';
                EmailAddress := '';
                ApprovalStatus := '';
                ApprovedBy := '';
                //ApproverSignature:='';
                EmailGenerated := '';
                RegionDimension := '';
                InvoiceEmail := '';

                DimensionValue.Reset();
                DimensionValue.SetRange(DimensionValue.Code, "Purchase Header"."Shortcut Dimension 1 Code");
                if DimensionValue.FindFirst() then begin
                    EmailGenerated := DimensionValue."LPO Corr. E-Mail";
                    RegionDimension := DimensionValue.Region;
                    InvoiceEmail := DimensionValue."Invoice Corr. E-Mail";
                end;

                if "Purchase Header".Status = "Purchase Header".Status::Released then
                    ApprovalStatus := 'APPROVED';

                Vendors.Reset;
                Vendors.SetRange(Vendors."No.", "Purchase Header"."Pay-to Vendor No.");
                if Vendors.FindFirst then begin
                    PhoneNumber := Vendors."Phone No.";
                    EmailAddress := Vendors."E-Mail";
                end;




                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Purchase Header"."Shortcut Dimension 2 Code");
                if DimensionValue.FindFirst then begin
                    Departments := DimensionValue.Name;
                end;

                ApprovalEntry2.RESET;
                ApprovalEntry2.SETRANGE(ApprovalEntry2."Document No.", "Purchase Header"."No.");
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
        Vendors: Record Vendor;
        CompanyAddress: Text;
        NumberText: array[2] of Text[120];
        CheckReport: Report Check;
        LNo: Integer;
        PreparedBy: Text;
        ApproverName: Text;
        EmailAddress: Text;
        PhoneNumber: Text;
        PropertyNo: Code[20];
        PurchaseLine: Record "Purchase Line";
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
        ApproverID: code[20];
        ApprovalType: text;
        WorkflowStepInstanceArchive: Record "Workflow Step Instance Archive";
        WorkflowStepArgumentArchive: Record "Workflow Step Argument Archive";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        EmailGenerated: Text;
        DescptiionRemarks: Text;
        RegionDimension: Text;
        InvoiceEmail: text;
}

