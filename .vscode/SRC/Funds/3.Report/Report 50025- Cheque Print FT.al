report 50025 "Cheque Print FT"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Cheque Print FT.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Funds Transfer Header"; "Funds Transfer Header")
        {
            column(Payee; "Funds Transfer Header".Payee)
            {
            }
            column(BankAccountName; "Funds Transfer Header"."Bank Account Name")
            {
            }
            column(PayDate; "Funds Transfer Header"."Posting Date")
            {
            }
            column(Amount; "Funds Transfer Header"."Amount To Transfer")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(PayeeName_PaymentHeader; "Funds Transfer Header".Description)
            {
            }
            dataitem("Funds Transfer Line"; "Funds Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(AccountNo_FundsTransferLine; "Funds Transfer Line"."Account No.")
                {
                }
                column(AccountName_FundsTransferLine; "Funds Transfer Line"."Account Name")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                "Funds Transfer Header"."Bank Account Name" := UpperCase("Funds Transfer Header"."Bank Account Name");
                //CALCFIELDS("Funds Transfer Header"."Amount To Transfer");

                CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(NumberText, "Amount To Transfer", "Funds Transfer Header"."Currency Code");
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
        NumberText: array[2] of Text[100];
        CheckReport: Report Check;
}

