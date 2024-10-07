report 50053 "Post Approved Funds Transfer"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Funds Transfer Header"; "Funds Transfer Header")
        {
            //  DataItemTableView = WHERE(Posted=CONST(No), Status=CONST(Approved));

            trigger OnAfterGetRecord()
            begin


                FundsUserSetup.RESET;
                FundsUserSetup.SETRANGE(FundsUserSetup.UserID, "Funds Transfer Header"."User ID");
                IF FundsUserSetup.FINDFIRST THEN BEGIN
                    //  FundsManagement.PostFundsTransferQueue("Funds Transfer Header"."No.",FundsUserSetup."Payment Journal Template",FundsUserSetup."Payment Journal Batch",FALSE);
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

    var
        // AccountApplicationHeader: Record Table52137675;
        // InvstReceiptApplication: Codeunit Codeunit52137635;
        // ReceiptDate: Date;
        // FundsManagement: Codeunit "Funds Management";
        FundsUserSetup: Record "Funds User Setup";
}

