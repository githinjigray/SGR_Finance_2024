report 50071 "Posted Purchase Invoice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Posted Purchase Invoice Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "Posting Date";
            column(no; "Purch. Inv. Header"."No.")
            {
            }
            column(vendname; "Purch. Inv. Header"."Pay-to Name")
            {
            }
            column(pdate; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(invoiceno; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(amount; "Purch. Inv. Header".Amount)
            {
            }
            column(amountvat; "Purch. Inv. Header"."Amount Including VAT")
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

