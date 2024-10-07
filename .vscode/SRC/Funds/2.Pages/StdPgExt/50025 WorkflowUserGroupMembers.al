pageextension 50025 "Workflow User Group Members2" extends "Workflow User Group Members"
{
    layout
    {
        addafter("Sequence No.")
        {
            field("Approver Type"; rec."Approver Type")
            {
                ApplicationArea = all;
                ToolTip = 'Approver Type';
            }
        }
    }
}
