tableextension 50006 "Approval Entry Ext" extends "Approval Entry"
{
    fields
    {
        field(70000; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(70001; "Document Source"; Code[150])
        {
            Caption = 'Document Source';
            DataClassification = ToBeClassified;
        }
        field(70002; Document_Type; Text[100])
        {
            Caption = 'Document_Type';
            DataClassification = ToBeClassified;
        }
        field(70003; "Rejection Comments"; Text[250])
        {
            Caption = 'Rejection Comments';
            DataClassification = ToBeClassified;
        }
        field(70004; "Record Opened"; Boolean)
        {
            Caption = 'Record Opened';
            DataClassification = ToBeClassified;
        }
        field(70005; "Web Portal Approval"; Boolean)
        {
            Caption = 'Web Portal Approval';
            DataClassification = ToBeClassified;
        }
        field(70006; "Sender Employee No"; Code[20])
        {
            Caption = 'Sender Employee No';
            DataClassification = ToBeClassified;
        }
        field(70007; "Approver Employee No"; Code[20])
        {
            Caption = 'Approver Employee No';
            DataClassification = ToBeClassified;
        }
        field(70008; "Sender Name"; Text[100])
        {
            Caption = 'Sender Name';
            DataClassification = ToBeClassified;
        }
        field(70009; "Approver Name"; Text[100])
        {
            Caption = 'Approver Name';
            DataClassification = ToBeClassified;
        }
        field(70010; "Rejection Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejection Sent';
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                ProcurementManagement: Codeunit "Procurement Management";
            begin
                //  if Status = Status::Rejected then
                //  ProcurementManagement.CreateRejectionEmails("Document No.");
            end;
        }
    }

}
