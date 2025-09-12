page 50032 "Imprest Line"
{
    Caption = 'Imprest Line';
    PageType = ListPart;
    SourceTable = "Imprest Line";
    ApplicationArea = all;


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
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                    ApplicationArea = All;
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
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the unit cost.';
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity';
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
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
            }
        }
    }
}
