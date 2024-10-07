page 50085 "Bank Acc.Reconciliation Lines2"
{
    Caption = 'Bank Acc.Reconciliation Lines2';
    PageType = ListPart;
    SourceTable = "Bank Acc. Reconciliation Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date of the bank account or check ledger entry on the reconciliation line when the Suggest Lines function is used.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number of your choice that will appear on the reconciliation line.';
                }
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the check number for the transaction on the reconciliation line.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description for the transaction on the reconciliation line.';
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the transaction on the bank''s statement shown on this reconciliation line.';
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the transaction on the reconciliation line that has been applied to a bank account or check ledger entry.';
                }
                field(Difference; Rec.Difference)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the difference between the amount in the Statement Amount field and the amount in the Applied Amount field.';
                }
                field(Reconciled; Rec.Reconciled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reconciled field.';
                }
                field("Reconciling Date"; Rec."Reconciling Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reconciling Date field.';
                }
            }
        }
    }
}
