report 50041 "Bank Buffer Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Buffer Update.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Ledger Buffer"; "Bank Ledger Buffer")
        {
            DataItemTableView = WHERE(Reimbursed = CONST(false), "Bank Account No." = CONST('BANK_0011'));

            trigger OnAfterGetRecord()
            begin
                FundsTransferHeader.Reset;
                FundsTransferHeader.SetRange(FundsTransferHeader."No.", "Bank Ledger Buffer"."Document No.");
                FundsTransferHeader.SetRange(FundsTransferHeader.Posted, true);
                if FundsTransferHeader.FindFirst then begin
                    "Bank Ledger Buffer".Reimbursed := true;
                    "Bank Ledger Buffer"."Reimbursed By" := 'Queue';
                    "Bank Ledger Buffer"."Reimbursement Doc No." := FundsTransferHeader."No.";
                    "Bank Ledger Buffer".Modify;
                end;

                FundsTransferLine.Reset;
                FundsTransferLine.SetRange(FundsTransferLine.Posted, true);
                FundsTransferLine.SetRange(FundsTransferLine."Account No.", "Bank Ledger Buffer"."Document No.");
                if FundsTransferLine.FindFirst then begin
                    "Bank Ledger Buffer".Reimbursed := true;
                    "Bank Ledger Buffer"."Reimbursed By" := 'Queue';
                    "Bank Ledger Buffer"."Reimbursement Doc No." := FundsTransferLine."Document No.";
                    "Bank Ledger Buffer".Modify;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        FundsTransferHeader: Record "Funds Transfer Header";
        FundsTransferLine: Record "Funds Transfer Line";
}

