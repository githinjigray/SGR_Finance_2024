page 70613 "Employee Signature2"
{
    Caption = 'Employee Signature';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Employee;

    layout
    {
        //area(content)
        // {
        //     field(Image; rec."Employee Signature")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         ShowCaption = false;
        //         ToolTip = 'Specifies the Signature of the employee.';
        //     }
        // }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    rec.TestField("No.");
                    rec.TestField("First Name");
                    rec.TestField("Last Name");

                    //     if rec."Employee Signature".HasValue() then
                    //         if not Confirm(OverrideImageQst) then
                    //             exit;

                    //    // FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    //     if FileName = '' then
                    //         exit;

                    //     Clear(rec."Employee Signature");
                    //  //   rec."Employee Signature".ImportFile(FileName, ClientFileName);
                    //     rec.Modify(true);

                    //    // if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    rec.TestField("No.");
                    rec.TestField("First Name");
                    rec.TestField("Last Name");

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    // ExportPath := TemporaryPath + rec."No." + Format(rec."Employee Signature".MediaId);
                    // rec."Employee Signature".ExportFile(ExportPath);

                    // FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    // Clear(rec."Employee Signature");
                    // rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;

        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        MimeTypeTok: Label 'image/jpeg', Locked = true;
        DeleteExportEnabled: Boolean;

    local procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField("No.");
        Rec.TestField("First Name");
        Rec.TestField("Last Name");

        // if Rec."Employee Signature".HasValue() then
        //     if not Confirm(OverrideImageQst) then
        //         exit;

        // if Camera.GetPicture(PictureInstream, PictureDescription) then begin
        //     Clear(Rec."Employee Signature");
        //     Rec."Employee Signature".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
        //     Rec.Modify(true)
        // end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
       // DeleteExportEnabled := rec."Employee Signature".HasValue;
    end;
}
// {
//     Caption = 'Employee Signature';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     LinksAllowed = false;
//     PageType = CardPart;
//     SourceTable = Employee;
//     ApplicationArea = All;

//         layout
//         {
//             area(content)
//             {
//                 field("Employee Signature"; rec."Employee Signature")
//                 {
//                     ApplicationArea = all;
//                     ShowCaption = false;
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {

//                 action(ImportPicture)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Import';
//                     Image = Import;
//                     ToolTip = 'Import a picture file.';

//                     trigger OnAction()
//                     var
//                         FileManagement: Codeunit "File Management";
//                         FileName: Text;
//                         ClientFileName: Text;
//                     begin
//                         rec.TestField("No.");
//                         rec.TestField("First Name");
//                         rec.TestField("Last Name");

//                         if Image.HasValue then
//                             if not Confirm(OverrideImageQst) then
//                                 exit;

//                         FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
//                         if FileName = '' then
//                             exit;

//                         Clear(rec."Employee Signature");
//                         rec."Employee Signature".ImportFile(FileName, ClientFileName);
//                         if not rec.Insert(true) then
//                             rec.Modify(true);

//                         if FileManagement.DeleteServerFile(FileName) then;
//                     end;
//                 }
//                 action(ExportFile)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Export';
//                     Enabled = DeleteExportEnabled;
//                     Image = Export;
//                     ToolTip = 'Export the picture to a file.';

//                     trigger OnAction()
//                     var
//                         DummyPictureEntity: Record "Picture Entity";
//                         FileManagement: Codeunit "File Management";
//                         ToFile: Text;
//                         ExportPath: Text;
//                     begin
//                         rec.TestField("No.");
//                         rec.TestField("First Name");
//                         rec.TestField("Last Name");

//                         ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
//                         ExportPath := TemporaryPath + Rec."No." + Format(rec."Employee Signature".MediaId);
//                         Rec.Image.ExportFile(ExportPath);

//                         FileManagement.ExportImage(ExportPath, ToFile);
//                     end;
//                 }
//                 action(DeletePicture)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Delete';
//                     Enabled = DeleteExportEnabled;
//                     Image = Delete;
//                     ToolTip = 'Delete the record.';

//                     trigger OnAction()
//                     begin
//                         rec.TestField("No.");

//                         if not Confirm(DeleteImageQst) then
//                             exit;

//                         Clear(Image);
//                         rec.Modify(true);
//                     end;
//                 }
//             }
//         }

//         trigger OnAfterGetCurrRecord()
//         begin
//             SetEditableOnPictureActions;
//         end;

//         trigger OnOpenPage()
//         begin
//             // CameraAvailable := CameraProvider.IsAvailable;
//             // if CameraAvailable then
//             //   CameraProvider := CameraProvider.Create;
//         end;

//         var
//             //[RunOnClient]
//             //[WithEvents]
//             //CameraProvider: DotNet CameraProvider;
//             CameraAvailable: Boolean;
//             OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
//             DeleteImageQst: Label 'Are you sure you want to delete the picture?';
//             SelectPictureTxt: Label 'Select a picture to upload';
//             DeleteExportEnabled: Boolean;

//         local procedure SetEditableOnPictureActions()
//         begin
//             DeleteExportEnabled := Image.HasValue;
//         end;

//         // trigger CameraProvider::PictureAvailable(PictureName: Text;PictureFilePath: Text)
//         // var
//         //     File: File;
//         //     Instream: InStream;
//         // begin
//         //     if (PictureName = '') or (PictureFilePath = '') then
//         //       exit;

//         //     if Image.HasValue then
//         //       if not Confirm(OverrideImageQst) then begin
//         //         if Erase(PictureFilePath) then;
//         //         exit;
//         //       end;

//         //     File.Open(PictureFilePath);
//         //     File.CreateInStream(Instream);

//         //     Clear(Image);
//         //     Image.ImportStream(Instream,PictureName);
//         //     if not Insert(true) then
//         //       Modify(true);

//         //     File.Close;
//         //     if Erase(PictureFilePath) then;
//         // end;
// }

