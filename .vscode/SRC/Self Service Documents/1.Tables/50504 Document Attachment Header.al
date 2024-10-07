table 50504 "Document Attachment Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Record Id"; RecordId)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Table Id"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Document Type"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(69; "Description"; Text[100])
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
        field(210; Status; Enum "Document Attachement Status")
        {
            DataClassification = CustomerContent;
        }
        field(211; "Approval Comment"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(215; "Rejected"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(216; "Rejected By"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            ValidateTableRelation = false;
        }
        field(217; "Rejected Date Time"; DateTime)
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
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();
        SetCreatedDateTime;
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

    local procedure GetNextEntryNo(): Integer
    var
        DocumentAttachmentHeader: Record "Document Attachment Header";
    begin
        DocumentAttachmentHeader.Reset();
        DocumentAttachmentHeader.SetCurrentKey("Entry No.");
        DocumentAttachmentHeader.SetFilter("Entry No.", '>%1', 0);
        if DocumentAttachmentHeader.FindLast() then
            exit(DocumentAttachmentHeader."Entry No." + 1);
        exit(1);
    end;

    local procedure SetCreatedDateTime()
    begin
        if "Created By" = '' then
            "Created By" := UserId();
        "Created Date Time" := CurrentDateTime();
    end;

    local procedure SetLastModifiedDateTime()
    begin
        "Last Modified By" := UserId();
        "Last Modified Date Time" := CurrentDateTime();
    end;
}

enum 50000 "Document Attachement Status"
{
    Extensible = true;
    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(2; "Approved")
    {
        Caption = 'Approved';
    }
    value(3; "Rejected")
    {
        Caption = 'Rejected';
    }
}