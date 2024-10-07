page 50049 "Interest Buffer FD"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Interest Buffer1";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Interest Date"; Rec."Interest Date")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                }
                field("Interest Amount(LCY)"; Rec."Interest Amount(LCY)")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Transferred; Rec.Transferred)
                {
                }
            }
        }
    }

    actions
    {
    }
}

