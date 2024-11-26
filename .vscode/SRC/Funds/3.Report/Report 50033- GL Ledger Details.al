report 50033 "GL Ledger Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/GL Ledger Details.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            RequestFilterFields = "No.";
            column(No_GLAccount; "G/L Account"."No.")
            {
            }
            column(Name_GLAccount; "G/L Account".Name)
            {
            }
            column(SearchName_GLAccount; "G/L Account"."Search Name")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
                {
                }
                column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
                {
                }
                column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
                {
                }
                column(DocumentType_GLEntry; "G/L Entry"."Document Type")
                {
                }
                column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
                {
                }
                column(Description_GLEntry; "G/L Entry".Description)
                {
                }
                column(gLAmount; gLAmount)
                {
                }
                column(CPVNo; CPVNo)
                {
                }
                column(ChequeNo; ChequeNo)
                {
                }
                column(PayeeName; PayeeName)
                {
                }
                column(AmountPaid; AmountPaid)
                {
                }
                column(PaymentDate; PaymentDate)
                {
                }
                column(InvoiceNumber; InvoiceNumber)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ChequeNo := '';
                    PayeeName := '';
                    CPVNo := '';
                    AmountPaid := 0;
                    InvoiceNumber := '';


                    if "G/L Entry".Amount < 0 then begin
                        gLAmount := "G/L Entry".Amount * -1;
                    end else begin
                        gLAmount := "G/L Entry".Amount
                    end;



                    PaymentLine.Reset;
                    PaymentLine.SetRange(PaymentLine."Applies-to Doc. No.", "G/L Entry"."Document No.");
                    if PaymentLine.FindFirst then begin
                        if PaymentHeader.Get(PaymentLine."Document No.") then
                            PaymentHeader.CalcFields(PaymentHeader."Net Amount");
                        ChequeNo := PaymentHeader."Cheque No.";
                        PayeeName := PaymentHeader."Payee Name";
                        CPVNo := PaymentHeader."No.";
                        AmountPaid := PaymentHeader."Net Amount";
                        PaymentDate := PaymentHeader."Date Posted";
                    end;


                    if PurchInvHeader.Get("G/L Entry"."Document No.") then
                        InvoiceNumber := PurchInvHeader."Vendor Invoice No.";
                end;
            }
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
        CPVNo: Code[50];
        ChequeNo: Code[50];
        PayeeName: Text;
        AmountPaid: Decimal;
        PaymentDate: Date;
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        InvoiceNumber: Code[50];
        gLAmount: Decimal;
}

