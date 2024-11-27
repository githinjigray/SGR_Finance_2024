report 50003 "Receipt Header"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Receipt Header.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Receipt Header"; "Receipt Header")
        {
            column(No; "No.")
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(Received; Received)
            {
            }
            column(Date; "Posting Date")
            {
            }
            column(Department; "Global Dimension 1 Code")
            {
            }
            column(CostCenter; "Global Dimension 2 Code")
            {
            }
            column(RHAmount; "Amount Received")
            {
            }
            column(RHAmountLCY; "Receipt Line".Amount)
            {
            }
            column(RHDescription; "Received From")
            {
            }
            column(RHDesc; Description)
            {
            }
            column(Payee; "On Behalf of")
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CAddress; CompanyInformation.Address)
            {
            }
            column(CAddress2; CompanyInformation."Address 2")
            {
            }
            column(CImage; CompanyInformation.Picture)
            {
            }
            column(CFax; CompanyInformation."Fax No.")
            {
            }
            column(CTel; CompanyInformation."Phone No.")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(TotalAmountText; TotalAmountText[1])
            {
            }
            column(USERID_Control1102755012; UserId)
            {
            }
            dataitem("Receipt Line"; "Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(TType; "Receipt Line"."Receipt Code")
                {
                }
                column(Description; Description)
                {
                }
                column(Amount; Amount)
                {
                }
                column(AmountLCY; "Amount(LCY)")
                {
                }
                column(PayMode; "Receipt Line"."Document Type")
                {
                }
                column(ChequeNo; "Receipt Header"."Reference No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Receipt Header"."Total Line Amount");
                EnglishLanguageCode := 1033;
                CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(TotalAmountText, ("Receipt Header"."Total Line Amount"), "Receipt Header"."Currency Code");

                if "Receipt Header".Posted = true then
                    Received := 'RECEIVED'
                else
                    Received := '';

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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        CheckReport: Report Check;
        TotalLegalFee: Decimal;
        TotalMembershipFee: Decimal;
        TotalAmount: Decimal;
        TotalInvestment: Decimal;
        TotalAmountText: array[2] of Text[80];
        TotalInvestmentText: array[2] of Text[80];
        Percentage: Decimal;
        Interest: Decimal;
        InterestText: array[2] of Text;
        user: Record User;
        userid: Text;
        EnglishLanguageCode: Integer;
        Received: Text;
}

