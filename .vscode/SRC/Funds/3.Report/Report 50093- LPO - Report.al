report 50093 "LPO - Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/LPO - Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order));

            RequestFilterFields = Status, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code";
            column(Status_PurchaseRequisitions; Status)
            {
            }
            column(Description_PurchaseRequisitions; "Posting Description")
            {
            }
            column(Purchase_Type; "Purchase Header"."Purchase Type")
            {
            }
            column(GlobalDimension1Code_PurchaseRequisitions; "Purchase Header"."Shortcut Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PurchaseRequisitions; "Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_PurchaseRequisitions; "Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PurchaseRequisitions; "Shortcut Dimension 4 Code")
            {
            }
            column(VATAmount_PurchaseRequisitions; "Amount Including VAT")
            {
            }
            column(No_PurchaseRequisitions; "No.")
            {
            }
            column(DocumentDate_PurchaseRequisitions; "Document Date")
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions; "Posting Date")
            {
            }
            column(Amount_PurchaseRequisitions; Amount)
            {
            }
            column(AmountLCY_PurchaseRequisitions; "Amount(LCY)")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader; "Vendor Invoice No.")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Pay-to Name")
            {
            }
        }
        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order), "Version No." = CONST(1), Amount = FILTER(<> 0));
            column(Status_PurchaseRequisitions1; Status)
            {
            }
            column(Description_PurchaseRequisitions1; "Posting Description")
            {
            }
            column(GlobalDimension1Code_PurchaseRequisitions1; "Purchase Header"."Shortcut Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PurchaseRequisitions1; "Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            // column(ShortcutDimension3Code_PurchaseRequisitions1;"Shortcut Dimension 3 Code")
            // {
            // }
            // column(ShortcutDimension4Code_PurchaseRequisitions1;"Shortcut Dimension 4 Code")
            // {
            // }
            column(VATAmount_PurchaseRequisitions1; "Amount Including VAT")
            {
            }
            column(No_PurchaseRequisitions1; "No.")
            {
            }
            column(DocumentDate_PurchaseRequisitions1; "Document Date")
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions1; "Posting Date")
            {
            }
            column(Amount_PurchaseRequisitions1; Amount)
            {
            }
            // column(AmountLCY_PurchaseRequisitions1;"Amount(LCY)")
            // {
            // }
            column(PaytoVendorNo_PurchaseHeader1; "Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader1; "Pay-to Name")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader1; "Vendor Invoice No.")
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

