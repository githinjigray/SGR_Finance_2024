report 50022 "Cash Voucher Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Cash Voucher Report.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            // DataItemTableView = SORTING("Cheque Type");
            RequestFilterFields = "Cheque Type";
            column(DOCNAME; DOCNAME)
            {
            }
            column(Payments_Header__No__; "No.")
            {
            }
            column(PayeeName_PaymentHeader; "Payment Header"."Payee Name")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            column(Payments_Header__Cheque_No__; "Reference No.")
            {
            }
            column(Payments_Header_Payee; PayeeNamesII)
            {
            }
            column(RefferenceNew; RefferenceNew)
            {
            }
            column(Payments_Header__Payments_Header__Date; "Posting Date")
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_; "Global Dimension 2 Code")
            {
            }
            column(USERID; UserId)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode_Control1102756010; CurrCode)
            {
            }
            column(CurrCode_Control1102756012; CurrCode)
            {
            }
            column(Approved_; 'Approved')
            {
                AutoFormatType = 1;
            }
            column(Approval_Status_____; 'Approval Status' + ':')
            {
                AutoFormatType = 1;
            }
            column(TIME_PRINTED_____FORMAT_TIME__Control1102755003; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4__Control1102755004; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755012; UserId)
            {
            }
            column(NumberText_1__Control1102755016; NumberText[1])
            {
            }
            column(TTotal_Control1102755034; TTotal)
            {
            }
            column(CurrCode_Control1102755035; CurrCode)
            {
            }
            column(CurrCode_Control1102755037; CurrCode)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(PAYMENT_DETAILSCaption; PAYMENT_DETAILSCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(NET_AMOUNTCaption; NET_AMOUNTCaptionLbl)
            {
            }
            column(W_TAXCaption; W_TAXCaptionLbl)
            {
            }
            column(Document_No___Caption; Document_No___CaptionLbl)
            {
            }
            column(Currency_Caption; Currency_CaptionLbl)
            {
            }
            column(Payment_To_Caption; Payment_To_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Cheque_No__Caption; Cheque_No__CaptionLbl)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_Caption; FieldCaption("Global Dimension 2 Code"))
            {
            }
            column(R_CENTERCaption; R_CENTERCaptionLbl)
            {
            }
            column(PROJECTCaption; PROJECTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755013; EmptyStringCaption_Control1102755013Lbl)
            {
            }
            column(Amount_in_wordsCaption_Control1102755021; Amount_in_wordsCaption_Control1102755021Lbl)
            {
            }
            column(Printed_By_Caption_Control1102755026; Printed_By_Caption_Control1102755026Lbl)
            {
            }
            column(TotalCaption_Control1102755033; TotalCaption_Control1102755033Lbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
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
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(Bank; "Payment Header"."Bank Account No.")
            {
                IncludeCaption = true;
            }
            column(BankName; "Payment Header"."Bank Account Name")
            {
                IncludeCaption = true;
            }
            column(PayMode; "Payment Header"."Payment Mode")
            {
                IncludeCaption = true;
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(CheckedBy; "Payment Header"."Bank Account Name")
            {
            }
            column(ApprovedBy; "Payment Header"."Bank Account Name")
            {
            }
            column(AllowanceDoc; "Payment Header"."Bank Account No.")
            {
            }
            column(DocNo; "Payment Header"."Bank Account No.")
            {
            }
            column(PayeeType_PaymentHeader; "Payment Header"."Payee Type")
            {
            }
            column(PayeeNo_PaymentHeader; "Payment Header"."Payee No.")
            {
            }
            column(Header_Description; Description)
            {
            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Payment_Line__Net_Amount__; "Net Amount")
                {
                }
                column(Payment_Line__Net_Amount__LCY; "Net Amount(LCY)")
                {
                }
                column(Payment_Line_Amount; "Payment Line"."Total Amount")
                {
                }
                column(Transaction_Name_______Account_No________Account_Name_____; "Payment Line"."Account Name")
                {
                }
                column(AccountNo_PaymentLine; "Account No.")
                {
                }
                column(AccountName_PaymentLine; "Account Name")
                {
                }
                column(Payment_remarks; Description)
                {
                }
                column(Payment_Line__Withholding_Tax_Amount_; "Payment Line"."Withholding Tax Amount")
                {
                }
                column(Payment_Line__VAT_Amount_; "Payment Line"."Withholding VAT Amount")
                {
                }
                column(Payment_Line__Global_Dimension_1_Code_; "Global Dimension 1 Code")
                {
                }
                column(Payment_Line__Shortcut_Dimension_2_Code_; "Global Dimension 2 Code")
                {
                }
                column(Payment_Line_Line_No_; "Payment Line"."Line No.")
                {
                }
                column(Payment_Line_No; "Payment Line"."Document No.")
                {
                }
                column(Payment_Line_Type; "Payment Line"."Document Type")
                {
                }
                column(Line_Reference_No_; "Reference No.")
                {
                }

                trigger OnAfterGetRecord()
                begin


                    TTotal := TTotal + "Net Amount";
                end;
            }
            dataitem(Total; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
            }
            dataitem(CreationApprovalEntry; "Approval Entry")
            {
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_CreationApprovalEntry; CreationApprovalEntry."Sequence No.")
                {
                }
                column(SenderID_CreationApprovalEntry; CreationApprovalEntry."Sender ID")
                {
                }
                column(ApproverID_CreationApprovalEntry; CreationApprovalEntry."Approver ID")
                {
                }
                column(DateTimeSentforApproval_CreationApprovalEntry; CreationApprovalEntry."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_CreationApprovalEntry; CreationApprovalEntry."Last Date-Time Modified")
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
            }

            trigger OnAfterGetRecord()
            begin
                StrCopyText := '';
                if "No. Printed" >= 1 then begin
                    StrCopyText := DUPLICATE;
                end;
                TTotal := 0;

                DOCNAME := CHEQUEVOUCHER;

                CalcFields("Payment Header"."Total Amount", "Payment Header"."Net Amount", "Payment Header"."WithHolding Tax Amount");
                CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(NumberText, ("Payment Header"."Net Amount"), '');


                /*IF "Payment Header"."Payee Type"="Payment Header"."Payee Type"::Meeting THEN BEGIN
                  IF "Payment Header"."Board Individual Payment"=FALSE THEN BEGIN
                    PayeeNamesII:="Payment Header"."Bank Account Name";
                  END ELSE BEGIN
                    PayeeNamesII:="Payment Header"."Payee Name";
                  END;
                END;
                
                IF "Payment Header"."Payee Type"<>"Payment Header"."Payee Type"::Meeting THEN BEGIN
                      PayeeNamesII:="Payment Header"."Payee Name";
                 END;
                
                */

                IF "Payment Header"."Payment Mode" = "Payment Header"."Payment Mode"::Cheque THEN BEGIN
                    RefferenceNew := "Payment Header"."Cheque No.";
                END ELSE BEGIN
                    RefferenceNew := "Payment Header"."Reference No.";
                END;

                CurrCode := '';
                Exchangerateused := 0;

                CurrCode := "Payment Header"."Currency Code";
                if CurrCode = '' then begin
                    GenLedgerSetup.get;
                    CurrCode := GenLedgerSetup."LCY Code";
                end;

                if "Payment Header"."Currency Code" <> '' then begin
                    Exchangerateused := "Payment Header"."Net Amount(LCY)" / "Payment Header"."Net Amount";
                end;

                // EmployeeList.Reset();
                // EmployeeList.setrange("User ID", "Payment Header"."User ID");
                // if EmployeeList.FindFirst() then
                //     PreparedBy := EmployeeList."First Name" + ' ' + EmployeeList."Last Name";
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FieldNo("No.");
                //CurrCode := 'KES';
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
        StrCopyText: Text[30];
        GenLedgerSetup: Record "General Ledger Setup";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DOCNAME: Text[30];
        VATCaptionLbl: Label 'VAT';
        PAYMENT_DETAILSCaptionLbl: Label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        NET_AMOUNTCaptionLbl: Label 'AMOUNT';
        W_TAXCaptionLbl: Label 'W/TAX';
        Document_No___CaptionLbl: Label 'Document No. :';
        Currency_CaptionLbl: Label 'Currency:';
        Payment_To_CaptionLbl: Label 'Payment To:';
        Document_Date_CaptionLbl: Label 'Document Date:';
        Cheque_No__CaptionLbl: Label 'Cheque No.:';
        R_CENTERCaptionLbl: Label 'R.CENTER CODE';
        PROJECTCaptionLbl: Label 'PROJECT CODE';
        TotalCaptionLbl: Label 'Total';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Amount_in_wordsCaptionLbl: Label 'Amount in words';
        EmptyStringCaptionLbl: Label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: Label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: Label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: Label 'Printed By:';
        TotalCaption_Control1102755033Lbl: Label 'Total';
        Signature_CaptionLbl: Label 'Signature:';
        Date_CaptionLbl: Label 'Date:';
        Name_CaptionLbl: Label 'Name:';
        RecipientCaptionLbl: Label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: Label 'Budget';
        CreationDoc: Boolean;
        PayeeNamesII: Text;
        CHEQUEVOUCHER: Label 'CHEQUE PAYMENT VOUCHER';
        DUPLICATE: Label 'DUPLICATE';
        RefferenceNew: Code[30];
        Exchangerateused: Decimal;
        PreparedBy: Text[250];
        EmployeeList: Record Employee;
}

