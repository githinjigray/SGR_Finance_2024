page 70050 "Procurement Period Setup"
{
    ApplicationArea = All;
    Caption = 'Procurement Period Setup';
    PageType = List;
    SourceTable = "Procurement Period";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Period name"; Rec."Period name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period name field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Procurement Emails")
            {
                RunObject = page "Procurement Email Messages";
                ToolTip = 'Procurement Emails';
            }
        }
    }
}
