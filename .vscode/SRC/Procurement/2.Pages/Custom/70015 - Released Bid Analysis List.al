page 70015 "Released Bid Analysis List"
{
    CardPageID = "Bid Analysis Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Bid Analysis Header";
    SourceTableView = WHERE(Status = FILTER(Released | Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; REC."No.")
                {
                    ApplicationArea = All;
                }
                field("RFQ No."; REC."RFQ No.")
                {
                    ApplicationArea = All;
                }
                field("LPO No. Assigned"; REC."LPO No. Assigned")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Document Date"; REC."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; REC."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 6 Code"; REC."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                }

                field(Status; REC.Status)
                {
                    ApplicationArea = All;
                }
                field("User ID"; REC."User ID")
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

