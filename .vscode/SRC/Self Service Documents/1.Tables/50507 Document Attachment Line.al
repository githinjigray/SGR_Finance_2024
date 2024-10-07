page 50507 "Document Attachment Line"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Document Attachment Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("File Size"; Rec."File Size")
                {
                    ApplicationArea = All;
                }
                field(ViewFile; Link)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'View File';
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        Hyperlink(rec."External File Link");
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }

    var
        Link: Text;
}