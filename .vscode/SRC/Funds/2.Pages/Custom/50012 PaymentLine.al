page 50012 "Payment Line"
{
    Caption = 'Payment Line';
    PageType = ListPart;
    SourceTable = "Payment Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payee Type"; Rec."Payee Type")
                {
                    ToolTip = 'Specifies the value of the Payee Type field.';
                    ApplicationArea = All;
                }
                field("Payee No."; Rec."Payee No.")
                {
                    ToolTip = 'Specifies the value of the Payee No. field.';
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                    ApplicationArea = All;
                }
                // field("Payment Code"; Rec."Payment Code")
                // {
                //     ToolTip = 'Specifies the value of the Payment Code field.';
                //     ApplicationArea = All;
                // }
                // field("Payment Code Description"; Rec."Payment Code Description")
                // {
                //     ToolTip = 'Specifies the value of the Payment Code Description field.';
                //     ApplicationArea = All;
                // }
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
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Posting Group field.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                    ApplicationArea = All;
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ToolTip = 'Specifies the value of the VAT Code field.';
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                    ApplicationArea = All;
                }
                field("VAT Amount(LCY)"; Rec."VAT Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the VAT Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Code field.';
                    ApplicationArea = All;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Amount field.';
                    ApplicationArea = All;
                }
                field("Withholding Tax Amount(LCY)"; Rec."Withholding Tax Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Withholding VAT Code"; Rec."Withholding VAT Code")
                {
                    ToolTip = 'Specifies the value of the Withholding VAT Code field.';
                    ApplicationArea = All;
                }
                field("Withholding VAT Amount"; Rec."Withholding VAT Amount")
                {
                    ToolTip = 'Specifies the value of the Withholding VAT Amount field.';
                    ApplicationArea = All;
                }
                field("Withholding VAT Amount(LCY)"; Rec."Withholding VAT Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Withholding VAT Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the value of the Net Amount field.';
                    ApplicationArea = All;
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Net Amount(LCY) field.';
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field("Phone No."; rec."Phone No.")
                {
                    ToolTip = 'Specifies the employee  Phone number ';
                    ApplicationArea = All;
                }
            }
        }
    }
}
