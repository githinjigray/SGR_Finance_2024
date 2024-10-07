report 50106 "Reverse Bank Acc. Statement"
{
    // JC1.000 - J Chaloupka 07/11/18 Reverse Bank Account Statement
    //   Object created

    Caption = 'Reverse Bank Account Statement';
    Permissions = TableData "Bank Account" = rimd,
                  TableData "Bank Account Ledger Entry" = rimd,
                  TableData "Bank Acc. Reconciliation" = rimd,
                  TableData "Bank Acc. Reconciliation Line" = rimd,
                  TableData "Bank Account Statement" = rimd,
                  TableData "Bank Account Statement Line" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.");

            trigger OnAfterGetRecord()
            begin
                Open := true;
                "Statement Status" := "Statement Status"::"Bank Acc. Entry Applied";
                "Remaining Amount" := Amount;
                Modify;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Bank Account No.", BankAccountNo);
                SetRange("Statement No.", StatementNo);
                SetRange(Open, false);
                SetRange("Statement Status", "Bank Account Ledger Entry"."Statement Status"::Closed);
            end;
        }
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            DataItemTableView = SORTING("Bank Account No.", "Statement No.");
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = SORTING("Bank Account No.", "Statement No.", "Statement Line No.");

                trigger OnAfterGetRecord()
                var
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                begin
                    BankAccReconciliationLine.Init;
                    BankAccReconciliationLine.TransferFields("Bank Account Statement Line");
                    BankAccReconciliationLine.Insert;
                end;
            }

            trigger OnAfterGetRecord()
            var
                BankAccReconciliation: Record "Bank Acc. Reconciliation";
            begin
                BankAccReconciliation.Init;
                BankAccReconciliation.TransferFields("Bank Account Statement");
                BankAccReconciliation.Status := BankAccReconciliation.Status::Open;
                BankAccReconciliation.Insert;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Bank Account No.", BankAccountNo);
                SetRange("Statement No.", StatementNo);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(BankAccountNo; BankAccountNo)
                    {
                        Caption = 'Bank Account No.';
                        TableRelation = "Bank Account";
                        ApplicationArea = All;
                    }
                    field(StatementNo; StatementNo)
                    {
                        Caption = 'Statement No.';
                        ApplicationArea = All;
                    }
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

    trigger OnPostReport()
    begin
        if BankAccount.Get(BankAccountNo) then begin
            BankAccount."Last Statement No." := '';
            BankAccount."Balance Last Statement" := 0;
            BankAccount.Modify;
        end;

        if BankAccountStatement.Get(BankAccountNo, StatementNo) then
            BankAccountStatement.Delete(true);

        if GuiAllowed then
            Message(Text001);
    end;

    var
        BankAccount: Record "Bank Account";
        BankAccountStatement: Record "Bank Account Statement";
        BankAccountNo: Code[20];
        StatementNo: Code[20];
        Text001: Label 'Process finished.';
}

