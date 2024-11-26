report 50047 "Bank Account Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Account Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
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
            column(RemainingAmount_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Remaining Amount")
            {
            }
            column(AmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Amount (LCY)")
            {
            }
            column(BankAccPostingGroup_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Acc. Posting Group")
            {
            }
            column(GlobalDimension1Code_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(OurContactCode_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Our Contact Code")
            {
            }
            column(UserID_BankAccountLedgerEntry; "Bank Account Ledger Entry"."User ID")
            {
            }
            column(SourceCode_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Source Code")
            {
            }
            column(Open_BankAccountLedgerEntry; "Bank Account Ledger Entry".Open)
            {
            }
            column(Positive_BankAccountLedgerEntry; "Bank Account Ledger Entry".Positive)
            {
            }
            column(ClosedbyEntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Closed by Entry No.")
            {
            }
            column(ClosedatDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Closed at Date")
            {
            }
            column(JournalBatchName_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Journal Batch Name")
            {
            }
            column(ReasonCode_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Reason Code")
            {
            }
            column(BalAccountType_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bal. Account Type")
            {
            }
            column(BalAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bal. Account No.")
            {
            }
            column(TransactionNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Transaction No.")
            {
            }
            column(StatementStatus_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement Status")
            {
            }
            column(StatementNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement No.")
            {
            }
            column(StatementLineNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement Line No.")
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
            column(DocumentDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Date")
            {
            }
            column(ExternalDocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."External Document No.")
            {
            }
            column(Reversed_BankAccountLedgerEntry; "Bank Account Ledger Entry".Reversed)
            {
            }
            column(ReversedbyEntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Reversed by Entry No.")
            {
            }
            column(ReversedEntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Reversed Entry No.")
            {
            }
            column(CheckLedgerEntries_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Check Ledger Entries")
            {
            }
            column(DimensionSetID_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Dimension Set ID")
            {
            }
            // column(Description2_BankAccountLedgerEntry;"Bank Account Ledger Entry".Description2)
            // {
            // }

            trigger OnAfterGetRecord()
            begin
                if BankAcountCode = '' then
                    Error('Bank Account Must me specified');

                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('StartDate/EndDate Must me specified');



                OpeningBalance := 0;
                ClosingBalance := 0;



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

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", BankAcountCode);
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", 0D, CalcDate('-1D', StartDate));
                if BankAccountLedgerEntry.FindSet then begin
                    repeat
                        OpeningBalance := OpeningBalance + BankAccountLedgerEntry.Amount;
                    until BankAccountLedgerEntry.Next = 0;
                end;

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", BankAcountCode);
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", 0D, EndDate);
                if BankAccountLedgerEntry.FindSet then begin
                    repeat
                        ClosingBalance := ClosingBalance + BankAccountLedgerEntry.Amount;
                    until BankAccountLedgerEntry.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry"."Posting Date", StartDate, EndDate);
                "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry"."Bank Account No.", BankAcountCode);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Bank Account"; BankAcountCode)
                {
                    TableRelation = "Bank Account";
                    ApplicationArea = All;
                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        BankName: Text;
        BankAccount: Record "Bank Account";
        DebitAmount: Text;
        CreditAmount: Text;
        StartDate: Date;
        EndDate: Date;
        BankAcountCode: Code[10];
        OpeningBalance: Decimal;
        ClosingBalance: Decimal;
        RunningBalance: Decimal;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
}

