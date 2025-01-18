report 50052 "Office VAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Office VAT Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("G/L Account No." = FILTER('2816'), Amount = FILTER(< 0), Reversed = CONST(false));
            column(CBankName; CompanyInfo."Bank Name")
            {
            }
            column(CBankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CBankAccountNo; CompanyInfo."Bank Account No.")
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
            column(DATETIME; CurrentDateTime)
            {
            }
            column(ExternalDocumentNo_GLEntry; "G/L Entry"."External Document No.")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(Description_GLEntry; TransactionDescription)
            {
            }
            column(BalAccountNo_GLEntry; "G/L Entry"."Bal. Account No.")
            {
            }
            column(Amount_GLEntry; "G/L Entry"."Credit Amount")
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(Amounts; "G/L Entry".Amount)
            {
            }
            column(SourceNumber; SourceNumber)
            {
            }
            column(SourceName; SourceName)
            {
            }
            column(InvoiceNumber; InvoiceNumber)
            {
            }
            column(InvoiceDate; Invoicedate)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(TotalAmount; totalAmount)
            {
            }
            column(TINNumber; TINNumber)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(PropertyNumber; PropertyNumber)
            {
            }
            column(PropertyName; PropertyName)
            {
            }
            column(LandLordNumber; LandlordNumber)
            {
            }
            column(LandlordName; LandlordName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Withholding := false;

                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('The Start/End Date cannot be empty.');

                if EndDate < StartDate then
                    Error('The End Date cannot be earlier than the Start Date.');


                SourceName := '';
                SourceNumber := '';
                Invoicedate := 0D;
                InvoiceNumber := '';
                TINNumber := '';
                SourceName := '';
                NetAmount := 0;
                totalAmount := 0;

                TransactionDescription := '';
                TransactionDescription := "G/L Entry".Description;

                if PurchCrMemoHdr.Get("G/L Entry"."Document No.") then begin
                    SourceNumber := PurchCrMemoHdr."Pay-to Vendor No.";
                    SourceName := PurchCrMemoHdr."Pay-to Name";
                    InvoiceNumber := PurchCrMemoHdr."No.";
                    Invoicedate := PurchCrMemoHdr."Document Date";
                    //if TempCustomer.Get(SourceNumber) then
                    // TINNumber:=TempCustomer." TIN No.";

                end;

                if SalesInvoiceHeader.Get("G/L Entry"."Document No.") then begin
                    SourceNumber := SalesInvoiceHeader."Sell-to Customer No.";
                    SourceName := SalesInvoiceHeader."Sell-to Customer Name";
                    InvoiceNumber := SalesInvoiceHeader."No.";
                    Invoicedate := SalesInvoiceHeader."Posting Date";
                    // if TempCustomer.Get(SourceNumber) then
                    // TINNumber:=TempCustomer." TIN No.";

                end;

                if SalesCrMemoHeader.Get("G/L Entry"."Document No.") then begin
                    SourceNumber := SalesCrMemoHeader."Sell-to Customer No.";
                    SourceName := SalesCrMemoHeader."Sell-to Customer Name";
                    InvoiceNumber := SalesCrMemoHeader."No.";
                    Invoicedate := SalesCrMemoHeader."Posting Date";
                    //  if TempCustomer.Get(SourceNumber) then
                    //  TINNumber:=TempCustomer." TIN No.";

                end;


                // if InvoiceHeader.Get("G/L Entry"."Document No.") then begin
                //    SourceNumber:=InvoiceHeader."Account No.";
                //   SourceName:=InvoiceHeader."Account Name";
                //   InvoiceNumber:=InvoiceHeader."No.";
                //   Invoicedate:=InvoiceHeader."Posting Date";
                // if TempCustomer.Get(SourceNumber) then
                //  TINNumber:=TempCustomer." TIN No.";

                //end;


                if PaymentHeader.Get("G/L Entry"."Document No.") then
                    CurrReport.Skip;




                if "G/L Entry"."Posting Date" < 20210101D then begin
                    NetAmount := "G/L Entry"."Credit Amount" * (100 / 14);
                end else begin
                    NetAmount := "G/L Entry"."Credit Amount" * (100 / 16);
                end;

                totalAmount := "G/L Entry"."Credit Amount" + NetAmount;

                if PaymentHeader.Get("G/L Entry"."Document No.") then
                    CurrReport.Skip;

                // if "G/L Entry".Document_Type="G/L Entry".Document_Type::Receipt then
                //  CurrReport.Skip;

                if SourceNumber = '' then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                "G/L Entry".SetRange("G/L Entry"."Posting Date", StartDate, EndDate);
            end;
        }
        dataitem("G/L Entry2"; "G/L Entry")
        {
            DataItemTableView = WHERE("G/L Account No." = FILTER('20200'), Amount = FILTER(> 0), Reversed = CONST(false));
            column(ExternalDocumentNo_GLEntry2; "External Document No.")
            {
            }
            column(DocumentNo_GLEntry2; "Document No.")
            {
            }
            column(Description_GLEntry2; TransactionDescription2)
            {
            }
            column(BalAccountNo_GLEntry2; "Bal. Account No.")
            {
            }
            column(Amounts2; "G/L Entry".Amount)
            {
            }
            column(Amount_GLEntry2; "G/L Entry"."Debit Amount")
            {
            }
            column(PostingDate_GLEntry2; "Posting Date")
            {
            }
            column(SourceNumber2; SourceNumber2)
            {
            }
            column(SourceName2; SourceName2)
            {
            }
            column(InvoiceNumber2; InvoiceNumber2)
            {
            }
            column(InvoiceDate2; Invoicedate2)
            {
            }
            column(NetAmount2; NetAmount2)
            {
            }
            column(TotalAmount2; totalAmount2)
            {
            }
            column(TINNumber2; TINNumber2)
            {
            }
            column(VatAmount2; VatAmount2)
            {
            }
            column(Withholding; Withholding)
            {
            }
            column(ReversalInv_No; ReversalInv_No)
            {
            }
            column(ReversalDate; ReversalDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SourceName2 := '';
                SourceNumber2 := '';
                Invoicedate2 := 0D;
                InvoiceNumber2 := '';
                TINNumber2 := '';
                SourceName2 := '';
                NetAmount2 := 0;
                totalAmount2 := 0;
                TransactionDescription2 := '';
                Withholding := false;
                ReversalInv_No := '';
                ReversalDate := 0D;

                TransactionDescription2 := "G/L Entry2".Description;

                if PaymentHeader.Get("G/L Entry"."Document No.") then
                    CurrReport.Skip;

                if PurchInvHeader.Get("G/L Entry2"."Document No.") then begin

                    SourceNumber2 := PurchInvHeader."Buy-from Vendor No.";
                    SourceName2 := PurchInvHeader."Buy-from Vendor Name";
                    InvoiceNumber2 := PurchInvHeader."Vendor Invoice No.";
                    Invoicedate2 := PurchInvHeader."Document Date";
                    if TradeVendor.Get(SourceNumber2) then
                        TINNumber2 := TradeVendor."VAT Registration No.";

                end;






                VatAmount2 := 0;
                VatAmount2 := "G/L Entry2"."Debit Amount";

                if "G/L Entry2"."Posting Date" < 20210101D then begin
                    NetAmount2 := "G/L Entry2"."Debit Amount" * (100 / 14);
                end else begin
                    NetAmount2 := "G/L Entry2"."Debit Amount" * (100 / 16);
                end;


                totalAmount2 := "G/L Entry2"."Debit Amount" + NetAmount2;

                if PaymentHeader.Get("G/L Entry2"."Document No.") then
                    CurrReport.Skip;


                //IF "G/L Entry2".Document_Type="G/L Entry2".Document_Type::Receipt THEN
                //CurrReport.SKIP;

                if SalesCrMemoHeader.Get("G/L Entry2"."Document No.") then begin
                    SourceNumber2 := SalesCrMemoHeader."Sell-to Customer No.";
                    SourceName2 := SalesCrMemoHeader."Sell-to Customer Name";
                    InvoiceNumber2 := SalesCrMemoHeader."No.";
                    Invoicedate2 := SalesCrMemoHeader."Posting Date";
                    if VendorAgent.Get(SourceNumber2) then
                        TINNumber2 := VendorAgent."VAT Registration No.";

                end;


                ReceiptHeader.Reset;
                ReceiptHeader.SetRange("No.", "G/L Entry2"."Document No.");
                if ReceiptHeader.FindFirst then begin
                    //  if (ReceiptHeader."Payment Mode"=ReceiptHeader."Payment Mode"::"Withholding Rental Income") or
                    //    (ReceiptHeader."Payment Mode"=ReceiptHeader."Payment Mode"::"Withholding Tax") or
                    //     (ReceiptHeader."Payment Mode"=ReceiptHeader."Payment Mode"::"Withholding VAT") then
                    // Withholding:=true;
                    // SourceNumber2:=ReceiptHeader."Client No.";
                    // SourceName2:=ReceiptHeader."Client Name";

                    ReceiptLines.Reset;
                    ReceiptLines.SetRange(ReceiptLines."Document No.", ReceiptHeader."No.");
                    if ReceiptLines.FindFirst then begin
                        InvoiceNumber2 := ReceiptLines."Applies-to Doc. No.";

                    end;
                    // if TempCustomer.Get(SourceNumber2) then
                    //  TINNumber2:=TempCustomer." TIN No.";
                end;



                if SourceNumber2 = '' then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                "G/L Entry2".SetRange("G/L Entry2"."Posting Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        CompanyInfo: Record "Company Information";
        NewGLEntry: Record "G/L Entry";
        StartDate: Date;
        EndDate: Date;
        ERROR0001: Label 'Start Date must be specified!';
        ERROR0002: Label 'End Date must be specified!';
        Text30Days: Label 'Please Pay Amount due';
        Text60Days: Label 'Please arrange to pay in the next 14 days.';
        Text90Days: Label 'Please arrange to pay in the next 14 days.';
        TextAbove90Days: Label 'Please arrange to pay in the next 14 days,failure to which we shall destress you.';
        PropertyCode: Code[50];
        SourceNumber: Code[30];
        SourceName: Text;
        InvoiceNumber: Code[30];
        Invoicedate: Date;
        NetAmount: Decimal;
        totalAmount: Decimal;
        TINNumber: Code[40];
        TempCustomer: Record Customer;
        PropertyNumber: Code[30];
        PropertyName: Text;
        LandlordNumber: Code[30];
        LandlordName: Text;
        PurchInvHeader: Record "Purch. Inv. Header";
        TradeVendor: Record Vendor;
        SourceNumber2: Code[30];
        SourceName2: Text;
        InvoiceNumber2: Code[30];
        Invoicedate2: Date;
        NetAmount2: Decimal;
        totalAmount2: Decimal;
        TINNumber2: Code[40];
        VatAmount2: Decimal;
        VendorAgent: Record Vendor;
        PaymentHeader: Record "Payment Header";
        ReceiptHeader: Record "Receipt Header";
        Withholding: Boolean;
        TransactionDescription: Text;
        TransactionDescription2: Text;
        ReceiptLines: Record "Receipt Line";
        ReversalInv_No: Code[20];
        ReversalDate: Date;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    //  InvoiceHeader: Record "Invoice Header";
}

