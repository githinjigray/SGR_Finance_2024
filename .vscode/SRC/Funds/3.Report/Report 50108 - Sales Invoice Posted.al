report 50108 "Sales Invoice Posted"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Sales Invoice Posted.rdlc';
    EnableExternalImages = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(InvoiceNo; "No.")
            {
            }
            column(Date_Of_Flight; "Date Of Flight")
            {
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
            }
            column(GrossAmount; GrossAmount)
            {
            }
            column(Currency; Currency)
            {

            }
            column(TotalDiscountAmount; TotalDiscountAmount)
            {

            }
            column(GrossAmountIncDiscount; GrossAmountIncDiscount)
            {

            }
            column(Posting_Description; "Posting Description")
            {
            }
            column(CustomerTIN; CustomerTIN)
            {
            }
            column(CustomerAddress; CustomerAddress)
            {
            }
            column(CustomerEmail; CustomerEmail)
            {
            }
            column(CustomerPhoneNo; CustomerPhoneNo)
            {
            }
            column(InvoiceDate; "Posting Date")
            {
            }
            column(DueDate_SalesInvoiceHeader; "Sales Invoice Header"."Due Date")
            {
            }
            column(TenantNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Bill-to Customer No.")
            {
            }
            column(TenantName; "Bill-to Name")
            {
            }
            column(BilltoName_SalesHeader; "Bill-to Name")
            {
            }
            column(ContractNo; "Bill-to Name")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPhone; CompanyInfo."Phone No.")
            {
            }
            column(CEmail; CompanyInfo."E-Mail")
            {
            }
            column(CVATNo; GeneralLedgerSetup."Company TIN")
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            column(CBankName; CompanyInfo."Bank Name")
            {
            }
            column(CBankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(BANKACCNAME; CompanyInfo."Bank Name")
            {
            }
            column(PropertyCode; PropertyCode)
            {
            }
            column(PropertyName; PropertyName)
            {
            }
            column(ControlUnitInvoiceNo; ControlUnitInvoiceNo)
            {
            }
            column(ExpiryDate; ExpiryDate)
            {
            }
            column(ReviewDate; ReviewDate)
            {
            }
            column(TotalAmountExclVAT; Amount)
            {
            }
            column(Amount_SalesHeader; Amount)
            {
            }
            column(TotalVATAmount; TotalVATAmount)
            {
            }
            column(TotalAmountInclVAT; "Amount Including VAT")
            {
            }
            column(AmountIncludingVAT_SalesHeader; "Amount Including VAT")
            {
            }
            column(CustomerBalance; CustomerBalance)
            {
            }
            column(InvoiceDescription; InvoiceDescription)
            {
            }
            column(CustomerInvoiceNo_TIMSResponses; InvoiceDescription)
            {
            }
            // column(CustomerInvoiceNo_TIMSResponses; TIMSResponses."Customer Invoice No.")
            // {
            // }
            column(VerifiyUrl_TIMSResponses; VerifyURL)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Line Discount %" = filter(<> 0));
                column(Unit_Price; "Unit Price")
                {

                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {

                }
                column(ChargeName; Description)
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(Description; Description)
                {
                }
                column(AmountExclVAT; Amount)
                {
                }
                column(Amount_SalesLine; Amount)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(AmountInclVAT; "Amount Including VAT")
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                {
                }
                column(LineDiscount_SalesInvoiceLine; "Sales Invoice Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Discount Amount")
                {
                }
                column(VAT_SalesInvoiceLine; "Sales Invoice Line"."VAT %")
                {
                }
                column(Shortcut_Dimension_3_Code; Shortcut_Dimension_3_Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GeneralLedgerSetup.get;
                    VATAmount := 0;
                    Shortcut_Dimension_3_Code := '';
                    VATAmount := "Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount;


                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 3 Code");
                    if DimensionSetEntry.FindFirst() then begin
                        DimensionSetEntry.CalcFields("Dimension Value Name");
                        Shortcut_Dimension_3_Code := DimensionSetEntry."Dimension Value Code";
                        //Shortcut_Dimension_3_Code := DimensionSetEntry."Dimension Value Code" + '-' + DimensionSetEntry."Dimension Value Name";

                    end;
                end;
            }
            dataitem("Sales Invoice Line2"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Line Discount %" = filter(0));
                column(Unit_Price2; "Sales Invoice Line2"."Unit Price")
                {

                }
                column(Unit_of_Measure_Code2; "Sales Invoice Line2"."Unit of Measure Code")
                {

                }
                column(ChargeName2; "Sales Invoice Line2".Description)
                {
                }
                column(Description_SalesLine2; "Sales Invoice Line2".Description)
                {
                }
                column(Description2; "Sales Invoice Line2".Description)
                {
                }
                column(AmountExclVAT2; "Sales Invoice Line2".Amount)
                {
                }
                column(Amount_SalesLine2; "Sales Invoice Line2".Amount)
                {
                }
                column(VATAmount2; VATAmount)
                {
                }
                column(AmountInclVAT2; "Sales Invoice Line2"."Amount Including VAT")
                {
                }
                column(Quantity_SalesInvoiceLine2; "Sales Invoice Line2".Quantity)
                {
                }
                column(LineDiscount_SalesInvoiceLine2; "Sales Invoice Line2"."Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesInvoiceLine2; "Sales Invoice Line2"."Line Discount Amount")
                {
                }
                column(VAT_SalesInvoiceLine2; "Sales Invoice Line2"."VAT %")
                {
                }
                column(Shortcut_Dimension_3_Code2; Shortcut_Dimension_3_Code2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GeneralLedgerSetup.get;
                    VATAmount := 0;
                    Shortcut_Dimension_3_Code2 := '';
                    VATAmount := "Sales Invoice Line2"."Amount Including VAT" - "Sales Invoice Line2".Amount;

                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", "Sales Invoice Line2"."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 3 Code");
                    if DimensionSetEntry.FindFirst() then begin
                        DimensionSetEntry.CalcFields("Dimension Value Name");
                        Shortcut_Dimension_3_Code2 := DimensionSetEntry."Dimension Value Code"
                        // Shortcut_Dimension_3_Code2 := DimensionSetEntry."Dimension Value Code" + '-' + DimensionSetEntry."Dimension Value Name";

                    end;

                end;
            }
            trigger OnAfterGetRecord()
            begin
                GeneralLedgerSetup.get;
                CurrentAmount := 0;
                CustomerBalance := 0;
                InvoiceDescription := '';
                TotalVATAmount := 0;
                ControlUnitInvoiceNo := '';
                VerifyURL := '';
                CustomerTIN := '';
                CustomerAddress := '';
                CustomerPhoneNo := '';
                CustomerEmail := '';
                GrossAmount := 0;
                TotalDiscountAmount := 0;
                GrossAmountIncDiscount := 0;

                if CustomerREC.get("Sell-to Customer No.") then begin
                    CustomerTIN := CustomerREC."TIN No.";
                    CustomerAddress := CustomerREC.Address;
                    CustomerPhoneNo := CustomerREC."Phone No.";
                    CustomerEmail := CustomerREC."E-Mail";

                end;
                "Sales Invoice Header".CalcFields(Amount, "Amount Including VAT");

                //IF TIMSResponses.GET("Sales Invoice Header"."No.") THEN;
                //IF TIMSResponses.GET("Sales Invoice Header"."Pre-Assigned No.") THEN;
                //VerifyURL:=FORMAT(TIMSResponses."Verifiy Url");

                InvoiceDescription := "Sales Invoice Header"."Posting Description";
                /*ControlUnitInvoiceNo:="Sales Invoice Header"."CU Invoice No.";
                IF "Sales Invoice Header"."CU Invoice No."='' THEN
                  ControlUnitInvoiceNo:="Sales Invoice Header"."Old CU Invoice No.";*/
                //TypeHelper.UrlEncode(VerifyURL);

                "Sales Invoice Header".CalcFields("Sales Invoice Header".Amount);
                "Sales Invoice Header".CalcFields("Sales Invoice Header"."Amount Including VAT");
                TotalVATAmount := "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount;

                InvoiceLines.Reset();
                InvoiceLines.SetRange("Document No.", "Sales Invoice Header"."No.");
                InvoiceLines.SetFilter("Line Discount Amount", '>%1', 0);
                if FindSet() then begin
                    InvoiceLines.CalcSums("Amount Including VAT");
                    InvoiceLines.CalcSums("Line Discount Amount");
                    TotalDiscountAmount := InvoiceLines."Line Discount Amount";
                    GrossAmountIncDiscount := InvoiceLines."Amount Including VAT";
                    GrossAmount := GrossAmountIncDiscount + TotalDiscountAmount;
                end;


                if "Sales Invoice Header"."Currency Code" <> '' then
                    Currency := "Sales Invoice Header"."Currency Code"
                else
                    Currency := GeneralLedgerSetup."LCY Code";

            end;

        }
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = where("Show In Sales Invoice" = filter(true));
            column(Bank_Account_No_; "Bank Account No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Bank_Branch_No_; "Bank Branch No.")
            {
            }
            column(SWIFT_Code; "SWIFT Code")
            {
            }
            column(Show_In_Sales_Invoice; "Show In Sales Invoice")
            {

            }
            column(BankCurrency; BankCurrency)
            {
            }
            trigger OnAfterGetRecord()
            begin
                BankCurrency := '';
                GeneralLedgerSetup.Get();
                if "Bank Account"."Currency Code" <> '' then
                    BankCurrency := "Bank Account"."Currency Code"
                else
                    BankCurrency := GeneralLedgerSetup."LCY Code";
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
        // LandlordContractHeader: Record Table51535496;
        // LandlordContractLine: Record Table51535497;
        CompanyInfo: Record "Company Information";
        CustomerREC: Record Customer;
        //PropertyGeneralSetup: Record Table51535527;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        //LeaseInvoicingBatch: Record Table51535454;
        //Property: Record Table51535420;
        PropertyName: Text;
        TypeHelper: Codeunit "Type Helper";
        // TIMSResponses: Record Table51535719;
        ExpiryDate: Date;
        ReviewDate: Date;
        Description2: Text;
        CustomerBalance: Decimal;
        CurrentAmount: Decimal;
        InvoiceDescription: Text;
        PropertyCode: Code[20];
        VATAmount: Decimal;
        TotalVATAmount: Decimal;
        ControlUnitInvoiceNo: Text;
        VerifyURL: Text;
        InvoiceName: Text;
        CustomerTIN: code[20];
        CustomerAddress: Text[250];
        CustomerPhoneNo: Text[250];
        CustomerEmail: Text[250];
        GrossAmount: Decimal;
        TotalDiscountAmount: Decimal;
        GrossAmountIncDiscount: Decimal;
        BankCurrency: Code[20];
        InvoiceLines: Record "Sales Invoice Line";
        Currency: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
        Shortcut_Dimension_3_Code: Text;
        Shortcut_Dimension_3_Code2: Text;
        DimensionSetEntry: Record "Dimension Set Entry";
}

