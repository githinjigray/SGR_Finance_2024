report 50111 ApprovalUpdate
{
    ApplicationArea = All;
    Caption = 'Approval Update 2';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Employee; Employee)
        {
            trigger OnAfterGetRecord()
            var
                ApprovalsCu: Codeunit "Portal Approvals";
            begin
                Message(ApprovalsCu.GetOpenApprovalEntries('LVCT0250', ''));
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
