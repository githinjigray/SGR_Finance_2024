page 50037 "Imprest Surrender Line"
{
    Caption = 'Imprest Surrender Line';
    PageType = ListPart;
    SourceTable = "Imprest Surrender Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Imprest Code"; Rec."Imprest Code")
                {
                    ToolTip = 'Specifies the value of the Imprest Code field.';
                    ApplicationArea = All;
                }
                field("Imprest Code Description"; Rec."Imprest Code Description")
                {
                    ToolTip = 'Specifies the value of the Imprest Code Description field.';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Amount Advanced"; Rec."Amount Advanced")
                {
                    ToolTip = 'Specifies the value of the Amount Advanced field.';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Amount Advanced (LCY)"; Rec."Amount Advanced (LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount Advanced (LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ToolTip = 'Specifies the value of the Actual Spent field.';
                    ApplicationArea = All;
                }
                field("Actual Spent(LCY)"; Rec."Actual Spent(LCY)")
                {
                    ToolTip = 'Specifies the value of the Actual Spent(LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Difference; Rec.Difference)
                {
                    ToolTip = 'Specifies the value of the Difference field.';
                    ApplicationArea = All;
                }
                field("Difference(LCY)"; Rec."Difference(LCY)")
                {
                    ToolTip = 'Specifies the value of the Difference(LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Specifies the value of the Receipt No. field.';
                    ApplicationArea = All;
                }
                field("Cash Receipt"; Rec."Cash Receipt")
                {
                    ToolTip = 'Specifies the value of the Cash Receipt field.';
                    ApplicationArea = All;
                }
                field("Cash Receipt(LCY)"; Rec."Cash Receipt(LCY)")
                {
                    ToolTip = 'Specifies the value of the Cash Receipt(LCY) field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expense Account type"; Rec."Expense Account type")
                {
                    ToolTip = 'Specifies the value of the Expense Account type field.';
                    ApplicationArea = All;
                }

                field("Expense Account No."; Rec."Expense Account No.")
                {
                    ToolTip = 'Specifies the value of the Expense Account No. field.';
                    ApplicationArea = All;
                }
                field("Expense Acc. Name"; Rec."Expense Acc. Name")
                {
                    ToolTip = 'Specifies the value of the Expense Acc. Name field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    ToolTip = 'Specifies the value of the Global Dimension 4 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 5 Codefield.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 6 Codefield.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
            }
        }
    }
}
