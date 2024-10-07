pageextension 50031 "Bank Account Statement ListEXT" extends "Bank Account Statement List"
{
    // layout
    // {
    // }
    // actions
    // {
    //     addafter(Print)
    //     {
    //         action("Print Reconciliation")
    //         {
    //             Caption = 'Print Reconciliation';
    //             Image = Print;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             ToolTip = 'Print Reconciliation';
    //             ApplicationArea = All;


    //             trigger OnAction()
    //             var
    //                 PrintStatement: Record "Bank Account Statement";
    //             begin
    //                 PrintStatement.Reset;
    //                 PrintStatement.SetRange(PrintStatement."Bank Account No.", rec."Bank Account No.");
    //                 PrintStatement.SetRange(PrintStatement."Statement No.", rec."Statement No.");
    //                 if PrintStatement.FindFirst then begin
    //                     REPORT.RunModal(REPORT::"Bank Acc. Reconciliations Post", true, false, PrintStatement);
    //                 end;
    //             end;
    //         }
    //     }
    // }
}
