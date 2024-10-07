page 50057 "Payment Codes"
{
    ApplicationArea = All;
    Caption = 'Payment Codes';
    PageType = List;
    SourceTable = "Funds Transaction Code";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the "Account Type" field.';
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
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Posting Group field.';
                    ApplicationArea = All;
                }
                field("Include VAT"; Rec."Include VAT")
                {
                    ToolTip = 'Specifies the value of the Include VAT field.';
                    ApplicationArea = All;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ToolTip = 'Specifies the value of the VAT Code field.';
                    ApplicationArea = All;
                }
                field("Include Withholding Tax"; Rec."Include Withholding Tax")
                {
                    ToolTip = 'Specifies the value of the Include Withholding Tax field.';
                    ApplicationArea = All;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Code field.';
                    ApplicationArea = All;
                }
                field("Include Withholding VAT"; Rec."Include Withholding VAT")
                {
                    ToolTip = 'Specifies the value of the Include Withholding VAT field.';
                    ApplicationArea = All;
                }
                field("Withholding VAT Code"; Rec."Withholding VAT Code")
                {
                    ToolTip = 'Specifies the value of the Withholding VAT Code field.';
                    ApplicationArea = All;
                }
                field("Funds Claim Code"; Rec."Funds Claim Code")
                {
                    ToolTip = 'Specifies the value of the Funds Claim Code field.';
                    ApplicationArea = All;
                }
                field("Payroll Taxable"; Rec."Payroll Taxable")
                {
                    ToolTip = 'Specifies the value of the Payroll Taxable field.';
                    ApplicationArea = All;
                }
                field("Payroll Allowance Code"; Rec."Payroll Allowance Code")
                {
                    ToolTip = 'Specifies the value of the Payroll Allowance Code field.';
                    ApplicationArea = All;
                }
                field("Payroll Deduction Code"; Rec."Payroll Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Payroll Deduction Code field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
