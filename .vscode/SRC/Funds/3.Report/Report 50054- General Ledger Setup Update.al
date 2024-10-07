report 50054 "General Ledger Setup Update"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("General Ledger Setup"; "General Ledger Setup")
        {

            trigger OnAfterGetRecord()
            begin
                if "General Ledger Setup"."Allow Posting To" <> 0D then begin
                    if Today > "General Ledger Setup"."Allow Posting To" then begin
                        "General Ledger Setup"."Allow Posting From" := CalcDate('-CM', "General Ledger Setup"."Allow Posting To");
                        "General Ledger Setup"."Allow Posting To" := CalcDate('+1M', "General Ledger Setup"."Allow Posting To");
                        "General Ledger Setup".Modify;
                    end;
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
}

