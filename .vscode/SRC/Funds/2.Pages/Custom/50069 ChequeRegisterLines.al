page 50069 "Cheque Register Lines"
{
    Caption = 'Cash Register Lines';
    PageType = ListPart;
    SourceTable = "Cheque Register Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Denomination; Rec.Denomination)
                {
                    ToolTip = 'Specifies the value of the Denomination field.', Comment = '%';
                }
                field("Denomination Description"; Rec."Denomination Description")
                {
                    ToolTip = 'Specifies the value of the Denomination Description field.', Comment = '%';
                }
                field("Denomination Amount"; Rec."Denomination Amount")
                {
                    ToolTip = 'Specifies the value of the Denomination Amount field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }

            }
        }
    }
}
