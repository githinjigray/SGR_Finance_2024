report 50090 "Purchase Reqsitions-Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Purchase Reqsitions-Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Requisitions"; "Purchase Requisitions")
        {
            RequestFilterFields = Status, "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code";
            column(Status_PurchaseRequisitions; "Purchase Requisitions".Status)
            {
            }
            column(Description_PurchaseRequisitions; "Purchase Requisitions".Description)
            {
            }
            column(Purchase_Type; "Purchase Requisitions"."Purchase Type")
            {
            }
            column(GlobalDimension1Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 4 Code")
            {
            }
            column(VATAmount_PurchaseRequisitions; "Purchase Requisitions"."VAT Amount")
            {
            }
            column(VATAmountLCY_PurchaseRequisitions; "Purchase Requisitions"."VAT Amount(LCY)")
            {
            }
            column(TotalAmount_PurchaseRequisitions; "Purchase Requisitions"."Total Amount")
            {
            }
            column(TotalAmountLCY_PurchaseRequisitions; "Purchase Requisitions"."Total Amount(LCY)")
            {
            }
            column(No_PurchaseRequisitions; "Purchase Requisitions"."No.")
            {
            }
            column(DocumentDate_PurchaseRequisitions; "Purchase Requisitions"."Document Date")
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions; "Purchase Requisitions"."Requested Receipt Date")
            {
            }
            column(Amount_PurchaseRequisitions; "Purchase Requisitions".Amount)
            {
            }
            column(AmountLCY_PurchaseRequisitions; "Purchase Requisitions"."Amount(LCY)")
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

