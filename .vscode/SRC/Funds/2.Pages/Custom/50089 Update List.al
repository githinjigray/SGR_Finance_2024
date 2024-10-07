page 50089 "Update List"
{
    ApplicationArea = All;
    Caption = 'Update List';
    PageType = List;
    SourceTable = Update;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("GL Account No"; Rec."GL Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GL Account No field.';
                }
            }
        }
    }
}
