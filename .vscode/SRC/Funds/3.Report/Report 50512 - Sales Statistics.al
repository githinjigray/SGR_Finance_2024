report 50512 "Sales Statistics Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Sales tatistics Report.rdl';
    ApplicationArea = All;
    Caption = 'Sales Statistics Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header";
        "Sales Invoice Header")
        {
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
            trigger OnPreDataItem()
            begin
                if (StartDate <> 0D) and (Enddate <> 0D) Then
                    "Sales Invoice Header".SetRange("Posting Date", StartDate, Enddate);
                if CustomerNo <> '' then
                    "Sales Invoice Header".SetRange("Bill-to Customer No.", CustomerNo);
            end;

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
                    if ("Sales Invoice Header"."Amount Including VAT" <> 0) and ("Sales Invoice Header"."Currency Factor" <> 0) then
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
                        if ("Sales Cr.Memo Header"."Amount Including VAT" <> 0) and ("Sales Cr.Memo Header"."Currency Factor" <> 0) then
                            CreditNoteAmountLCY := SalesCrMemoHeader."Amount Including VAT" / SalesCrMemoHeader."Currency Factor";
                    end;
                end;
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            column(PostingDate_CR; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(PostingDescription_CR; "Sales Cr.Memo Header"."Posting Description")
            {
            }
            column(SelltoCustomerNo_CR; "Sales Cr.Memo Header"."Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name_CR; "Sell-to Customer Name")
            {
            }
            column(No__CR; "Sales Cr.Memo Header"."No.")
            {
            }
            column(BilltoCustomerNo__CR; "Sales Cr.Memo Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName__CR; "Sales Cr.Memo Header"."Bill-to Name")
            {
            }
            column(BilltoName2__CR; "Sales Cr.Memo Header"."Bill-to Name 2")
            {
            }
            column(PreAssignedNo__CR; "Sales Cr.Memo Header"."Pre-Assigned No.")
            {
            }
            column(CurrencyCode__CR; "Sales Cr.Memo Header"."Currency Code")
            {
            }
            column(Amount__CR; "Sales Cr.Memo Header".Amount)
            {
            }
            column(AmountIncludingVAT__CR; "Sales Cr.Memo Header"."Amount Including VAT")
            {
            }
            column(CurrencyFactor__CR; "Sales Cr.Memo Header"."Currency Factor")
            {
            }
            column(RemainingAmount__CR; "Sales Cr.Memo Header"."Remaining Amount")
            {
            }
            column(AmountLCY_CR; AmountLCYCR)
            {
            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {
            }
            column(Sales_Inv_Amount_; SalesInvAmount)
            {
            }
            trigger OnPreDataItem()
            begin
                if (StartDate <> 0D) and (Enddate <> 0D) Then
                    "Sales Cr.Memo Header".SetRange("Posting Date", StartDate, Enddate);
                if CustomerNo <> '' then
                    "Sales Cr.Memo Header".SetRange("Bill-to Customer No.", CustomerNo);
            end;

            trigger OnAfterGetRecord()
            begin
                AmountLCYCR := 0;
                SalesInvAmount := 0;

                "Sales Cr.Memo Header".CalcFields("Amount Including VAT");
                AmountLCYCR := "Sales Cr.Memo Header"."Amount Including VAT";
                if "Sales Cr.Memo Header"."Currency Code" <> '' then begin
                    if ("Sales Cr.Memo Header"."Amount Including VAT" <> 0) and ("Sales Cr.Memo Header"."Currency Factor" <> 0) then
                        AmountLCYCR := "Sales Cr.Memo Header"."Amount Including VAT" / "Sales Cr.Memo Header"."Currency Factor";
                end;

                SalesInvHeader.Reset();
                SalesInvHeader.SetRange("No.", "Sales Cr.Memo Header"."Applies-to Doc. No.");
                if SalesInvHeader.FindFirst() then begin
                    SalesInvHeader.CalcFields(SalesInvHeader."Amount Including VAT");
                    SalesInvAmount := SalesInvHeader."Amount Including VAT";
                    if "Sales Invoice Header"."Currency Code" <> '' then begin
                        if (SalesInvHeader."Amount Including VAT" <> 0) and (SalesInvHeader."Currency Factor" <> 0) then
                            SalesInvAmount := SalesInvHeader."Amount Including VAT" / SalesInvHeader."Currency Factor";
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                        ToolTip = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
                        ToolTip = 'End Date';
                    }
                    field(CustomerNo; CustomerNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Customer';
                        ToolTip = 'Customer';
                        TableRelation = Customer."No.";
                    }
                }
            }
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
        SalesInvAmount: decimal;
        AmountLCYCR: Decimal;
        StartDate: Date;
        Enddate: Date;
        CustomerNo: code[10];
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvHeader: Record "Sales Invoice Header";
}

