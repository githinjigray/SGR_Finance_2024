report 50084 "Purchase Requisitions List"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Purchase Requisitions List.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Requisitions"; "Purchase Requisitions")
        {
            column(No_PurchaseRequisitions; "Purchase Requisitions"."No.")
            {
            }
            column(DocumentDate_PurchaseRequisitions; "Purchase Requisitions"."Document Date")
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions; "Purchase Requisitions"."Requested Receipt Date")
            {
            }
            column(Budget_PurchaseRequisitions; "Purchase Requisitions".Budget)
            {
            }
            column(CurrencyCode_PurchaseRequisitions; "Purchase Requisitions"."Currency Code")
            {
            }
            column(CurrencyFactor_PurchaseRequisitions; "Purchase Requisitions"."Currency Factor")
            {
            }
            column(Amount_PurchaseRequisitions; "Purchase Requisitions".Amount)
            {
            }
            column(AmountLCY_PurchaseRequisitions; "Purchase Requisitions"."Amount(LCY)")
            {
            }
            column(Description_PurchaseRequisitions; "Purchase Requisitions".Description)
            {
            }
            column(GlobalDimension1Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 2 Code")
            {
            }
            column(UserID_PurchaseRequisitions; "Purchase Requisitions"."User ID")
            {
            }
            column(EmployeeNo_PurchaseRequisitions; "Purchase Requisitions"."Employee No.")
            {
            }
            column(ShortcutDimension3Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 4 Code")
            {
            }
            column(EMPLOYEENAME; EMPLOYEENAME)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if HREmployee.Get("Purchase Requisitions"."Employee No.") then begin

                end;
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

    var
        EMPLOYEENAME: Text;
        HREmployee: Record Employee;
}

