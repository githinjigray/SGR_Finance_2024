report 50046 "Cash Book Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Cash Book Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = WHERE(Reversed = CONST(false));
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
            column(BankAcountCode; BankAcountCode)
            {
            }
            column(DebitAmount; DebitAmount)
            {
            }
            column(CreditAmount; CreditAmount)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(RunningBalance; RunningBalance)
            {
            }
            column(BankName; BankName)
            {
            }
            column(ClosingBalance; ClosingBalance)
            {
            }
            column(OpeningBalance; OpeningBalance)
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
        StartDate: Date;
        EndDate: Date;
        BankAcountCode: Code[10];
        OpeningBalance: Decimal;
        ClosingBalance: Decimal;
        RunningBalance: Decimal;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
}

