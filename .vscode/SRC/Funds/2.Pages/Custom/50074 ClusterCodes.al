page 50074 "Cluster Codes"
{
    ApplicationArea = All;
    Caption = 'Cluster Codes';
    PageType = List;
    SourceTable = "Cluster Codes";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cluster Code"; Rec."Cluster Code")
                {
                    ToolTip = 'Specifies the value of the Cluster Code field.';
                    ApplicationArea = All;
                }
                field("Cluster Name"; Rec."Cluster Name")
                {
                    ToolTip = 'Specifies the value of the Cluster Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
