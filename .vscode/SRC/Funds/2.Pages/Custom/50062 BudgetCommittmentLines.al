page 50062 "Budget Committment Lines"
{
    Caption = 'Budget Committment Lines';
    PageType = ListPart;
    SourceTable = "Budget Committment";
    ApplicationArea = All;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {               
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field("Month Budget"; Rec."Month Budget")
                {
                    ToolTip = 'Specifies the value of the Month Budget field.';
                    ApplicationArea = All;
                }
                field("Month Actual"; Rec."Month Actual")
                {
                    ToolTip = 'Specifies the value of the Month Actual field.';
                    ApplicationArea = All;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                    ApplicationArea = All;
                }
                field(Budget; Rec.Budget)
                {
                    ToolTip = 'Specifies the value of the Budget field.';
                    ApplicationArea = All;
                }
                field(Committed; Rec.Committed)
                {
                    ToolTip = 'Specifies the value of the Committed field.';
                    ApplicationArea = All;
                }
                field("Committed By"; Rec."Committed By")
                {
                    ToolTip = 'Specifies the value of the Committed By field.';
                    ApplicationArea = All;
                }
                field("Committed Date"; Rec."Committed Date")
                {
                    ToolTip = 'Specifies the value of the Committed Date field.';
                    ApplicationArea = All;
                }
                field("Committed Time"; Rec."Committed Time")
                {
                    ToolTip = 'Specifies the value of the Committed Time field.';
                    ApplicationArea = All;
                }
                field("Committed Machine"; Rec."Committed Machine")
                {
                    ToolTip = 'Specifies the value of the Committed Machine field.';
                    ApplicationArea = All;
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                    ApplicationArea = All;
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ToolTip = 'Specifies the value of the Cancelled By field.';
                    ApplicationArea = All;
                }
                field("Cancelled Date"; Rec."Cancelled Date")
                {
                    ToolTip = 'Specifies the value of the Cancelled Date field.';
                    ApplicationArea = All;
                }
                field("Cancelled Time"; Rec."Cancelled Time")
                {
                    ToolTip = 'Specifies the value of the Cancelled Time field.';
                    ApplicationArea = All;
                }                
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
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
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.', Comment = '%';
                }

                field("Vendor/Cust No."; Rec."Vendor/Cust No.")
                {
                    ToolTip = 'Specifies the value of the Vendor/Cust No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
