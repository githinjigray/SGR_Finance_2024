pageextension 50001 "365 G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        addafter("Income/Balance")
        {

            field("Account Location"; Rec."Account Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Account Location field.', Comment = '%';
            }
        }
    }
}
