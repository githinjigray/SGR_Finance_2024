report 50070 "Bid Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bid Analysis.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bid Analysis"; "Bid Analysis")
        {
            RequestFilterFields = "Request for Quotation No.";
            column(RequestforQuotationNo_BidAnalysisItems; "Bid Analysis"."Request for Quotation No.")
            {
            }
            column(VendorNo_BidAnalysisItems; "Bid Analysis"."Vendor No.")
            {
            }
            column(VendorName_BidAnalysisItems; VendorName)
            {
            }
            column(ItemNo_BidAnalysisItems; "Bid Analysis"."Item No.")
            {
            }
            column(Name_BidAnalysisItems; "Bid Analysis".Description)
            {
            }
            column(Description_BidAnalysisItems; "Bid Analysis".Description)
            {
            }
            column(Quantity_BidAnalysisItems; "Bid Analysis".Quantity)
            {
            }
            column(UnitOfMeasure_BidAnalysisItems; "Bid Analysis"."Unit Of Measure")
            {
            }
            column(UnitCost_BidAnalysisItems; "Bid Analysis".Amount)
            {
            }
            column(TotalCost_BidAnalysisItems; "Bid Analysis"."Line Amount")
            {
            }
            column(Remarks_BidAnalysisItems; "Bid Analysis".Remarks)
            {
            }
            column(SelectedVendor; SelectedVendor)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Vendor.Get("Bid Analysis"."Vendor No.") then
                    VendorName := Vendor.Name;

                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);

                BidAnalysis.Reset;
                BidAnalysis.SetRange("Request for Quotation No.", "Bid Analysis"."Request for Quotation No.");
                BidAnalysis.SetRange("Item No.", "Bid Analysis"."Item No.");
                BidAnalysis.SetCurrentKey("Item No.", "Line Amount");
                BidAnalysis.Ascending(true);
                if BidAnalysis.FindFirst then begin
                    if Vendor.Get(BidAnalysis."Vendor No.") then
                        SelectedVendor := Vendor.Name;
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
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
        BidAnalysisItems: Record "Bid Analysis Items";
        SelectedVendor: Text;
        Vendor: Record Vendor;
        CompanyInformation: Record "Company Information";
        BidAnalysis: Record "Bid Analysis";
        VendorName: Text;
}

