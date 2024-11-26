report 50037 "Payments and Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Payments and Receipts.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Bank Account No.";
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
            column(PAYEENAME; PAYEENAME)
            {
            }
            column(REFFERENCENUMBER; REFFERENCENUMBER)
            {
            }
            column(BANKNAME; BANKNAME)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //IF "Bank Account Ledger Entry"."Posting Date" IN[StartDate..EndDate] THEN
                // CurrReport.SKIP
                //"Bank Account Ledger Entry".SETRANGE("Bank Account Ledger Entry"."Posting Date",StartDate,EndDate);
                PAYEENAME := '';
                BANKNAME := '';
                REFFERENCENUMBER := '';


                if BankAccount.Get("Bank Account Ledger Entry"."Bank Account No.") then
                    BANKNAME := BankAccount.Name;


                if PaymentHeader.Get("Bank Account Ledger Entry"."Document No.") then begin
                    REFFERENCENUMBER := PaymentHeader."Cheque No.";
                    if REFFERENCENUMBER = '' then
                        REFFERENCENUMBER := PaymentHeader."Reference No.";
                end;


                if ReceiptHeader.Get("Bank Account Ledger Entry"."Document No.") then begin
                    REFFERENCENUMBER := ReceiptHeader."Reference No.";
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

    var
        StartDate: Date;
        EndDate: Date;
        PAYEENAME: Text;
        REFFERENCENUMBER: Code[30];
        BANKNAME: Text;
        BankAccount: Record "Bank Account";
        PaymentHeader: Record "Payment Header";
        ReceiptHeader: Record "Receipt Header";
}

