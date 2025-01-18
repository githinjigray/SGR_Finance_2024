report 50020 "Bank Transactions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Transactions Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.", "Date Filter";
            column(No_BankAccount; "Bank Account"."No.")
            {
            }
            column(Name_BankAccount; "Bank Account".Name)
            {
            }
            column(BankAccountType_BankAccount; "Bank Account"."Bank Acc. Posting Group")
            {
            }
            column(Balance_BankAccount; "Bank Account".Balance)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter");
                RequestFilterFields = "Posting Date", "Document No.", "External Document No.", "User ID";
                column(EntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Entry No.")
                {
                }
                column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.")
                {
                }
                column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentType_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry; "Bank Account Ledger Entry".Description)
                {
                }
                column(CurrencyCode_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Currency Code")
                {
                }
                column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
                {
                }
                column(DebitAmount_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Debit Amount")
                {
                }
                column(CreditAmount_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Credit Amount")
                {
                }
                column(DebitAmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."External Document No.")
                {
                }
                column(UserID_BankAccountLedgerEntry; "Bank Account Ledger Entry"."User ID")
                {
                }
                column(DebitAmount; DebitAmount)
                {
                }
                column(CreditAmount; CreditAmount)
                {
                }
                column(BankName; BankName)
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
                dataitem("Approval Entry"; "Approval Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
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
                    if BankAccount.Get("Bank Account Ledger Entry"."Bank Account No.") then
                        BankName := BankAccount.Name;

                    if "Bank Account Ledger Entry"."Debit Amount (LCY)" <> 0 then begin
                        DebitAmount := Format("Bank Account Ledger Entry"."Debit Amount (LCY)")
                    end else begin
                        DebitAmount := '';
                    end;

                    if "Bank Account Ledger Entry"."Credit Amount (LCY)" <> 0 then begin
                        CreditAmount := Format("Bank Account Ledger Entry"."Credit Amount (LCY)");
                    end else begin
                        CreditAmount := '';
                    end;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        BankName: Text;
        BankAccount: Record "Bank Account";
        DebitAmount: Text;
        CreditAmount: Text;
}

