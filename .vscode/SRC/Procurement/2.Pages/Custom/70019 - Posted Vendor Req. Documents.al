page 70019 "Posted Vendor Req. Documents"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea=all;
    UsageCategory = Lists;
    SourceTable = "Vendor Required Documents";
    SourceTableView = WHERE("LPO Invoice No" = FILTER(<> ''));

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
                field("LPO Invoice No"; rec."LPO Invoice No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LPO Vendor No."; rec."LPO Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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

