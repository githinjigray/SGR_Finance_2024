report 50062 "Customers Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Customers Statement.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(CBankName; CompanyInfo."Bank Name")
            {
            }
            column(CBankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebPage; CompanyInfo.Website)
            {
            }
            column(CompanyLogoDetails; CompanyInfo."Ship-to Address")
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            column(TINNo_Customer; Customer."TIN No.")
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(PhoneNo_Customer; Customer."Phone No.")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(StatementDate; StatementDate)
            {
            }
            column(BalBf; BalBf)
            {
            }
            column(BalCF; BalCF)
            {
            }
            column(LRNumber; LRNumber)
            {
            }
            column(PropertyName; PropertyName)
            {
            }
            column(Address_Customer; Customer.Address)
            {
            }
            column(EMail_Customer; Customer."E-Mail")
            {
            }
            column(ContactEMail_Customer; Customer."E-Mail")
            {
            }
            column(W30Days; "30Days")
            {
            }
            column(W60Days; "60Days")
            {
            }
            column(W90Days; "90Days")
            {
            }
            column(MoreThan90Days; Above90Days)
            {
            }
            column(AgingMessage; AgingMessage)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Currency Code", "Posting Date") WHERE(Reversed = CONST(false));
                column(CustomerNo_CustLedgerEntry; "Customer No.")
                {
                }
                column(PostingDate_CustLedgerEntry; "Posting Date")
                {
                }
                column(DocumentType_CustLedgerEntry; "Document Type")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Document No.")
                {
                }
                column(Description_CustLedgerEntry; Description)
                {
                }
                column(CustomerName_CustLedgerEntry; "Customer Name")
                {
                }
                column(CurrencyCode_CustLedgerEntry; "Currency Code")
                {
                }
                column(Amount_CustLedgerEntry; Amount)
                {
                }
                column(AmountLCY_CustLedgerEntry; Amount)
                {
                }
                column(LandLordNo; LandLordNo)
                {
                }
                column(LandlordName; LandlordName)
                {
                }
                column(DebitAmountLCY_CustLedgerEntry; "Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_CustLedgerEntry; "Credit Amount (LCY)")
                {
                }
                column(RunningBal; RunningBal)
                {
                }
                column(ExternalDocumentNo_CustLedgerEntry; "External Document No.")
                {
                }
                column(VATAmounts_CustLedgerEntry; Amount)
                {
                }
                column(ImprestNumber; ImprestNumber)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Debit Amount (LCY)", "Cust. Ledger Entry"."Credit Amount (LCY)", "Cust. Ledger Entry".Amount);

                    RunningBal := RunningBal + "Cust. Ledger Entry".Amount;
                    ImprestNumber := '';

                    ImprestSurrenderHeader.Reset;
                    ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."No.", "Cust. Ledger Entry"."Document No.");
                    if ImprestSurrenderHeader.FindFirst then begin
                        ImprestNumber := ImprestSurrenderHeader."Imprest No.";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    "Cust. Ledger Entry".SetRange("Cust. Ledger Entry"."Posting Date", StartDate, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BalBf := 0;
                BalCF := 0;
                "30Days" := 0;
                "60Days" := 0;
                "90Days" := 0;
                Above90Days := 0;
                LandlordTIN := '';




                if StartDate = 0D then Error(ERROR0001);
                if EndDate = 0D then Error(ERROR0002);
                StatementDate := CalcDate('-1D', StartDate);

                //RunningBal:=0;


                //balance bF
                DetailedCustLedgEntry.Reset;
                DetailedCustLedgEntry.SetRange("Customer No.", Customer."No.");
                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                if EndDate <> 0D then
                    DetailedCustLedgEntry.SetRange("Posting Date", 0D, StatementDate);
                if DetailedCustLedgEntry.FindSet then begin
                    DetailedCustLedgEntry.CalcSums("Amount (LCY)");
                    BalBf := DetailedCustLedgEntry."Amount (LCY)";
                end;

                //balance CF
                DetailedCustLedgEntry.Reset;
                DetailedCustLedgEntry.SetRange("Customer No.", Customer."No.");
                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                if EndDate <> 0D then
                    DetailedCustLedgEntry.SetRange("Posting Date", 0D, EndDate);
                if DetailedCustLedgEntry.FindSet then begin
                    DetailedCustLedgEntry.CalcSums("Amount (LCY)");
                    BalCF := DetailedCustLedgEntry."Amount (LCY)";
                end;



                //Aging
                //Within 30Days
                AgeEndDate := EndDate;
                AgeStartDate := CalcDate('-30D', AgeEndDate);


                TempCustLedgerEntry.Reset;
                TempCustLedgerEntry.SetFilter(TempCustLedgerEntry."Customer No.", Customer."No.");
                TempCustLedgerEntry.SetRange(TempCustLedgerEntry."Posting Date", AgeStartDate, AgeEndDate);
                if TempCustLedgerEntry.FindSet then begin
                    repeat
                        TempCustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                        "30Days" := "30Days" + TempCustLedgerEntry."Remaining Amt. (LCY)";
                    until TempCustLedgerEntry.Next = 0
                end;


                //Within 60Days
                AgeEndDate := CalcDate('-1D', AgeStartDate);
                AgeStartDate := CalcDate('-30D', AgeEndDate);


                TempCustLedgerEntry.Reset;
                TempCustLedgerEntry.SetFilter(TempCustLedgerEntry."Customer No.", Customer."No.");
                TempCustLedgerEntry.SetRange(TempCustLedgerEntry."Posting Date", AgeStartDate, AgeEndDate);
                if TempCustLedgerEntry.FindSet then begin
                    repeat
                        TempCustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                        "60Days" := "60Days" + TempCustLedgerEntry."Remaining Amt. (LCY)";
                    until TempCustLedgerEntry.Next = 0
                end;


                //Within 90Days
                AgeEndDate := CalcDate('-1D', AgeStartDate);
                AgeStartDate := CalcDate('-30D', AgeEndDate);


                TempCustLedgerEntry.Reset;
                TempCustLedgerEntry.SetFilter(TempCustLedgerEntry."Customer No.", Customer."No.");
                TempCustLedgerEntry.SetRange(TempCustLedgerEntry."Posting Date", AgeStartDate, AgeEndDate);
                if TempCustLedgerEntry.FindSet then begin
                    repeat
                        TempCustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                        "90Days" := "90Days" + TempCustLedgerEntry."Remaining Amt. (LCY)";
                    until TempCustLedgerEntry.Next = 0
                end;

                //Above 90Days
                AgeEndDate := CalcDate('-1D', AgeStartDate);
                AgeStartDate := 0D;

                TempCustLedgerEntry.Reset;
                TempCustLedgerEntry.SetFilter(TempCustLedgerEntry."Customer No.", Customer."No.");
                TempCustLedgerEntry.SetRange(TempCustLedgerEntry."Posting Date", AgeStartDate, AgeEndDate);
                if TempCustLedgerEntry.FindSet then begin
                    repeat
                        TempCustLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                        Above90Days := Above90Days + TempCustLedgerEntry."Remaining Amt. (LCY)";
                    until TempCustLedgerEntry.Next = 0
                end;


                if "30Days" <> 0 then
                    AgingMessage := Text30Days;
                if "60Days" <> 0 then
                    AgingMessage := Text60Days;
                if "90Days" <> 0 then
                    AgingMessage := Text90Days;
                if Above90Days <> 0 then
                    AgingMessage := TextAbove90Days;
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
        CompanyInfo.CalcFields(Picture);
        RunningBal := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        LandLordNo: Code[20];
        TempLandLordNo: Code[20];
        LandlordName: Text;
        Vendor: Record Vendor;
        StartDate: Date;
        EndDate: Date;
        BalBf: Decimal;
        TempCustLedgerEntry: Record "Cust. Ledger Entry";
        TempCustomer: Record Customer;
        ERROR0001: Label 'Start Date must be specified!';
        ERROR0002: Label 'End Date must be specified!';
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        RunningBal: Decimal;
        BalCF: Decimal;
        StatementDate: Date;
        PropertyName: Text;
        LRNumber: Code[40];
        "30Days": Decimal;
        "60Days": Decimal;
        "90Days": Decimal;
        Above90Days: Decimal;
        AgeStartDate: Date;
        AgeEndDate: Date;
        AgingMessage: Text;
        Text30Days: Label 'Please Pay Amount due';
        Text60Days: Label 'Please arrange to pay in the next 14 days.';
        Text90Days: Label 'Please arrange to pay in the next 14 days,failure to which we shall destress you.';
        TextAbove90Days: Label 'Please arrange to pay in the next 14 days,failure to which we shall destress you.';
        LeaseExpiry: Label 'Lease is due to expire. Kindly make arrangement to Renew';
        LeaseMessage: Text;
        LandlordTIN: Code[30];
        ImprestNumber: Code[30];
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
}

