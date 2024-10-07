report 50032 "Send Impr. Surrender Reminders"
{
    ApplicationArea = All;
    ProcessingOnly=TRUE;
    Caption = 'Send Imprest Surrender Reminders';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ImprestHeader; "Imprest Header")      
        {
            DataItemTableView = WHERE(Posted=CONST(true));
            trigger OnAfterGetRecord()
            var
            begin
                //if (CALCDATE('5D',ImprestHeader."Date Posted"))=TODAY THEN begin
                    ImprestSurrender.SendImprestSurrenderEmail(ImprestHeader."No.");
                //end;
            end;
        }
        
    }
    
        var
        ImprestSurrender:Codeunit "Imprest Surrender";
}
