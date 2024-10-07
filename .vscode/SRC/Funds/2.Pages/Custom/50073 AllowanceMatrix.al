page 50073 "Allowance Matrix"
{
    ApplicationArea = All;
    Caption = 'Allowance Matrix';
    PageType = List;
    SourceTable = "Allowance Matrix";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Job Group"; Rec."Job Group")
                {
                    ToolTip = 'Specifies the value of the Job Group field.';
                    ApplicationArea = All;
                }
                field("Allowance Code"; Rec."Allowance Code")
                {
                    ToolTip = 'Specifies the value of the Allowance Code field.';
                    ApplicationArea = All;
                }
                field("Cluster Code"; Rec."Cluster Code")
                {
                    ToolTip = 'Specifies the value of the Cluster Code field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field("Traveling From"; Rec."Traveling From")
                {
                    ToolTip = 'Specifies the value of the Traveling From field.';
                    ApplicationArea = All;
                }
                field("Traveling To"; Rec."Traveling To")
                {
                    ToolTip = 'Specifies the value of the Traveling To field.';
                    ApplicationArea = All;
                }
                field("Allowance Description"; Rec."Allowance Description")
                {
                    ToolTip = 'Specifies the value of the Allowance Description field.';
                    ApplicationArea = All;
                }
                field("Transport Allowance"; Rec."Transport Allowance")
                {
                    ToolTip = 'Specifies the value of the Transport Allowance field.';
                    ApplicationArea = All;
                }
                field("Exempt from Cluster Code"; Rec."Exempt from Cluster Code")
                {
                    ToolTip = 'Specifies the value of the Exempt from Cluster Code field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
