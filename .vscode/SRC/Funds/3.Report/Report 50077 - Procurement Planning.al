report 50077 "Procurement Planning"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Procurement Planning.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Procurement Planning Header"; "Procurement Planning Header")
        {
            column(PreparedBy; PreparedBy)
            {
            }
            column(EmployeeTitle; EmployeeTitle)
            {
            }
            column(FromDate_ProcurementPlanningHeader; "Procurement Planning Header"."From Date")
            {
            }
            column(ToDate_ProcurementPlanningHeader; "Procurement Planning Header"."To Date")
            {
            }
            column(No_ProcurementPlanningHeader; "Procurement Planning Header"."No.")
            {
            }
            column(Name_ProcurementPlanningHeader; "Procurement Planning Header".Name)
            {
            }
            column(FinancialYear_ProcurementPlanningHeader; "Procurement Planning Header"."Financial Year")
            {
            }
            column(DocumentDate_ProcurementPlanningHeader; "Procurement Planning Header"."Document Date")
            {
            }
            column(Budget_ProcurementPlanningHeader; "Procurement Planning Header".Budget)
            {
            }
            column(BudgetDescription_ProcurementPlanningHeader; "Procurement Planning Header"."Budget Description")
            {
            }
            column(UserID_ProcurementPlanningHeader; "Procurement Planning Header"."User ID")
            {
            }
            column(NoSeries_ProcurementPlanningHeader; "Procurement Planning Header"."No. Series")
            {
            }
            column(GlobalDimension1Code_ProcurementPlanningHeader; "Procurement Planning Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ProcurementPlanningHeader; "Procurement Planning Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_ProcurementPlanningHeader; "Procurement Planning Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_ProcurementPlanningHeader; "Procurement Planning Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_ProcurementPlanningHeader; "Procurement Planning Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_ProcurementPlanningHeader; "Procurement Planning Header"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_ProcurementPlanningHeader; "Procurement Planning Header"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_ProcurementPlanningHeader; "Procurement Planning Header"."Shortcut Dimension 8 Code")
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
            dataitem("Procurement Planning Line"; "Procurement Planning Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(LN; LN)
                {
                }
                column(DocumentNo_ProcurementPlanningLine; "Procurement Planning Line"."Document No.")
                {
                }
                column(LineNo_ProcurementPlanningLine; "Procurement Planning Line"."Line No.")
                {
                }
                column(Type_ProcurementPlanningLine; "Procurement Planning Line".Type)
                {
                }
                column(No_ProcurementPlanningLine; "Procurement Planning Line"."No.")
                {
                }
                column(Description_ProcurementPlanningLine; "Procurement Planning Line".Description)
                {
                }
                column(Description2_ProcurementPlanningLine; "Procurement Planning Line"."Description 2")
                {
                }
                column(UnitofMeasure_ProcurementPlanningLine; "Procurement Planning Line"."Unit of Measure")
                {
                }
                column(Quantity_ProcurementPlanningLine; "Procurement Planning Line".Quantity)
                {
                }
                column(ProcurementMethod_ProcurementPlanningLine; "Procurement Planning Line"."Procurement Method")
                {
                }
                column(SourceofFunds_ProcurementPlanningLine; "Procurement Planning Line"."Source of Funds")
                {
                }
                column(Estimatedcost_ProcurementPlanningLine; "Procurement Planning Line"."Estimated cost")
                {
                }
                column(TimeProcess_ProcurementPlanningLine; "Procurement Planning Line"."Time Process")
                {
                }
                column(InviteAdvertiseTender_ProcurementPlanningLine; "Procurement Planning Line"."Invite/Advertise Tender")
                {
                }
                column(OpenTenderDate_ProcurementPlanningLine; "Procurement Planning Line"."Open Tender Date")
                {
                }
                column(EvaluateTenderDate_ProcurementPlanningLine; "Procurement Planning Line"."Evaluate Tender Date")
                {
                }
                column(CommitteeAwardApprovalDate_ProcurementPlanningLine; "Procurement Planning Line"."Committee Award Approval Date")
                {
                }
                column(NotificationofAwardDate_ProcurementPlanningLine; "Procurement Planning Line"."Notification of Award Date")
                {
                }
                column(ContractSigningDate_ProcurementPlanningLine; "Procurement Planning Line"."Contract Signing Date")
                {
                }
                column(TotaltimetoContractsign_ProcurementPlanningLine; "Procurement Planning Line"."Total time to Contract sign")
                {
                }
                column(TimeofCompletionofContract_ProcurementPlanningLine; "Procurement Planning Line"."Time of Completion of Contract")
                {
                }
                column(OpenTenderDays_ProcurementPlanningLine; "Procurement Planning Line"."Open Tender Days")
                {
                }
                column(EvaluateTenderDays_ProcurementPlanningLine; "Procurement Planning Line"."Expected Date of Delivery")
                {
                }
                column(CommitteeAwardApprovalDays_ProcurementPlanningLine; "Procurement Planning Line"."Committee Award Approval Days")
                {
                }
                column(NotificationofAwardDays_ProcurementPlanningLine; "Procurement Planning Line"."Notification of Award Days")
                {
                }
                column(ContractSigningDays_ProcurementPlanningLine; "Procurement Planning Line"."Contract Signing Days")
                {
                }
                column(GlobalDimension1Code_ProcurementPlanningLine; "Procurement Planning Line"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_ProcurementPlanningLine; "Procurement Planning Line"."Global Dimension 2 Code")
                {
                }
                column(ShortcutDimension3Code_ProcurementPlanningLine; "Procurement Planning Line"."Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_ProcurementPlanningLine; "Procurement Planning Line"."Shortcut Dimension 4 Code")
                {
                }
                column(ShortcutDimension5Code_ProcurementPlanningLine; "Procurement Planning Line"."Shortcut Dimension 5 Code")
                {
                }
                column(ShortcutDimension6Code_ProcurementPlanningLine; "Procurement Planning Line"."Shortcut Dimension 6 Code")
                {
                }
                column(ShortcutDimension7Code_ProcurementPlanningLine; "Procurement Planning Line"."Shortcut Dimension 7 Code")
                {
                }
                column(ShortcutDimension8Code_ProcurementPlanningLine; "Procurement Planning Line"."Shortcut Dimension 8 Code")
                {
                }
                column(ResponsibilityCenter_ProcurementPlanningLine; "Procurement Planning Line"."Responsibility Center")
                {
                }
                column(ProcurementPlanType_ProcurementPlanningLine; "Procurement Planning Line"."Procurement Plan Type")
                {
                }
                column(ProcurementPlanGrouTINg_ProcurementPlanningLine; "Procurement Planning Line"."Procurement Plan GrouTINg")
                {
                }
                column(GLBudgetLineAC_ProcurementPlanningLine; "Procurement Planning Line"."G/L Budget Line A/C")
                {
                }
                column(BudgetAmount_ProcurementPlanningLine; "Procurement Planning Line"."Budget Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LN := LN + 1;
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
                PreparedBy := '';
                EmployeeTitle := '';

                // Employees.Reset;
                // Employees.SetRange(Employees."User ID", "Procurement Planning Header"."User ID");
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
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        LN: Integer;
        PreparedBy: Text;
        EmployeeTitle: Text;
        Employees: Record Employee;
}

