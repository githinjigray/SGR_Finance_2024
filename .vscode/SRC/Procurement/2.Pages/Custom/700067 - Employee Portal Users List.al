page 70067 "Employee Portal Users"
{
    ApplicationArea = All;
    Caption = 'Employee Portal Users';
    PageType = List;
    SourceTable = HRPortalUsers;
    UsageCategory = Lists;
    InsertAllowed = true;
    Editable = true;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(employeeNo; Rec.employeeNo)
                {
                    ToolTip = 'Specifies the Employee Number';
                }
                field(IdNo; Rec.IdNo)
                {
                    ToolTip = 'Specifies the Employee ID Number';
                }
                field(password; Rec.password)
                {
                    ToolTip = 'Specifies the employee password Number';
                }
                field(changedPassword; Rec.changedPassword)
                {
                    ToolTip = 'Specifies whether or not an employee has changed their password';
                }
            }
        }
    }
}
