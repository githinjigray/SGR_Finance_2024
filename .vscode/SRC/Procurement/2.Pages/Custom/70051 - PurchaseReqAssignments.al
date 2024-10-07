page 70051 "Purchase Req. Assignments"
{
    Caption = 'Purchase Requisition Assignments';
    PageType = ListPart;
    SourceTable = "Purchase Req. Assignments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No.';
                    ToolTip = 'Specifies the Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name';
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Assigned By"; Rec."Assigned By")
                {
                    ApplicationArea = All;
                    Caption = 'Assigned By';
                    ToolTip = 'Specifies the value of the Assigned DateTime field.';
                }
                field("Assigned DateTime"; Rec."Assigned DateTime")
                {
                    ApplicationArea = All;
                    Caption = 'Assigned DateTime';
                    ToolTip = 'Specifies the value of the Assigned DateTime field.';
                }
            }
        }
    }
}
