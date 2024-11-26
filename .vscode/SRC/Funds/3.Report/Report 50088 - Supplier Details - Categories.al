report 50088 "Supplier Details - Categories"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Supplier Details - Categories.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Supplier Category"; "Supplier Category")
        {
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoEMail; CompanyInfo."E-Mail")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            // column(CompanyTIN;CompanyInfo."Company TIN")
            // {
            // }
            // column(LetterHead;CompanyInfo."Company Letter Head")
            // {
            // }
            column(SupplierCategory_SupplierCategory; "Supplier Category")
            {
            }
            column(CategoryDescription_SupplierCategory; "Category Description")
            {
            }
            dataitem("Prequalified Suppliers"; "Prequalified Suppliers")
            {
                DataItemLink = "Supplier Name" = FIELD("Document Number");
                column(SupplierName_PrequalifiedSuppliers; "Prequalified Suppliers"."Supplier Name")
                {
                }
                column(ProcurementPeriod_PrequalifiedSuppliers; "Prequalified Suppliers"."Procurement Period")
                {
                }
                column(SupplierCategory_PrequalifiedSuppliers; "Prequalified Suppliers"."Supplier Category")
                {
                }
                column(SupplierCategoryDescription_PrequalifiedSuppliers; "Prequalified Suppliers"."Supplier Category Description")
                {
                }
                column(VendorNo_PrequalifiedSuppliers; "Prequalified Suppliers"."Vendor No.")
                {
                }
                column(EMail_PrequalifiedSuppliers; "Prequalified Suppliers"."E-Mail")
                {
                }
                column(Prequalified_PrequalifiedSuppliers; "Prequalified Suppliers".Prequalified)
                {
                }
                column(PhoneNo_PrequalifiedSuppliers; "Prequalified Suppliers"."Phone No.")
                {
                }
                column(TINNo_PrequalifiedSuppliers; "Prequalified Suppliers"."TIN No.")
                {
                }
                column(PostalAddress_PrequalifiedSuppliers; "Prequalified Suppliers"."Postal Address")
                {
                }
                column(PostalCode_PrequalifiedSuppliers; "Prequalified Suppliers"."Postal Code")
                {
                }
            }
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
        // CompanyInfo.CalcFields("Company Letter Head");



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
        FeeTypeDescription: Text;
    // FeeTypes: Record "Fee Types";
}

