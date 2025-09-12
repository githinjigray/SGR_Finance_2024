report 50057 "FD Status Change(Queue)"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("FD Processing1"; "FD Processing1")
        {
            DataItemTableView = WHERE("Fixed Deposit Status" = CONST(Active), "FD Type" = CONST("Fixed Deposit"));

            trigger OnAfterGetRecord()
            begin
                IF "FD Processing1"."FD Maturity Date" < TODAY THEN BEGIN
                    "FD Processing1"."Fixed Deposit Status" := "FD Processing1"."Fixed Deposit Status"::Matured;
                    "FD Processing1".MODIFY
                END;
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
}

