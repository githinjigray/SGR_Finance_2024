table 50503 "Document Attachment Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Document Attachment Header"."Entry No.";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Upload Directory"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(10; "File Name"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(11; "File Type"; Enum "File Type Options")
        {
            DataClassification = CustomerContent;
        }
        field(12; "File Extension"; Text[30])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                case LowerCase("File Extension") of
                    'jpg', 'jpeg', 'bmp', 'png', 'tiff', 'tif', 'gif':
                        "File Type" := "File Type"::Image;
                    'pdf':
                        "File Type" := "File Type"::PDF;
                    'docx', 'doc':
                        "File Type" := "File Type"::Word;
                    'xlsx', 'xls':
                        "File Type" := "File Type"::Excel;
                    'pptx', 'ppt':
                        "File Type" := "File Type"::PowerPoint;
                    'msg':
                        "File Type" := "File Type"::Email;
                    'xml':
                        "File Type" := "File Type"::XML;
                    else
                        "File Type" := "File Type"::Other;
                end;
            end;
        }
        field(13; "File Size"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(15; "File Path"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Clean File Path"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(20; "External File Link"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(200; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            ValidateTableRelation = false;
        }
        field(201; "Created Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(205; "Last Modified By"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            ValidateTableRelation = false;
        }
        field(206; "Last Modified Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(8000; "Id"; Guid)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        IF "Line No." = 0 THEN
            "Line No." := GetNextLineNo();
        SetCreatedDateTime();
        Id := CreateGuid();
    end;

    trigger OnModify()
    begin
        SetLastModifiedDateTime();
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure GetNextLineNo(): Integer
    var
        DocumentAttachmentLine: Record "Document Attachment Line";
    begin
        DocumentAttachmentLine.RESET;
        DocumentAttachmentLine.SETCURRENTKEY("Document Entry No.");
        DocumentAttachmentLine.SETRANGE("Document Entry No.", "Document Entry No.");
        if DocumentAttachmentLine.FINDLAST then
            exit(DocumentAttachmentLine."Line No." + 1);
        exit(1);
    end;

    local procedure SetCreatedDateTime()
    begin
        if "Created By" = '' then
            "Created By" := USERID;
        "Created Date Time" := CURRENTDATETIME;
    end;

    local procedure SetLastModifiedDateTime()
    begin
        "Last Modified By" := USERID;
        "Last Modified Date Time" := CURRENTDATETIME;
    end;
}

enum 50590 "File Type Options"
{
    Extensible = true;
    value(0; " ")
    {
        CaptionML = ENU = ' ';
    }
    value(1; "Image")
    {
        CaptionML = ENU = 'Image';
    }
    value(2; "PDF")
    {
        CaptionML = ENU = 'PDF';
    }
    value(3; "Word")
    {
        CaptionML = ENU = 'Word';
    }
    value(4; "Excel")
    {
        CaptionML = ENU = 'Excel';
    }
    value(5; "PowerPoint")
    {
        CaptionML = ENU = 'PowerPoint';
    }
    value(6; "Email")
    {
        CaptionML = ENU = 'Email';
    }
    value(7; "XML")
    {
        CaptionML = ENU = 'XML';
    }
    value(8; "Other")
    {
        CaptionML = ENU = 'Other';
    }
}