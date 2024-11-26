report 50021 "Daily Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Daily Summary.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter";
            column(No_BankAccount; "Bank Account"."No.")
            {
            }
            column(Name_BankAccount; "Bank Account".Name)
            {
            }
            column(DateFilter_BankAccount; "Bank Account"."Date Filter")
            {
            }
            column(BankAccPostingGroup_BankAccount; "Bank Account"."Bank Acc. Posting Group")
            {
            }
            column(MinBalance_BankAccount; "Bank Account"."Min. Balance")
            {
            }
            column(OpBal; OpBal)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(BankAccBalance; BankAccBalance)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = WHERE(Reversed = CONST(false));
                RequestFilterFields = "User ID";
                column(EntryNo; "Bank Account Ledger Entry"."Entry No.")
                {
                }
                column(UserID; "Bank Account Ledger Entry"."User ID")
                {
                }
                column(PostingDate; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Description; "Bank Account Ledger Entry".Description)
                {
                }
                column(Amount; "Bank Account Ledger Entry".Amount)
                {
                }
                column(BalAccountNo; "Bank Account Ledger Entry"."Bal. Account No.")
                {
                }
                column(DocumentType; "Bank Account Ledger Entry"."Document Type")
                {
                }
                column(Cheque_No; "Bank Account Ledger Entry"."External Document No.")
                {
                }
                column(PayeeName; PayeeName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not PrintReversedEntries and Reversed then
                        CurrReport.Skip;
                    BankAccLedgEntryExists := true;
                    BankAccBalance := BankAccBalance + Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)";

                    /*IF "Bank Account Ledger Entry".Amount<0 THEN
                    "Bank Account Ledger Entry".Amount:="Bank Account Ledger Entry".Amount*-1;*/

                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := false;
                    // CurrReport.CreateTotals(Amount,"Amount (LCY)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                if DateFilter_BankAccount <> '' then
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change", "Net Change (LCY)");
                        StartBalance := "Net Change";
                        StartBalanceLCY := "Net Change (LCY)";
                        SetFilter("Date Filter", DateFilter_BankAccount);
                    end;
                // CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;
                OpBal := StartBalance;

                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                //CurrReport.CreateTotals("Bank Account Ledger Entry"."Amount (LCY)",StartBalanceLCY);
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

    trigger OnInitReport()
    begin
        PageGroupNo := 1;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        BankAccFilter := "Bank Account".GetFilters;
        DateFilter_BankAccount := "Bank Account".GetFilter("Date Filter");
    end;

    var
        CompanyInfo: Record "Company Information";
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text[250];
        DateFilter_BankAccount: Text[30];
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        MinDate: Date;
        OpBal: Decimal;
        BankAcc: Record "Bank Account";
        ReceiptHeader: Record "Receipt Header";
        PayMode: Option " ",Cash,Cheque,"Deposit Slip",EFT,"Bankers Cheque",RTGS,"M-Pesa",PDQ;
        PayeeName: Text;
        ImprestHeader: Record "Imprest Header";
        JournalVoucherHeader: Record "Journal Voucher Header";
        PaymentHeader: Record "Payment Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
}

