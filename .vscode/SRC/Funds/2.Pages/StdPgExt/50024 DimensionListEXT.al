pageextension 50024 "Dimension List EXT" extends Dimensions
{
    layout
    {

    }
    actions
    {
        addafter("Dimension &Values")
        {
            action("Upload Dimension Values")
            {
                ApplicationArea = all;
                Caption = 'Upload Dimension Values';
                //RunObject = xmlport "Upload Dimension Values";
                ToolTip = 'Upload Dimension Values';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Visible=false;
            }
        }
    }
    trigger OnOpenPage()

    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Create/Edit Dimensions", true);
        if not UserSetup.FindFirst() then begin
            Error('Not Allowed to create/Edit Dimensions. Contact System Administrator');
        end
    end;

    var
        UserSetup: Record "User Setup";
}
