report 50064 "Recall FD Monthly Interest1"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = all;
    dataset
    {
        dataitem("FD Processing1"; "FD Processing1")
        {
            DataItemTableView = WHERE("Fixed Deposit Status" = CONST(Matured));
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin

                EndDate := 0D;
                EndDate := "FD Processing1"."FD Maturity Date";

                TotalInterestAmount := 0;

                FundsGeneralSetup.GET;
                FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Fixed Deposit Interest A/c");


                FDInterestBuffer.RESET;
                FDInterestBuffer.SETRANGE(FDInterestBuffer."Document No.", "FD Processing1"."Document No.");
                FDInterestBuffer.SETRANGE(FDInterestBuffer.Transferred, FALSE);
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
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                GenJournalLine."Account No." := "FD Processing1"."FD Account";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "FD Processing1"."FD Maturity Date";
                GenJournalLine.Description := 'Interest Recalled for -' + "FD Processing1"."Document No." + '- as at ' + FORMAT("FD Processing1"."FD Maturity Date");
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
                GenJournalLine."Posting Date" := "FD Processing1"."FD Maturity Date";
                GenJournalLine.Description := 'Interest Recalled for  -' + "FD Processing1"."Document No." + '- as at ' + FORMAT("FD Processing1"."FD Maturity Date");
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
                IF FDInterestBuffer2.FINDSET THEN BEGIN
                    REPEAT
                        FDInterestBuffer2.Transferred := TRUE;
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
}

