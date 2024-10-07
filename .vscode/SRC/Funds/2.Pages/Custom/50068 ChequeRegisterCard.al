page 50068 "Cheque Register Card"
{
    Caption = 'Cheque Register Card';
    PageType = Card;
    SourceTable = "Cheque Register";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ToolTip = 'Specifies the value of the Bank Account field.';
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ToolTip = 'Specifies the value of the Bank Account Name field.';
                    ApplicationArea = All;
                }
                field("Last Cheque No."; Rec."Last Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Last Cheque No. field.';
                    ApplicationArea = All;
                }
                field("Cheque Book Number"; Rec."Cheque Book Number")
                {
                    ToolTip = 'Specifies the value of the Cheque Book Number field.';
                    ApplicationArea = All;
                }
                field("No of Leaves"; Rec."No of Leaves")
                {
                    ToolTip = 'Specifies the value of the No of Leaves field.';
                    ApplicationArea = All;
                }
                field("Cheque Number From"; Rec."Cheque Number From")
                {
                    ToolTip = 'Specifies the value of the Cheque Number From field.';
                    ApplicationArea = All;
                }
                field("Cheque Number To."; Rec."Cheque Number To.")
                {
                    ToolTip = 'Specifies the value of the Cheque Number To. field.';
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ToolTip = 'Specifies the value of the Incoming Document Entry No. field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
