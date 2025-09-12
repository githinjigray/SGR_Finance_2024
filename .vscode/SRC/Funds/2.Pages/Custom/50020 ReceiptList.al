page 50020 "Receipt List"
{
    ApplicationArea = All;
    Caption = 'Receipt List';
    PageType = List;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;
    DeleteAllowed = false;
    CardPageId = "Receipt Card";
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
            }
        }
    }
    actions
    {
        area(Processing)
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
            action("Preview Posting")
            {
                ApplicationArea = All;
                Caption = 'Preview Posting';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    PostReceipt.CheckReceiptMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := true;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Batch");
                        JTemplate := FundsUserSetup."Receipt Journal Template";
                        JBatch := FundsUserSetup."Receipt Journal Batch";
                        PostReceipt.PostReceipt(Rec."No.", JTemplate, JBatch, Preview);
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }
            action("Post Receipt")
            {
                ApplicationArea = All;
                Caption = 'PostPayment';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    PostReceipt.CheckReceiptMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := false;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Batch");
                        JTemplate := FundsUserSetup."Receipt Journal Template";
                        JBatch := FundsUserSetup."Receipt Journal Batch";
                        PostReceipt.PostReceipt(Rec."No.", JTemplate, JBatch, Preview);
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }

            action("Post & Print Receipt")
            {
                ApplicationArea = All;
                Caption = 'Post & Print Payment';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    PostReceipt.CheckReceiptMandatoryFields(Rec."No.");
                    IF FundsUserSetup.GET(USERID) THEN BEGIN
                        Preview := false;
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Template");
                        FundsUserSetup.TESTFIELD(FundsUserSetup."Receipt Journal Batch");
                        JTemplate := FundsUserSetup."Receipt Journal Template";
                        JBatch := FundsUserSetup."Receipt Journal Batch";
                        PostReceipt.PostReceipt(Rec."No.", JTemplate, JBatch, Preview);
                        COMMIT;
                        ReceiptHeader.RESET;
                        ReceiptHeader.SETRANGE(ReceiptHeader."No.", Rec."No.");
                        IF ReceiptHeader.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(REPORT::"Receipt Header", TRUE, FALSE, ReceiptHeader);
                        END
                    END ELSE BEGIN
                        ERROR(Txt_001, USERID);
                    END;
                end;
            }

        }
        area(Reporting)
        {
            action("Print Receipt")
            {
                ApplicationArea = All;
                Caption = 'Print Receipt', comment = 'ENU="Print Receipt"';
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

        }
    }
    var
        FundsUserSetup: Record "Funds User Setup";
        ReceiptHeader: Record "Receipt Header";
        PostReceipt: Codeunit ReceiptPost;
        Preview: Boolean;
        JTemplate: code[20];
        JBatch: code[20];
        Txt_001: TextConst ENU = 'User Account %1 is not Setup for Payments Posting, Contact the System Administrator';
}
