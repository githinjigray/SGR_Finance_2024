page 50506 "HR Online Attachments"
{
    ApplicationArea = All;
    //     ApplicationArea = All;
    //     Caption = 'HR Online Attachments';
    //     PageType = List;
    //     SourceTable = "HR Online Attachment";
    //     UsageCategory = Lists;
    //     Editable = false;
    //     DeleteAllowed = false;

    //     layout
    //     {
    //         area(content)
    //         {
    //             repeater(General)
    //             {
    //                 field(Email; Rec.Email)
    //                 {
    //                     ApplicationArea = All;
    //                     ToolTip = 'Specifies the value of the Email field.';
    //                     Editable = false;
    //                 }
    //                 field("File Name"; Rec."File Name")
    //                 {
    //                     ApplicationArea = All;
    //                     ToolTip = 'Specifies the value of the File Name field.';
    //                     Editable = false;
    //                 }
    //                 field("Document Description"; Rec.Description)
    //                 {
    //                     ApplicationArea = All;
    //                     ToolTip = 'Specifies the value of the Document Description field.';
    //                     Editable = false;
    //                 }
    //                 field("Created On"; Rec."Created On")
    //                 {
    //                     ApplicationArea = All;
    //                     ToolTip = 'Specifies the value of the Created On field.';
    //                     Editable = false;
    //                 }
    //                 field("Document Attached"; Rec."Document Attached")
    //                 {
    //                     ApplicationArea = All;
    //                     ToolTip = 'Specifies the value of the Document Attached field.';
    //                     Editable = false;
    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(Processing)
    //         {
    //             action(DocAttach)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'View Attachment';
    //                 Image = Attach;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ToolTip = 'View an attachment.';

    //                 trigger OnAction()
    //                 begin
    //                     if rec."Document Attached" then
    //                         Hyperlink('http://portal.hopewwkenya.org/OnlineAttachments/' + rec."File Name")
    //                     else
    //                         Error(Rec.Description + ' Not Attached.');
    //                 end;
    //             }
    //         }
    //     }
}
