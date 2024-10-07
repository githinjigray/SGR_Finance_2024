page 50076 "Bank Branches"
{
    ApplicationArea = All;
    Caption = 'Bank Branches';
    PageType = List;
    SourceTable = "Bank Branch";
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
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Branch Code field.';
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Branch Name field.';
                }
                field("Branch Physical Location"; Rec."Branch Physical Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Physical Location field.';
                }
                field("Branch Postal Code"; Rec."Branch Postal Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Postal Code field.';
                }
                field("Branch Address"; Rec."Branch Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Address field.';
                }
                field("Branch Phone No."; Rec."Branch Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Phone No. field.';
                }
                field("Branch Mobile No."; Rec."Branch Mobile No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Mobile No. field.';
                }
                field("Branch Email Address"; Rec."Branch Email Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Email Address field.';
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank field.';
                }
            }
         
        }
        
    }
    actions
    {
        area(Processing)
        {
            action("Upload Bank Branches")
            {
                Caption = 'Upload Bank Branches';
                RunObject = xmlport "Bank Branches";
                ToolTip = 'Upload Bank Branches';
            }
        }
    }
}
