report 50098 "Inventory By Location"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Inventory By Location.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            CalcFields = "Item No.", "Posting Date", "Location Code";
            column(ItemNo; "Item Ledger Entry"."Item No.")
            {
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(Location; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity; "Item Ledger Entry".Quantity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ItemDescription := '';
                Item.Reset;
                if Item.Get("Item Ledger Entry"."Item No.") then
                    ItemDescription := Item.Description;
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
        Item: Record Item;
        ItemDescription: Text;
}

