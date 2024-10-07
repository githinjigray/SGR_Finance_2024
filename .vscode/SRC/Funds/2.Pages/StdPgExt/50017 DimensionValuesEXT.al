pageextension 50017 "Dimension Values EXT" extends "Dimension Values"
{
    layout
    {
        addafter(Totaling)
        {
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Sequence No"; rec."Sequence No")
            {
                ApplicationArea = all;
            }
            field(Description; rec.Description)
            {
                ApplicationArea = all;
            }
            field("E-Mail"; rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field("LPO Corr. E-Mail"; Rec."LPO Corr. E-Mail")
            {
                ApplicationArea = all;
            }
            field("Invoice Corr. E-Mail"; rec."Invoice Corr. E-Mail")
            {
                ApplicationArea = all;
            }
            field(Region; Rec.Region)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addbefore("Indent Dimension Values")
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
            }
        }
    }
}
