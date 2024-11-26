pageextension 50040 "365 Bank Acc. Rec. Lines" extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Payee Name/Received From"; Rec."Payee Name/Received From")
            {
                ApplicationArea = all;
                ToolTip = 'Payee Name/Received From';
                Editable = false;
            }
        }
    }
}
