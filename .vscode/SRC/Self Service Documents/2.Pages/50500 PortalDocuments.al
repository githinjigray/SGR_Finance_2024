page 50500 PortalDocuments
{
    ApplicationArea = All;
    Caption = 'Portal Attachments';
    PageType = List;
    SourceTable = "Portal Documents";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("DocumentNo."; Rec."DocumentNo.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DocumentNo. field.';
                    Editable = false;
                }
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Code field.';
                    Editable = false;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Description field.';
                    Editable = false;
                }
                field("SharePoint URL"; Rec."SharePoint URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SharePoint URL field.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'View Attachment';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View an attachment.';

                trigger OnAction()
                begin
                    if rec."Document Attached" then
                        Hyperlink(rec."SharePoint URL")
                    else
                        Error(Rec."Document Description" + ' Not Attached.');
                end;
            }
        }
    }
}
