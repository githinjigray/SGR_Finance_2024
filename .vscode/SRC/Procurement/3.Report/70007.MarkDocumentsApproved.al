report 70007 "Mark Documents Approved"
{
    ApplicationArea = All;
    //     ApplicationArea = All;
    //     Caption = 'Mark Documents Approved';
    //     UsageCategory = Administration;
    //     ProcessingOnly = true;
    //     dataset
    //     {
    //         dataitem(PaymentHeader; "Payment Header")
    //         {
    //             DataItemTableView = WHERE(Status = filter("pending approval"));
    //             trigger OnAfterGetRecord()
    //             begin
    //                 ApprovalEntries.Reset();
    //                 ApprovalEntries.SetRange("Document No.", PaymentHeader."No.");
    //                 if ApprovalEntries.FindLast() then begin
    //                     NewApprovalEntries.Reset();
    //                     NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
    //                     NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
    //                     if NewApprovalEntries.FindFirst() then begin
    //                         PaymentHeader.Status := PaymentHeader.Status::Approved;
    //                         PaymentHeader.Validate(Status);
    //                         PaymentHeader.Modify();
    //                     end;
    //                 end;
    //             end;
    //         }
    //         dataitem("Imprest Surrender Header"; "Imprest Surrender Header")
    //         {
    //             DataItemTableView = WHERE(Status = filter("pending approval"));
    //             trigger OnAfterGetRecord()
    //             begin
    //                 ApprovalEntries.Reset();
    //                 ApprovalEntries.SetRange("Document No.", "Imprest Surrender Header"."No.");
    //                 if ApprovalEntries.FindLast() then begin
    //                     NewApprovalEntries.Reset();
    //                     NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
    //                     NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
    //                     if NewApprovalEntries.FindFirst() then begin
    //                         "Imprest Surrender Header".Status := "Imprest Surrender Header".Status::Approved;
    //                         "Imprest Surrender Header".Validate(Status);
    //                         "Imprest Surrender Header".Modify();
    //                     end;
    //                 end;
    //             end;
    //         }
    //         dataitem("Imprest Header"; "Imprest Header")
    //         {
    //             DataItemTableView = WHERE(Status = filter("pending approval"));
    //             trigger OnAfterGetRecord()
    //             begin
    //                 ApprovalEntries.Reset();
    //                 ApprovalEntries.SetRange("Document No.", "Imprest Header"."No.");
    //                 if ApprovalEntries.FindLast() then begin
    //                     NewApprovalEntries.Reset();
    //                     NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
    //                     NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
    //                     if NewApprovalEntries.FindFirst() then begin
    //                         "Imprest Header".Status := "Imprest Header".Status::Approved;
    //                         "Imprest Header".Validate(Status);
    //                         "Imprest Header".Modify();
    //                     end;
    //                 end;
    //             end;
    //         }
    //         dataitem("Purchase Header"; "Purchase Header")
    //         {
    //             DataItemTableView = WHERE(Status = filter("pending approval"));
    //             trigger OnAfterGetRecord()
    //             begin
    //                 ApprovalEntries.Reset();
    //                 ApprovalEntries.SetRange("Document No.", "Purchase Header"."No.");
    //                 if ApprovalEntries.FindLast() then begin
    //                     NewApprovalEntries.Reset();
    //                     NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
    //                     NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
    //                     if NewApprovalEntries.FindFirst() then begin
    //                         "Purchase Header".Status := "Purchase Header".Status::Released;
    //                         "Purchase Header".Validate(Status);
    //                         "Purchase Header".Modify();
    //                     end;
    //                 end;
    //             end;
    //         }
    //         dataitem("Funds Claim Header"; "Funds Claim Header")
    //         {
    //             DataItemTableView = WHERE(Status = filter("pending approval"));
    //             trigger OnAfterGetRecord()
    //             begin
    //                 ApprovalEntries.Reset();
    //                 ApprovalEntries.SetRange("Document No.", "Funds Claim Header"."No.");
    //                 if ApprovalEntries.FindLast() then begin
    //                     NewApprovalEntries.Reset();
    //                     NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
    //                     NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
    //                     if NewApprovalEntries.FindFirst() then begin
    //                         "Funds Claim Header".Status := "Funds Claim Header".Status::Approved;
    //                         "Funds Claim Header".Validate(Status);
    //                         "Funds Claim Header".Modify();
    //                     end;
    //                 end;
    //             end;
    //         }
    //     }
    //     var
    //         ApprovalEntries: Record "Approval Entry";
    //         NewApprovalEntries: Record "Approval Entry";
}
