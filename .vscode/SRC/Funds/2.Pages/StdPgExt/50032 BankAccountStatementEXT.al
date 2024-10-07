pageextension 50032 "Bank Account StatementEXT" extends "Bank Account Statement"
{
    //     Layout
    //     {
    //     }
    //     actions
    //     {
    //         addbefore(Print)
    //         {
    //             action("Print Reconciliation")
    //             {
    //                 Caption = 'Print Reconciliation';
    //                 Image = Print;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 ToolTip = 'Print Reconciliation';
    //                 ApplicationArea = All;


    //                 trigger OnAction()
    //                 var
    //                     PrintStatement: Record "Bank Account Statement";
    //                 begin
    //                     PrintStatement.Reset;
    //                     PrintStatement.SetRange(PrintStatement."Bank Account No.", rec."Bank Account No.");
    //                     PrintStatement.SetRange(PrintStatement."Statement No.", rec."Statement No.");
    //                     if PrintStatement.FindFirst then begin
    //                         REPORT.RunModal(REPORT::"Bank Acc. Reconciliations Post", true, false, PrintStatement);
    //                     end;
    //                 end;
    //             }
    //             action("Reverse statement")
    //             {
    //                 Caption = 'Reverse statement';
    //                 Image = ReverseRegister;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 ToolTip = 'Reverse statement';
    //                 RunObject = report "Reverse Bank Acc. Statement";
    //                 ApplicationArea = All;
    //             }

    //         }
    //     }
}
