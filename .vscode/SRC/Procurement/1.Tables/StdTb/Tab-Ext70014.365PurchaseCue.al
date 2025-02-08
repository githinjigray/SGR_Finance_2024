tableextension 70014 "365 Purchase Cue" extends "Purchase Cue"
{
    fields
    {
        field(70000; "Contract Requests"; Integer)
        {
            CalcFormula = Count("Contract Request Header");
            FieldClass = FlowField;
        }
        field(70001; "Active Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2");
            FieldClass = FlowField;
        }
        field(70002; "In-Active Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2" where("Contract Status" = const(Terminated)));
            FieldClass = FlowField;
        }
        field(70003; "Expired Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2" where("Contract Status" = const(Expired)));
            FieldClass = FlowField;
        }
    }
}
