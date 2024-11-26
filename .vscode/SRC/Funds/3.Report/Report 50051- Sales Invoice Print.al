report 50051 "Sales Invoice Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Sales Invoice Print.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(InvoiceNo; "No.")
            {
            }
            column(InvoiceDate; "Posting Date")
            {
            }
            column(TenantNo; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(TenantName; "Sales Header"."Bill-to Name")
            {
            }
            column(BilltoName_SalesHeader; "Sales Header"."Bill-to Name")
            {
            }
            column(ContractNo; "Sales Header"."Bill-to Name")
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
            // column(CVATNo;CompanyInfo."Company TIN")
            // {
            // }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            column(CBankName; LandlordContractHeader."Cash Voucher Nos.")
            {
            }
            column(CBankBranch; LandlordContractHeader."Cash Voucher Nos.")
            {
            }
            column(CBankAccountNo; LandlordContractHeader."Cash Voucher Nos.")
            {
            }
            column(BANKACCNAME; LandlordContractHeader."Cash Voucher Nos.")
            {
            }
            column(PropertyCode; PropertyCode)
            {
            }
            column(PropertyName; PropertyName)
            {
            }
            column(ExpiryDate; ExpiryDate)
            {
            }
            column(ReviewDate; ReviewDate)
            {
            }
            column(TotalAmountExclVAT; "Sales Header".Amount)
            {
            }
            column(Amount_SalesHeader; "Sales Header".Amount)
            {
            }
            column(TotalVATAmount; TotalVATAmount)
            {
            }
            column(TotalAmountInclVAT; "Sales Header"."Amount Including VAT")
            {
            }
            column(AmountIncludingVAT_SalesHeader; "Sales Header"."Amount Including VAT")
            {
            }
            column(CustomerBalance; CustomerBalance)
            {
            }
            column(InvoiceDescription; InvoiceDescription)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ChargeName; "Sales Line".Description)
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Description; "Sales Line".Description)
                {
                }
                column(AmountExclVAT; "Sales Line".Amount)
                {
                }
                column(Amount_SalesLine; "Sales Line".Amount)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(AmountInclVAT; "Sales Line"."Amount Including VAT")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATAmount := 0;

                    VATAmount := "Sales Line"."Amount Including VAT" - "Sales Line".Amount;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrentAmount := 0;
                CustomerBalance := 0;
                InvoiceDescription := '';
                TotalVATAmount := 0;

                "Sales Header".CalcFields(Amount, "Amount Including VAT");



                InvoiceDescription := "Sales Header"."Posting Description";

                "Sales Header".CalcFields("Sales Header".Amount);
                "Sales Header".CalcFields("Sales Header"."Amount Including VAT");
                TotalVATAmount := "Sales Header"."Amount Including VAT" - "Sales Header".Amount;
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

        PropertyGeneralSetup.Get;
    end;

    var
        LandlordContractHeader: Record "Funds General Setup";
        LandlordContractLine: Record "Funds General Setup";
        CompanyInfo: Record "Company Information";
        CustomerREC: Record Customer;
        PropertyGeneralSetup: Record "Funds General Setup";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        LeaseInvoicingBatch: Record "Funds General Setup";
        Property: Record "Funds General Setup";
        PropertyName: Text;
        ExpiryDate: Date;
        ReviewDate: Date;
        Description2: Text;
        CustomerBalance: Decimal;
        CurrentAmount: Decimal;
        InvoiceDescription: Text;
        PropertyCode: Code[20];
        VATAmount: Decimal;
        TotalVATAmount: Decimal;
}

