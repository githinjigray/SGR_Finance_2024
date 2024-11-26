report 50089 "Account Payable Ageing"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Account Payable Ageing.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
        {
            DataItemTableView = WHERE("Initial Entry Global Dim. 2" = FILTER(<> ''));
            RequestFilterFields = "Posting Date", "Initial Entry Global Dim. 2";
            column(PostingDate_DetailedCustLedgEntry; "Posting Date")
            {
            }
            column(DocumentNo_DetailedCustLedgEntry; "Document No.")
            {
            }
            column(Amount_DetailedCustLedgEntry; Amount)
            {
            }
            // column(Description2_DetailedCustLedgEntry;"Detailed Vendor Ledg. Entry".Document_Type)
            // {
            // }
            column(TransactionCode_DetailedCustLedgEntry; "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 2")
            {
            }
            column(CustomerNo_DetailedCustLedgEntry; "Detailed Vendor Ledg. Entry"."Vendor No.")
            {
            }
            column(T0to30Days; "0to30Days")
            {
            }
            column(T31to90Days; "31to90Days")
            {
            }
            column(T91to180Days; "91to180Days")
            {
            }
            column(Above180Days; Above180Days)
            {
            }
            column(RunDate; RunDate)
            {
            }
            column(TransactionCodeName; TransactionCodeName)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "Vendor No." = FIELD("Vendor No."), "Global Dimension 2 Code" = FIELD("Initial Entry Global Dim. 2");
                column(Description_CustLedgerEntry; Description)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                FeeTypes.Reset;
                FeeTypes.SetRange(FeeTypes.Code, "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 2");
                if FeeTypes.FindFirst then begin
                    TransactionCodeName := FeeTypes.Name;
                end;


                VendorDetail.Reset;
                VendorDetail.SetRange(VendorDetail."No.", "Detailed Vendor Ledg. Entry"."Vendor No.");
                if VendorDetail.FindFirst then begin
                    CustomerName := VendorDetail.Name;
                end;


                PeriodDate := RunDate;

                "0to30Days" := 0;
                "31to90Days" := 0;
                "91to180Days" := 0;
                Above180Days := 0;


                //0to30 Days In Arrears Normal
                EndDate := PeriodDate;
                StartDate := CalcDate('-30D', PeriodDate);
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Vendor No.", "Detailed Vendor Ledg. Entry"."Vendor No.");
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Global Dimension 2 Code", "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 2");
                VendorLedgerEntry.SetRange(VendorLedgerEntry.Open, true);
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Due Date", StartDate, EndDate);
                if VendorLedgerEntry.FindSet then begin

                    repeat
                        VendorLedgerEntry.CalcFields(VendorLedgerEntry."Remaining Amount");
                        "0to30Days" := "0to30Days" + VendorLedgerEntry."Remaining Amount";
                    until VendorLedgerEntry.Next = 0;
                end;

                //31 to 90 Days In Arrears-Watch
                EndDate := CalcDate('-1D', StartDate);
                StartDate := CalcDate('-90D', PeriodDate);
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Vendor No.", "Detailed Vendor Ledg. Entry"."Vendor No.");
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Global Dimension 2 Code", "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 2");
                VendorLedgerEntry.SetRange(VendorLedgerEntry.Open, true);
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Due Date", StartDate, EndDate);
                if VendorLedgerEntry.FindSet then begin
                    repeat
                        VendorLedgerEntry.CalcFields(VendorLedgerEntry."Remaining Amount");
                        "31to90Days" := "31to90Days" + VendorLedgerEntry."Remaining Amount";
                    until VendorLedgerEntry.Next = 0;
                end;

                //91 to 180 Days In Arrears-Doubtful
                EndDate := CalcDate('-1D', StartDate);
                StartDate := CalcDate('-180D', PeriodDate);
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Vendor No.", "Detailed Vendor Ledg. Entry"."Vendor No.");
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Global Dimension 2 Code", "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 2");
                VendorLedgerEntry.SetRange(VendorLedgerEntry.Open, true);
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Due Date", StartDate, EndDate);
                if VendorLedgerEntry.FindSet then begin
                    repeat
                        VendorLedgerEntry.CalcFields(VendorLedgerEntry."Remaining Amount");
                        "91to180Days" := "91to180Days" + VendorLedgerEntry."Remaining Amount";
                    until VendorLedgerEntry.Next = 0;
                end;

                //Above180 Days In Arrears-Loss
                EndDate := CalcDate('-1D', StartDate);
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Vendor No.", "Detailed Vendor Ledg. Entry"."Vendor No.");
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Global Dimension 2 Code", "Detailed Vendor Ledg. Entry"."Initial Entry Global Dim. 2");
                VendorLedgerEntry.SetRange(VendorLedgerEntry.Open, true);
                VendorLedgerEntry.SetFilter(VendorLedgerEntry."Due Date", '<%1', EndDate);
                if VendorLedgerEntry.FindSet then begin
                    repeat
                        VendorLedgerEntry.CalcFields(VendorLedgerEntry."Remaining Amount");
                        Above180Days := Above180Days + VendorLedgerEntry."Remaining Amount";
                    until VendorLedgerEntry.Next = 0;
                end;

                //----------------------------------------------------------------------------
            end;

            trigger OnPreDataItem()
            begin
                if RunDate = 0D then
                    Error('Select the Run Date, it cannot be Null');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Run Date"; RunDate)
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

    var
        RunDate: Date;
        "0to30Days": Decimal;
        "31to90Days": Decimal;
        "91to180Days": Decimal;
        Above180Days: Decimal;
        CustomerName: Text;
        TransactionCodeName: Text;
        FeeTypes: Record "Dimension Value";
        EndDate: Date;
        PeriodDate: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        StartDate: Date;
        VendorDetail: Record Vendor;
}

