report 50105 "Bank Acc. Reconciliations Post"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Acc. Reconciliations Post.rdlc';
    Caption = 'Posted Bank Account Reconciliation Report';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {

            RequestFilterFields = "Statement No.";
            column(DiffAmount; DiffAmount)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Statement Date")
            {
            }
            column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(TotalAppliedAmount_BankAccReconciliation; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(TotalTransactionAmount_BankAccReconciliation; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Statement Ending Balance")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Statement Amount" = FILTER(< 0), Difference = FILTER(<> 0));
                column(CheckNo_BankAccReconciliationLine; "Check No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Transaction Date")
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Statement Line No.")
                {
                }
                column(Description_BankAccReconciliationLine; Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Statement Amount")
                {
                }
            }
            dataitem("<Bank Acc. Reconciliation Ln1>"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Statement Amount" = FILTER(> 0), Difference = FILTER(<> 0));
                column(CheckNo_BankAccReconciliationLine1; "Check No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn1; "Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; "Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; "Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine1; Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; "Statement Amount")
                {
                }
            }
            dataitem("<Bank Acc. Reconciliation LN3>"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Applied Amount" = FILTER(<> 0));
                column(CheckNo_BankAccReconciliationLine3; "Check No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn3; "Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine3; "Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine3; "Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine3; Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine3; "Statement Amount")
                {
                }
                column(AppliedAmount_BankAccReconciliationLN3; "<Bank Acc. Reconciliation LN3>"."Applied Amount")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("statement No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(r; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(ApprovalType; ApprovalType)
                {
                }

                dataitem(Employee; Employee)
                {
                    DataItemLink = "Employee User ID" = FIELD("Approver ID");
                    column(EmployeeFirstName;
                    Employee."First Name")
                    {
                    }
                    column(EmployeeMiddleName; Employee."Middle Name")
                    {
                    }
                    column(EmployeeLastName; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Signature")
                    {
                    }
                    column(JobTitle_Employee; Employee."Job Title")
                    {
                    }
                }
                trigger OnAfterGetRecord()
                begin

                    BankAccountStatement2.Reset();
                    BankAccountStatement2.SetRange("Statement Ending Balance", "Approval Entry".Amount);
                    if not BankAccountStatement2.FindFirst() then
                        CurrReport.Skip();


                    ApprovalType := '';

                    WorkflowStepInstanceArchive.RESET;
                    WorkflowStepInstanceArchive.SETRANGE(WorkflowStepInstanceArchive."Workflow Code", "Approval Entry"."Approval Code");
                    WorkflowStepInstanceArchive.SETRANGE(WorkflowStepInstanceArchive."Function Name", 'CREATEAPPROVALREQUESTS');
                    IF WorkflowStepInstanceArchive.FINDFIRST THEN BEGIN
                        WorkflowStepArgumentArchive.RESET;
                        WorkflowStepArgumentArchive.SETRANGE(WorkflowStepArgumentArchive.ID, WorkflowStepInstanceArchive.Argument);
                        IF WorkflowStepArgumentArchive.FINDFIRST THEN BEGIN
                            WorkflowUserGroupMember.RESET;
                            WorkflowUserGroupMember.SETRANGE(WorkflowUserGroupMember."Workflow User Group Code", WorkflowStepArgumentArchive."Workflow User Group Code");
                            WorkflowUserGroupMember.SETRANGE(WorkflowUserGroupMember."User Name", "Approval Entry"."Approver ID");
                            IF WorkflowUserGroupMember.FINDFIRST THEN BEGIN
                                IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Reviewer THEN
                                    ApprovalType := 'Reviewer';
                                IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Approver THEN
                                    ApprovalType := 'Approver';
                                IF WorkflowUserGroupMember."Approver Type" = WorkflowUserGroupMember."Approver Type"::Authorizer THEN
                                    ApprovalType := 'Authorizer';
                            END;
                        END;
                    END;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                TotalDiffFunc();

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");
                    BankAccountBalanceasperCashBook := Bank."Net Change";

                    BankStatementLine.Reset;
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    BankStatementLine.SetFilter(BankStatementLine."Applied Amount", '=%1', 0);
                    BankStatementLine.SetFilter(BankStatementLine.Difference, '<>%1', 0);
                    if BankStatementLine.Find('-') then
                        repeat
                            if BankStatementLine."Statement Amount" < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            else
                                if BankStatementLine."Statement Amount" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        until BankStatementLine.Next = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    BankStatBalance := "Bank Account Statement"."Statement Ending Balance";


                    //Sysre
                    Clear(RecAmt);
                    BankAccReconLine.Reset;
                    BankAccReconLine.SetRange(BankAccReconLine."Bank Account No.", "Bank Account No.");
                    BankAccReconLine.SetRange(BankAccReconLine."Statement No.", "Statement No.");
                    if BankAccReconLine.Find('-') then begin
                        repeat
                            if BankAccReconLine."Applied Amount" <> 0 then
                                RecAmt := RecAmt + BankAccReconLine."Applied Amount"
                        until BankAccReconLine.Next = 0;
                    end;

                    BankDiff := 0;
                    BankDiff := ("Statement Ending Balance" - "Balance Last Statement");

                    DiffAmount := 0;
                    DiffAmount := BankDiff - RecAmt;

                    //insert entries posted after reconciliation
                    StartDate := 0D;
                    StartDate := CalcDate('-CM', "Statement Date");
                    TotalNotAvailable := 0;



















                    //IF  BankDiff <> RecAmt THEN ERROR ('The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts');


                    //IF (UnpresentedChequesTotal+TotalDifference) =(BankAccountBalanceasperCashBook-BankStatBalance) THEN
                    if BankDiff = RecAmt then
                        ReconciliationStatement := 'The bank reconciliation is complete!'
                    else
                        ReconciliationStatement := ' The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);

                //ReconciliationStatement:='Reconciliation is incomplete please go through it again';
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

    var
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Account Statement Line";
        CompanyInfo: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "Bank Account Statement Line";
        BankRecUnPresented: Record "Bank Account Statement Line";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "Bank Account Statement Line";
        BankAccountStatement2: Record "Bank Account Statement";
        StartDate: Date;
        BankAccountLedgerEntry2: Record "Bank Account Ledger Entry";
        TotalNotAvailable: Decimal;
        DiffAmount: Decimal;
        ApprovalType: text;
        WorkflowStepInstanceArchive: Record "Workflow Step Instance Archive";
        WorkflowStepArgumentArchive: Record "Workflow Step Argument Archive";
        WorkflowUserGroupMember: Record "Workflow User Group Member";

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Account Statement"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Account Statement"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            //MESSAGE('%1',TotalDifference);
            until BankRecPresented.Next = 0;
        end;
    end;
}

