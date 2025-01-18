report 50048 "Cash Book Balance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Cash Book Balance Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.", "Bank Acc. Posting Group";
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
            column(No_BankAccount; "Bank Account"."No.")
            {
            }
            column(Name_BankAccount; "Bank Account".Name)
            {
            }
            column(SearchName_BankAccount; "Bank Account"."Search Name")
            {
            }
            column(BankAccountNo_BankAccount; "Bank Account"."Bank Account No.")
            {
            }
            column(Balance_BankAccount; BankBalance)
            {
            }
            column(GlobalDimension1Code_BankAccount; "Bank Account"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_BankAccount; "Bank Account"."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                BankBalance := 0;


                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('StartDate/EndDate Must me specified');


                BankAccountLedgerEntry.Reset;
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Bank Account No.", "Bank Account"."No.");
                BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Posting Date", StartDate, EndDate);
                if BankAccountLedgerEntry.FindSet then begin
                    BankAccountLedgerEntry.CalcSums(BankAccountLedgerEntry.Amount);
                    BankBalance := BankAccountLedgerEntry.Amount;
                end;
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
        BankBalance: Decimal;
}

