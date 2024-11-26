report 50044 "Bank Ledger Buffer"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Ledger Buffer.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {

            trigger OnAfterGetRecord()
            begin
                BankLedgerBuffer.Reset;
                BankLedgerBuffer.SetRange(BankLedgerBuffer."Entry No.", "Bank Account Ledger Entry"."Entry No.");
                if not BankLedgerBuffer.FindFirst then begin

                    BufferBankLedgerBuffer.Init;
                    BufferBankLedgerBuffer."Entry No." := "Bank Account Ledger Entry"."Entry No.";
                    BufferBankLedgerBuffer."Bank Account No." := "Bank Account Ledger Entry"."Bank Account No.";
                    BufferBankLedgerBuffer."Posting Date" := "Bank Account Ledger Entry"."Posting Date";
                    BufferBankLedgerBuffer."Document No." := "Bank Account Ledger Entry"."Document No.";
                    // BufferBankLedgerBuffer."Document Type":="Bank Account Ledger Entry"."Document Type";
                    BufferBankLedgerBuffer.Amount := "Bank Account Ledger Entry".Amount;
                    BufferBankLedgerBuffer."Currency Code" := "Bank Account Ledger Entry"."Currency Code";
                    BufferBankLedgerBuffer.Description := "Bank Account Ledger Entry".Description;
                    BufferBankLedgerBuffer."Bank Acc. Posting Group" := "Bank Account Ledger Entry"."Bank Acc. Posting Group";
                    BufferBankLedgerBuffer."Debit Amount" := "Bank Account Ledger Entry"."Debit Amount";
                    BufferBankLedgerBuffer."Credit Amount" := "Bank Account Ledger Entry"."Credit Amount";
                    BufferBankLedgerBuffer.Insert

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
        BankLedgerBuffer: Record "Bank Ledger Buffer";
        BufferBankLedgerBuffer: Record "Bank Ledger Buffer";
}

