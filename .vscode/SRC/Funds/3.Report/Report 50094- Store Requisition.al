report 50094 "Store Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Store Requisition.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Store Requisition Header"; "Store Requisition Header")
        {
            column(PreparedBy; PreparedBy)
            {
            }
            column(EmployeeTitle; EmployeeTitle)
            {
            }
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
            column(CBankName; CompanyInfo."Bank Name")
            {
            }
            column(CBankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CBankAccountNo; CompanyInfo."Bank Account No.")
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
            column(CompanyWebPage; CompanyInfo.Website)
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            column(IssuingOfficer; IssuingOfficer)
            {
            }
            column(Job_No_; "Job No.")
            {
            }
            column(Reference_No_; "Reference No.")
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
                column(QuantitytoIssue_StoreRequisitionLine; "Store Requisition Line"."Quantity to Issue")
                {
                }
                column(Unit_Cost; "Unit Cost")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(PartNo; PartNo)
                {
                }

                column(PartNo1; PartNo1)
                {
                }
                column(PartNo2; PartNo2)
                {
                }
                column(PartNo3; PartNo3)
                {
                }
                column(PartNo4; PartNo4)
                {
                }
                column(Lot_No_; "Lot No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    PartNo := '';
                    PartNo1 := '';
                    PartNo2 := '';
                    PartNo3 := '';
                    PartNo4 := 0;


                    PartNo := "Store Requisition Line"."Part No.";
                    PartNo1 := "Store Requisition Line"."Alternative Part No. 1";
                    PartNo2 := "Store Requisition Line"."Alternative Part No. 2";
                    PartNo3 := "Store Requisition Line"."Alternative Part No. 3";
                    PartNo4 := "Store Requisition Line"."Alternative Part No. 4";

                end;
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
                // HREmployee.Reset;
                // HREmployee.SetRange(HREmployee."User ID", "Store Requisition Header"."User ID");
                // if HREmployee.FindFirst then begin
                //     HrEmployeeName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                // end;


                PurchasesPayablesSetup.Get;

                // HREmployee.Reset;
                // HREmployee.SetRange(HREmployee."User ID", PurchasesPayablesSetup."User to replenish Stock");
                // if HREmployee.FindFirst then begin
                //     IssuingOfficer := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                // end;


                PreparedBy := '';
                EmployeeTitle := '';

                HREmployee.Reset;
                HREmployee.SetRange(HREmployee."No.", "Store Requisition Header"."Employee No.");
                if HREmployee.FindFirst then begin
                    PreparedBy := HREmployee."First Name" + ' ' + HREmployee."Last Name";
                    //EmployeeTitle := HREmployee."Job Title";
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
        PreparedBy: Text;
        EmployeeTitle: Text;
        ItemList: record Item;
        PartNo: code[100];
        PartNo1: code[100];
        PartNo2: code[100];
        PartNo3: code[100];
        PartNo4: Decimal;


}

