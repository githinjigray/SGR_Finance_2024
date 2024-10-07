page 50501 "Selfservice Documents"
{
    Caption = 'Selfservice Documents';
    PageType = Card;
    SourceTable = "Selfservice Documents";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
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
