pageextension 70019 "365 Purchase Agent Activities" extends "Purchase Agent Activities"
{
    layout
    {
        addfirst(content)
        {
            cuegroup("Contract Management")
            {
                Caption = 'Contract Management';
                field("Contract Requests"; Rec."Contract Requests")
                {
                    DrillDownPageID = "Contract Requests";
                    ToolTip = 'Contract Requests';
                    ApplicationArea = all;
                }
                field("Active Contracts"; Rec."Active Contracts")
                {
                    DrillDownPageID = Contracts;
                    ToolTip = 'Active Contract List';
                    ApplicationArea = all;
                }
                field("Terminated Contracts"; Rec."In-Active Contracts")
                {
                    DrillDownPageID = Contracts;
                    ToolTip = 'Terminated Contract List';
                    ApplicationArea = all;
                }
                field("Expired Contracts"; Rec."Expired Contracts")
                {
                    DrillDownPageID = "Expired Contracts";
                    ToolTip = 'Expired Contract List';
                    ApplicationArea = all;
                }
            }
        }
    }
}
