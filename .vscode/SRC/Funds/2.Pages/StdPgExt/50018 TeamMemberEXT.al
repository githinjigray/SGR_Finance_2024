pageextension 50018 "Team Member EXT" extends "Team Member Activities"
{
    layout
    {
        addbefore("Time Sheets to Approve")
        {
            field("Requests to Approve"; rec."Requests to Approve")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
                DrillDownPageId = "Requests to Approve";
            }
        }
        modify("Approved Time Sheets")
        {
            Visible = false;
        }
        modify("Open Time Sheets")
        {
            Visible = false;
        }
        modify("Submitted Time Sheets")
        {
            Visible = false;
        }
        modify("Rejected Time Sheets")
        {
            Visible = false;
        }
        modify("Current Time Sheet")
        {
            Visible = false;
        }
    }


}
