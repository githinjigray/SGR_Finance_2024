report 50066 "Purchase Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Purchase Requisition.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Requisitions"; "Purchase Requisitions")
        {
            column(PRN_No; "Purchase Requisitions"."No.")
            {
            }
            column(Department; "Purchase Requisitions"."Global Dimension 1 Code")
            {
            }
            column(Purchase_Type; "Purchase Requisitions"."Purchase Type")
            {
            }
            column(Date; "Purchase Requisitions"."Document Date")
            {
            }
            column(EmployeeNo; "Purchase Requisitions"."No.")
            {
            }
            column(EmployeeName; "Purchase Requisitions"."No.")
            {
            }
            column(Description_PurchaseRequisitions; "Purchase Requisitions".Description)
            {
            }
            column(UserID_PurchaseRequisitionHeader; "Purchase Requisitions"."User ID")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(PrintDate; PrintDate)
            {
            }
            column(PrintTime; PrintTime)
            {
            }
            column(Status_PurchaseRequisitions; "Purchase Requisitions".Status)
            {
            }
            column(GlobalDimension1Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_PurchaseRequisitions; "Purchase Requisitions"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_PurchaseRequisitions; "Purchase Requisitions"."Shortcut Dimension 7 Code")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(EmployeeTitle; EmployeeTitle)
            {
            }
            column(RequestedReceiptDate_PurchaseRequisitions; "Purchase Requisitions"."Requested Receipt Date")
            {
            }
            column(DeliveryLocation; DeliveryLocation)
            {
            }
            dataitem("Purchase Requisition Line"; "Purchase Requisition Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Purchase Requisition Line"."No.")
                {
                }
                column(Description; "Purchase Requisition Line".Description)
                {
                }
                column(Remarks_PurchaseRequisitionLine; "Purchase Requisition Line".Remarks)
                {
                }
                column(Location_Codes; "Purchase Requisition Line"."Location Code")
                {
                }
                column(UnitofMeasure; "Purchase Requisition Line"."Unit of Measure")
                {
                }
                column(Quantity; "Purchase Requisition Line".Quantity)
                {
                }
                column(EstimatedUnitCost; "Purchase Requisition Line"."Estimated Unit Cost")
                {
                }
                column(EstimatedTotalCost; "Purchase Requisition Line"."Estimated Unit Cost" * "Purchase Requisition Line".Quantity)
                {
                }
                column(ActualCost; "Purchase Requisition Line"."Total Cost")
                {
                }
                column(TenderQuotationRef; "Purchase Requisition Line"."Document No.")
                {
                }
                column(RequisitionCode_PurchaseRequisitionLine; "Purchase Requisition Line"."Requisition Code")
                {
                }
                column(RequisitionType_PurchaseRequisitionLine; "Purchase Requisition Line"."Requisition Type")
                {
                }
                column(UnitofMeasure_PurchaseRequisitionLine; "Purchase Requisition Line"."Unit of Measure")
                {
                }
                column(Inventory_PurchaseRequisitionLine; "Purchase Requisition Line".Inventory)
                {
                }
                column(VATAmount; "Purchase Requisition Line"."VAT Amount")
                {
                }
                column(NetAmount; "Purchase Requisition Line"."Total Amount")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(r; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "Employee User ID" = FIELD("Approver ID");
                    column(EmployeeFirstName; Employee."First Name")
                    {
                    }
                    column(EmployeeMiddleName; Employee."Middle Name")
                    {
                    }
                    column(EmployeeLastName; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Signature")
                    {
                    }
                    column(JobTitle_Employee; Employee."Job Title")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                PreparedBy := '';
                EmployeeTitle := '';

                // Employees.Reset;
                // Employees.SetRange(Employees."No.", "Purchase Requisitions"."Employee No.");
                // if Employees.FindFirst then begin
                //     PreparedBy := Employees."First Name" + ' ' + Employees."Last Name";
                //     EmployeeTitle := Employees."HR Job Title";
                // end;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        PrintDate := Today;
        PrintTime := Time;
    end;

    var
        CompanyInfo: Record "Company Information";
        PrintDate: Date;
        PrintTime: Time;
        PreparedBy: Text;
        EmployeeTitle: Text;
        DeliveryLocation: Text;
        Employees: Record Employee;
}

