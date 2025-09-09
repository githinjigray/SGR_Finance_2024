codeunit 60008 "Ledger Entry Extensionsions"
{
    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    procedure CopyGLEntriesFromGenJnlLine(var GLEntry: record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry.Description2 := GenJournalLine.Description2;
        if GenJournalLine."Currency Code" <> '' then begin
            GLEntry."Currency Code" := GenJournalLine."Currency Code";
            GLEntry."Currency Amount" := GenJournalLine.Amount;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun(var SalesHeader: Record "Sales Header")

    begin
        SalesHeader.TestField("Payment Method Code");
        SalesHeader.TestField("Posting Description");
        SalesHeader.CalcFields(Amount, "Amount Including VAT");
        if (SalesHeader."Currency Factor" <> 0) and (SalesHeader."Currency Code" <> '') then begin

            SalesHeader."Amount (LCY)" := SalesHeader.Amount / SalesHeader."Currency Factor";
            SalesHeader."Amount Inc. VAT (LCY)" := SalesHeader."Amount Including VAT" / SalesHeader."Currency Factor";

        end else begin
            SalesHeader."Amount (LCY)" := SalesHeader.Amount;
            SalesHeader."Amount Inc. VAT (LCY)" := SalesHeader."Amount Including VAT";
        end;
        SalesHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRunPurchase(var PurchaseHeader: Record "Purchase Header")
    begin

        PurchaseHeader.TestField("Posting Description");
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Posting Description" := '';
    end;


    [EventSubscriber(ObjectType::Table, Database::"purchase Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecordPurchase(var PurchHeader: Record "purchase Header")
    begin
        PurchHeader."Posting Description" := '';
    end;

    [EventSubscriber(ObjectType::Table, Database::"purchase line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure OnCopyFromItemOnAfterCheck(var PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    begin
        PurchaseLine."Location Code" := Item."Location Code";
        PurchaseLine.Validate("Location Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    procedure OnRejectApprovalRequest(var ApprovalEntry: record "Approval Entry")
    var
        PaymentCard: Record "Payment Header";
    begin
        ApprovalCommentLine.RESET;
        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", ApprovalEntry."Document No.");
        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."User ID", USERID);
        IF NOT ApprovalCommentLine.FINDFIRST THEN
            ERROR(RejectionComments);


        // case RecRef.Number of
        //     DATABASE::"Payment Header":
        //         begin
        //             RecRef.SetTable(PaymentCard);
        //             PaymentCard.Validate(Status, PaymentCard.Status::Open);
        //             PaymentCard.Modify(true);
        //             Handled := true;
        //         end;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    procedure ReleaseDocument(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    begin
        ProcurementManagement.CreatePurchaseHeaderEmailOnFullApproval(PurchaseHeader."No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnValidateItemNoOnBeforeSetDescription', '', false, false)]
    local procedure OnValidateItemNoOnBeforeSetDescriptionadd(var ItemJournalLine: Record "Item Journal Line"; Item: Record Item)
    begin
        ItemJournalLine."Part No." := item."Part No.";
        ItemJournalLine."Alternative Part No. 1" := Item."Alternative Part No. 1";
        ItemJournalLine."Alternative Part No. 2" := Item."Alternative Part No. 2";
        ItemJournalLine."Alternative Part No. 3" := Item."Alternative Part No. 3";
    end;

    [EventSubscriber(ObjectType::table, Database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line")
    begin
        SalesLine."Part No." := Item."Part No.";
        SalesLine."Alternative Part No. 1" := item."Alternative Part No. 1";
        SalesLine."Alternative Part No. 2" := item."Alternative Part No. 2";
        SalesLine."Alternative Part No. 3" := item."Alternative Part No. 3";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequest, '', false, false)]
    local procedure "Approvals Mgmt._OnApproveApprovalRequest"(var ApprovalEntry: Record "Approval Entry")
    Var
        PaymentHeader: Record "Payment Header";
        ApprovalEntries: Record "Approval Entry";
    begin
        PaymentHeader.Reset();
        PaymentHeader.SetRange("No.", ApprovalEntry."Document No.");
        if PaymentHeader.FindFirst() then begin

            ApprovalEntries.Reset();
            ApprovalEntries.SetCurrentKey("Entry No.");
            ApprovalEntries.SetRange("Document Type", ApprovalEntries."Document Type"::" ");
            ApprovalEntries.SetRange("Document No.", PaymentHeader."No.");
            ApprovalEntries.SetFilter(Status, '%1|%2|%3', ApprovalEntries.Status::Open, ApprovalEntries.Status::" ", ApprovalEntries.Status::Created);
            if ApprovalEntries.IsEmpty then begin
                ApprovalEntries.SetFilter(Status, '%1|%2', ApprovalEntries.Status::Approved, ApprovalEntries.Status::Rejected);
                if ApprovalEntries.FindLast() then
                    if ApprovalEntries.Status = ApprovalEntries.Status::Approved then begin
                        PaymentHeader.Status := PaymentHeader.Status::Approved;
                        PaymentHeader.Validate(Status);
                        PaymentHeader.Modify();
                    end;
            end;
        end;
    end;

    var
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        WorkflowResponses: Codeunit "Workflow Response Handling";
        PurchaseHeaders: Record "Purchase Header";
        ProcurementManagement: Codeunit "Procurement Management";
        RejectionComments: TextConst ENU = 'Kindly give reasons for rejcting approval of this record under comments section';
}

