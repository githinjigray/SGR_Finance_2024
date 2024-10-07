page 50051 "Fixed Deposit Bids"
{
    PageType = List;
    SourceTable = "Fixed Deposit Bids1";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("FD Duration"; Rec."FD Duration")
                {
                }
                field(Rate; Rec.Rate)
                {
                }
            }
        }
    }

    actions
    {
    }
}

