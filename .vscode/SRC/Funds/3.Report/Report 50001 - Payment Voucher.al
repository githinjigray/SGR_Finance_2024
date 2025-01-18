report 50001 "Payment Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Payment Voucher.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(EmployeeTitle; EmployeeTitle)
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(Paid; Paid)
            {
            }
            column(Reference_No_; "Payment Header"."Reference No.")
            {
            }
            column(GlobalDimension1Code_PaymentHeader; "Payment Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PaymentHeader; "Payment Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_PaymentHeader; "Payment Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PaymentHeader; "Payment Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_PaymentHeader; "Payment Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_PaymentHeader; "Payment Header"."Shortcut Dimension 6 Code")
            {
            }
            column(No; "No.")
            {
            }
            column(Payee; "Payee Name")
            {
            }
            column(PaymentDate; "Posting Date")
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(Status; Status)
            {
            }
            column(USERID; "User ID")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(Description; Description)
            {
            }
            column(PaymentMode; "Payment Mode")
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(OnBehalfOf; "On Behalf Of")
            {
            }
            column(ChequeNo; "Cheque No.")
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
            column(CompanyWebPage; CompanyInfo.Website)
            {
            }
            column(Bank; "Bank Account No.")
            {
                IncludeCaption = true;
            }
            column(BankName; "Bank Account Name")
            {
            }
            column(DepartmentCode; "Shortcut Dimension 4 Code")
            {
            }
            column(PayeeAddress; PayeeAddress)
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            column(TODAY; Format(Today, 1, 4))
            {
            }
            column(USER; UserId)
            {
            }
            column(ApproverID; ApproverID)
            {
            }
            column(ApprovalDateTime; ApprovalDateTime)
            {
            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                //DataItemTableView = SORTING("Line No.", "Document No.", "Payment Code") ORDER(Ascending);
                column(AccountNo; "Payment Line"."Account No.")
                {
                }
                column(AccountName; "Payment Line"."Account Name")
                {
                }
                column(NetAmount; "Net Amount")
                {
                }
                column(Amount; "Total Amount")
                {
                }
                column(Description2; Description)
                {
                }
                column(WTax; "Payment Line"."Withholding Tax Amount")
                {
                }
                column(WVat; "Payment Line"."Withholding VAT Amount")
                {
                }
                column(InvoiceNo; InvoiceNo)
                {
                }
                column(AppliestoDocNo_PaymentLine; "Payment Line"."Applies-to Doc. No.")
                {
                }
                column(WithholdingTaxCode_PaymentLine; "Payment Line"."Withholding Tax Code")
                {
                }
                column(WithholdingVATCode_PaymentLine; "Payment Line"."Withholding VAT Code")
                {
                }
                column(Global_Dimension_1_Code; "Payment Line"."Global Dimension 1 Code")
                {
                }
                column(Global_Dimension_2_Code; "Payment Line"."Global Dimension 2 Code")
                {
                }
                column(Shortcut_Dimension_3_Code; "Payment Line"."Shortcut Dimension 3 Code")
                {
                }
                column(Shortcut_Dimension_4_Code; "Payment Line"."Shortcut Dimension 4 Code")
                {
                }
                column(Shortcut_Dimension_5_Code; "Payment Line"."Shortcut Dimension 5 Code")
                {
                }
                column(Shortcut_Dimension_6_Code; "Payment Line"."Shortcut Dimension 6 Code")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Vendor.Get("Account No.") then begin
                        PayeeAddress := Vendor.Address;
                    end;

                    if PostedInvoice.Get("Applies-to Doc. No.") then begin
                        InvoiceNo := PostedInvoice."Vendor Invoice No.";
                        InvoiceDate := PostedInvoice."Posting Date";
                    end;
                    IF "Payment Line"."Payee Type" = "Payment Line"."Payee Type"::Imprest THEN
                        InvoiceNo := "Payment Line"."Payee No.";

                    if "Withholding Tax Code" <> '' then begin
                        if FundsTaxCodes.Get("Withholding Tax Code") then
                            "WHT%" := Format(FundsTaxCodes.Percentage);
                    end;


                    if "Withholding VAT Code" <> '' then begin
                        if FundsTaxCodes.Get("Withholding Tax Code") then
                            "WHTVAT%" := (FundsTaxCodes.Percentage);
                    end;

                    "Payment Header".CalcFields("Net Amount");
                    if "Payment Header"."Amount to Offset" <> 0 then
                        "Payment Line"."Net Amount" := "Payment Line"."Net Amount" - "Payment Header"."Amount to Offset";
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
                column(r; "Approval Entry"."Last Date-Time Modified")
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
                    DataItemLink = "Employee User ID" = FIELD("Approver ID");
                    column(EmployeeFirstName;
                    Employee."First Name")
                    {
                    }
                    column(EmployeeMiddleName; Employee."Middle Name")
                    {
                    }
                    column(EmployeeLastName; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Signature")
                    {
                    }
                    column(JobTitle_Employee; Employee."Job Title")
                    {
                    }
                }
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
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = FIELD("No.");
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Description_VendorLedgerEntry; "Vendor Ledger Entry".Description)
                {
                }
                column(AmountToApply; AmountToApply)
                {
                }
                column(VendorName; VendorName)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    AmountToApply := 0;
                    VendorName := '';
                    if "Payment Header".Status <> "Payment Header".Status::Posted then begin
                        AmountToApply := "Vendor Ledger Entry"."Amount to Apply";

                        /*IF ("Vendor Ledger Entry"."Amount to Apply" < 0) AND ("Vendor Ledger Entry"."Document Type"= "Vendor Ledger Entry"."Document Type"::Invoice) THEN
                          AmountToApply:="Vendor Ledger Entry"."Amount to Apply"*-1;*/
                    end;


                    if "Payment Header".Status = "Payment Header".Status::Posted then begin
                        AmountToApply := "Vendor Ledger Entry"."Remaining Amt. (LCY)";

                        if "Vendor Ledger Entry"."Remaining Amt. (LCY)" < 0 then
                            AmountToApply := "Vendor Ledger Entry"."Remaining Amt. (LCY)" * -1;
                    end;

                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Vendor Ledger Entry"."Vendor No.");
                    if Vendor.FindFirst then begin
                        VendorName := Vendor.Name;
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                CalcFields("Total Amount", "Net Amount", "WithHolding Tax Amount");
                TotalAmount := "Net Amount";
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Round(("Net Amount" - "Payment Header"."Amount to Offset")), "Currency Code");
                if "Payment Header".Posted = true then
                    Paid := 'PAID'
                else
                    paid := '';
                if Bank.Get("Bank Account No.") then begin
                    BankName := Bank.Name;
                    BankAccountNo := Bank."Bank Account No.";
                end;

                GLSetup.Get;
                if "Payment Header"."Currency Code" = '' then
                    CurrencyCode := GLSetup."LCY Code"
                else
                    CurrencyCode := "Payment Header"."Currency Code";


                if "Payment Header"."Cheque No." = '' then
                    "Payment Header"."Cheque No." := "Payment Header"."Reference No.";



                // Emp.Reset;
                // Emp.SetRange(Emp."User ID", "Payment Header"."User ID");
                // if Emp.FindFirst then begin
                //     PreparedBy := Emp."First Name" + ' ' + Emp."Last Name";
                //     EmployeeTitle := Emp."HR Job Title";
                // end;
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
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Bank: Record "Bank Account";
        PurchaseInvoice: Record "Purch. Inv. Header";
        User: Record User;
        Vendor: Record Vendor;
        PostedInvoice: Record "Purch. Inv. Header";
        FundsTaxCodes: Record "Funds Tax Code";
        GLSetup: Record "General Ledger Setup";
        CheckReport: Report Check;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        NumberText: array[2] of Text[80];
        BankAccountNo: Code[20];
        BankName: Text[100];
        PayeeAddress: Text[100];
        InvoiceDate: Date;
        CurrencyCode: Code[50];
        InvoiceNo: Code[50];
        TotalAmount: Decimal;
        PreparedBy: Text;
        Paid: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        "WHT%": Text;
        "WHTVAT%": Integer;
        DocumentName: Label 'PAYMENT VOUCHER';
        ApproverID: Code[20];
        ApprovalDateTime: Text;
        CurrencyName: Label 'KES';
        AmountToApply: Decimal;
        VendorName: Text;
        EmployeeTitle: Text;
        Emp: Record Employee;
        ApprovalType: text;
        WorkflowStepInstanceArchive: Record "Workflow Step Instance Archive";
        WorkflowStepArgumentArchive: Record "Workflow Step Argument Archive";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
}

