pageextension 50030 BankLegderExt extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'External Document No.';
            }
        }
        addafter(Description)
        {
            field("Payee Name/Received From"; Rec."Payee Name/Received From")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Payee Name/Received From';
                Caption = 'Payee Name/Received From';
            }
        }
        addafter("Shortcut Dimension 6 Code")
        {
            field("Statement Status"; rec."Statement Status")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Statement Status';
                Caption = 'Statement Status';
            }
            field("Statement No."; rec."Statement No.")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Statement No.';
                Caption = 'Statement No.';
            }
            field("Statement Line No."; rec."Statement Line No.")
            {
                ApplicationArea = all;
                ToolTip = 'Statement Line No.';
                Caption = 'Statement Line No.';
                Editable = false;
            }
        }
    }
}
