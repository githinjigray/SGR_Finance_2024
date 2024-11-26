report 50059 "Customer Balances Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Customer Balances Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Customer Posting Group";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(CustomerPostingGroup_Customer; Customer."Customer Posting Group")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
                {
                }
                column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
                {
                }
                column(DebitAmount_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount")
                {
                }
                column(CreditAmount_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount")
                {
                }
                // column(TransactionCode_CustLedgerEntry;"Cust. Ledger Entry"."Transaction Code")
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

