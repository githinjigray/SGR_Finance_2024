report 50034 "Employee Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Employee Statement.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(GlobalDimension1Code_Employee; Employee."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Employee; Employee."Global Dimension 2 Code")
            {
            }
            // column(ShortcutDimension3Code_Employee; Employee."Shortcut Dimension 3 Code")
            // {
            // }
            // column(ShortcutDimension4Code_Employee; Employee."Shortcut Dimension 4 Code")
            // {
            // }
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
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                column(EmployeeNo_EmployeeLedgerEntry; "Customer No.")
                {
                }
                column(PostingDate_EmployeeLedgerEntry; "Posting Date")
                {
                }
                column(DocumentType_EmployeeLedgerEntry; "Document Type")
                {
                }
                column(DocumentNo_EmployeeLedgerEntry; "Document No.")
                {
                }
                column(Description_EmployeeLedgerEntry; Description)
                {
                }
                column(CurrencyCode_EmployeeLedgerEntry; "Currency Code")
                {
                }
                column(Amount_EmployeeLedgerEntry; Amount)
                {
                }
                column(DebitAmountLCY_EmployeeLedgerEntry; "Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_EmployeeLedgerEntry; "Credit Amount (LCY)")
                {
                }
                column(RunningAmount; RunningAmount)
                {
                }
                column(DebitAmountText; DebitAmountText)
                {
                }
                column(CreditAmountText; CreditAmountText)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Amount (LCY)");
                    RunningAmount := RunningAmount + "Cust. Ledger Entry"."Amount (LCY)";
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverName; ApproverName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // HREmployee.Reset;
                    // HREmployee.SetRange(HREmployee."User ID", "Approval Entry"."Approver ID");
                    // if HREmployee.FindFirst then begin
                    //     ApproverName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                    // end;
                end;
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

    trigger OnInitReport()
    begin
        RunningAmount := 0;
    end;

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
        DebitAmountText: Text;
        CreditAmountText: Text;
        RunningAmount: Decimal;
}

