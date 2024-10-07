pageextension 50019 "Sales Order EXT" extends "Sales Order"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 3 Code';
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 4 Code';
            }
            field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 5 Code';
            }
            field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 6 Code';
            }
        }
        addlast(General)
        {
            field("Order From"; Rec."Order From")
            {
                ApplicationArea = all;
                ToolTip = 'Order From';
            }
        }
    }
}
