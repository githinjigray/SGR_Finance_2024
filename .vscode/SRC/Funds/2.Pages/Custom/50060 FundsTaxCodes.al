page 50060 "Funds Tax Codes"
{
    ApplicationArea = All;
    Caption = 'Funds Tax Codes';
    PageType = List;
    SourceTable = "Funds Tax Code";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tax Code"; Rec."Tax Code")
                {
                    ToolTip = 'Specifies the value of the Tax Code field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Posting Group field.';
                    ApplicationArea = All;
                }
                field("Base Percentage (%)"; Rec."Base Percentage (%)")
                {
                    ToolTip = 'Specifies the value of the Base Percentage (%) field.';
                    ApplicationArea = All;
                }
                field("Current VAT"; Rec."Current VAT")
                {
                    ToolTip = 'Specifies the value of the Current VAT field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
