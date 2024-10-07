pageextension 70502 "365 Phys. Inventory Journal" extends "Phys. Inventory Journal"
{
    layout
    {
        addafter("Item No.")
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = all;
                ToolTip = 'Part No.';
                Editable = false;
            }
        }
        addafter("Unit Cost")
        {
            field("Alternative Part No. 1"; Rec."Alternative Part No. 1")
            {
                ApplicationArea = all;
                ToolTip = '"Alternative Part No. 1';
                Editable = false;
            }
            field("Alternative Part No. 2"; Rec."Alternative Part No. 2")
            {
                ApplicationArea = all;
                ToolTip = '"Alternative Part No. 2';
                Editable = false;
            }
            field("Alternative Part No. 3"; Rec."Alternative Part No. 3")
            {
                ApplicationArea = all;
                ToolTip = '"Alternative Part No. 3';
                Editable = false;
            }
        }
    }
}
