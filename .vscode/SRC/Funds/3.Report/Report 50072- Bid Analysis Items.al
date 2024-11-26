report 50072 "Bid Analysis Items"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bid Analysis Items.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bid Analysis Header"; "Bid Analysis Header")
        {
            column(No_BidAnalysisHeader; "Bid Analysis Header"."No.")
            {
                //
            }
            column(DocumentDate_BidAnalysisHeader; "Bid Analysis Header"."Document Date")
            {
            }
            column(RFQDate_BidAnalysisHeader; "Bid Analysis Header"."RFQ Date")
            {
            }
            column(Description_BidAnalysisHeader; "Bid Analysis Header".Description)
            {
            }
            column(ReasonforSelectionofVendor_BidAnalysisHeader; "Bid Analysis Header"."Reason for Selection of Vendor")
            {
            }
            column(SelectedVendor_BidAnalysisHeader; "Bid Analysis Header"."Selected Vendor")
            {
            }
            column(CompanyInfoName; CompanyInfO.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfO.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfO."Address 2")
            {
            }
            column(CompanyInfoPhone; CompanyInfO."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfO.Picture)
            {
            }
            column(CompanyEmail; CompanyInfO."E-Mail")
            {
            }
            column(UserID_BidAnalysisHeader; "Bid Analysis Header"."User ID")
            {
            }
            column(GlobalDimension1Code_BidAnalysisHeader; "Bid Analysis Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_BidAnalysisHeader; "Bid Analysis Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_BidAnalysisHeader; "Bid Analysis Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_BidAnalysisHeader; "Bid Analysis Header"."Shortcut Dimension 4 Code")
            {
            }
            column(VendorName_BidAnalysisHeader; "Bid Analysis Header"."Vendor Name")
            {
            }
            dataitem("Bid Analysis Items"; "Bid Analysis Items")
            {
                DataItemLink = "Document No." = FIELD("No.");
                RequestFilterFields = "Request for Quotation No.";
                column(VATAmount_BidAnalysisItems; "Bid Analysis Items"."VAT Amount")
                {

                }
                column(TotalCostIncVAT_BidAnalysisItems; "Bid Analysis Items"."Total Cost Inc. VAT")
                {
                }
                column(RequestforQuotationNo_BidAnalysisItems; "Request for Quotation No.")
                {
                }
                column(Line_No; "Line No")
                {
                }
                column(VendorNo_BidAnalysisItems; "Vendor No.")
                {
                }
                column(VendorName_BidAnalysisItems; "Vendor Name")
                {
                }
                column(ItemNo_BidAnalysisItems; "No.")
                {
                }
                column(Name_BidAnalysisItems; Description)
                {
                }
                column(Description_BidAnalysisItems; Description)
                {
                }
                column(Quantity_BidAnalysisItems; Quantity)
                {
                }
                column(UnitOfMeasure_BidAnalysisItems; "Unit Of Measure")
                {
                }
                column(UnitCost_BidAnalysisItems; "Unit Cost")
                {
                }
                column(TotalCost_BidAnalysisItems; "Total Cost Exc. VAT")
                {
                }
                column(Remarks_BidAnalysisItems; Remarks)
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
                    if Vendor.Get("Bid Analysis Items"."Vendor No.") then
                        VendorName := Vendor.Name;

                    CompanyInformation.Get;
                    CompanyInformation.CalcFields(Picture);
                    SelectedVendor := '';
                    BidAnalysisItems.Reset;
                    BidAnalysisItems.SetRange("Document No.", "Bid Analysis Header"."No.");
                    BidAnalysisItems.SetRange("No.", "Bid Analysis Items"."No.");
                    BidAnalysisItems.SetCurrentKey("No.", "Total Cost Exc. VAT");
                    BidAnalysisItems.Ascending(true);
                    if BidAnalysisItems.FindSet then begin
                        SelectedVendor := BidAnalysisItems."Vendor Name";
                    end;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = FILTER(Approved));
                column(DocumentType_ApprovalEntry; "Approval Entry"."Document Type")
                {
                }
                column(DocumentNo_ApprovalEntry; "Approval Entry"."Document No.")
                {
                }
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(ApprovalCode_ApprovalEntry; "Approval Entry"."Approval Code")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(SalespersPurchCode_ApprovalEntry; "Approval Entry"."Salespers./Purch. Code")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(Status_ApprovalEntry; "Approval Entry".Status)
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
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
    }

    trigger OnPreReport()
    begin
        CompanyInfO.Get;
        CompanyInfO.CalcFields(Picture);
    end;

    var
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
        BidAnalysisItems: Record "Bid Analysis Items";
        SelectedVendor: Text;
        Vendor: Record Vendor;
        CompanyInformation: Record "Company Information";
        VendorName: Text;
        CompanyInfO: Record "Company Information";
}

