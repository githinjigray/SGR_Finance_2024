report 50075 "Request for Quatations"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Request for Quatations.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Request for Quotation Header"; "Request for Quotation Header")
        {
            RequestFilterFields = "No.";
            column(No_RequestforQuotationHeader; "Request for Quotation Header"."No.")
            {
            }
            column(DocumentDate_RequestforQuotationHeader; "Request for Quotation Header"."Document Date")
            {
            }
            column(ClosingDate_RequestforQuotationHeader; "Request for Quotation Header"."Closing Date")
            {
            }
            column(CurrencyCode_RequestforQuotationHeader; "Request for Quotation Header"."Currency Code")
            {
            }
            column(CurrencyFactor_RequestforQuotationHeader; "Request for Quotation Header"."Currency Factor")
            {
            }
            column(Amount_RequestforQuotationHeader; "Request for Quotation Header".Amount)
            {
            }
            column(AmountLCY_RequestforQuotationHeader; "Request for Quotation Header"."Amount(LCY)")
            {
            }
            column(Description_RequestforQuotationHeader; "Request for Quotation Header".Description)
            {
            }
            dataitem("Request for Quotation Line"; "Request for Quotation Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                PrintOnlyIfDetail = false;
                column(No_RequestforQuotationLine; "Request for Quotation Line"."No.")
                {
                }
                column(Name_RequestforQuotationLine; "Request for Quotation Line".Name)
                {
                }
                column(Type_RequestforQuotationLine; "Request for Quotation Line".Type)
                {
                }
                column(Quantity_RequestforQuotationLine; "Request for Quotation Line".Quantity)
                {
                }
                column(Description_RequestforQuotationLine; "Request for Quotation Line".Description)
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
                column(ProcEmail; GenLedgerSetup."Procurement Email")
                {
                }
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
        PurchaseOrderCaption = 'Purchase Order';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        CopyText: Text;
        PurchLines: Record "Purchase Line";
        NumberText: array[2] of Text[120];
        CheckReport: Report Check;
        LPOText: Text;
        GenLedgerSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        CampusName: Text;
        DeptName: Text;
        LNo: Integer;
        Employees: Record Employee;
}

