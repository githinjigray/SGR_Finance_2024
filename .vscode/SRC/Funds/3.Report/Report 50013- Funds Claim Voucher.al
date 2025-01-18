report 50013 "Funds Claim Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Funds Claim Voucher.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Funds Claim Header"; "Funds Claim Header")
        {
            // DataItemTableView = SORTING("Cheque Type");
            RequestFilterFields = "Cheque Type";
            column(No; "No.")
            {
            }
            column(ChequeNo; "Reference No.")
            {
            }
            column(Payee; "Funds Claim Header"."Payee Name")
            {
            }
            column(PaymentDate; "Posting Date")
            {
            }
            column(Bank; "Bank Account No.")
            {
            }
            column(BankName; "Bank Account Name")
            {
            }
            column(PhoneNo; "Funds Claim Header"."Currency Code")
            {
            }
            column(Type_ImprestHeader; "Funds Claim Header".Status)
            {
            }
            column(Description_ImprestHeader; Description)
            {
            }
            column(DateFrom_ImprestHeader; "Funds Claim Header"."Date Posted")
            {
            }
            column(DateTo_ImprestHeader; "Funds Claim Header"."Date Posted")
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
            dataitem("Funds Claim Line"; "Funds Claim Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(InvoiceDate; "Posting Date")
                {
                }
                column(ImprestCode; "Funds Claim Line"."Funds Claim Code")
                {
                }
                column(Amount; Amount)
                {
                }
                column(AmountLCY; "Amount(LCY)")
                {
                }
                column(Description; Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Bank.Get("Funds Claim Line"."Account No.") then begin
                        Payee := Bank.Name;
                    end;
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
                }
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;

                "Funds Claim Header".CalcFields("Funds Claim Header".Amount);
                TotalAmount := "Funds Claim Header".Amount;
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, (TotalAmount), "Funds Claim Header"."Currency Code");

                if Bank.Get("Funds Claim Header"."Bank Account No.") then begin
                    BankName := Bank.Name;
                    BankAccountNo := Bank."Bank Account No.";
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
        PurchaseInvoice: Record "Purch. Inv. Header";
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        Vendor: Record Vendor;
        PostedInvoice: Record "Purch. Inv. Header";
        Payee: Text;
}

