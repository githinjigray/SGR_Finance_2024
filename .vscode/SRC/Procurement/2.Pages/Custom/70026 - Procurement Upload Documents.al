page 70026 "Procurement Upload Documents"
{
    PageType = List;
    SourceTable = "Procurement Upload Documents";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)

                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {

                    ToolTip = 'Specifies the value of the code field.';
                    ApplicationArea = All;
                }
                field("Document Description"; Rec."Document Description")
                {

                    ToolTip = 'Specifies the value of the Document Description field.';
                    ApplicationArea = All;
                }
                field("Document Code"; Rec."Document Code")
                {

                    ToolTip = 'Specifies the value of the Document code field.';
                    ApplicationArea = All;
                }
                field("Tender Stage"; Rec."Tender Stage")
                {
                    ToolTip = 'Specifies the value of the Tender stage field.';
                    ApplicationArea = All;
                }
                field("Document Mandatory"; Rec."Document Mandatory")
                {

                    ToolTip = 'Specifies the value of the Document Mandatory field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

