report 50029 "CPV Tracking Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/CPV Tracking Report.rdlc';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payment Line"; "Payment Line")
        {
            //DataItemTableView = WHERE("Payment Type" = CONST(cheque), Status = FILTER(<> Open), "Account Type" = FILTER(Vendor));
            RequestFilterFields = "Posting Date", Status;
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo.Website)
            {
            }
            column(IssuingOfficer; IssuingOfficer)
            {
            }
            column(LPODate; LPODate)
            {
            }
            column(InvoiceDate; InvoiceDate)
            {
            }
            column(GRNdate; GRNdate)
            {
            }
            column(PAYEEName; PAYEEName)
            {
            }
            column(INVoiceNo; INVoiceNo)
            {
            }
            column(DocumentNo_PaymentLine; "Payment Line"."Document No.")
            {
            }
            column(DocumentType_PaymentLine; "Payment Line"."Document Type")
            {
            }
            column(PaymentCode_PaymentLine; "Payment Line"."Payment Code")
            {
            }
            column(PaymentCodeDescription_PaymentLine; "Payment Line"."Payment Code Description")
            {
            }
            column(AccountType_PaymentLine; "Payment Line"."Account Type")
            {
            }
            column(AccountNo_PaymentLine; "Payment Line"."Account No.")
            {
            }
            column(AccountName_PaymentLine; "Payment Line"."Account Name")
            {
            }
            column(PostingGroup_PaymentLine; "Payment Line"."Posting Group")
            {
            }
            column(Description_PaymentLine; "Payment Line".Description)
            {
            }
            column(AppliestoDocType_PaymentLine; "Payment Line"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_PaymentLine; "Payment Line"."Applies-to Doc. No.")
            {
            }
            column(PostingDate_PaymentLine; "Payment Line"."Posting Date")
            {
            }
            column(NetAmount_PaymentLine; "Payment Line"."Net Amount")
            {
            }
            column(OrderNo; OrderNo)
            {
            }
            column(SupplierNo; SupplierNo)
            {
            }
            column(SupplierName; SupplierName)
            {
            }
            column(CPVno; CPVno)
            {
            }
            column(CPVCreationDate; CPVCreationDate)
            {
            }
            column(CPVPostingDate; CPVPostingDate)
            {
            }
            column(ChequeType; ChequeType)
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(ChequeAmount; ChequeAmount)
            {
            }
            column(ChequePrinted; ChequePrinted)
            {
            }
            column(ChequePrintingDate; ChequePrintingDate)
            {
            }
            column(PayingAccount; PayingAccount)
            {
            }
            column(DateApproval; DateApproval)
            {
            }
            column(CPVStatus; CPVStatus)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LPODate := 0D;
                InvoiceDate := 0D;
                GRNdate := 0D;
                INVoiceNo := '';
                OrderNo := '';
                SupplierNo := '';
                SupplierName := '';


                CPVno := '';
                CPVCreationDate := 0D;
                CPVPostingDate := 0D;
                ChequeAmount := 0;
                ChequePrinted := false;
                ChequePrintingDate := 0D;
                ChequeNo := '';
                PAYEEName := '';
                PayingAccount := '';
                DateApproval := 0DT;

                PurchInvHeader.Reset;
                PurchInvHeader.SetRange(PurchInvHeader."No.", "Applies-to Doc. No.");
                if PurchInvHeader.FindFirst then begin
                    LPODate := PurchInvHeader."Order Date";
                    InvoiceDate := PurchInvHeader."Posting Date";
                    INVoiceNo := PurchInvHeader."Vendor Invoice No.";
                    OrderNo := PurchInvHeader."Order No.";
                    SupplierNo := PurchInvHeader."Pay-to Vendor No.";
                    SupplierName := PurchInvHeader."Pay-to Name";
                end;


                PurchRcptHeader.Reset;
                PurchRcptHeader.SetRange(PurchRcptHeader."Order No.", OrderNo);
                if PurchRcptHeader.FindFirst then begin
                    GRNdate := PurchRcptHeader."Posting Date";
                end;




                PaymentHeader.Reset;
                PaymentHeader.SetRange(PaymentHeader."No.", "Payment Line"."Document No.");
                if PaymentHeader.FindFirst then begin
                    PaymentHeader.CalcFields(PaymentHeader."Net Amount");
                    CPVno := PaymentHeader."No.";
                    CPVCreationDate := PaymentHeader."Document Date";
                    CPVPostingDate := PaymentHeader."Date Posted";
                    ChequeAmount := PaymentHeader."Net Amount";
                    ChequePrinted := PaymentHeader."Cheque Printed";
                    ChequePrintingDate := PaymentHeader."Cheque Printing Date";
                    ChequeType := PaymentHeader."Cheque Type";
                    ChequeNo := PaymentHeader."Cheque No.";
                    PAYEEName := PaymentHeader."Payee Name";
                    CPVStatus := PaymentHeader.Status;
                    if BankAccount.Get(PaymentHeader."Bank Account No.") then
                        PayingAccount := BankAccount."Bank Account No.";
                end;

                ApprovalEntry.Reset;
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Payment Line"."Document No.");
                if ApprovalEntry.FindFirst then begin
                    DateApproval := ApprovalEntry."Date-Time Sent for Approval";
                end;
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
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        ApproverName: Text;
        IssuingOfficer: Text;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LPODate: Date;
        InvoiceDate: Date;
        GRNdate: Date;
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        INVoiceNo: Code[250];
        OrderNo: Code[250];
        PaymentHeader: Record "Payment Header";
        PAYEEName: Text;
        BankAccount: Record "Bank Account";
        PayingAccount: Code[250];
        SupplierNo: Code[250];
        SupplierName: Text;
        CPVno: Code[250];
        CPVCreationDate: Date;
        CPVPostingDate: Date;
        ChequeType: Option " ","Computer Cheque","Manual Cheque";
        ChequeAmount: Decimal;
        ChequePrinted: Boolean;
        ChequePrintingDate: Date;
        ChequeNo: Code[250];
        ApprovalEntry: Record "Approval Entry";
        DateApproval: DateTime;
        CPVStatus: Option Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
}

