pageextension 50028 "Approval Comments EXT" extends "Approval Comments"
{
    layout
    {
        addafter(Comment)
        {
            // field("Additional Comments"; rec."Additional Comments")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Additional comments either on rejection or approval of the record';
            //     ShowMandatory = true;
            // }
        }
    }
}
