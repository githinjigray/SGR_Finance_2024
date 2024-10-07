table 70032 HRPortalUsers
{
    Caption = 'HRPortalUsers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; employeeNo; Code[200])
        {
            TableRelation = Employee."No.";
        }
        field(3; IdNo; Code[20])
        {
        }
        field(4; password; Text[250])
        {
        }
        field(5; "Authentication Email"; Text[80])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Authentication Email");
            end;
        }
        field(6; changedPassword; Boolean)
        {
        }
        field(7; State; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;

        }
        field(8; "Last Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; employeeName; Code[200])
        {
            // TableRelation = Employee."No.";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
