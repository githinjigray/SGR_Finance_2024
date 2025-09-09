report 70009 "Dummy Report 3"
{
    ApplicationArea = All;
    Caption = 'Approval Update-PRF';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = false;
    Permissions = TableData "Approval Entry" = rm;

    dataset
    {
        dataitem("Purchase Requisitions"; "Purchase Requisitions")
        {
            //DataItemTableView = where("Journal Batch Name" = filter('TAKEON'));
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            begin
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Document No.", "Purchase Requisitions"."No.");
                if ApprovalEntry.FindSet() then begin
                    repeat
                        ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;

                    "Purchase Requisitions".Status:="Purchase Requisitions".Status::Open;
                    "Purchase Requisitions".Validate(Status);
                    "Purchase Requisitions".Modify();
                end;
            end;
        }

    }
    var
        EntryNo: Code[20];
        ApprovalEntry: Record "Approval Entry";
}
