page 50800 "Denominations Types Setup"
{
    ApplicationArea = All;
    Caption = 'Denominations Types Setup';
    PageType = List;
    SourceTable = "Denomination Types";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Denomintaion; Rec.Denomintaion)
                {
                    ToolTip = 'Specifies the value of the Denomintaion field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Denomination Description"; Rec."Denomination Description")
                {
                    ToolTip = 'Specifies the value of the Denomination Description field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Denomination Amount"; Rec."Denomination Amount")
                {
                    ToolTip = 'Specifies the value of the Denomination Amount field.', Comment = '%';
                    ApplicationArea = all;
                }
            }
        }
    }
}
