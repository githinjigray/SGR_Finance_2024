page 50050 "Imprest Card Application"
{
    Caption = 'Imprest Card Application';
    PageType = Card;
    SourceTable = "Imprest Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the value of the Bank Account No. field.';
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ToolTip = 'Specifies the value of the Bank Account Name field.';
                    ApplicationArea = All;
                }
                field("Bank Account Balance"; Rec."Bank Account Balance")
                {
                    ToolTip = 'Specifies the value of the Bank Account Balance field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Imprest Remaining Amount"; Rec."Imprest Remaining Amount")
                {
                    ToolTip = 'Specifies the value of the Imprest Remaining Amount field.';
                    ApplicationArea = All;
                }
                field("Imprest Remaining Amount(LCY)"; Rec."Imprest Remaining Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Imprest Remaining Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Date From"; Rec."Date From")
                {
                    ToolTip = 'Specifies the value of the Date From field.';
                    ApplicationArea = All;
                }
                field("Date To"; Rec."Date To")
                {
                    ToolTip = 'Specifies the value of the Date To field.';
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ToolTip = 'Specifies the value of the Employee Posting Group field.';
                    ApplicationArea = All;
                }
                field(Surrendered; Rec.Surrendered)
                {
                    ToolTip = 'Specifies the value of the Surrendered field.';
                    ApplicationArea = All;
                }
                field("Imprest Surrender No."; Rec."Imprest Surrender No.")
                {
                    ToolTip = 'Specifies the value of the Imprest Surrender No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    ApplicationArea = All;
                }
                field("Depature Time"; Rec."Depature Time")
                {
                    ToolTip = 'Specifies the value of the Depature Time field.';
                    ApplicationArea = All;
                }
                field("Return Time"; Rec."Return Time")
                {
                    ToolTip = 'Specifies the value of the Return Time field.';
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                    ApplicationArea = All;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.';
                    ApplicationArea = All;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field.';
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                    ApplicationArea = All;
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    ToolTip = 'Specifies the value of the Reversed By field.';
                    ApplicationArea = All;
                }
                field("Reversal Date"; Rec."Reversal Date")
                {
                    ToolTip = 'Specifies the value of the Reversal Date field.';
                    ApplicationArea = All;
                }
                field("Reversal Time"; Rec."Reversal Time")
                {
                    ToolTip = 'Specifies the value of the Reversal Time field.';
                    ApplicationArea = All;
                }
                field("Reversal Posting Date"; Rec."Reversal Posting Date")
                {
                    ToolTip = 'Specifies the value of the Reversal Posting Date field.';
                    ApplicationArea = All;
                }
                field(Reimbursed; Rec.Reimbursed)
                {
                    ToolTip = 'Specifies the value of the Reimbursed field.';
                    ApplicationArea = All;
                }
                field("Reimbursment Date"; Rec."Reimbursment Date")
                {
                    ToolTip = 'Specifies the value of the Reimbursment Date field.';
                    ApplicationArea = All;
                }
                field("Reimbursement No."; Rec."Reimbursement No.")
                {
                    ToolTip = 'Specifies the value of the Reimbursement No. field.';
                    ApplicationArea = All;
                }
                field("CPV No."; Rec."CPV No.")
                {
                    ToolTip = 'Specifies the value of the CPV No. field.';
                    ApplicationArea = All;
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ToolTip = 'Specifies the value of the Incoming Document Entry No. field.';
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    ApplicationArea = All;
                }
                field("HR Job Grade"; Rec."HR Job Grade")
                {
                    ToolTip = 'Specifies the value of the HR Job Grade field.';
                    ApplicationArea = All;
                }
                field("HR Employee No."; Rec."HR Employee No.")
                {
                    ToolTip = 'Specifies the value of the HR Employee No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
