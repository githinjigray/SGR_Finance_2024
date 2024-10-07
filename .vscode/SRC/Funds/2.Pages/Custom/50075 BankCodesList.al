page 50075 "Bank Codes List"
{
    ApplicationArea = All;
    Caption = 'Bank Codes List';
    PageType = List;
    SourceTable = "Bank Code";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Bank Branches")
            {
                ToolTip = 'Bank branches';
                RunObject = page "Bank Branches";
                RunPageLink = "Bank Code" = field("Bank Code");
                Promoted = true;
                PromotedIsBig = true;
                Image = NewBank;
            }
            action("Upload Bank Codes")
            {
                Caption = 'Upload Bank Codes';
                RunObject = xmlport "Bank Codes";
                ToolTip = 'Upload Bank Codes';
            }
            action("Upload Bank Branches")
            {
                Caption = 'Upload Bank Branches';
                RunObject = xmlport "Bank Branches";
                ToolTip = 'Upload Bank Branches';
            }
            //xmlport "Upload Dimension Values"
            action("Upload Dimensions")
            {
                Caption = 'Upload Dimensions';
                //RunObject = xmlport "Upload Dimension Values";
                ToolTip = 'Upload Dimensions';
            }
        }
    }
}
