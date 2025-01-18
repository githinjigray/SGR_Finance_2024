report 50073 "Request for Quatation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Request for Quatation Report.rdl';
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
            column(IssueDate_RequestforQuotationHeader; "Request for Quotation Header"."Issue Date")
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
            column(EditinOutlookClient_RequestforQuotationHeader; "Request for Quotation Header"."Edit in Outlook Client")
            {
            }
            column(AGPOCertificate; "Request for Quotation Header"."AGPO Certificate")
            {
            }
            column(BusinessRegistrationCert; "Request for Quotation Header"."Business Registration Cert.")
            {
            }
            column(TaxComplianceCert; "Request for Quotation Header"."Tax Compliance Cert.")
            {
            }
            column(ConfidentialBusQuestionnaire; "Request for Quotation Header"."Confidential Bus.Questionnaire")
            {
            }
            column(Time_RequestforQuotationHeader; "Request for Quotation Header".Time)
            {
            }
            column(GlobalDimension2Code_RequestforQuotationHeader; "Global Dimension 2 Code")
            {
            }
            column(LNo2; LNo2)
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
                column(UnitofMeasureCode_RequestforQuotationLine; "Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo2 := LNo2 + 1;
                end;
            }
            dataitem("Specification Attributes"; "Specification Attributes")
            {
                DataItemLink = "RFQ No." = FIELD("No.");
                column(LNO; LNo)
                {
                }
                column(Specification_RFQSpecificationTable; Specification)
                {
                }
                column(Requirement_RFQSpecificationTable; Requirement)
                {
                }
                column(LineNo_RFQSpecificationTable; "Line No.")
                {
                }
                column(RFQNo_RFQSpecificationTable; "RFQ No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                end;
            }
            dataitem("Procurement Requirements"; "Procurement Requirements")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_ProcurementRequirements; "Procurement Requirements"."Document No.")
                {
                }
                column(LineNo_ProcurementRequirements; "Procurement Requirements"."Line No.")
                {
                }
                column(Description_ProcurementRequirements; "Procurement Requirements".Description)
                {
                }
                column(LNo3; LNo3)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo3 := LNo3 + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RequestforQuotationVendors.Reset;
                RequestforQuotationVendors.SetRange("RFQ Document No.", "Request for Quotation Header"."No.");
                if RequestforQuotationVendors.FindSet then begin
                    repeat
                    // VendorName[i]:=RequestforQuotationVendors."Vendor Name";
                    until RequestforQuotationVendors.Next = 0;
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
        PurchaseOrderCaption = 'Purchase Order';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
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
        LNo2: Integer;
        LNo3: Integer;
        VendorName: array[10] of Text;
        i: Integer;
}

