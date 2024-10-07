page 70028 "Vendor Required Documents"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Vendor Required Documents";
    SourceTableView = WHERE("LPO Invoice No" = FILTER(''));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Code"; rec."Document Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Description"; rec."Document Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Verified"; rec."Document Verified")
                {
                    ApplicationArea = All;
                }
                field("Verified By"; rec."Verified By")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Links)
            {
            }
            systempart(Control8; Notes)
            {
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
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if rec.HasLinks then begin
            rec."Document Attached" := true;
            rec.Modify;
        end;
    end;
}

