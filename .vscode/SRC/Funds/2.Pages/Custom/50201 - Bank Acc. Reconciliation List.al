page 50291 "Bank Acc. Recon List2"
{
    ApplicationArea = all;
    Caption = 'Bank Account Reconciliations - (SGR)';
    CardPageID = "Bank Acc. Recon Card2";
    // DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the bank account that you want to reconcile with the bank''s statement.';
                }
                field(StatementNo; Rec."Statement No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the bank account statement.';
                }
                field(StatementDate; Rec."Statement Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on the bank account statement.';
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending balance shown on the last bank statement, which was used in the last posted bank reconciliation for this bank account.';
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending balance shown on the bank''s statement that you want to reconcile with the bank account.';
                }
                field("Total Reconciled"; Rec."Total Reconciled")
                {
                    ApplicationArea = all;
                }
                field("Total Unreconciled"; Rec."Total Unreconciled")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Bank Acc.Recon. Post (Yes/No)2";
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                }
                // action(PostAndPrint)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Post and &Print';
                //     Image = PostPrint;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     RunObject = Codeunit "Bank Acc. Recon. Post+Print";
                //     ShortCutKey = 'Shift+F9';
                //     ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                // }
            }
        }
    }

    var
        RecAmt: Decimal;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        BankDiff: Decimal;
        Text0001: Label 'The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
}

