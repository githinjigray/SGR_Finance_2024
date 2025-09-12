page 50023 "Posted Receipt List"
{
    ApplicationArea = All;
    Caption = 'Posted Receipt List';
    PageType = List;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(true));
    UsageCategory = History;
    DeleteAllowed = false;
    CardPageId = "Posted Receipt Card";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                    ApplicationArea = All;
                }
                field("Receipt Type"; Rec."Receipt Type")
                {
                    ToolTip = 'Specifies the value of the Receipt Type field.';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                    ApplicationArea = All;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ToolTip = 'Specifies the value of the Account Balance field.';
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    ApplicationArea = All;
                }
                field("Received From"; Rec."Received From")
                {
                    ToolTip = 'Specifies the value of the Received From field.';
                    ApplicationArea = All;
                }
                field("On Behalf of"; Rec."On Behalf of")
                {
                    ToolTip = 'Specifies the value of the On Behalf of field.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    ApplicationArea = All;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                    ApplicationArea = All;
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ToolTip = 'Specifies the value of the Amount Received field.';
                    ApplicationArea = All;
                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount Received(LCY) field.';
                    ApplicationArea = All;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ToolTip = 'Specifies the value of the Total Line Amount field.';
                    ApplicationArea = All;
                }
                field("Total Line Amount(LCY)"; Rec."Total Line Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Line Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = All;
                }    
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }            
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                    ApplicationArea = All;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.';
                    ApplicationArea = All;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field.';
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                    ApplicationArea = All;
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    ToolTip = 'Specifies the value of the Reversed By field.';
                    ApplicationArea = All;
                }
                field("Reversal Date"; Rec."Reversal Date")
                {
                    ToolTip = 'Specifies the value of the Reversal Date field.';
                    ApplicationArea = All;
                }
                field("Reversal Time"; Rec."Reversal Time")
                {
                    ToolTip = 'Specifies the value of the Reversal Time field.';
                    ApplicationArea = All;
                }
                field("Reversal Posting Date"; Rec."Reversal Posting Date")
                {
                    ToolTip = 'Specifies the value of the Reversal Posting Date field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {

        area(Reporting)
        {
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("Print Receipt")
            {
                ApplicationArea = All;
                Caption = 'Print Receipt', comment = 'ENU=Print Receipt';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Receipt;

                trigger OnAction()
                begin
                    ReceiptHeader.RESET;
                    ReceiptHeader.SETRANGE(ReceiptHeader."No.", Rec."No.");
                    IF ReceiptHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Receipt Header", TRUE, FALSE, ReceiptHeader);
                    END
                end;
            }
            action("Copy Document")
            {
                ApplicationArea = All;
                Caption = 'Copy Document', comment = 'ENU=Copy Document';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CopyDocument;

                trigger OnAction()
                var
                    ReceiptHeadrNew: Record "Receipt Header";
                    ReceiptHeadrNew2: Record "Receipt Header";
                    ReceiptLineNew: Record "Receipt Line";
                    ReceiptLineold: Record "Receipt Line";
                    NewrEceiptNo: code[20];
                    ReceiptCard: Page "Receipt Card";
                begin
                    if Confirm('The document copied will have a new sufix to the document number but with all details which can be edited') then begin
                        NewrEceiptNo := '';
                        NewrEceiptNo := Rec."No." + '/2';
                        ReceiptHeadrNew.Init();
                        ReceiptHeadrNew."No." := NewrEceiptNo;
                        ReceiptHeadrNew."Document Date" := Today;
                        ReceiptHeadrNew."Posting Date" := Rec."Posting Date";
                        ReceiptHeadrNew."Payment Mode" := Rec."Payment Mode";
                        ReceiptHeadrNew."Receipt Type" := Rec."Receipt Type";
                        ReceiptHeadrNew."Account No." := Rec."Account No.";
                        ReceiptHeadrNew."Account Name" := Rec."Account Name";
                        ReceiptHeadrNew."Reference No." := Rec."Reference No.";
                        ReceiptHeadrNew."Received From" := Rec."Received From";
                        ReceiptHeadrNew."On Behalf of" := Rec."On Behalf of";
                        ReceiptHeadrNew."Currency Code" := Rec."Currency Code";
                        ReceiptHeadrNew."Currency Factor" := Rec."Currency Factor";
                        ReceiptHeadrNew."Amount Received" := Rec."Amount Received";
                        ReceiptHeadrNew."Amount Received(LCY)" := Rec."Amount Received(LCY)";
                        ReceiptHeadrNew.Description := Rec.Description;
                        ReceiptHeadrNew."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        ReceiptHeadrNew."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        ReceiptHeadrNew."Shortcut Dimension 3 Code" := Rec."Shortcut Dimension 3 Code";
                        ReceiptHeadrNew."Shortcut Dimension 4 Code" := Rec."Shortcut Dimension 4 Code";
                        ReceiptHeadrNew."Shortcut Dimension 5 Code" := Rec."Shortcut Dimension 5 Code";
                        ReceiptHeadrNew."Shortcut Dimension 6 Code" := Rec."Shortcut Dimension 6 Code";
                        ReceiptHeadrNew."User ID" := UserId;
                        ReceiptHeadrNew."Customer Email Address" := Rec."Customer Email Address";

                        if ReceiptHeadrNew.Insert() then begin
                            ReceiptLineold.Reset();
                            ReceiptLineold.SetRange("Document No.", Rec."No.");
                            if ReceiptLineold.FindSet() then begin
                                repeat
                                    ReceiptLineNew.Init();
                                    ReceiptLineNew."Line No." := 0;
                                    ReceiptLineNew."Document No." := NewrEceiptNo;
                                    ReceiptLineNew."Document Type" := ReceiptLineold."Document Type";
                                    ReceiptLineNew."Receipt Code" := ReceiptLineold."Receipt Code";
                                    ReceiptLineNew."Receipt Code Description" := ReceiptLineold."Receipt Code Description";
                                    ReceiptLineNew."Account Type" := ReceiptLineold."Account Type";
                                    ReceiptLineNew."Account No." := ReceiptLineold."Account No.";
                                    ReceiptLineNew."Account Name" := ReceiptLineold."Account Name";
                                    ReceiptLineNew."Posting Group" := ReceiptLineold."Posting Group";
                                    ReceiptLineNew.Description := ReceiptLineold.Description;
                                    ReceiptLineNew."Posting Date" := ReceiptLineold."Posting Date";
                                    ReceiptLineNew."Currency Code" := ReceiptLineold."Currency Code";
                                    ReceiptLineNew."Currency Factor" := ReceiptLineold."Currency Factor";
                                    ReceiptLineNew.Amount := ReceiptLineold.Amount;
                                    ReceiptLineNew."Amount(LCY)" := ReceiptLineold."Amount(LCY)";
                                    ReceiptLineNew."VAT Code" := ReceiptLineold."VAT Code";
                                    ReceiptLineNew."VAT Amount" := ReceiptLineold."VAT Amount";
                                    ReceiptLineNew."VAT Amount(LCY)" := ReceiptLineold."VAT Amount(LCY)";
                                    ReceiptLineNew."Withholding Tax Code" := ReceiptLineold."Withholding Tax Code";
                                    ReceiptLineNew."Withholding Tax Amount" := ReceiptLineold."Withholding Tax Amount";
                                    ReceiptLineNew."Withholding Tax Amount(LCY)" := ReceiptLineold."Withholding Tax Amount(LCY)";
                                    ReceiptLineNew."Withholding VAT Code" := ReceiptLineold."Withholding VAT Code";
                                    ReceiptLineNew."Withholding VAT Amount" := ReceiptLineold."Withholding VAT Amount";
                                    ReceiptLineNew."Withholding VAT Amount(LCY)" := ReceiptLineold."Withholding VAT Amount(LCY)";
                                    ReceiptLineNew."Net Amount" := ReceiptLineold."Net Amount";
                                    ReceiptLineNew."Net Amount(LCY)" := ReceiptLineold."Net Amount(LCY)";
                                    ReceiptLineNew."Applies-to Doc. Type" := ReceiptLineold."Applies-to Doc. Type";
                                    ReceiptLineNew."Applies-to Doc. No." := ReceiptLineold."Applies-to Doc. No.";
                                    ReceiptLineNew."Applies-to ID" := ReceiptLineold."Applies-to ID";
                                    ReceiptLineNew.Committed := ReceiptLineold.Committed;
                                    ReceiptLineNew."Budget Code" := ReceiptLineold."Budget Code";
                                    ReceiptLineNew."Invoice Amount" := ReceiptLineold."Invoice Amount";
                                    ReceiptLineNew."Global Dimension 1 Code" := ReceiptLineold."Global Dimension 1 Code";
                                    ReceiptLineNew."Global Dimension 2 Code" := ReceiptLineold."Global Dimension 2 Code";
                                    ReceiptLineNew."Shortcut Dimension 3 Code" := ReceiptLineold."Shortcut Dimension 3 Code";
                                    ReceiptLineNew."Shortcut Dimension 4 Code" := ReceiptLineold."Shortcut Dimension 4 Code";
                                    ReceiptLineNew."Shortcut Dimension 5 Code" := ReceiptLineold."Shortcut Dimension 5 Code";
                                    ReceiptLineNew."Shortcut Dimension 6 Code" := ReceiptLineold."Shortcut Dimension 6 Code";
                                    ReceiptLineNew.Status := ReceiptLineNew.Status::Open;
                                    ReceiptLineNew.Insert();
                                until ReceiptLineold.Next() = 0;
                            end;
                        end;
                        ReceiptHeadrNew2.Reset;
                        ReceiptHeadrNew2.SetRange("No.", NewrEceiptNo);
                        ReceiptCard.SetTableView(ReceiptHeadrNew2);
                        ReceiptCard.Run;
                        Message('Copy document complete. Continue....');
                    end;
                end;

            }
        }
    }
    var
        FundsUserSetup: Record "Funds User Setup";
        ReceiptHeader: Record "Receipt Header";
        JTemplate: code[20];
        JBatch: code[20];
        Txt_001: TextConst ENU = 'User Account %1 is not Setup for Payments Posting, Contact the System Administrator';
}
