report 50102 "PRF Details Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/PRF Details Report.rdlc';
    ApplicationArea = All;
    //ApplicationArea=all;
    dataset
    {
        dataitem("Purchase Requisition Line"; "Purchase Requisition Line")
        {
            RequestFilterFields = "Document No.", "Document Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code";
            column(DocumentDate_PurchaseRequisitionLine; "Purchase Requisition Line"."Document Date")
            {
            }
            column(RequisitionType_PurchaseRequisitionLine; "Purchase Requisition Line"."Requisition Type")
            {
            }
            column(RequisitionCode_PurchaseRequisitionLine; "Purchase Requisition Line"."Requisition Code")
            {
            }
            column(Quantity_PurchaseRequisitionLine; "Purchase Requisition Line".Quantity)
            {
            }
            column(DocumentNo_PurchaseRequisitionLine; "Purchase Requisition Line"."Document No.")
            {
            }
            column(EmployeeNo_PurchaseRequisitionLine; "Purchase Requisition Line"."Employee No.")
            {
            }
            column(EmployeeName_PurchaseRequisitionLine; "Purchase Requisition Line"."Employee Name")
            {
            }
            column(Description_PurchaseRequisitionLine; "Purchase Requisition Line".Description)
            {
            }
            column(UnitofMeasure_PurchaseRequisitionLine; "Purchase Requisition Line"."Unit of Measure")
            {
            }
            column(TotalCost_PurchaseRequisitionLine; "Purchase Requisition Line"."Total Cost")
            {
            }
            dataitem("Purchase Header Archive"; "Purchase Header Archive")
            {
                DataItemLink = "No." = FIELD("Purchase Order No.");
                DataItemTableView = WHERE("Version No." = FILTER(1));
                column(OrderDate_PurchaseHeaderArchive; "Purchase Header Archive"."Order Date")
                {
                }
                column(PostingDate_PurchaseHeaderArchive; "Purchase Header Archive"."Posting Date")
                {
                }
                column(No_PurchaseHeaderArchive; "Purchase Header Archive"."No.")
                {
                }
                column(PaytoName_PurchaseHeaderArchive; "Purchase Header Archive"."Pay-to Name")
                {
                }
                dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
                {
                    DataItemLink = "No." = FIELD("No.");
                    column(PaytoName_PurchInvHeader; "Purch. Inv. Header"."Pay-to Name")
                    {
                    }
                    column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
                    {
                    }
                    column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
                    {
                    }
                    column(OrderDate_PurchInvHeader; "Purch. Inv. Header"."Order Date")
                    {
                    }
                    column(PostingDate_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
                    {
                    }
                    column(PostingDescription_PurchInvHeader; "Purch. Inv. Header"."Posting Description")
                    {
                    }
                    column(Amount_PurchInvHeader; "Purch. Inv. Header".Amount)
                    {
                    }
                    column(AmountIncludingVAT_PurchInvHeader; "Purch. Inv. Header"."Amount Including VAT")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                //"Purchase Requisition Line"
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
        PurchaseHeader: Record "Purchase Header";
        PurchaseRequisitions: Record "Purchase Requisitions";
}

