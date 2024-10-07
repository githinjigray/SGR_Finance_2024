report 50110 "Approval Comments Report"
{
    ApplicationArea = All;
    Caption = 'Approval Comments Report';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ApprovalCommentLine; "Approval Comment Line")
        {
            RequestFilterFields = "Document No.";
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(Comment; Comment)
            {
            }
            column(DateandTime; "Date and Time")
            {
            }
            column(UserID; "User ID")
            {
            }
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
