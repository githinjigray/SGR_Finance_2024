report 50082 "Budget Utilization Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Budget Utilization Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.";
            column(MarketPrice; MarketPrice)
            {
            }
            column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(EntryType_ItemLedgerEntry; "Item Ledger Entry"."Entry Type")
            {
            }
            column(SourceNo_ItemLedgerEntry; "Item Ledger Entry"."Source No.")
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo.Website)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF ItemList.GET("Item Ledger Entry"."Item No.") THEN
                    ItemDescription := ItemList.Description;



                // ItemMarketPrice.RESET;
                // ItemMarketPrice.SETRANGE(ItemMarketPrice.Item,"Item Ledger Entry"."Item No.");
                // //ItemMarketPrice.SETRANGE(ItemMarketPrice."From Date",ItemMarketPrice."To Date","Item Ledger Entry"."Posting Date");
                // IF ItemMarketPrice.FINDFIRST THEN BEGIN
                //   MarketPrice:=ItemMarketPrice."Market Price";
                // END;
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

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture)
    end;

    var
        //ItemMarketPrice: Record Table52137056;
        ItemList: Record Item;
        MarketPrice: Decimal;
        CompanyInfo: Record "Company Information";
        ItemDescription: Text;
}

