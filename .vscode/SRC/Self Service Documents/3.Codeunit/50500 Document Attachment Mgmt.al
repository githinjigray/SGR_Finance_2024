codeunit 50500 "Document Attachment Mgmt."
 {
//     trigger OnRun()
//     begin
//     end;

//     [Scope('OnPrem')]
//     procedure UploadFileOnD365(WindowTitle: Text[50]; ClientFileName: Text; ServerFolderName: Text; DocumentEntryNo: Integer; RecRef: RecordRef): Boolean
//     var
//         FileManagement: Codeunit "File Management";
//         DocumentAttachmentLine: Record "Document Attachment Line";
//         Filter: Text;
//         RootPath: Text;
//         CleanRootPath: Text;
//         FileName: Text[100];
//         FileExtension: Text[30];
//         FileSize: BigInteger;
//         FileModifyDate: Date;
//         FileModifyTime: Time;
//         TempServerFileName: Text;
//         ServerFileName: Text;
//         AllowedFileTypes: TextConst ENU = 'Image files (*.bmp,*.jpg,*.jpeg)|*.bmp;*.jpg;*.jpeg|PDF files (*.pdf)|*.pdf';
//     begin
//         RootPath := 'C:\ERPDocuments\';
//         CleanRootPath := 'C:\\ERPDocuments\\';

//         Filter := FileManagement.GetToFilterText(AllowedFileTypes, ClientFileName);
//         if FileManagement.GetFileNameWithoutExtension(ClientFileName) = '' then
//             ClientFileName := '';

//         if not FileManagement.ServerDirectoryExists(RootPath + ServerFolderName) then
//             FileManagement.ServerCreateDirectory(RootPath + ServerFolderName);

//         TempServerFileName := UploadFileWithFilter(WindowTitle, ClientFileName, Filter, AllowedFileTypes);

//         FileName := FileManagement.GetFileName(TempServerFileName);
//         FileExtension := FileManagement.GetExtension(TempServerFileName);
//         FileManagement.GetServerFileProperties(TempServerFileName, FileModifyDate, FileModifyTime, FileSize);

//         ServerFileName := RootPath + ServerFolderName + '\' + FileName;
//         CleanRootPath := CleanRootPath + ServerFolderName + '\\' + FileName;

//         if File.Copy(TempServerFileName, ServerFileName) then begin
//             File.Erase(TempServerFileName);
//             DocumentAttachmentLine.INIT;
//             DocumentAttachmentLine."Document Entry No." := DocumentEntryNo;
//             DocumentAttachmentLine."Upload Directory" := ServerFolderName;
//             DocumentAttachmentLine."File Name" := FileName;
//             DocumentAttachmentLine.Validate("File Extension", FileExtension);
//             DocumentAttachmentLine."File Size" := Format(FileSize);
//             DocumentAttachmentLine."File Path" := ServerFileName;
//             DocumentAttachmentLine."Clean File Path" := CleanRootPath;
//             DocumentAttachmentLine."External File Link" := '';
//             if DocumentAttachmentLine.Insert(true) then begin
//                 OnAfterUploadFileOnD365(DocumentAttachmentLine);
//                 Message('File Upload Successful.');
//             end;
//         end;
//     end;

//     local procedure UploadFileWithFilter(WindowTitle: Text[50]; ClientFileName: Text; FileFilter: Text; ExtFilter: Text): Text
//     var
//         Uploaded: Boolean;
//         ServerFileName: Text;
//         SingleFilterErr: TextConst ENU = 'Specify a file filter and an extension filter when using this function.';
//     begin
//         ClearLastError();
//         if (FileFilter = '') XOR (ExtFilter = '') then
//             Error(SingleFilterErr);

//         Uploaded := Upload(WindowTitle, '', FileFilter, ClientFileName, ServerFileName);

//         if Uploaded then
//             exit(ServerFileName);

//         if GetLastErrorCode() <> '' then
//             Error('%1', GetLastErrorText());
//         exit('');
//     end;

//     [BusinessEvent(false)]
//     [Scope('OnPrem')]
//     local procedure OnAfterUploadFileOnD365(var DocumentAttachmentLine: Record "Document Attachment Line")
//     begin
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt.", 'OnAfterUploadFileOnD365', '', false, false)]
//     local procedure UploadFileToSharePoint(var DocumentAttachmentLine: Record "Document Attachment Line")
//     var
//         client: HttpClient;
//         SharePointEndpoint: Text;
//         Content: HttpContent;
//         Response: HttpResponseMessage;
//         ResponseTxt: Text;
//         Body: Text;
//     begin
//         SharePointEndpoint := 'http://localhost:8081/api/FileUpload';
//         Clear(Body);
//         Clear(Content);
//         Clear(Response);
//         Body := '{';
//         Body := Body + '"FileName": "' + DocumentAttachmentLine."File Name" + '",';
//         Body := Body + '"FileExtension": "' + DocumentAttachmentLine."File Extension" + '",';
//         Body := Body + '"FileLocalPath": "' + DocumentAttachmentLine."Clean File Path" + '",';
//         Body := Body + '"UploadFolder": "' + DocumentAttachmentLine."Upload Directory" + '"';
//         Body := Body + '}';
//         content.WriteFrom(Body);
//         client.Post(SharePointEndpoint, Content, Response);
//         if Response.IsSuccessStatusCode then begin
//             Response.Content.ReadAs(ResponseTxt);
//             DocumentAttachmentLine."External File Link" := ResponseTxt;
//             DocumentAttachmentLine.Modify(true);
//         end;
//     end;
 }
