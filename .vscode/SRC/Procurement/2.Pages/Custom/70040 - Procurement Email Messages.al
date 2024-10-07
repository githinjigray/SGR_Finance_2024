page 70040 "Procurement Email Messages"
{
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Procurement Email Messages";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sender Name"; rec."Sender Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Sender Name field';
                }
                field("Sender Address"; rec."Sender Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Sender Address field';
                }
                field(Subject; rec.Subject)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Subject field';
                }
                field(Recipients; rec.Recipients)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Recipients field';
                }
                field("Recipients CC"; rec."Recipients CC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Recipients CC field';
                }
                field("Recipients BCC"; rec."Recipients BCC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Recipients BCC field';
                }
                field(Body; rec.Body)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Body field';
                }
                field(HtmlFormatted; rec.HtmlFormatted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HTML formatted field';
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the created by field';
                }
                field("Date Created"; rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Date Created field';
                }
                field("Time Created"; rec."Time Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Time created field';
                }
                field("Email Sent"; rec."Email Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Email sent field';
                }
                field("Date Sent"; rec."Date Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Date sent field';
                }
                field("Time Sent"; rec."Time Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Time sent field';
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Document No. field';
                }
            }
        }
    }

    actions
    {
    }
}

