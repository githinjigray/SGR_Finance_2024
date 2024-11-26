report 50035 "Cash Position Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Cash Position Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            column(No_BankAccount; "Bank Account"."No.")
            {
            }
            column(Name_BankAccount; "Bank Account".Name)
            {
            }
            column(SearchName_BankAccount; "Bank Account"."Search Name")
            {
            }
            column(Name2_BankAccount; "Bank Account"."Name 2")
            {
            }
            column(BankAccountType_BankAccount; "Bank Account"."Bank Acc. Posting Group")
            {
            }
            column(Balance_BankAccount; "Bank Account".Balance)
            {
            }
            column(BalanceLCY_BankAccount; "Bank Account"."Balance (LCY)")
            {
            }
            column(BalanceStartDate; BalanceStartDate)
            {
            }
            column(BalanceEndDate; BalanceEndDate)
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
            column(StartDateNew; StartDateNew)
            {
            }
            column(EndDateNew; EndDateNew)
            {
            }
            column(TreasuryLoan; TreasuryLoan)
            {
            }
            column(TotalStartAmount; TotalStartAmount)
            {
            }
            column(TotalEndAmount; TotalEndAmount)
            {
            }
            column(TotalDebits; TotalDebits)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('The Start/End Date cannot be empty.');

                if EndDate < StartDate then
                    Error('The End Date cannot be earlier than the Start Date.');


                BalanceStartDate := 0;
                BalanceEndDate := 0;
                DebitAmount := 0;
                CreditAmount := 0;
                TotalCredits := 0;
                TotalDebits := 0;
                TotalEndAmount := 0;
                TotalStartAmount := 0;

                StartDateNew := StartDate;
                EndDateNew := EndDate;

                /*BankAccount.RESET;
                BankAccount.SETRANGE(BankAccount."No.","Bank Account"."No.");
                BankAccount.SETRANGE(BankAccount."Date Filter",0D,StartDate);
                IF BankAccount.FINDFIRST THEN BEGIN
                  BankAccount.CALCFIELDS(BankAccount."Balance (LCY)");
                  BalanceStartDate:=BankAccount."Balance (LCY)";
                END;
                
                
                BankAccount.RESET;
                BankAccount.SETRANGE(BankAccount."No.","Bank Account"."No.");
                BankAccount.SETRANGE(BankAccount."Date Filter",StartDate,EndDate);
                IF BankAccount.FINDFIRST THEN BEGIN
                  BankAccount.CALCFIELDS(BankAccount."Balance (LCY)");
                  BalanceEndDate:=BankAccount."Balance (LCY)";
                END;
                */


                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", "Bank Account"."No.");
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", 0D, StartDate);
                if BankAccountLedgerEntry.FindFirst then begin
                    repeat
                        BalanceStartDate := BalanceStartDate + BankAccountLedgerEntry."Amount (LCY)";
                    until BankAccountLedgerEntry.Next = 0;
                end;

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", "Bank Account"."No.");
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", 0D, EndDate);
                if BankAccountLedgerEntry.FindFirst then begin
                    repeat
                        BalanceEndDate := BalanceEndDate + BankAccountLedgerEntry."Amount (LCY)";
                    until BankAccountLedgerEntry.Next = 0;
                end;

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", "Bank Account"."No.");
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", StartDate, EndDate);
                BankAccountLedgerEntry.SetFilter(BankAccountLedgerEntry."Amount (LCY)", '<%1', 0);
                if BankAccountLedgerEntry.FindFirst then begin
                    repeat
                        CreditAmount := CreditAmount + BankAccountLedgerEntry."Amount (LCY)";
                    until BankAccountLedgerEntry.Next = 0;
                end;

                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", "Bank Account"."No.");
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", StartDate, EndDate);
                BankAccountLedgerEntry.SetFilter(BankAccountLedgerEntry."Amount (LCY)", '>%1', 0);
                if BankAccountLedgerEntry.FindFirst then begin
                    repeat
                        DebitAmount := DebitAmount + BankAccountLedgerEntry."Amount (LCY)";
                    until BankAccountLedgerEntry.Next = 0;
                end;

                TreasuryLoan := TreasuryLoan * -1;


                // ======================================= get totals =================================

                BankAccount.Reset;
                //BankAccount.SetFilter(BankAccount."Bank Account Type",'%1|%2|%3|%4|%5',0,2,3,4,5);
                if BankAccount.FindSet then begin
                    repeat
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", BankAccount."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", 0D, StartDate);
                        if BankAccountLedgerEntry.FindFirst then begin
                            repeat
                                TotalStartAmount := TotalStartAmount + BankAccountLedgerEntry."Amount (LCY)";
                            until BankAccountLedgerEntry.Next = 0;
                        end;
                    until BankAccount.Next = 0;
                end;


                BankAccount.Reset;
                //BankAccount.SetFilter(BankAccount."Bank Account Type",'%1|%2|%3|%4|%5',0,2,3,4,5);
                if BankAccount.FindSet then begin
                    repeat
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", BankAccount."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", 0D, EndDate);
                        if BankAccountLedgerEntry.FindFirst then begin
                            repeat
                                TotalEndAmount := TotalEndAmount + BankAccountLedgerEntry."Amount (LCY)";
                            until BankAccountLedgerEntry.Next = 0;
                        end;
                    until BankAccount.Next = 0;
                end;
                //==================================
                BankAccount.Reset;
                // BankAccount.SetFilter(BankAccount."Bank Account Type",'%1|%2|%3|%4|%5',0,2,3,4,5);
                if BankAccount.FindSet then begin
                    repeat
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", BankAccount."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", StartDate, EndDate);
                        BankAccountLedgerEntry.SetFilter(BankAccountLedgerEntry."Amount (LCY)", '>%1', 0);
                        if BankAccountLedgerEntry.FindFirst then begin
                            repeat
                                TotalDebits := TotalDebits + BankAccountLedgerEntry."Amount (LCY)";
                            until BankAccountLedgerEntry.Next = 0;
                        end;
                    until BankAccount.Next = 0;
                end;


                BankAccount.Reset;
                //BankAccount.SetFilter(BankAccount."Bank Account Type",'%1|%2|%3|%4|%5',0,2,3,4,5);
                if BankAccount.FindSet then begin
                    repeat
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", BankAccount."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", StartDate, EndDate);
                        BankAccountLedgerEntry.SetFilter(BankAccountLedgerEntry."Amount (LCY)", '<%1', 0);
                        if BankAccountLedgerEntry.FindFirst then begin
                            repeat
                                TotalCredits := TotalCredits + BankAccountLedgerEntry."Amount (LCY)";
                            until BankAccountLedgerEntry.Next = 0;
                        end;
                    until BankAccount.Next = 0;
                end;

            end;

            trigger OnPreDataItem()
            begin
                //\"Bank Account".GETFILTER("Bank Account"."Date Filter");
                //\"Bank Account".SETFILTER("Bank Account"."Date Filter",'%1..%2',0D,StartDate);
                //GLFilter := "Bank Account".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                }
                field("Treasury Loan"; TreasuryLoan)
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
        StartDate: Date;
        EndDate: Date;
        StartDateNew: Date;
        EndDateNew: Date;
        BalanceStartDate: Decimal;
        BalanceEndDate: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccount: Record "Bank Account";
        GLFilter: Text;
        TreasuryLoan: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;
        TotalStartAmount: Decimal;
        TotalEndAmount: Decimal;
}

