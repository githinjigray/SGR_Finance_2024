report 50103 "Vendor Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Vendor Statement.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
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
            column(CompanyTIN; GeneralLedgerSetup."Company TIN")
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            column(TINNo_Customer; Vendor."VAT Registration No.")
            {
            }
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(PhoneNo_Customer; "Phone No.")
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
            column(Address_Customer; Address)
            {
            }
            column(EMail_Customer; "E-Mail")
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
            column(DepositAmount; DepositAmount)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                //The property 'DataItemTableView' shouldn't have an empty value.
                //DataItemTableView = '';
                column(CustomerNo_CustLedgerEntry; "Vendor No.")
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
                column(CustomerName_CustLedgerEntry; "Vendor Name")
                {
                }
                column(CurrencyCode_CustLedgerEntry; "Currency Code")
                {
                }
                column(Amount_CustLedgerEntry; Amount)
                {
                }
                column(AmountLCY_CustLedgerEntry; "Amount (LCY)")
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
                column(ExternalDocumentNo_CustLedgerEntry; EXTDOCNo)
                {
                }
                column(VATAmounts_CustLedgerEntry; Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Vendor Ledger Entry".SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");

                    if ReceiptHeader.Get("Vendor Ledger Entry"."Document No.") then
                        EXTDOCNo := ReceiptHeader."Reference No.";

                    if TenantInvoiceHeader.Get("Vendor Ledger Entry"."Document No.") then
                        EXTDOCNo := TenantInvoiceHeader."No.";

                    if JournalVoucherHeader.Get("Vendor Ledger Entry"."Document No.") then
                        EXTDOCNo := JournalVoucherHeader."JV No.";

                    "Vendor Ledger Entry".CalcFields("Vendor Ledger Entry"."Amount (LCY)");
                    "Vendor Ledger Entry".CalcFields("Vendor Ledger Entry"."Debit Amount (LCY)");
                    "Vendor Ledger Entry".CalcFields("Vendor Ledger Entry"."Credit Amount (LCY)");


                    TotalDebit := 0;
                    TotalCredit := 0;

                    TotalDebit := "Vendor Ledger Entry"."Debit Amount (LCY)";
                    TotalCredit := "Vendor Ledger Entry"."Credit Amount (LCY)";

                    RunningBal := RunningBal + "Vendor Ledger Entry".Amount;


                    if "Vendor Ledger Entry"."Posting Date" < StartDate then
                        CurrReport.Skip;


                    if "Vendor Ledger Entry"."Posting Date" > EndDate then
                        CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    "Vendor Ledger Entry".SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");
                    GeneralLedgerSetup.get;
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

                if StartDate = 0D then Error(ERROR0001);
                if EndDate = 0D then Error(ERROR0002);
                StatementDate := CalcDate('-1D', StartDate);

                RunningBal := 0;


                //balance bF
                DetailedCustLedgEntry.Reset;
                DetailedCustLedgEntry.SetRange("Vendor No.", Vendor."No.");
                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                if EndDate <> 0D then
                    DetailedCustLedgEntry.SetRange("Posting Date", 0D, StatementDate);
                if DetailedCustLedgEntry.FindSet then begin
                    DetailedCustLedgEntry.CalcSums("Amount (LCY)");
                    BalBf := DetailedCustLedgEntry."Amount (LCY)";
                end;

                //balance CF
                DetailedCustLedgEntry.Reset;
                DetailedCustLedgEntry.SetRange("Vendor No.", Vendor."No.");
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


                "Vendor Ledger Entry".Reset;
                "Vendor Ledger Entry".SetFilter("Vendor No.", Vendor."No.");
                "Vendor Ledger Entry".SetRange("Vendor Ledger Entry"."Posting Date", AgeStartDate, AgeEndDate);
                if "Vendor Ledger Entry".FindSet then begin
                    repeat
                        "Vendor Ledger Entry".CalcFields("Remaining Amt. (LCY)");
                        "30Days" := "30Days" + "Vendor Ledger Entry"."Remaining Amt. (LCY)";
                    until "Vendor Ledger Entry".Next = 0
                end;


                //Within 60Days
                AgeEndDate := CalcDate('-1D', AgeStartDate);
                AgeStartDate := CalcDate('-30D', AgeEndDate);


                "Vendor Ledger Entry".Reset;
                "Vendor Ledger Entry".SetFilter("Vendor Ledger Entry"."Vendor No.", Vendor."No.");
                "Vendor Ledger Entry".SetRange("Vendor Ledger Entry"."Posting Date", AgeStartDate, AgeEndDate);
                if "Vendor Ledger Entry".FindSet then begin
                    repeat
                        "Vendor Ledger Entry".CalcFields("Remaining Amt. (LCY)");
                        "60Days" := "60Days" + "Vendor Ledger Entry"."Remaining Amt. (LCY)";
                    until "Vendor Ledger Entry".Next = 0
                end;


                //Within 90Days
                AgeEndDate := CalcDate('-1D', AgeStartDate);
                AgeStartDate := CalcDate('-30D', AgeEndDate);


                "Vendor Ledger Entry".Reset;
                "Vendor Ledger Entry".SetFilter("Vendor Ledger Entry"."Vendor No.", Vendor."No.");
                "Vendor Ledger Entry".SetRange("Vendor Ledger Entry"."Posting Date", AgeStartDate, AgeEndDate);
                if "Vendor Ledger Entry".FindSet then begin
                    repeat
                        "Vendor Ledger Entry".CalcFields("Remaining Amt. (LCY)");
                        "90Days" := "90Days" + "Vendor Ledger Entry"."Remaining Amt. (LCY)";
                    until "Vendor Ledger Entry".Next = 0
                end;

                //Above 90Days
                AgeEndDate := CalcDate('-1D', AgeStartDate);
                AgeStartDate := 0D;

                "Vendor Ledger Entry".Reset;
                "Vendor Ledger Entry".SetFilter("Vendor No.", Vendor."No.");
                "Vendor Ledger Entry".SetRange("Vendor Ledger Entry"."Posting Date", AgeStartDate, AgeEndDate);
                if "Vendor Ledger Entry".FindSet then begin
                    repeat
                        "Vendor Ledger Entry".CalcFields("Remaining Amt. (LCY)");
                        Above90Days := Above90Days + "Vendor Ledger Entry"."Remaining Amt. (LCY)";
                    until "Vendor Ledger Entry".Next = 0
                end;


                if "30Days" <> 0 then
                    AgingMessage := Text30Days;
                if "60Days" <> 0 then
                    AgingMessage := Text60Days;
                if "90Days" <> 0 then
                    AgingMessage := Text90Days;
                if Above90Days <> 0 then
                    AgingMessage := TextAbove90Days;


                DepositAmount := 0;
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
        LandLordNo: Code[20];
        TempLandLordNo: Code[20];
        LandlordName: Text;
        VendorLst: Record Vendor;
        StartDate: Date;
        EndDate: Date;
        BalBf: Decimal;
        TempCustLedgerEntry: Record "Vendor Ledger Entry";
        TempCustomer: Record Customer;
        ERROR0001: Label 'Start Date must be specified!';
        ERROR0002: Label 'End Date must be specified!';
        DetailedCustLedgEntry: Record "Detailed Vendor Ledg. Entry";
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
        EXTDOCNo: Code[50];
        ReceiptHeader: Record "Receipt Header";
        TenantInvoiceHeader: Record "Purch. Rcpt. Header";
        JournalVoucherHeader: Record "Journal Voucher Header";
        DepositAmount: Decimal;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        GeneralLedgerSetup: Record "General Ledger Setup";
}

