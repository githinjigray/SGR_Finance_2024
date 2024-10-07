pageextension 70615 "Standard Employee Card2" extends "Employee Card"
{
    layout
    {
        addlast(factboxes)
        {
            part(employeesgnatue; "Employee Signature2")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
