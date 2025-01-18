report 50096 "Store Requisition Requests"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Store Requisition Requests.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Store Requisition Header"; "Store Requisition Header")
        {
            column(No_StoreRequisitionHeader; "Store Requisition Header"."No.")
            {
            }
            column(Requestdate_StoreRequisitionHeader; "Store Requisition Header"."Document Date")
            {
            }
            column(PostingDate_StoreRequisitionHeader; "Store Requisition Header"."Posting Date")
            {
            }
            column(RequiredDate_StoreRequisitionHeader; "Store Requisition Header"."Required Date")
            {
            }
            column(RequesterID_StoreRequisitionHeader; "Store Requisition Header"."Requester ID")
            {
            }
            column(TotalLineAmount_StoreRequisitionHeader; "Store Requisition Header".Amount)
            {
            }
            column(Description_StoreRequisitionHeader; "Store Requisition Header".Description)
            {
            }
            column(GlobalDimension1Code_StoreRequisitionHeader; "Store Requisition Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_StoreRequisitionHeader; "Store Requisition Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_StoreRequisitionHeader; "Store Requisition Header"."Shortcut Dimension 6 Code")
            {
            }
            column(HrEmployeeName; HrEmployeeName)
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
            column(IssuingOfficer; IssuingOfficer)
            {
            }
            dataitem("Store Requisition Line"; "Store Requisition Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(LineNo_StoreRequisitionLine; "Store Requisition Line"."Line No.")
                {
                }
                column(DocumentNo_StoreRequisitionLine; "Store Requisition Line"."Document No.")
                {
                }
                column(ItemNo_StoreRequisitionLine; "Store Requisition Line"."Item No.")
                {
                }
                column(LocationCode_StoreRequisitionLine; "Store Requisition Line"."Location Code")
                {
                }
                column(Inventory_StoreRequisitionLine; "Store Requisition Line".Inventory)
                {
                }
                column(Quantity_StoreRequisitionLine; "Store Requisition Line".Quantity)
                {
                }
                column(UnitofMeasureCode_StoreRequisitionLine; "Store Requisition Line"."Unit of Measure Code")
                {
                }
                column(Description_StoreRequisitionLine; "Store Requisition Line".Description)
                {
                }
                column(ItemDescription_StoreRequisitionLine; "Store Requisition Line"."Item Description")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                HREmployee.Reset;
                HREmployee.SetRange(HREmployee."Employee User ID", "Store Requisition Header"."User ID");
                if HREmployee.FindFirst then begin
                    HrEmployeeName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                end;


                // PurchasesPayablesSetup.Get;

                // HREmployee.Reset;
                // HREmployee.SetRange(HREmployee."User ID", PurchasesPayablesSetup."User to replenish Stock");
                // if HREmployee.FindFirst then begin
                //     IssuingOfficer := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
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
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        ApproverName: Text;
        IssuingOfficer: Text;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
}

