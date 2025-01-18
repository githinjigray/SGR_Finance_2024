report 50005 "Imprest Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Imprest Voucher.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Imprest Header"; "Imprest Header")
        {
            // DataItemTableView = SORTING("Cheque Type");
            // RequestFilterFields = "Cheque Type";
            column(EmployeeTitle; EmployeeTitle)
            {
            }
            column(GlobalDimension1Code_ImprestHeader; "Imprest Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ImprestHeader; "Imprest Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_ImprestHeader; "Imprest Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_ImprestHeader; "Imprest Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_ImprestHeader; "Imprest Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_ImprestHeader; "Imprest Header"."Shortcut Dimension 6 Code")
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(No; "Imprest Header"."No.")
            {
            }
            column(ChequeNo; "Imprest Header"."Reference No.")
            {
            }
            column(Payee; "Imprest Header"."Employee Name")
            {
            }
            column(PaymentDate; "Imprest Header"."Posting Date")
            {
            }
            column(Bank; "Imprest Header"."Bank Account No.")
            {
            }
            column(BankName; "Imprest Header"."Bank Account Name")
            {
            }
            column(PhoneNo; "Imprest Header"."Phone No.")
            {
            }
            // column(Type_ImprestHeader;"Imprest Header".Type)
            // {
            // }
            column(Description_ImprestHeader; "Imprest Header".Description)
            {
            }
            column(DateFrom_ImprestHeader; "Imprest Header"."Date From")
            {
            }
            column(DateTo_ImprestHeader; "Imprest Header"."Date To")
            {
            }
            column(NumberText; NumberText[1])
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
            dataitem("Imprest Line"; "Imprest Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(InvoiceDate; "Posting Date")
                {
                }
                column(ImprestCode; "Imprest Line"."Imprest Code")
                {
                }
                column(Amount; "Imprest Line".Amount)
                {
                }
                column(AmountLCY; "Imprest Line"."Amount(LCY)")
                {
                }
                column(Description; "Imprest Line".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Bank.Get("Imprest Line"."Account No.") then begin
                        Payee := Bank.Name;
                    end;
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

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                "Imprest Header".CalcFields("Imprest Header".Amount);
                TotalAmount := "Imprest Header".Amount;
                // CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(NumberText, (TotalAmount), "Imprest Header"."Currency Code");

                if Bank.Get("Imprest Header"."Bank Account No.") then begin
                    BankName := Bank.Name;
                    BankAccountNo := Bank."Bank Account No.";
                end;


                Emp.Reset;
                Emp.SetRange(Emp."No.", "Imprest Header"."Employee No.");
                if Emp.FindFirst then begin
                    PreparedBy := Emp."First Name" + ' ' + Emp."Last Name";
                    //EmployeeTitle := Emp."HR Job Title"
                end;

                if "Imprest Header"."Currency Code" <> '' then
                    CurrencyCode := "Imprest Header"."Currency Code"
                else
                    CurrencyCode := 'KES';
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
        CurrencyCode: Code[20];
        InvoiceDate: Date;
        InvoiceNo: Code[50];
        TotalAmount: Decimal;
        PurchaseInvoice: Record "Purch. Inv. Header";
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        Vendor: Record Vendor;
        PostedInvoice: Record "Purch. Inv. Header";
        Payee: Text;
        EmployeeTitle: Text;
        Emp: Record Employee;
}

