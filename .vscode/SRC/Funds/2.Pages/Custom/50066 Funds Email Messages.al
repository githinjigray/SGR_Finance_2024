page 50066 "Funds Email Messages"
{
    ApplicationArea = All;
    Editable=true;
    Caption = 'Funds Email Messages';
    PageType = List;
    SourceTable = "Funds Email Messages";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sender Name field.';
                }
                field("Sender Address"; Rec."Sender Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sender Address field.';
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subject field.';
                }
                field(Recipients; Rec.Recipients)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recipients field.';
                }
                field("Recipients CC"; Rec."Recipients CC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recipients CC field.';
                }
                field("Recipients BCC"; Rec."Recipients BCC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recipients BCC field.';
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Body field.';
                }
                field(HtmlFormatted; Rec.HtmlFormatted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HtmlFormatted field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Time Created"; Rec."Time Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Created field.';
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Sent field.';
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Sent field.';
                }
                field("Time Sent"; Rec."Time Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Sent field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
            }
        }
    }
}
