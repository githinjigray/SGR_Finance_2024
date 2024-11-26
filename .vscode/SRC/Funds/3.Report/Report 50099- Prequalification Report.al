report 50099 "Prequalification Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Prequalification Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Supplier Category"; "Supplier Category")
        {
            column(DocumentNumber_SupplierCategory; "Document Number")
            {
            }
            column(SupplierCategory_SupplierCategory; "Supplier Category")
            {
            }
            column(CategoryDescription_SupplierCategory; "Category Description")
            {
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
}

