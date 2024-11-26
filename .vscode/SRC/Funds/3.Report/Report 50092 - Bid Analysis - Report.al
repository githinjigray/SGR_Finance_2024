report 50092 "Bid Analysis - Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bid Analysis - Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bid Analysis Header"; "Bid Analysis Header")
        {

            RequestFilterFields = Status, "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code";
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
            column(No_PurchaseRequisitions; "No.")
            {
            }
            column(DocumentDate_PurchaseRequisitions; "Document Date")
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions; "Bid Analysis Header"."Document Date")
            {
            }
            column(ReasonforSelectionofVendor_BidAnalysisHeader; "Bid Analysis Header"."Reason for Selection of Vendor")
            {
            }
            column(LPONoAssigned_BidAnalysisHeader; "Bid Analysis Header"."LPO No. Assigned")
            {
            }
            column(SelectedVendor_BidAnalysisHeader; "Bid Analysis Header"."Selected Vendor")
            {
            }
            column(VendorName_BidAnalysisHeader; "Bid Analysis Header"."Vendor Name")
            {
            }
            dataitem("Bid Analysis Items"; "Bid Analysis Items")
            {
                DataItemLink = "Vendor No." = FIELD("Selected Vendor"), "Document No." = FIELD("No.");
                column(VATAmount_PurchaseRequisitions; "VAT Amount")
                {
                }
                column(TotalAmount_PurchaseRequisitions; "Total Cost Inc. VAT")
                {
                }
                // column(Amount_PurchaseRequisitions;"Total Cost")
                // {
                // }
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

