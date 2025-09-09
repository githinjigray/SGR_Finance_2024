page 50090 "365 BC Attachments"

{
    PageType = ListPart;
    SourceTable = "Document Attachment";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                { ApplicationArea = All; }

                field("Attachment Type"; Rec."Attachment Type")
                { ApplicationArea = All; }
            }
        }
    }


    actions
    {
        area(processing)
        {
            //             action(UploadDocument)
            //             {
            //                 ApplicationArea = All;
            //                 trigger OnAction()
            //                 var
            //                     RecRef: RecordRef;
            //                     TempBlob: Record "365 TempBlob";
            //                     FileManagement: Codeunit "File Management";
            //                     FileName: Text;
            //                     InStream: InStream;
            //                     DocAttachment: Record "Document Attachment";
            //                 begin
            //                    // FileName := FileManagement.BLOBImportWithFilter(TempBlob, 'Select a file', '', '*.pdf;*.docx;*.jpg;*.*');
            //                     TempBlob.Blob.CreateInStream(InStream);

            //                     DocAttachment.Init();
            //                     DocAttachment."Table ID" := DATABASE::"Payment Header";
            //                     DocAttachment."No." := Rec."No.";
            //                     DocAttachment."File Name" := FileName;
            //                     DocAttachment."File Extension" :=
            // FileManagement.GetExtension(FileName);
            //                     DocAttachment."Document Reference ID".ImportStream(InStream, '', FileName);
            //                     DocAttachment.Insert(true);
            //                 end;
            //             }
        }
    }
}




