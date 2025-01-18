report 50028 "VAT Payable Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/VAT Payable Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("G/L Account No." = CONST('202310'));
            RequestFilterFields = "Posting Date";
            column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
            {
            }
            column(AppliestoDocType_PaymentLine; "G/L Entry"."Document No.")
            {
            }
            column(AppliestoDocNo_PaymentLine; "G/L Entry"."Document No.")
            {
            }
            column(AppliestoID_PaymentLine; "G/L Entry"."Document No.")
            {
            }
            column(Committed_PaymentLine; "G/L Entry"."Document No.")
            {
            }
            column(DocumentNo_PaymentLine; "G/L Entry"."Document No.")
            {
            }
            column(AccountNo_PaymentLine; "G/L Entry"."G/L Account No.")
            {
            }
            column(AccountName_PaymentLine; "G/L Entry"."G/L Account No.")
            {
            }
            column(Description_PaymentLine; "G/L Entry".Description)
            {
            }
            column(PostingDate_PaymentLine; "G/L Entry"."Posting Date")
            {
            }
            column(VATAmount; VATAmount)
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
            column(VATCode_PaymentLine; "G/L Entry"."Document No.")
            {
            }
            column(VATAmount_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(VATAmountLCY_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(WithholdingTaxCode_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(WithholdingTaxAmount_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(WithholdingTaxAmountLCY_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(WithholdingVATCode_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(WithholdingVATAmount_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(WithholdingVATAmountLCY_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(NetAmount_PaymentLine; "G/L Entry".Amount)
            {
            }
            column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
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
            column(ShortcutDimension6Code_PaymentLine; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension1Code_PaymentLine; "G/L Entry"."Global Dimension 2 Code")
            {
            }
            column(VendorInvoiceNo; VendorInvoiceNo)
            {
            }
            column(CustomerNo; CustomerNo)
            {
            }
            column(Customername; Customername)
            {
            }
            column(InvDescription; InvDescription)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TINno := '';
                InvoiceAmt := 0;
                InvoiceDate := 0D;
                VendorInvoiceNo := '';
                CustomerNo := '';
                Customername := '';
                InvDescription := '';
                DocumentNo := '';

                if "G/L Entry"."Source Code" = 'SALES' then begin
                    if SalesInvoiceHeader.Get("G/L Entry"."Document No.") then
                        DocumentNo := SalesInvoiceHeader."Pre-Assigned No.";
                end else begin
                    DocumentNo := "G/L Entry"."Document No.";
                end;







                SalesInvoiceHeader.Reset;
                SalesInvoiceHeader.SetRange(SalesInvoiceHeader."No.", "G/L Entry"."Document No.");
                if SalesInvoiceHeader.FindFirst then begin
                    SalesInvoiceHeader.CalcFields(SalesInvoiceHeader."Amount Including VAT");
                    VendorInvoiceNo := SalesInvoiceHeader."Pre-Assigned No.";
                    InvoiceDate := SalesInvoiceHeader."Posting Date";
                    CustomerNo := SalesInvoiceHeader."Sell-to Customer No.";
                    Customername := SalesInvoiceHeader."Sell-to Customer Name";
                    if TINno = '' then begin
                        TINno := SalesInvoiceHeader."VAT Registration No.";
                    end;

                    SalesInvoiceLine.Reset;
                    SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                    //SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Sell-to Customer No.",SalesInvoiceHeader."Bill-to Customer No.");
                    if SalesInvoiceLine.FindSet then begin
                        repeat
                            InvoiceAmt := InvoiceAmt + SalesInvoiceLine.Amount;
                            InvDescription := SalesInvoiceLine.Description;
                        until SalesInvoiceLine.Next = 0;
                    end;
                end;

                if InvDescription = '' then
                    InvDescription := "G/L Entry".Description;


                if "G/L Entry"."Credit Amount" <> 0 then
                    VATAmount := "G/L Entry"."Credit Amount";

                if "G/L Entry"."Debit Amount" <> 0 then
                    VATAmount := ("G/L Entry"."Debit Amount") * -1;
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
        Tenants: Record Customer;
        TINno: Text;
        InvoiceDate: Date;
        InvoiceAmt: Decimal;
        VendorInvoiceNo: Code[30];
        WTVAT: Record "Funds Tax Code";
        WTperct: Code[10];
        CustomerNo: Code[30];
        Customername: Text;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        InvDescription: Text;
        DocumentNo: Code[50];
        VATAmount: Decimal;
}

