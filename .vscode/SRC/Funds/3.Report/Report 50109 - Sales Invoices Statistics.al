report 50109 "Sales Invoices Statistics"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Sales Invoices Statistics.rdlc';
    ApplicationArea = All;
    Caption = 'Sales Invoices Statistics';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header";
        "Sales Invoice Header")
        {
            RequestFilterFields = "Posting Date", "Sell-to Customer No.";
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(PostingDescription_SalesInvoiceHeader; "Sales Invoice Header"."Posting Description")
            {
            }
            column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(BilltoName2_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name 2")
            {
            }
            column(PreAssignedNo_SalesInvoiceHeader; "Sales Invoice Header"."Pre-Assigned No.")
            {
            }
            column(CurrencyCode_SalesInvoiceHeader; "Sales Invoice Header"."Currency Code")
            {
            }
            column(Amount_SalesInvoiceHeader; "Sales Invoice Header".Amount)
            {
            }
            column(AmountIncludingVAT_SalesInvoiceHeader; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(CurrencyFactor_SalesInvoiceHeader; "Sales Invoice Header"."Currency Factor")
            {
            }
            column(RemainingAmount_SalesInvoiceHeader; "Sales Invoice Header"."Remaining Amount")
            {
            }
            column(AmountLCY; AmountLCY)
            {
            }
            column(CreditNoteAmount; CreditNoteAmount)
            {
            }
            column(CreditNoteNo; CreditNoteNo)
            {
            }
            column(ReversedInvoice; ReversedInvoice)
            {
            }
            column(CreditNoteAmountLCY; CreditNoteAmountLCY)
            {
            }

            trigger OnAfterGetRecord()
            begin
                AmountLCY := 0;
                CreditNoteAmount := 0;
                CreditNoteAmountLCY := 0;
                CreditNoteNo := '';
                ReversedInvoice := false;

                "Sales Invoice Header".CalcFields("Amount Including VAT");
                AmountLCY := "Sales Invoice Header"."Amount Including VAT";
                if "Sales Invoice Header"."Currency Code" <> '' then begin
                    AmountLCY := "Sales Invoice Header"."Amount Including VAT" / "Sales Invoice Header"."Currency Factor";
                end;

                SalesCrMemoHeader.Reset;
                SalesCrMemoHeader.SetRange("Applies-to Doc. No.", "Sales Invoice Header"."No.");
                if SalesCrMemoHeader.FindFirst then begin
                    SalesCrMemoHeader.CalcFields("Amount Including VAT");
                    CreditNoteNo := SalesCrMemoHeader."No.";
                    CreditNoteAmount := SalesCrMemoHeader."Amount Including VAT";
                    CreditNoteAmountLCY := SalesCrMemoHeader."Amount Including VAT";
                    ReversedInvoice := true;
                    if SalesCrMemoHeader."Currency Code" <> '' then begin
                        CreditNoteAmountLCY := SalesCrMemoHeader."Amount Including VAT" / SalesCrMemoHeader."Currency Factor";
                    end;
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

    var
        CreditNoteAmount: Decimal;
        CreditNoteNo: Code[20];
        AmountLCY: Decimal;
        CreditNoteAmountLCY: Decimal;
        ReversedInvoice: Boolean;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
}

