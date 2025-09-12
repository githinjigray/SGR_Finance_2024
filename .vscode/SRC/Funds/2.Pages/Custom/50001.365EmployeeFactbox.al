page 50001 "365 Employee Factbox"
{
    Caption = 'Invoice Terms & Conditions';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Employee;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(Image; Rec.Signature)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the Signature of the employee';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportMedia)
            {
                ApplicationArea = All;
                Caption = 'Import Media';
                Image = Import;

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: Instream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec.Signature.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec.Signature);
                    Rec.Modify(true);
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

    [Scope('OnPrem')]
    procedure ImportThis()
    begin

    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing Signature will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the Signature?';
        SelectPictureTxt: Label 'Select a Signature to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify the Employee name before you can import a Signature.';
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.Find();

        if Rec.Signature.HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Signature);
            Rec.Signature.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Signature.HasValue;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(Camera.IsAvailable());
    end;
}
