page 70054 "Vendor Regions of Operation"
{
    ApplicationArea = All;
    Caption = 'Vendor Regions of Operation';
    PageType = List;
    SourceTable = "Vendor Regions of Operation";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("County Code"; Rec."County Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County Code field.';
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County Name field.';
                }
            }
        }
    }
}
