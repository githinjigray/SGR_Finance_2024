page 50068 "Cheque Register Card"
{
    Caption = 'Cash Register';
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
                field("Balance"; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
            }
            part(FchequeRegisterLines; "Cheque Register Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");

            }
        }

    }
}
