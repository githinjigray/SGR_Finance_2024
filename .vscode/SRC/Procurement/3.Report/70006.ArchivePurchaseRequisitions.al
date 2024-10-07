report 70006 "Archive Purchase Requisitions"
{
    ApplicationArea = All;
    Caption = 'Archive Purchase Requisitions';
    UsageCategory = Administration;
    ProcessingOnly = true;
    UseRequestPage = false;
    dataset
    {
        dataitem(PurchaseRequisitions; "Purchase Requisitions")
        {
            DataItemTableView = where(Status = FILTER(approved));
            trigger OnAfterGetRecord()
            begin
                StillOpen := false;
                RequisitionLines.Reset();
                RequisitionLines.SetRange("Document No.", "No.");
                RequisitionLines.SetRange(Status, Status::Approved);
                if RequisitionLines.FindSet() then begin
                    repeat
                        if RequisitionLines.Closed = false then
                            StillOpen := true;
                    until RequisitionLines.Next = 0;
                end;
                if StillOpen = false then begin
                    Status := Status::Closed;
                    modify;
                end;
            end;
        }
    }

    var
        RequisitionLines: Record "Purchase Requisition Line";
        StillOpen: Boolean;
}
