report 50027 "Finance VAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Finance VAT Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Payment Line"; "Payment Line")
        {
            //DataItemTableView = WHERE(Status=CONST(Posted));
            RequestFilterFields = "Posting Date";
            column(AppliestoDocType_PaymentLine; "Payment Line"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_PaymentLine; "Payment Line"."Applies-to Doc. No.")
            {
            }
            column(AppliestoID_PaymentLine; "Payment Line"."Applies-to ID")
            {
            }
            column(Committed_PaymentLine; "Payment Line".Committed)
            {
            }
            column(DocumentNo_PaymentLine; "Payment Line"."Document No.")
            {
            }
            column(AccountNo_PaymentLine; "Payment Line"."Account No.")
            {
            }
            column(AccountName_PaymentLine; "Payment Line"."Account Name")
            {
            }
            column(Description_PaymentLine; "Payment Line".Description)
            {
            }
            column(PostingDate_PaymentLine; "Payment Line"."Posting Date")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
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
            column(VATCode_PaymentLine; "Payment Line"."VAT Code")
            {
            }
            column(VATAmount_PaymentLine; "Payment Line"."VAT Amount")
            {
            }
            column(VATAmountLCY_PaymentLine; "Payment Line"."VAT Amount(LCY)")
            {
            }
            column(WithholdingTaxCode_PaymentLine; "Payment Line"."Withholding Tax Code")
            {
            }
            column(WithholdingTaxAmount_PaymentLine; "Payment Line"."Withholding Tax Amount")
            {
            }
            column(WithholdingTaxAmountLCY_PaymentLine; "Payment Line"."Withholding Tax Amount(LCY)")
            {
            }
            column(WithholdingVATCode_PaymentLine; "Payment Line"."Withholding VAT Code")
            {
            }
            column(WithholdingVATAmount_PaymentLine; "Payment Line"."Withholding VAT Amount")
            {
            }
            column(WithholdingVATAmountLCY_PaymentLine; "Payment Line"."Withholding VAT Amount(LCY)")
            {
            }
            column(NetAmount_PaymentLine; "Payment Line"."Net Amount")
            {
            }
            column(TINno; TINno)
            {
            }
            column(InvoiceDate; InvoiceDate)
            {
            }
            column(InvoiceAmt; InvoiceAmt)
            {
            }
            column(ShortcutDimension6Code_PaymentLine; "Payment Line"."Shortcut Dimension 6 Code")
            {
            }
            column(GlobalDimension1Code_PaymentLine; "Payment Line"."Global Dimension 1 Code")
            {
            }
            column(VendorInvoiceNo; VendorInvoiceNo)
            {
            }
            column(CPVNo; CPVNo)
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(SupplierName; SupplierName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TINno := '';
                InvoiceAmt := 0;
                InvoiceDate := 0D;
                VendorInvoiceNo := '';
                SupplierName := '';
                ChequeNo := '';
                CPVNo := '';


                Suppliers.Reset;
                if Suppliers.Get("Account No.") then begin
                    TINno := Suppliers."VAT Registration No.";
                    SupplierName := Suppliers.Name;
                end;



                PostedInvoices.Reset;
                if PostedInvoices.Get("Applies-to Doc. No.") then begin
                    PostedInvoices.CalcFields(PostedInvoices.Amount);
                    VendorInvoiceNo := PostedInvoices."Vendor Invoice No.";
                    InvoiceAmt := PostedInvoices.Amount;
                    InvoiceDate := PostedInvoices."Posting Date";
                end;


                if InvoiceAmt = 0 then
                    InvoiceAmt := "Payment Line"."Total Amount";


                if PaymentHeader.Get("Payment Line"."Document No.") then
                    ChequeNo := PaymentHeader."Cheque No.";
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
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        CompanyInfo: Record "Company Information";
        TotalAmount: Decimal;
        Suppliers: Record Vendor;
        PostedInvoices: Record "Purch. Inv. Header";
        TINno: Text;
        InvoiceDate: Date;
        InvoiceAmt: Decimal;
        VendorInvoiceNo: Code[30];
        WTVAT: Record "Funds Tax Code";
        WTperct: Code[10];
        CPVNo: Code[30];
        ChequeNo: Code[30];
        SupplierName: Text;
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
}

