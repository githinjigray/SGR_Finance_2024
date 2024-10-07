tableextension 50023 "Workflow User Group mem 2" extends "Workflow User Group Member"
{
    fields
    {
        field(70000; "Approver Type"; Option)
        {
            Caption = 'Approver Type';
            DataClassification = ToBeClassified;
            OptionMembers = Approver,Reviewer,Authorizer;
            OptionCaption = 'Approver,Reviewer,Authorizer';
        }
    }
}
