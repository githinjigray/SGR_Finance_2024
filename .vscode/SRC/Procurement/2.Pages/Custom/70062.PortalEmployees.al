page 70062 "Portal Employees"
{
    ApplicationArea = All;
    Caption = 'Employee Portal Users';
    PageType = List;
    SourceTable = HRPortalUsers;
    UsageCategory = Lists;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(employeeNo; Rec.employeeNo)
                {
                    ToolTip = 'Specifies the value of the employeeNo field.';
                }
                field(employeeName; Rec.employeeName)
                {
                    ToolTip = 'Specifies the value of the employeeName field.';
                }


                field("Authentication Email"; Rec."Authentication Email")
                {
                    ToolTip = 'Specifies the value of the Authentication Email field.';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.';
                }
                field(IdNo; Rec.IdNo)
                {
                    ToolTip = 'Specifies the value of the IdNo field.';
                }
                field(password; Rec.password)
                {
                    ToolTip = 'Specifies the value of the password field.';
                }
                field(changedPassword; Rec.changedPassword)
                {
                    ToolTip = 'Specifies the value of the changedPassword field.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Test")
            {
                Image = MakeDiskette;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page PortalDocuments;
                trigger OnAction()
                var
                    hrportal: codeunit HRPortal;
                begin
                    //hrportal.sendPurchaseRequisitionApproval('A00034', '0359');
                end;
            }
        }
    }
}

