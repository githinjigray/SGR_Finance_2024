report 50091 "RFQ - Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/RFQ - Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Request for Quotation Header"; "Request for Quotation Header")
        {
            RequestFilterFields = "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code";
            column(Status_PurchaseRequisitions; Status)
            {
            }
            column(Description_PurchaseRequisitions; Description)
            {
            }
            column(GlobalDimension1Code_PurchaseRequisitions; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PurchaseRequisitions; "Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_PurchaseRequisitions; "Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PurchaseRequisitions; "Shortcut Dimension 4 Code")
            {
            }
            column(VATAmount_PurchaseRequisitions; Amount)
            {
            }
            column(VATAmountLCY_PurchaseRequisitions; Amount)
            {
            }
            column(TotalAmount_PurchaseRequisitions; Amount)
            {
            }
            column(TotalAmountLCY_PurchaseRequisitions; Amount)
            {
            }
            column(No_PurchaseRequisitions; "Request for Quotation Header"."No.")
            {
            }
            column(DocumentDate_PurchaseRequisitions; "Document Date")
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions; "Request for Quotation Header"."Document Date")
            {
            }
            column(Amount_PurchaseRequisitions; Amount)
            {
            }
            column(AmountLCY_PurchaseRequisitions; "Amount(LCY)")
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

