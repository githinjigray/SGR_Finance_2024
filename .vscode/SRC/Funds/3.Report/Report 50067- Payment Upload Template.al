report 50067 "Payment Upload Template"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Payment Upload Template.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = WHERE("Net Amount" = FILTER(<> 0));
            RequestFilterFields = "Posting Date", "Bank Account No.";
            column(No_PaymentHeader; "Payment Header"."No.")
            {
            }
            column(PostingDate_PaymentHeader; "Payment Header"."Posting Date")
            {
            }
            column(PaymentMode_PaymentHeader; "Payment Header"."Payment Mode")
            {
            }
            column(PayingAccountNo; PayingAccountNo)
            {
            }
            column(PayingBankDetail; PayingBankDetail)
            {
            }
            column(PayeeBankAccountName_PaymentHeader; "Payment Header"."Payee Bank Account Name")
            {
            }
            column(PayeeBankAccountNo_PaymentHeader; "Payment Header"."Payee Bank Account No.")
            {
            }
            column(MPESAPaybillAccountNo_PaymentHeader; "Payment Header"."MPESA/Paybill Account No.")
            {
            }
            column(PayeeBankCode_PaymentHeader; "Payment Header"."Payee Bank Code")
            {
            }
            column(PayeeBankName_PaymentHeader; "Payment Header"."Payee Bank Name")
            {
            }
            column(PayeeName_PaymentHeader; "Payment Header"."Payee Name")
            {
            }
            column(NetAmountLCY_PaymentHeader; "Payment Header"."Net Amount(LCY)")
            {
            }
            column(NetAmount_PaymentHeader; "Payment Header"."Net Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PayingBankDetail := '';
                PayingBankDetail := '';

                PayingBankDetail := "Payment Header"."Bank Account No." + '-' + "Payment Header"."Bank Account Name";

                if BankAccount.Get("Payment Header"."Bank Account No.") then
                    PayingAccountNo := BankAccount."Bank Account No.";
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
        PayingAccountNo: Text;
        PayingBankDetail: Text;
        BankAccount: Record "Bank Account";
}

