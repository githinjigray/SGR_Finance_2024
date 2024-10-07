page 70024 "Purchase Requisition Codes"
{
    PageType = List;
    SourceTable = "Purchase Requisition Codes";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Type"; rec."Requisition Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Requisition Code"; rec."Requisition Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
            }
        }
    }

    actions
    {
    }
}

