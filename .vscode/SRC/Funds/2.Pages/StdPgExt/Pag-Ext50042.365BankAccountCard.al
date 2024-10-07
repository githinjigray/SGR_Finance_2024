pageextension 50042 "365 Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field("Show In Sales Invoice"; Rec."Show In Sales Invoice")
            {
                ApplicationArea = all;
                ToolTip = 'Show In Sales Invoice';
            }
        }
    }
}
