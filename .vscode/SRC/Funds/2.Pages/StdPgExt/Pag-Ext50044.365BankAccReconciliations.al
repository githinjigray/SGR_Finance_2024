pageextension 50044 "365 Bank Acc. Reconciliations" extends "Bank Acc. Reconciliation List"
{
    layout
    {
        addlast(Control1)
        {

            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field.', Comment = '%';
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
            }
        }
    }
}
