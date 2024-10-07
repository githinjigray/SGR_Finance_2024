pageextension 50026 "Workflow User Group EXT" extends "Workflow User Group"
{
    layout
    {

    }
    trigger OnOpenPage()

    begin
        // UserSetup.Reset();
        // UserSetup.SetRange("User ID", UserId);
        // UserSetup.SetRange(, true);
        // if not UserSetup.FindFirst() then begin
        //     Error('Not Allowed to create/Edit Workflows');
        // end
    end;

    var
        UserSetup: Record "User Setup";
}
