pageextension 50043 "365 Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {

    }
    actions
    {
        addfirst("A&ccount")
        {
            action("GL Entries -Excel")
            {
                RunObject = report "GL Entries-Excel Export";
                ApplicationArea = all;
                image = Excel;

                trigger OnAction()
                begin
                end;
            }
        }
    }
}
