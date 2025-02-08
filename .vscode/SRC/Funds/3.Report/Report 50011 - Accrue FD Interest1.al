report 50011 "Accrue FD Interest1"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    dataset
    {
        dataitem("FD Processing1"; "FD Processing1")
        {
            DataItemTableView = WHERE("Fixed Deposit Status" = CONST(1));
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                IF "FD Processing1"."FD Type" = "FD Processing1"."FD Type"::"Fixed Deposit" THEN BEGIN
                    InterestBuffer.RESET;
                    IF InterestBuffer.FINDLAST THEN
                        IntBufferNo := InterestBuffer.No + 1;

                    AccruedInt := 0;
                    AccruedInt := ((Today - "FD Processing1"."Fixed Deposit Start Date") * "FD Amount" * "Interest rate") / (365 * 100);

                    InterestBuffer.INIT;
                    InterestBuffer.No := IntBufferNo;
                    InterestBuffer."Account No" := "FD Account";
                    InterestBuffer."Account Type" := "Account Type";
                    InterestBuffer."Document No." := "Document No.";
                    InterestBuffer."Interest Date" := Today;
                    InterestBuffer."Interest Amount" := AccruedInt;
                    InterestBuffer."User ID" := USERID;
                    IF InterestBuffer."Interest Amount" <> 0 THEN
                        InterestBuffer.INSERT

                END;


                IF (EndDate = 0D) THEN
                    ERROR('The End Date cannot be empty.');



                TotalInterestAmount := 0;

                FundsGeneralSetup.GET;
                FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Fixed Deposit Interest A/c");
                FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Fixed Deposit Accrual A/c");


                FDInterestBuffer.RESET;
                FDInterestBuffer.SETRANGE(FDInterestBuffer."Document No.", "FD Processing1"."Document No.");
                FDInterestBuffer.SETRANGE(FDInterestBuffer.Transferred, FALSE);
                FDInterestBuffer.SETRANGE(FDInterestBuffer.Accrued, FALSE);
                FDInterestBuffer.SETRANGE(FDInterestBuffer."Interest Date", 0D, EndDate);
                IF FDInterestBuffer.FINDSET THEN BEGIN
                    REPEAT
                        TotalInterestAmount := TotalInterestAmount + FDInterestBuffer."Interest Amount";
                    UNTIL FDInterestBuffer.NEXT = 0;
                END;

                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Journal Batch Name" := 'INTCALC';
                GenJournalLine."Document No." := "FD Processing1"."Document No.";
                GenJournalLine."External Document No." := "FD Processing1"."Document No." + '/' + FORMAT("FD Processing1"."FD Maturity Date");
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := FundsGeneralSetup."Fixed Deposit Accrual A/c";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := EndDate;
                GenJournalLine.Description := 'Accrued Fixed deposit interest for -' + "FD Processing1"."Document No." + '- as at ' + FORMAT(EndDate);
                GenJournalLine.Description2 := 'Accrued Fixed deposit interest for -' + "FD Processing1"."Document No." + '- as at ' + FORMAT(EndDate);
                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TotalInterestAmount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '';
                GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Journal Batch Name" := 'INTCALC';
                GenJournalLine."Document No." := "FD Processing1"."Document No.";
                GenJournalLine."External Document No." := "FD Processing1"."Document No." + '/' + FORMAT("FD Processing1"."FD Maturity Date");
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := FundsGeneralSetup."Fixed Deposit Interest A/c";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := EndDate;
                GenJournalLine.Description := 'Accrued Fixed deposit interest for -' + "FD Processing1"."Document No." + '- as at ' + FORMAT(EndDate);
                GenJournalLine.Description2 := 'Accrued Fixed deposit interest for -' + "FD Processing1"."Document No." + '- as at ' + FORMAT(EndDate);
                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                GenJournalLine.Amount := -TotalInterestAmount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '';
                GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                COMMIT;

                //Post the Journal Lines
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                COMMIT;

                FDInterestBuffer2.RESET;
                FDInterestBuffer2.SETRANGE(FDInterestBuffer2."Document No.", "FD Processing1"."Document No.");
                FDInterestBuffer2.SETRANGE(FDInterestBuffer2."Interest Date", 0D, EndDate);
                FDInterestBuffer2.SETRANGE(FDInterestBuffer2.Transferred, FALSE);
                FDInterestBuffer2.SETRANGE(FDInterestBuffer2.Accrued, FALSE);
                IF FDInterestBuffer2.FINDSET THEN BEGIN
                    REPEAT
                        FDInterestBuffer2.Accrued := TRUE;
                        FDInterestBuffer2.MODIFY;
                    UNTIL FDInterestBuffer2.NEXT = 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name", 'INTCALC');
                GenJournalLine.DELETEALL;
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
                    Visible = false;
                    ApplicationArea = all;
                }
                field("End Date"; EndDate)
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

    trigger OnPreReport()
    begin
        IF NOT CONFIRM('Are you sure you want to accrue the interest for the fixed deposit upto the specified date?') THEN
            ERROR('Operation Cancelled!');
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        FDInterestBuffer: Record "Interest Buffer1";
        FundsGeneralSetup: Record "Funds General Setup";
        FDInterestBuffer2: Record "Interest Buffer1";
        FDProcessing2: Record "FD Processing1";
        StartDate: Date;
        EndDate: Date;
        TotalInterestAmount: Decimal;
        AccruedInt: Decimal;
        InterestBuffer: Record "Interest Buffer1";
        IntBufferNo: Integer;
}

