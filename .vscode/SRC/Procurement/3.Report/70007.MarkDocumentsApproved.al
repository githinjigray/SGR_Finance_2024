report 70007 "Mark Documents Approved"
{
    ApplicationArea = All;
    Caption = 'Mark Documents Approved';
    UsageCategory = Administration;
    ProcessingOnly = true;
    Permissions = TableData "Approval Entry" = rm, TableData "Payment Header" = rm,
                 TableData "Imprest Surrender Header" = rm, TableData "Imprest Header" = rm, TableData "Funds Claim Header" = rm, TableData "Purchase Header" = rm;
    dataset
    {
        dataitem(PaymentHeader; "Payment Header")
        {
            DataItemTableView = WHERE(Status = filter("pending approval"));
            trigger OnAfterGetRecord()
            begin
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", PaymentHeader."No.");
                if ApprovalEntries.FindLast() then begin
                    NewApprovalEntries.Reset();
                    NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
                    NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
                    if NewApprovalEntries.FindFirst() then begin
                        PaymentHeader.Status := PaymentHeader.Status::Approved;
                        PaymentHeader.Validate(Status);
                        if PaymentHeader.Modify() then begin
                            ModifyApprovalEntries.Reset();
                            ModifyApprovalEntries.SetRange("Document No.", PaymentHeader."No.");
                            ModifyApprovalEntries.SetRange(Status, ModifyApprovalEntries.Status::Open);
                            if ModifyApprovalEntries.FindSet() then begin
                                repeat
                                    ModifyApprovalEntries.Status := ModifyApprovalEntries.Status::Approved;
                                    ModifyApprovalEntries.Modify();
                                until ModifyApprovalEntries.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        dataitem("Imprest Surrender Header"; "Imprest Surrender Header")
        {
            DataItemTableView = WHERE(Status = filter("pending approval"));
            trigger OnAfterGetRecord()
            begin
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", "Imprest Surrender Header"."No.");
                if ApprovalEntries.FindLast() then begin
                    NewApprovalEntries.Reset();
                    NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
                    NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
                    if NewApprovalEntries.FindFirst() then begin
                        "Imprest Surrender Header".Status := "Imprest Surrender Header".Status::Approved;
                        "Imprest Surrender Header".Validate(Status);
                        if "Imprest Surrender Header".Modify() then begin
                            ModifyApprovalEntries.Reset();
                            ModifyApprovalEntries.SetRange("Document No.", "Imprest Surrender Header"."No.");
                            ModifyApprovalEntries.SetRange(Status, ModifyApprovalEntries.Status::Open);
                            if ModifyApprovalEntries.FindSet() then begin
                                repeat
                                    ModifyApprovalEntries.Status := ModifyApprovalEntries.Status::Approved;
                                    ModifyApprovalEntries.Modify();
                                until ModifyApprovalEntries.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        dataitem("Imprest Header"; "Imprest Header")
        {
            DataItemTableView = WHERE(Status = filter("pending approval"));
            trigger OnAfterGetRecord()
            begin
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", "Imprest Header"."No.");
                if ApprovalEntries.FindLast() then begin
                    NewApprovalEntries.Reset();
                    NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
                    NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
                    if NewApprovalEntries.FindFirst() then begin
                        "Imprest Header".Status := "Imprest Header".Status::Approved;
                        "Imprest Header".Validate(Status);
                        if "Imprest Header".Modify() then begin
                            ModifyApprovalEntries.Reset();
                            ModifyApprovalEntries.SetRange("Document No.", "Imprest Header"."No.");
                            ModifyApprovalEntries.SetRange(Status, ModifyApprovalEntries.Status::Open);
                            if ModifyApprovalEntries.FindSet() then begin
                                repeat
                                    ModifyApprovalEntries.Status := ModifyApprovalEntries.Status::Approved;
                                    ModifyApprovalEntries.Modify();
                                until ModifyApprovalEntries.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = WHERE(Status = filter("pending approval"));
            trigger OnAfterGetRecord()
            begin
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", "Purchase Header"."No.");
                if ApprovalEntries.FindLast() then begin
                    NewApprovalEntries.Reset();
                    NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
                    NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
                    if NewApprovalEntries.FindFirst() then begin
                        "Purchase Header".Status := "Purchase Header".Status::Released;
                        "Purchase Header".Validate(Status);
                        if "Purchase Header".Modify() then begin
                            ModifyApprovalEntries.Reset();
                            ModifyApprovalEntries.SetRange("Document No.", "Purchase Header"."No.");
                            ModifyApprovalEntries.SetRange(Status, ModifyApprovalEntries.Status::Open);
                            if ModifyApprovalEntries.FindSet() then begin
                                repeat
                                    ModifyApprovalEntries.Status := ModifyApprovalEntries.Status::Approved;
                                    ModifyApprovalEntries.Modify();
                                until ModifyApprovalEntries.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        dataitem("Funds Claim Header"; "Funds Claim Header")
        {
            DataItemTableView = WHERE(Status = filter("pending approval"));
            trigger OnAfterGetRecord()
            begin
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", "Funds Claim Header"."No.");
                if ApprovalEntries.FindLast() then begin
                    NewApprovalEntries.Reset();
                    NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
                    NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
                    if NewApprovalEntries.FindFirst() then begin
                        "Funds Claim Header".Status := "Funds Claim Header".Status::Approved;
                        "Funds Claim Header".Validate(Status);
                        if "Funds Claim Header".Modify() then begin
                            ModifyApprovalEntries.Reset();
                            ModifyApprovalEntries.SetRange("Document No.", "Funds Claim Header"."No.");
                            ModifyApprovalEntries.SetRange(Status, ModifyApprovalEntries.Status::Open);
                            if ModifyApprovalEntries.FindSet() then begin
                                repeat
                                    ModifyApprovalEntries.Status := ModifyApprovalEntries.Status::Approved;
                                    ModifyApprovalEntries.Modify();
                                until ModifyApprovalEntries.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        dataitem("Purchase Requisitions"; "Purchase Requisitions")
        {
            DataItemTableView = WHERE(Status = filter("pending approval"));
            trigger OnAfterGetRecord()
            begin
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", "Purchase Requisitions"."No.");
                if ApprovalEntries.FindLast() then begin
                    NewApprovalEntries.Reset();
                    NewApprovalEntries.SetRange("Sequence No.", ApprovalEntries."Sequence No.");
                    NewApprovalEntries.SetRange(Status, NewApprovalEntries.Status::Approved);
                    if NewApprovalEntries.FindFirst() then begin
                        "Purchase Requisitions".Status := "Purchase Requisitions".Status::Approved;
                        "Purchase Requisitions".Validate(Status);
                        if "Purchase Requisitions".Modify() then begin
                            ModifyApprovalEntries.Reset();
                            ModifyApprovalEntries.SetRange("Document No.", "Purchase Requisitions"."No.");
                            ModifyApprovalEntries.SetRange(Status, ModifyApprovalEntries.Status::Open);
                            if ModifyApprovalEntries.FindSet() then begin
                                repeat
                                    ModifyApprovalEntries.Status := ModifyApprovalEntries.Status::Approved;
                                    ModifyApprovalEntries.Modify();
                                until ModifyApprovalEntries.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
    }
    var
        ApprovalEntries: Record "Approval Entry";
        NewApprovalEntries: Record "Approval Entry";
        ModifyApprovalEntries: Record "Approval Entry";
}
