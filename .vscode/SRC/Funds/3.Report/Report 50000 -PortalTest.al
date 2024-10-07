report 50000 "Portal Test"
{
    ApplicationArea = All;
    Caption = 'Portal Test';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Purchase Requisition Line"; "Purchase Requisition Line")
        {
            DataItemTableView = where("Document No." = FILTER('PRF-23-00466'));
            trigger OnAfterGetRecord()
            var
                //fundsMgmt: Codeunit "Funds Management WS";
                // travelVoucher: Codeunit "Travel Voucher Management WS";
                // HRMgmt: Codeunit "HR Management WS";
                //Training: Codeunit "HR Employee Training WS";
                Proc: Codeunit "Procurement Management WS";
                PortalApprovals: Codeunit "Portal Approvals";
            //Employee:Record Employee;
            //U9QdY6KAeYZarp7LUWvSYle84mHLj8lWoIz2RRHJUwo=
            begin
                //Message(travelVoucher.GetTravelRequestLines('TV_0001'));
                //  Message(Format(HRMgmt.GetEmployeeAnnualLeaveBalance('HWK__001')));
                // Message(Format(Training.GetApprovedTrainingNeeds('HWK__001')));
                //Message(Format(Proc.GetPurchaseRequisitionCodes('Service')));
                "Purchase Requisition Line"."Purchase Order No." := '';
                "Purchase Requisition Line".Modify;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
