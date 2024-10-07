page 70043 "Procurement Periods"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Period";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period name"; Rec."Period name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Period Name field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the End Date field';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the closed field';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(TXT0001) then begin
                        Rec.Closed := true;
                        Rec.Modify;
                        Message(TXT0002);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    trigger OnOpenPage()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    var
        TXT0001: Label 'Are you sure you want to close the procurement period?';
        TXT0002: Label 'Procurement Period Close successfully!';
}

