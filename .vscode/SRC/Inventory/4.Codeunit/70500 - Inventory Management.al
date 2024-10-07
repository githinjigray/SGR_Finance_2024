codeunit 70500 "Inventory Management"
{

    trigger OnRun()
    begin
    end;

    var
        Txt001: Label 'Store requisition No.:%1 is already posted.';

    procedure CheckStoreRequisitionMandatoryFields("Store Requisition Header": Record "Store Requisition Header"; Posting: Boolean)
    var
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
    begin
        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        //StoreRequisitionHeader.TESTFIELD("Document Date");
        //StoreRequisitionHeader.TESTFIELD("Posting Date");
        StoreRequisitionHeader.TestField(Description);
        if Posting then begin
            StoreRequisitionHeader.TestField(Status, StoreRequisitionHeader.Status::Approved);
        end;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        if StoreRequisitionLine.FindSet then begin
            StoreRequisitionLine.TestField("Item No.");
            StoreRequisitionLine.TestField("Location Code");
            StoreRequisitionLine.TestField("Quantity to Issue");
            StoreRequisitionLine.TestField("Unit of Measure Code");
            //  StoreRequisitionLine.TESTFIELD("Global Dimension 1 Code");

        end else begin
            Error('');
        end;

        /*
        StoreRequisitionLine.RESET;
        StoreRequisitionLine.SETRANGE(StoreRequisitionLine."Document No.","Store Requisition Header"."No.");
        IF StoreRequisitionLine.FINDSET THEN BEGIN
        */

    end;

    procedure PostStoreRequisition("Store Requisition Header": Record "Store Requisition Header"; JTemplate: Code[10]; JBatch: Code[10])
    var
        "LineNo.": Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        StoreRequisitionHeader2: Record "Store Requisition Header";
        StoreRequisitionLine2: Record "Store Requisition Line";
        TempRequisition: Record "Purchase Requisitions";
        NoSeriesMgt: Codeunit "No. Series";
        Setups: Record "Purchases & Payables Setup";
        TempRequisitionLines: Record "Purchase Requisition Line";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ExistInrequisition: Boolean;
        Items: Record Item;
        Text00011: Label 'Reorder point has been reached and  a purchase requisition has been created for your attention for item no: %1';
        HREmployee: Record "User Setup";
        EmailAddress: Text;
        NewRequisitionNo: Code[20];
        ProcurementManagement: Codeunit "Procurement Management";
    begin
        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        //Check posted document
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
        if ItemLedgerEntry.FindFirst then begin
            Error(Txt001, StoreRequisitionHeader."No.");
        end;
        //End Check Posted Document

        //If Item Journal Lines Exist, Delete
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
        if ItemJnlLine.FindSet then begin
            ItemJnlLine.DeleteAll;
        end;
        //End Delete Item Journal Lines

        "LineNo." := 1000;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        StoreRequisitionLine.SetFilter(StoreRequisitionLine."Quantity to Issue", '>%1', 0);
        if StoreRequisitionLine.FindSet then begin
            repeat
                "LineNo." := "LineNo." + 1;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := JTemplate;
                ItemJnlLine."Journal Batch Name" := JBatch;
                ItemJnlLine."Line No." := "LineNo.";
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Posting Date" := StoreRequisitionHeader."Posting Date";
                ItemJnlLine."Document No." := StoreRequisitionHeader."No.";
                ItemJnlLine."Item No." := StoreRequisitionLine."Item No.";
                ItemJnlLine.Validate("Item No.");
                Items.Reset;
                Items.SetRange(Items."No.", ItemJnlLine."Item No.");
                if Items.FindFirst then begin
                    ItemJnlLine."Gen. Prod. Posting Group" := Items."Gen. Prod. Posting Group";
                end;
                ItemJnlLine."Unit of Measure Code" := StoreRequisitionLine."Unit of Measure Code";
                ItemJnlLine.Validate("Unit of Measure Code");
                ItemJnlLine."Location Code" := StoreRequisitionLine."Location Code";
                ItemJnlLine.Validate("Location Code");
                ItemJnlLine.Description := CopyStr(StoreRequisitionHeader.Description, 1, 50);
                ItemJnlLine.Quantity := StoreRequisitionLine."Quantity to Issue";
                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Serial No." := StoreRequisitionLine."Alternative Part No. 3";
                ItemJnlLine."Shortcut Dimension 1 Code" := StoreRequisitionHeader."Global Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := StoreRequisitionHeader."Global Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, StoreRequisitionHeader."Shortcut Dimension 3 Code");
                ItemJnlLine.ValidateShortcutDimCode(4, StoreRequisitionHeader."Shortcut Dimension 4 Code");
                ItemJnlLine.ValidateShortcutDimCode(5, StoreRequisitionLine."Shortcut Dimension 5 Code");
                ItemJnlLine.ValidateShortcutDimCode(6, StoreRequisitionLine."Shortcut Dimension 6 Code");
                ItemJnlLine.ValidateShortcutDimCode(7, StoreRequisitionLine."Shortcut Dimension 7 Code");
                ItemJnlLine.ValidateShortcutDimCode(8, StoreRequisitionLine."Shortcut Dimension 8 Code");
                ItemJnlLine.Insert;
            until StoreRequisitionLine.Next = 0;

            Commit;
            //Post Entries
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
            ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
            if ItemJnlLine.FindSet then begin
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
            end;
            Commit;
            //End Post entries

            //Change Document Status
            ItemLedgerEntry.Reset;
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
            if ItemLedgerEntry.FindFirst then begin
                StoreRequisitionHeader2.Reset;
                StoreRequisitionHeader2.SetRange(StoreRequisitionHeader2."No.", StoreRequisitionHeader."No.");
                if StoreRequisitionHeader2.FindFirst then begin
                    StoreRequisitionHeader2.Status := StoreRequisitionHeader2.Status::Posted;
                    StoreRequisitionHeader2."Posting Date" := Today;
                    StoreRequisitionHeader2."Posted By" := UserId;
                    StoreRequisitionHeader2.Validate(StoreRequisitionHeader2.Status);
                    StoreRequisitionHeader2.Modify;
                end;
            end;
        end;


        //Replenish Purchase Requisition
        /* StoreRequisitionLine2.Reset;
         StoreRequisitionLine2.SetRange(StoreRequisitionLine2."Document No.","Store Requisition Header"."No.");
         if StoreRequisitionLine2.FindSet then begin
           repeat
             Setups.Get;
             Setups.TestField(Setups."User to replenish Stock");

             HREmployee.Reset;
             HREmployee.SetRange(HREmployee."User ID",Setups."User to replenish Stock");
             if HREmployee.FindFirst then begin
               EmailAddress:=HREmployee."E-Mail";
             end;

             Items.Reset;
             Items.SetRange(Items."No.",StoreRequisitionLine2."Item No.");
             Items.SetFilter(Items."Reorder Point",'<>%1',0);
             if Items.FindSet then begin
               repeat
               Items.CalcFields(Items.Inventory);
               if Items.Inventory<Items."Reorder Point" then begin
                 TempRequisition.Init;
               NewRequisitionNo:=NoSeriesMgt.GetNextNo(Setups."Purchase Requisition Nos.",0D,true);
               TempRequisition."No.":=NewRequisitionNo;
               TempRequisition."Requested Receipt Date":=Today;
               TempRequisition."Document Date":=Today;
               TempRequisition.Description:='Purchase requisition for Item that need replenishement';
               TempRequisition."User ID":=Setups."User to replenish Stock";
               TempRequisition.Validate(TempRequisition."User ID");
               TempRequisition."Replenishment PR":=true;
               TempRequisition.Insert;

               TempRequisitionLines.Init;
               TempRequisitionLines."Document No.":=NewRequisitionNo;
               TempRequisitionLines."Requisition Type":=TempRequisitionLines."Requisition Type"::Item;
               TempRequisitionLines.Validate(TempRequisitionLines."Requisition Type");
               TempRequisitionLines."Requisition Code":=Items."No.";
               TempRequisitionLines.Validate(TempRequisitionLines."Requisition Code");
                TempRequisitionLines.Validate(TempRequisitionLines."No.");
               TempRequisitionLines.Quantity:=Items."Reorder Quantity";
              if  TempRequisitionLines.Insert then begin
                Message(Text00011,TempRequisitionLines."Requisition Code");
                ProcurementManagement.CreateStockLevelEmail(NewRequisitionNo,EmailAddress,Items."No.");
                end;
               end;
               until Items.Next=0;
             end;

           until StoreRequisitionLine2.Next=0;
         end;*/
    end;
}

