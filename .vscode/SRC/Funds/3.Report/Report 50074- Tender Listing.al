report 50074 "Tender Listing"
{
    ApplicationArea = All;
    UseRequestPage = false;
    ProcessingOnly = true;
    Caption = 'Contracts Report Update';
    dataset
    {
        dataitem("Contract Header2"; "Contract Header2")
        {
            DataItemTableView = where("Contract Status" = filter(<> Expired), "Expiry Date" = filter(<> 0D));
            trigger OnAfterGetRecord()
            begin
                if "Contract Header2"."Expiry Date" < Today then begin
                    "Contract Header2"."Contract Status" := "Contract Header2"."Contract Status"::Expired;
                    if "Contract Header2".Modify() then begin
                        ContractRequest.Reset();
                        ContractRequest.SetRange("No.", "Contract Header2"."No.");
                        if ContractRequest.FindFirst() then begin
                            ContractRequest."Contract Status" := ContractRequest."Contract Status"::Terminated;
                            ContractRequest.Modify();
                        end;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        ContractRequest: Record "Contract Request Header";
}

