report 50060 "Transfer Interest New1"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Transfer Interest New1.rdlc';
    ApplicationArea = all;
    dataset
    {
        dataitem("FD Processing1"; "FD Processing1")
        {
            DataItemTableView = WHERE("Fixed Deposit Status" = FILTER(<> Matured));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Document No.", "Fixed Deposit Status";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Transfer := FALSE;

                "FD Processing1".CALCFIELDS("FD Processing1"."Untranfered Interest");
                IF "FD Processing1"."FD Maturity Date" <= TODAY THEN BEGIN
                    IF "FD Processing1"."Untranfered Interest" > 0 THEN BEGIN
                        //IF "FD Processing1"."Interest Earned">0 THEN BEGIN
                        IF AccountType.GET("FD Processing1"."Account Type") THEN BEGIN
                            //IF AccountType."Fixed Deposit" = TRUE THEN BEGIN
                            IF "FD Processing1"."FD Maturity Date" <= PDate THEN BEGIN
                                "FD Processing1"."FD Marked for Closure" := TRUE;
                                Transfer := TRUE;

                                //Send E-Mail
                                /*
                                SMTPMAIL.NewMessage(Gensetup."Sender Address",'DIMKES SACCO - Fixed Deposit Maturity');
                                SMTPMAIL.SetWorkMode();
                                SMTPMAIL.ClearAttachments();
                                SMTPMAIL.ClearAllRecipients();
                                SMTPMAIL.SetDebugMode();
                                SMTPMAIL.SetFromAdress(Gensetup."Sender Address");
                                SMTPMAIL.SetHost(Gensetup."Outgoing Mail Server");
                                SMTPMAIL.SetUserID(Gensetup."Sender User ID");
                                SMTPMAIL.AddLine('Your fixed deposit has matured and the interested earned transfered to your savings account.');
                                SMTPMAIL.AddLine('');
                                SMTPMAIL.AddLine('GM - UN SACCO');
                                SMTPMAIL.SetToAdress("FD Processing1"."E-Mail");
                                SMTPMAIL.Send;
                                */
                                //Send E-Mail

                            END ELSE
                                Transfer := FALSE;
                        END ELSE
                            Transfer := TRUE;
                    END;

                    IF Transfer = TRUE THEN BEGIN

                        LineNo := LineNo + 10000;

                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := "FD Processing1"."FD Account";
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                        IF AccountType.GET("FD Processing1"."Account Type") THEN BEGIN
                            //IF AccountType."Fixed Deposit" = TRUE THEN
                            //GenJournalLine."Account No.":="FD Processing1"."Savings Account No."
                            //ELSE
                            GenJournalLine."Account No." := "FD Processing1"."FD Account";
                            //END ELSE
                            GenJournalLine."Account No." := "FD Processing1"."FD Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            IF "FD Processing1"."FD Maturity Date" <= TODAY THEN BEGIN
                                GenJournalLine."Posting Date" := "FD Processing1"."FD Maturity Date"
                            END ELSE
                                GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := 'Interest Earned';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -"FD Processing1"."Untranfered Interest";
                            //GenJournalLine.Amount:=-"FD Processing1"."Interest Earned";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := '107080';
                            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;


                            //POST WITHHOLDING TAX
                            Gensetup.GET();
                            LineNo := LineNo + 10000;
                            Gensetup.GET();
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := "FD Processing1"."FD Account";
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine."Account No." := '107220';
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            IF "FD Processing1"."FD Maturity Date" <= TODAY THEN BEGIN
                                GenJournalLine."Posting Date" := "FD Processing1"."FD Maturity Date"
                            END ELSE
                                GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := 'Witholding Tax on Int';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            //IF AccountType."Fixed Deposit" = TRUE THEN
                            GenJournalLine.Amount := -"FD Processing1"."Untranfered Interest" * 0.15;
                            //ELSE
                            //GenJournalLine.Amount:=ROUND(((IntRate/1200)*"FD Processing1"."Balance (LCY)")*MidMonthFactor*0.15,0.05,'>');
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                            GenJournalLine."Bal. Account No." := "FD Processing1"."FD Account";
                            //GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                            GenJournalLine."Shortcut Dimension 1 Code" := "FD Processing1"."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := "FD Processing1"."Global Dimension 2 Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;


                            "FD Processing1".CALCFIELDS("FD Processing1"."Interest Earned");
                            //"FD Processing1".CALCFIELDS("FD Processing1"."Balance (LCY)");
                            "FD Processing1"."Transfer Amount to Savings" := (("FD Processing1"."FD Amount") + "FD Processing1"."Interest Earned") - ("FD Processing1"."Interest Earned" * 0.15);
                            IF ("FD Processing1"."FD Amount") < "FD Processing1"."Transfer Amount to Savings" THEN
                                //ERROR('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                LineNo := LineNo + 10000;

                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                            GenJournalLine."Document No." := "FD Account";
                            GenJournalLine."External Document No." := "FD Account";
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := "FD Processing1"."FD Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            IF "FD Processing1"."FD Maturity Date" <= TODAY THEN BEGIN
                                GenJournalLine."Posting Date" := "FD Processing1"."FD Maturity Date"
                            END ELSE
                                GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine.Description := 'Term Balance Tranfers';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := "FD Processing1"."Transfer Amount to Savings";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;

                            LineNo := LineNo + 10000;

                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                            GenJournalLine."Document No." := "FD Account";
                            GenJournalLine."External Document No." := "FD Account";
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := "FD Processing1"."Savings Account No.";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            IF "FD Processing1"."FD Maturity Date" <= TODAY THEN BEGIN
                                GenJournalLine."Posting Date" := "FD Processing1"."FD Maturity Date"
                            END ELSE
                                GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine.Description := 'Term Balance Tranfers';
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -"FD Processing1"."Transfer Amount to Savings";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;




                            InterestBuffer.RESET;
                            InterestBuffer.SETRANGE(InterestBuffer."Account No", "FD Processing1"."FD Account");
                            IF InterestBuffer.FIND('-') THEN
                                InterestBuffer.MODIFYALL(InterestBuffer.Transferred, TRUE);

                            "FD Processing1"."Fixed Deposit Status" := "FD Processing1"."Fixed Deposit Status"::Matured;
                            "FD Processing1".MODIFY;

                        END;
                    END;
                END;
                //END;

            end;

            trigger OnPostDataItem()
            begin

                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name", 'INTCALC-F');
                IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                        GLPosting.RUN(GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                END;

            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name", 'INTCALC-F');
                GenJournalLine.DELETEALL;

                DocNo := 'INT EARNED';
                PDate := TODAY;

                Gensetup.GET(0);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Document_No; DocNo)
                {
                    Caption = 'Document_No';
                    ApplicationArea = all;
                }
                field(Posting_Date; PDate)
                {
                    Caption = 'Posting_Date';
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

    trigger OnInitReport()
    begin
        Company.GET();
        Company.CALCFIELDS(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post";
        Account: Record Vendor;
        AccountType: Record "Bank Account";
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
        Transfer: Boolean;
        Gensetup: Record "Funds General Setup";
        PAGENO: Integer;
}

