report 50061 "Generate Interest-Fixed New1"
{
    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ApplicationArea = all;
    dataset
    {
        dataitem("FD Processing1"; "FD Processing1")
        {
            DataItemTableView = WHERE("FD Maturity Date" = FILTER(<> ''), "Fixed Deposit Status" = FILTER(Active));
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin

                IntRate := 0;
                AccruedInt := 0;
                MidMonthFactor := 1;
                MinBal := FALSE;
                RIntDays := IntDays;
                AsAt := PostStart;

                CALCFIELDS("Last Interest Earned Date");
                IF "Last Interest Earned Date" <> 0D THEN BEGIN
                    LastIntDate := "Last Interest Earned Date";
                END ELSE IF ("Last Interest Earned Date" = 0D) THEN
                        LastIntDate := "Fixed Deposit Start Date";

                IF "FD Maturity Date" < RunDate THEN BEGIN
                    RIntDays := LastIntDate - "FD Maturity Date";
                END ELSE
                    RIntDays := LastIntDate - RunDate;

                FDProcess.RESET;
                FDProcess.SETRANGE(FDProcess."Document No.", "FD Processing1"."Document No.");
                IF FDProcess.FINDSET THEN BEGIN
                    REPEAT
                        Bal := FDProcess."FD Amount";
                        DBALANCE := ROUND(((3 / 1200) * Bal) * 1, 0.05, '=');
                        IF "FD Maturity Date" < RunDate THEN BEGIN
                            PDate := "FD Maturity Date"
                        END ELSE
                            PDate := RunDate;
                        Rate := "Interest rate";
                        DURATION := "FD Processing1"."FD Duration";

                        FXDINterest := ROUND(((Bal * Rate / 100) / 365) * RIntDays, 0.05, '=');


                        AccruedInt := FXDINterest;
                        LineNo := LineNo + 10000;
                        IntBufferNo := IntBufferNo + 1;
                        InterestBuffer.INIT;
                        InterestBuffer.No := IntBufferNo;
                        InterestBuffer."Account No" := "FD Processing1"."FD Account";
                        InterestBuffer."Account Type" := "FD Processing1"."Account Type";
                        InterestBuffer."Document No." := "FD Processing1"."Document No.";
                        InterestBuffer."Interest Date" := PDate;
                        InterestBuffer."Interest Amount" := AccruedInt * -1;
                        InterestBuffer."User ID" := USERID;
                        InterestBuffer."Currency Code" := "FD Processing1"."Currency Code";
                        InterestBuffer.Validate("Currency Code");
                        IF InterestBuffer."Interest Amount" <> 0 THEN
                            InterestBuffer.INSERT(TRUE);

                    UNTIL FDProcess.NEXT = 0;
                END;


            end;

            trigger OnPostDataItem()
            begin

                message('Process Completed Successfully.');
            end;

            trigger OnPreDataItem()
            begin
                IF RunDate = 0D THEN ERROR('Run date must be specified');
                DocNo := 'INT EARNED';
                IF PDate = 0D THEN
                    PDate := RunDate;

                InterestBuffer.RESET;
                IF InterestBuffer.FIND('+') THEN
                    IntBufferNo := InterestBuffer.No;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(RunDate; RunDate)
                {
                    ApplicationArea = all;
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
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post";
        Account: Record Vendor;
        AccountType: Record "Fixed Deposit Type1";
        LineNo: Integer;
        ChequeType: Record "Fixed Deposit Type1";
        FDInterestCalc: Record "FD Interest Calculation Crit1";
        InterestBuffer: Record "Interest Buffer1";
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        StartDate: Date;
        IntDays: Integer;
        AsAt: Date;
        MinBal: Boolean;
        AccruedInt: Decimal;
        RIntDays: Integer;
        Bal: Decimal;
        DFilter: Text[50];
        FixedDtype: Record "Fixed Deposit Type1";
        DURATION: Integer;
        Dfilter2: Date;
        Dfilter3: Text[30];
        PostStart: Date;
        PostEnd: Date;
        DBALANCE: Decimal;
        FXDCODE: Code[20];
        Rate: Decimal;
        FXDINterest: Decimal;
        FXD: Record "Fixed Deposit Type1";
        FDDURATION: DateFormula;
        FDINTEREST: Decimal;
        FXDLINE: Record "FD Interest Calculation Crit1";
        DURATION2: Decimal;
        "Maturity Status": Option "Roll Back","Close Account","Transfer Interest";
        GnlJnlline: Record "Gen. Journal Line";
        GenSetUp: Record "Funds General Setup";
        LastIntDate: Date;
        FDProcess: Record "FD Processing1";
        RunDate: Date;
}

