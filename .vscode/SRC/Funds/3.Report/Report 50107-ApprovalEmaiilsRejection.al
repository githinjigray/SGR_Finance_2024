report 50107 "Approval Emaiils-Rejection"
{
    ApplicationArea = All;
    Caption = 'Approval Emaiils-Rejection';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = false;
    dataset
    {
        dataitem(ApprovaComments; "Approval Comment Line")
        {
            DataItemTableView = where("email sent" = filter(false));
            column(DocumentNo; "Document No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                ProcurementManagement: Codeunit "Procurement Management";
            begin
                ProcurementManagement.CreateRejectionEmails("Document No.");
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
