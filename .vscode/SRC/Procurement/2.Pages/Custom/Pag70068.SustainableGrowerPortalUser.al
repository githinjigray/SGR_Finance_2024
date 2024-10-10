page 70068 "Sustainable Grower Portal User"
{
    ApplicationArea = All;
    Caption = 'Sustainable Growers Portal User';
    PageType = List;
    SourceTable = "Sustainable Grower Portal User";
    UsageCategory = Lists;
    DeleteAllowed = true;
    Editable = true;
    // CardPageId = PortalUserCard;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field(FirstName; Rec.FirstName)
                {
                    ToolTip = 'Specifies the value of the FirstName field.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Full Name field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ToolTip = 'Specifies the value of the Authentication Email field.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.';
                }
                field("Change Password"; Rec."Change Password")
                {
                    ToolTip = 'Specifies the value of the Change Password field.';
                }
                field("Record Type"; Rec."Record Type")
                {
                    ToolTip = 'Specifies the value of the Record Type field.';
                }
                field("Record ID"; Rec."Record ID")
                {
                    ToolTip = 'Specifies the value of the Record ID field.';
                }
                field("Password Value"; Rec."Password Value")
                {
                    ToolTip = 'Specifies the value of the Password Value field.';
                }
                field(PasswordChanged; Rec.PasswordChanged)
                {
                    ToolTip = 'Specifies the value of the PasswordChanged field.';
                }
                field(Notified; Rec.Notified)
                {
                    ToolTip = 'Specifies the value of the Notified field.';
                }
                field("Notification Date"; Rec."Notification Date")
                {
                    ToolTip = 'Specifies the value of the Notification Date field.';
                }
                // field("Id Number"; Rec."Id Number")
                // {
                //     ToolTip = 'Specifies the value of the Id Number field.';
                // }
                // field(LastName; Rec.LastName)
                // {
                //     ToolTip = 'Specifies the value of the LastName field.';
                // }
                // field(MiddleName; Rec.MiddleName)
                // {
                //     ToolTip = 'Specifies the value of the MiddleName field.';
                // }
                field("Updated By"; Rec."Updated By")
                {
                    ToolTip = 'Specifies the value of the Updated By field.';
                }
                field("Updated On"; Rec."Updated On")
                {
                    ToolTip = 'Specifies the value of the Updated On field.';
                }
                field(Emailsent; Rec.Emailsent)
                {
                    ToolTip = 'Specifies the value of the Emailsent field.';
                }
                field("Notified On"; Rec."Notified On")
                {
                    ToolTip = 'Specifies the value of the Notified On field.';
                }
                // field(SystemId; Rec.SystemId)
                // {
                //     ToolTip = 'Specifies the value of the SystemId field.';
                // }
                // field(SystemCreatedAt; Rec.SystemCreatedAt)
                // {
                //     ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                // }
                // field(SystemCreatedBy; Rec.SystemCreatedBy)
                // {
                //     ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                // }
                // field(SystemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                // }
                // field(SystemModifiedBy; Rec.SystemModifiedBy)
                // {
                //     ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                // }
                // field("Last Modified Date"; Rec."Last Modified Date")
                // {
                //     ToolTip = 'Specifies the value of the Last Modified Date field.';
                // }
            }
        }
    }
}
