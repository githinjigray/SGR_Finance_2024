page 50502 "Documents & Links"
{
    ApplicationArea = All;
    Caption = 'Documents & Links';
    PageType = List;
    SourceTable = "Documents & Links";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Description field.';
                }
                field("Document Link"; Rec."Document Link")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Link field.';
                }
                field(Shared; Rec.Shared)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shared field.';
                }
            }
        }
    }
}
