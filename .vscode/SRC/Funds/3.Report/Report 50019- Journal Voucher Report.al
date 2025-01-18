report 50019 "Journal Voucher Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Journal Voucher Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Journal Voucher Header"; "Journal Voucher Header")
        {
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
            column(PreparedBy; PreparedBy)
            {
            }
            column(JVNo_JournalVoucherHeader; "Journal Voucher Header"."JV No.")
            {
            }
            column(Documentdate_JournalVoucherHeader; "Journal Voucher Header"."Document date")
            {
            }
            column(PostingDate_JournalVoucherHeader; "Journal Voucher Header"."Posting Date")
            {
            }
            column(DateCreated_JournalVoucherHeader; "Journal Voucher Header"."Date Created")
            {
            }
            column(UserID_JournalVoucherHeader; "Journal Voucher Header"."User ID")
            {
            }
            column(Status_JournalVoucherHeader; "Journal Voucher Header".Status)
            {
            }
            column(Description_JournalVoucherHeader; "Journal Voucher Header".Description)
            {
            }
            column(JVLinesCont_JournalVoucherHeader; "Journal Voucher Header"."JV Lines Cont")
            {
            }
            column(TotalAmount_JournalVoucherHeader; "Journal Voucher Header"."Total Amount")
            {
            }
            column(NoSeries_JournalVoucherHeader; "Journal Voucher Header"."No. Series")
            {
            }
            column(Posted_JournalVoucherHeader; "Journal Voucher Header".Posted)
            {
            }
            column(TimePosted_JournalVoucherHeader; "Journal Voucher Header"."Time Posted")
            {
            }
            column(PostedBy_JournalVoucherHeader; "Journal Voucher Header"."Posted By")
            {
            }
            column(Reversed_JournalVoucherHeader; "Journal Voucher Header".Reversed)
            {
            }
            column(ReversalDate_JournalVoucherHeader; "Journal Voucher Header"."Reversal Date")
            {
            }
            column(ReversalTime_JournalVoucherHeader; "Journal Voucher Header"."Reversal Time")
            {
            }
            column(ReversedBy_JournalVoucherHeader; "Journal Voucher Header"."Reversed By")
            {
            }
            column(TotalDebits_JournalVoucherHeader; "Journal Voucher Header"."Total Debits")
            {
            }
            column(TotalCredits_JournalVoucherHeader; "Journal Voucher Header"."Total Credits")
            {
            }
            dataitem("Journal Voucher Lines"; "Journal Voucher Lines")
            {
                DataItemLink = "JV No." = FIELD("JV No.");
                column(JVNo_JournalVoucherLines; "Journal Voucher Lines"."JV No.")
                {
                }
                column(AccountName_JournalVoucherLines; "Journal Voucher Lines"."Account Name")
                {
                }
                column(BalAccountName_JournalVoucherLines; "Journal Voucher Lines"."Bal. Account Name")
                {
                }
                column(LineNo_JournalVoucherLines; "Journal Voucher Lines"."Line No.")
                {
                }
                column(AccountType_JournalVoucherLines; "Journal Voucher Lines"."Account Type")
                {
                }
                column(AccountNo_JournalVoucherLines; "Journal Voucher Lines"."Account No.")
                {
                }
                column(PostingDate_JournalVoucherLines; "Journal Voucher Lines"."Posting Date")
                {
                }
                column(DocumentType_JournalVoucherLines; "Journal Voucher Lines"."Document Type")
                {
                }
                column(DocumentNo_JournalVoucherLines; "Journal Voucher Lines"."Document No.")
                {
                }
                column(Description_JournalVoucherLines; "Journal Voucher Lines".Description)
                {
                }
                column(VAT_JournalVoucherLines; "Journal Voucher Lines"."VAT %")
                {
                }
                column(BalAccountNo_JournalVoucherLines; "Journal Voucher Lines"."Bal. Account No.")
                {
                }
                column(CurrencyCode_JournalVoucherLines; "Journal Voucher Lines"."Currency Code")
                {
                }
                column(Amount_JournalVoucherLines; "Journal Voucher Lines".Amount)
                {
                }
                column(DebitAmount_JournalVoucherLines; "Journal Voucher Lines"."Debit Amount")
                {
                }
                column(CreditAmount_JournalVoucherLines; "Journal Voucher Lines"."Credit Amount")
                {
                }
                column(AmountLCY_JournalVoucherLines; "Journal Voucher Lines"."Amount (LCY)")
                {
                }
                column(BalanceLCY_JournalVoucherLines; "Journal Voucher Lines"."Balance (LCY)")
                {
                }
                column(CurrencyFactor_JournalVoucherLines; "Journal Voucher Lines"."Currency Factor")
                {
                }
                column(ShortcutDimension1Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 2 Code")
                {
                }
                column(AppliestoDocType_JournalVoucherLines; "Journal Voucher Lines"."Applies-to Doc. Type")
                {
                }
                column(AppliestoDocNo_JournalVoucherLines; "Journal Voucher Lines"."Applies-to Doc. No.")
                {
                }
                column(BalAccountType_JournalVoucherLines; "Journal Voucher Lines"."Bal. Account Type")
                {
                }
                column(ExternalDocumentNo_JournalVoucherLines; "Journal Voucher Lines"."External Document No.")
                {
                }
                column(FAPostingDate_JournalVoucherLines; "Journal Voucher Lines"."FA Posting Date")
                {
                }
                column(FAPostingType_JournalVoucherLines; "Journal Voucher Lines"."FA Posting Type")
                {
                }
                column(DepreciationBookCode_JournalVoucherLines; "Journal Voucher Lines"."Depreciation Book Code")
                {
                }
                column(Description2_JournalVoucherLines; "Journal Voucher Lines".Description2)
                {
                }
                column(ShortcutDimension3Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 4 Code")
                {
                }
                column(ShortcutDimension5Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 5 Code")
                {
                }
                column(ShortcutDimension6Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 6 Code")
                {
                }
                column(ShortcutDimension7Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 7 Code")
                {
                }
                column(ShortcutDimension8Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 8 Code")
                {
                }
                column(PostingGroup_JournalVoucherLines; "Journal Voucher Lines"."Posting Group")
                {
                }
                column(Posted_JournalVoucherLines; "Journal Voucher Lines".Posted)
                {
                }
                column(DatePosted_JournalVoucherLines; "Journal Voucher Lines"."Date Posted")
                {
                }
                column(PostedBy_JournalVoucherLines; "Journal Voucher Lines"."Posted By")
                {
                }
                column(TimePosted_JournalVoucherLines; "Journal Voucher Lines"."Time Posted")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("JV No.");
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
                // HREmployee.Reset;
                // HREmployee.SetRange(HREmployee."User ID", "Journal Voucher Header"."User ID");
                // if HREmployee.FindFirst then begin
                //     PreparedBy := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
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
        PreparedBy: Text;
        HREmployee: Record Employee;
}

