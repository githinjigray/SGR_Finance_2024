pageextension 50002 "365 Employee Card" extends "Employee Card"
{
    layout
    {
        addlast(General)
        {

            field("Employee User ID"; Rec."Employee User ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee User ID field.', Comment = '%';
            }
        }

        addlast(factboxes)
        {
            part(EmployeeSignature; "365 Employee Factbox")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Signature';
                Visible = true;
                Editable = true;
                UpdatePropagation = Both;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
