report 50006 "Imprest Surrender Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Imprest Surrender Voucher.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Imprest Surrender Header"; "Imprest Surrender Header")
        {
            column(GlobalDimension1Code_ImprestSurrenderHeader; "Imprest Surrender Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ImprestSurrenderHeader; "Imprest Surrender Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_ImprestSurrenderHeader; "Imprest Surrender Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_ImprestSurrenderHeader; "Imprest Surrender Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_ImprestSurrenderHeader; "Imprest Surrender Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_ImprestSurrenderHeader; "Imprest Surrender Header"."Shortcut Dimension 6 Code")
            {
            }
            column(EmployeeTitle; EmployeeTitle)
            {
            }
            column(No; "Imprest Surrender Header"."No.")
            {
            }
            column(ImprestNo; "Imprest Surrender Header"."Imprest No.")
            {
            }
            column(Payee; "Imprest Surrender Line"."Account Name")
            {
            }
            column(EmployeeName_ImprestSurrenderHeader; "Imprest Surrender Header"."Employee Name")
            {
            }
            column(PaymentDate; "Imprest Surrender Header"."Posting Date")
            {
            }
            column(NumberText; NumberText[1])
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
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(PayeeAddress; PayeeAddress)
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(CheckedBy; CheckedBy)
            {
            }
            column(AuthorisedBy; AuthorizedBy)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(ActualSpent_ImprestSurrenderHeader; "Imprest Surrender Header"."Actual Spent")
            {
            }
            column(Difference_ImprestSurrenderHeader; "Imprest Surrender Header".Difference)
            {
            }
            column(Amount_ImprestSurrenderHeader; "Imprest Surrender Header".Amount)
            {
            }
            column(CashReceiptAmount_ImprestSurrenderHeader; "Imprest Surrender Header"."Cash Receipt Amount")
            {
            }
            column(PayeeEMP; PayeeEMP)
            {
            }
            dataitem("Imprest Surrender Line"; "Imprest Surrender Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(InvoiceDate; "Imprest Surrender Line"."Posting Date")
                {
                }
                column(ImprestCode; "Imprest Surrender Line"."Imprest Code")
                {
                }
                column(Amount; "Imprest Surrender Line"."Amount Advanced")
                {
                }
                column(AmountLCY; "Imprest Surrender Line"."Amount Advanced (LCY)")
                {
                }
                column(Description; "Imprest Surrender Line".Description)
                {
                }
                column(ActualSpent_ImprestSurrenderLine; "Imprest Surrender Line"."Actual Spent")
                {
                }
                column(Difference_ImprestSurrenderLine; "Imprest Surrender Line".Difference)
                {
                }
                column(CashReceipt_ImprestSurrenderLine; "Imprest Surrender Line"."Cash Receipt")
                {
                }
                column(Overpayment_ImprestSurrenderLine; "Imprest Surrender Line".Overpayment)
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
                    // DataItemLink = "Employee User ID" = FIELD("Approver ID");
                    // column(EmployeeFirstName; Employee."First Name")
                    // {
                    // }
                    // column(EmployeeMiddleName; Employee."Middle Name")
                    // {
                    // }
                    // column(EmployeeLastName; Employee."Last Name")
                    // {
                    // }
                    // column(EmployeeSignature; Employee."Signature")
                    // {
                    // }
                    // column(JobTitle_Employee; Employee."Job Title")
                    // {
                    // }
                }
            }

            trigger OnPreDataItem()
            begin
                // Emp.Reset;
                // Emp.SetRange(Emp."User ID", "Imprest Surrender Header"."User ID");
                // if Emp.FindFirst then
                //     PayeeEMP := Emp."First Name" + ' ' + Emp."Last Name";


                // Emp.Reset;
                // Emp.SetRange(Emp."No.", "Imprest Surrender Header"."Employee No.");
                // if Emp.FindFirst then begin
                //     PreparedBy := Emp."First Name" + ' ' + Emp."Last Name";
                //     EmployeeTitle := Emp."HR Job Title";
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
    end;

    var
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        CompanyInfo: Record "Company Information";
        Bank: Record "Bank Account";
        BankAccountNo: Code[20];
        BankName: Text[100];
        PayeeAddress: Text[100];
        InvoiceDate: Date;
        InvoiceNo: Code[50];
        TotalAmount: Decimal;
        ImprestSurrender: Record "Imprest Surrender Header";
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        Emp: Record Employee;
        PostedImp: Record "Imprest Header";
        Payee: Text;
        PayeeEMP: Text;
        EmployeeTitle: Text;
}

