page 50504 SelfServiceDocumentList
{
    ApplicationArea = All;
    Caption = 'SelfService Documents';
    PageType = List;
    SourceTable = "Selfservice Documents";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Code field.';
                }
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Description field.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
            }
        }
    }
}
