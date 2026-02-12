report 50015 "Bank Acc ReconciliationTest"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Acc ReconciliationTest.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {

            column(EmployeeTitle; EmployeeTitle)
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(BankAccNo; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }
            column(StmtNo; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StmtBal; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BankName; BankAccName)
            {
            }
            column(StmtDate; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(CashBookBal; CashBookBal)
            {
            }
            column(RecMsg; RecMsg)
            {
            }
            column(TotalUncreditedChqs; TotalUncreditedChqs)
            {
            }
            column(TotalUnpresentedChqs; TotalUnpresentedChqs)
            {
            }
            column(Pic; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            dataitem(BankRec; "Bank Acc. Reconciliation Line2")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                column(DocNo; BankRec."Document No.")
                {
                }
                column(Amount; BankRec.Difference)
                {
                }
                column(Description; BankRec.Description)
                {
                }
                column(ChequeNo; BankRec."Check No.")
                {
                }
                column(PostingDate; BankRec."Transaction Date")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Statement No.");
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

                Emp.Reset;
                Emp.SetRange(Emp."Employee User ID", "Bank Acc. Reconciliation"."User ID");
                if Emp.FindFirst then begin
                    PreparedBy := Emp."First Name" + ' ' + Emp."Last Name";
                    EmployeeTitle := Emp."Job Title";
                end;

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Acc. Reconciliation"."Bank Account No.");
                if BankAccount.FindSet then begin
                    BankAccName := BankAccount.Name;
                end;

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Acc. Reconciliation"."Bank Account No.");
                if BankAccount.FindFirst then begin
                end;

                CashBookBal := 0;
                BankEntries.Reset;
                BankEntries.SetRange(BankEntries."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                BankEntries.SetRange(BankEntries."Posting Date", 0D, "Bank Acc. Reconciliation"."Statement Date");
                if BankEntries.FindSet then begin
                    repeat
                        CashBookBal := CashBookBal + BankEntries.Amount;
                    until BankEntries.Next = 0;
                end;

                TotalUncreditedChqs := 0;
                TotalUnpresentedChqs := 0;
                BankRecLine.Reset;
                BankRecLine.SetRange(BankRecLine."Bank Account No.", "Bank Account No.");
                BankRecLine.SetRange(BankRecLine."Statement Type", "Statement Type");
                BankRecLine.SetRange(BankRecLine."Statement No.", "Statement No.");
                BankRecLine.SetFilter(BankRecLine.Difference, '<>%1', 0);
                if BankRecLine.FindSet then begin
                    repeat
                        if BankRecLine.Difference > 0 then begin
                            //UncreditedChqs
                            TotalUncreditedChqs := TotalUncreditedChqs + BankRecLine.Difference;
                        end else begin
                            //UnpresentedChqs
                            TotalUnpresentedChqs := TotalUnpresentedChqs + BankRecLine.Difference;
                        end;
                    until BankRecLine.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        DefinedBankNo: Code[10];
        DefinedStatementNo: Code[10];
        CashBookBal: Decimal;
        BankStatBalance: Decimal;
        BankAccount: Record "Bank Account";
        BankRecHdr: Record "Bank Acc. Reconciliation";
        BankRecLine: Record "Bank Acc. Reconciliation Line2";
        TotalDifference: Decimal;
        TotalUncreditedChqs: Decimal;
        TotalUnpresentedChqs: Decimal;
        BankAccNo: Code[10];
        BankAccName: Text[50];
        BankRecLineDiff: Record "Bank Acc. Reconciliation Line";
        BankRecCash: Record "Bank Acc. Reconciliation";
        RecMsg: Text[250];
        BancRecReconciled: Record "Bank Acc. Reconciliation Line";
        TotalReconciled: Decimal;
        LastStatBal: Decimal;
        DiffBal: Decimal;
        CompanyInfo: Record "Company Information";
        BankEntries: Record "Bank Account Ledger Entry";
        BankRecLineNew: Record "Bank Acc. Reconciliation Line";
        PeriodStart: Date;
        PeriodEnd: Date;
        ApprovalType: text;
        PreparedBy: Text;
        EmployeeTitle: Text;
        Emp: Record Employee;
        WorkflowStepInstanceArchive: Record "Workflow Step Instance Archive";
        WorkflowStepArgumentArchive: Record "Workflow Step Argument Archive";
        WorkflowUserGroupMember: Record "Workflow User Group Member";
}

