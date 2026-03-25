report 70009 "Dummy Report 3"
{
    ApplicationArea = All;
    Caption = 'Approval Update-bank reconciliation';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = false;
    Permissions = TableData "Bank Acc. Reconciliation" = rm, tabledata "Approval Entry" = rm;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            //DataItemTableView = where("Journal Batch Name" = filter('TAKEON'));
            //RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            begin
                "Bank Acc. Reconciliation".Status := "Bank Acc. Reconciliation".Status::Open;
                if "Bank Acc. Reconciliation".Modify() then begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Document No.", "Bank Acc. Reconciliation"."Statement No.");
                    if ApprovalEntry.FindSet() then begin
                        repeat
                            ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                            ApprovalEntry.Modify();
                        until ApprovalEntry.Next() = 0;
                    end;
                end;

            end;
        }

    }
    var
        EntryNo: Code[20];
        ApprovalEntry: Record "Approval Entry";
}
