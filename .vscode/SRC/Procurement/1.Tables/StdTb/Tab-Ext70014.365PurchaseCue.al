tableextension 70014 "365 Purchase Cue" extends "Purchase Cue"
{
    fields
    {
        field(6500; "Contract Requests"; Integer)
        {
            CalcFormula = Count("Contract Request Header");
            FieldClass = FlowField;
        }
        field(6501; "Active Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2");
            FieldClass = FlowField;
        }
        field(6502; "In-Active Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2" where("Contract Status" = const(Terminated)));
            FieldClass = FlowField;
        }
        field(6503; "Expired Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2" where("Contract Status" = const(Expired)));
            FieldClass = FlowField;
        }
    }
}
