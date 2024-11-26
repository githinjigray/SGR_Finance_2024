report 50045 "Bank Reconciliation Process"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Bank Reconciliation Process.rdlc';
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Acc. Reconciliation Line2"; "Bank Acc. Reconciliation Line2")
        {

            trigger OnAfterGetRecord()
            begin


                ReconcilliationBuffer.Reset;
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Bank Account No.", "Bank Acc. Reconciliation Line2"."Bank Account No.");
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Statement No.", "Bank Acc. Reconciliation Line2"."Statement No.");
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Check No.", "Bank Acc. Reconciliation Line2"."Check No.");
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Statement Amount", "Bank Acc. Reconciliation Line2"."Statement Amount");
                if ReconcilliationBuffer.Find('-') then begin

                    "Bank Acc. Reconciliation Line2".Reconciled := true;
                    "Bank Acc. Reconciliation Line2"."Reconciling Date" := Today;
                    "Bank Acc. Reconciliation Line2"."Applied Amount" := "Bank Acc. Reconciliation Line2"."Statement Amount";
                    "Bank Acc. Reconciliation Line2".Difference := 0;
                    "Bank Acc. Reconciliation Line2"."Applied Entries" := 1;
                    "Bank Acc. Reconciliation Line2"."Ready for Application" := true;
                    "Bank Acc. Reconciliation Line2".Modify;

                    ReconcilliationBuffer.Reconciled := true;
                    ReconcilliationBuffer."Reconciling Date" := Today;
                    ReconcilliationBuffer.Modify;

                end else begin

                    "Bank Acc. Reconciliation Line2"."Applied Amount" := 0;
                    "Bank Acc. Reconciliation Line2".Difference := "Bank Acc. Reconciliation Line2"."Statement Amount";
                    "Bank Acc. Reconciliation Line2"."Applied Entries" := 0;
                    "Bank Acc. Reconciliation Line2"."Ready for Application" := true;

                    "Bank Acc. Reconciliation Line2".Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Unique Transaction Have Reconcilled. Kindly check for unreconcilled items and match manually where necessary to make reconcilliation complete.');
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
        ReconcilliationBuffer: Record "Bank Acc. Statement Linevb";
}

