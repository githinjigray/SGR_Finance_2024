page 50078 "Payments Profile"
{
    Caption = 'Payments Profile', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {

            part(FundsActivities; "Funds Account Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
            }
        }
        area(embedding)
        {



        }
        area(sections)
        {

            group("Funds Management")
            {
                Caption = 'Funds Management';
                Image = ReferenceData;
                ToolTip = 'Monitor your cash flow and set up cash flow forecasts.';

                action("Payment Vouchers")
                {
                    RunObject = Page "Payment List";
                    RunPageView = WHERE(Status = FILTER(<> Approved));
                }
                action("Cash Vouchers")
                {
                    RunObject = Page "Cash Payment List";
                    RunPageView = WHERE(Status = FILTER(<> Approved));
                }
            }
            group("Approved Funds Transactions")
            {
                Caption = 'Approved Funds Transactions';
                Image = ReferenceData;
                ToolTip = 'Approved Funds Transactions';

                action("Approved Payment Vouchers")
                {
                    RunObject = Page "Payment List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action("Approved Cash Vouchers")
                {
                    RunObject = Page "Cash Payment List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }



            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.';

                action("Posted Payment Vouchers")
                {
                    RunObject = Page "Posted Payment List";
                }
                action("Posted Cash Vouchers")
                {
                    RunObject = Page "Posted Cash Payment List";
                }
            }
        }
        area(creation)
        {

        }
        area(processing)
        {

        }
    }
}

