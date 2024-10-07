tableextension 50011 "Team Member Cue EXT" extends "Team Member Cue"
{
    fields
    {
        field(70000; "Requests to Approve"; Integer)
        {
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"), Status = FILTER(Open)));
        }
    }

}
