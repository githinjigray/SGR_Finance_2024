page 50051 "Fixed Deposit Bids"
{
    PageType = List;
    SourceTable = "Fixed Deposit Bids1";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("FD Duration"; Rec."FD Duration")
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

