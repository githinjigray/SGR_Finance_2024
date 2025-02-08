page 50045 "FD Transfer Term Amount Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "FD Processing1";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = ThisPartEditable;
                field("Document No."; rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                    ShowMandatory = true;
                }
                field("FD Type"; rec."FD Type")
                {
                    ShowMandatory = true;
                }
                field("FD Account"; rec."FD Account")
                {
                    ApplicationArea = All;
                }
                field("FD Account Name"; rec."FD Account Name")
                {
                    ApplicationArea = All;
                }
                field("FD Account Balance"; rec."FD Account Balance")
                {
                    Editable = false;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Term Deposit Details")
            {
                Caption = 'Term Deposit Details';
                Editable = ThisPartEditable;
                Visible = true;
                field("Fixed Deposit Status"; rec."Fixed Deposit Status")
                {
                    Editable = false;
                }
                field("Fixed Deposit Start Date"; rec."Fixed Deposit Start Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Maturity Date"; rec."Expected Maturity Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("FD Amount"; Rec."FD Amount")
                {
                    ApplicationArea = All;
                }
                field("FD Amount(LCY)"; Rec."FD Amount(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Interest rate"; rec."Interest rate")
                {
                    ApplicationArea = All;
                }
                field("Fixed Duration"; rec."Fixed Duration")
                {
                    ApplicationArea = All;
                }
                field("Interest Earned"; rec."Interest Earned")
                {
                    ApplicationArea = All;
                }
                field("Untranfered Interest"; rec."Untranfered Interest")
                {
                    ApplicationArea = All;
                }
                field("FD Maturity Date"; rec."FD Maturity Date")
                {
                    ApplicationArea = All;
                }
                field("Last Interest Earned Date"; rec."Last Interest Earned Date")
                {
                    Editable = false;
                    ApplicationArea = All;

                }
                field("Expected Interest On Term Dep"; rec."Expected Interest On Term Dep")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Int. On Term Dep(LCY)"; Rec."Expected Int. On Term Dep(LCY)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FD W/Tax Rate"; rec."FD W/Tax Rate")
                {
                    ApplicationArea = All;
                }
            }
            group("Call Deposit Details")
            {
                Caption = 'Call Deposit Details';
                Editable = CallEditable;
                Visible = true;
                field("Call Deposit Interest Days"; rec."Call Deposit Interest Days")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Approval)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    //DocumentType := DocumentType::FixedDeposits;
                    //ApprovalEntries.Setfilters(DATABASE::Table70000, DocumentType, "Document No.");
                    // ApprovalEntries.RUN;
                end;
            }
            // action("Send Approval Request")
            // {
            //     Caption = 'Send Approval Request';
            //     Image = SendApprovalRequest;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     trigger OnAction()
            //     var
            //         Text001: Label 'This request is already pending approval';
            //         //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //     begin
            //         //TESTFIELD("Global Dimension 1 Code");
            //         //TESTFIELD("Global Dimension 2 Code");
            //         TESTFIELD("FD Account");
            //         TESTFIELD("FD Amount");

            //         CALCFIELDS("FD Account Balance");
            //         IF "FD Amount" > "FD Account Balance" THEN
            //             ERROR('The balance in the FD Account is not enough!');

            //         //IF ApprovalsMgmt.CheckFixedDepositWorkflowEnabled(Rec) THEN
            //         // ApprovalsMgmt.OnSendFixedDepositForApproval(Rec);
            //         Status := Status::Approved;
            //         "Fixed Deposit Status" := "Fixed Deposit Status"::Active;
            //         MODIFY;
            //         MESSAGE('Succefully Approved!');
            //     end;
            // }
            // action("Cancel Approval Request")
            // {
            //     Caption = 'Cancel Approval Request';
            //     Image = Cancel;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         Approvalmgt: Codeunit "Approvals Mgmt.";
            //     begin
            //         IF Status <> Status::"Pending Approval" THEN
            //             ERROR(Text0001)
            //         ELSE
            //         //IF ApprovalsMgmt.CheckFixedDepositWorkflowEnabled(Rec) THEN
            //          // ApprovalsMgmt.OnCancelFixedDepositApprovalRequest(Rec);
            //     end;
            // }
        }
        area(processing)
        {
            action("Calculate Interest")
            {
                Caption = 'Calculate Interest';
                Promoted = true;
                RunObject = Report "Generate Interest-Fixed New1";
            }
            action("Activate FD")
            {
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.TESTFIELD("FD Type");
                    rec.TESTFIELD("Fixed Deposit Start Date");
                    rec.TESTFIELD("FD Amount");
                    rec.TESTFIELD("Interest rate");

                    IF rec."FD Type" = rec."FD Type"::"Fixed Deposit" THEN
                        rec.TESTFIELD("FD Maturity Date");

                    IF rec."Fixed Deposit Status" <> rec."Fixed Deposit Status"::"Open " THEN
                        ERROR('Fixed deposit status must be open!');

                    rec.CALCFIELDS("FD Account Balance");
                    IF rec."FD Amount" > rec."FD Account Balance" THEN
                        ERROR('The balance in the FD Account is not enough!');



                    IF CONFIRM('Are you sure you want to Activate the FD term?', FALSE) = FALSE THEN
                        EXIT;

                    Rec."Fixed Deposit Status" := Rec."Fixed Deposit Status"::Active;
                    Rec.MODIFY;
                    MESSAGE('Fixed Deosit Activated Succesfully');
                    CurrPage.CLOSE;
                end;
            }
            action("Interest Buffer Lines")
            {
                Image = Answers;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Interest Buffer FD";
                RunPageLink = "Document No." = FIELD("Document No.");
            }
            action("Fixed Deposit Bids")
            {
                Image = Aging;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Fixed Deposit Bids";
                RunPageLink = "Document No" = FIELD("Document No.");
            }

            action("Recall & Forefeit Fixed Deposit")
            {
                Image = CancelIndent;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Rec."Fixed Deposit Status", Rec."Fixed Deposit Status"::Active);
                    IF CONFIRM(Txt061) = FALSE THEN EXIT;

                    FDProcessing.RESET;
                    FDProcessing.SETRANGE(FDProcessing."Document No.", Rec."Document No.");
                    IF FDProcessing.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Recall FD Monthly Interest1", FALSE, FALSE, FDProcessing);
                    END;

                    Rec."Fixed Deposit Status" := Rec."Fixed Deposit Status"::Closed;
                    Rec.MODIFY;

                    MESSAGE(Text123);

                    CurrPage.CLOSE;
                end;
            }
            action("Recall Fixed Deposit")
            {
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Rec."Fixed Deposit Status", Rec."Fixed Deposit Status"::Active);
                    IF CONFIRM(Txt060) = FALSE THEN EXIT;

                    IF (Rec."FD Type" = Rec."FD Type"::"Call Deposit") AND (Rec."FD Maturity Date" = 0D) THEN BEGIN
                        Rec.TESTFIELD("Call Deposit Interest Days");
                        InterestBuffer.RESET;
                        IF InterestBuffer.FINDLAST THEN
                            IntBufferNo := InterestBuffer.No + 1;

                        AccruedInt := 0;
                        AccruedInt := (Rec."Call Deposit Interest Days" * Rec."FD Amount" * Rec."Interest rate") / (365 * 100);

                        InterestBuffer.INIT;
                        InterestBuffer.No := IntBufferNo;
                        InterestBuffer."Account No" := Rec."FD Account";
                        InterestBuffer."Account Type" := Rec."Account Type";
                        InterestBuffer."Document No." := Rec."Document No.";
                        InterestBuffer."Interest Date" := TODAY;
                        InterestBuffer."Interest Amount" := AccruedInt;
                        InterestBuffer."User ID" := USERID;
                        IF InterestBuffer."Interest Amount" <> 0 THEN
                            IF InterestBuffer.INSERT THEN BEGIN
                                Rec."FD Maturity Date" := TODAY;
                                Rec."Fixed Deposit Status" := Rec."Fixed Deposit Status"::Matured;
                                Rec.MODIFY;
                            END;
                    END;

                    COMMIT;

                    FDProcessing.RESET;
                    FDProcessing.SETRANGE(FDProcessing."Document No.", Rec."Document No.");
                    IF FDProcessing.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Recall FD Monthly Interest1", FALSE, FALSE, FDProcessing);
                    END;

                    Rec."Fixed Deposit Status" := Rec."Fixed Deposit Status"::Closed;
                    Rec.MODIFY;

                    MESSAGE(Text123);

                    CurrPage.CLOSE;
                end;
            }
            action("Accrue FD Interest")
            {
                Image = Report2;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Accrue FD Interest1";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        fnUpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Application Date" := TODAY;
        Rec."User ID" := USERID;
        //Rec."Global Dimension 1 Code" := 'FOSA';
        Rec."Account Type" := 'FIXED';

        fnUpdateControls();
    end;

    trigger OnOpenPage()
    begin
        fnUpdateControls
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        PictureExists: Boolean;
        AccountTypes: Record "FD Processing1";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        // Charges: Record char;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer1";
        FDType: Record "Fixed Deposit Type1";
        Vend: Record "Bank Account";
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Fixed Deposit Type1";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        UnclearedLoan: Decimal;
        LineN: Integer;
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GenSetup: Record "Funds General Setup";
        ObjFDProcessing: Record "FD Processing1";
        ObjGroup: Boolean;
        undisplay: Integer;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text0001: Label 'Status must be pending Approval';
        ThisPartEditable: Boolean;
        FDRec: Record "FD Processing1";
        SFactory: Codeunit "Approval Page Management";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,FixedDeposits,CloudPesaApps,AgentApps,LoanOfficerDetails,GuarantorSub,PettyCash,PaybillChanges;
        FDProcessing: Record "FD Processing1";
        Txt060: Label 'Are you sure you want to recall this Fixed deposit? Recalling the FD will retain any earned interest and mark this FD as closed.';
        Text123: Label 'Fixed Deposit Successfully recalled and closed.';
        Txt061: Label 'Are you sure you want to recall this Fixed deposit? Recalling the FD will  forefeit the existing earned interest and mark this FD as closed.';
        AccruedInt: Decimal;
        IntBufferNo: Integer;
        CallEditable: Boolean;

    local procedure fnUpdateControls()
    begin
        IF Rec."Fixed Deposit Status" <> Rec."Fixed Deposit Status"::"Open " THEN
            ThisPartEditable := FALSE

        ELSE
            ThisPartEditable := TRUE;


        IF Rec."Fixed Deposit Status" = Rec."Fixed Deposit Status"::Active THEN
            CallEditable := TRUE
        ELSE
            CallEditable := FALSE;
    end;
}

