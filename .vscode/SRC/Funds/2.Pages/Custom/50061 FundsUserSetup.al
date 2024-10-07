page 50061 "Funds User Setup"
{
    ApplicationArea = All;
    Caption = 'Funds User Setup';
    PageType = List;
    SourceTable = "Funds User Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.';
                    ApplicationArea = All;
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    ToolTip = 'Specifies the value of the Receipt Journal Template field.';
                    ApplicationArea = All;
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Receipt Journal Batch field.';
                    ApplicationArea = All;
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Template field.';
                    ApplicationArea = All;
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Payment Journal Batch field.';
                    ApplicationArea = All;
                }
                field("Fund Transfer Template Name"; Rec."Fund Transfer Template Name")
                {
                    ToolTip = 'Specifies the value of the Fund Transfer Template Name field.';
                    ApplicationArea = All;
                }
                field("Fund Transfer Batch Name"; Rec."Fund Transfer Batch Name")
                {
                    ToolTip = 'Specifies the value of the Fund Transfer Batch Name field.';
                    ApplicationArea = All;
                }
                field("Funds Claim Template"; Rec."Funds Claim Template")
                {
                    ToolTip = 'Specifies the value of the Funds Claim Template field.';
                    ApplicationArea = All;
                }
                field("Funds Claim  Batch"; Rec."Funds Claim  Batch")
                {
                    ToolTip = 'Specifies the value of the Funds Claim  Batch field.';
                    ApplicationArea = All;
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ToolTip = 'Specifies the value of the Imprest Template field.';
                    ApplicationArea = All;
                }
                field("Imprest Batch"; Rec."Imprest Batch")
                {
                    ToolTip = 'Specifies the value of the Imprest Batch field.';
                    ApplicationArea = All;
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    ToolTip = 'Specifies the value of the Default Receipts Bank field.';
                    ApplicationArea = All;
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    ToolTip = 'Specifies the value of the Default Payment Bank field.';
                    ApplicationArea = All;
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    ToolTip = 'Specifies the value of the Default Petty Cash Bank field.';
                    ApplicationArea = All;
                }
                field("JV Template"; Rec."JV Template")
                {
                    ToolTip = 'Specifies the value of the JV Template field.';
                    ApplicationArea = All;
                }
                field("JV Batch"; Rec."JV Batch")
                {
                    ToolTip = 'Specifies the value of the JV Batch field.';
                    ApplicationArea = All;
                }
                field("Reversal Template"; Rec."Reversal Template")
                {
                    ToolTip = 'Specifies the value of the Reversal Template field.';
                    ApplicationArea = All;
                }
                field("Reversal Batch"; Rec."Reversal Batch")
                {
                    ToolTip = 'Specifies the value of the Reversal Batch field.';
                    ApplicationArea = All;
                }
                field("Invoice Template"; Rec."Invoice Template")
                {
                    ToolTip = 'Specifies the value of the Invoice Template field.';
                    ApplicationArea = All;
                }
                field("Invoice Batch"; Rec."Invoice Batch")
                {
                    ToolTip = 'Specifies the value of the Invoice Batch field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        AppprovalRequests: page "Requests to Approve";
}
