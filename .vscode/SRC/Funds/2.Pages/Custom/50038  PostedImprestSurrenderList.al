page 50038 "Posted Imprest Surrender List"
{
    ApplicationArea = All;
    Caption = 'Posted Imprest Surrender List';
    PageType = List;
    SourceTable = "Imprest Surrender Header";
    SourceTableView = where(Posted = const(true));
    UsageCategory = History;
    DeleteAllowed = false;
    Editable = false;
    CardPageId = "Posted Imprest Surrender Card";
    PromotedActionCategoriesML = ENU = 'New,Process,Reports,Details,Approvals,Attachements,Category7_caption,Approvals,Category9_caption,Category10_caption,Category11_caption,Category12_caption,Category13_caption,Category14_caption,Category15_caption,Category16_caption,Category17_caption,Category18_caption,Category19_caption,Category20_caption';
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
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    ToolTip = 'Specifies the value of the Imprest No. field.';
                    ApplicationArea = All;
                }
                field("Imprest Date"; Rec."Imprest Date")
                {
                    ToolTip = 'Specifies the value of the Imprest Date field.';
                    ApplicationArea = All;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
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
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ToolTip = 'Specifies the value of the Actual Spent field.';
                    ApplicationArea = All;
                }
                field("Actual Spent(LCY)"; Rec."Actual Spent(LCY)")
                {
                    ToolTip = 'Specifies the value of the Actual Spent(LCY) field.';
                    ApplicationArea = All;
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Cash Receipt Amount field.';
                    ApplicationArea = All;
                }
                field("Cash Receipt Amount(LCY)"; Rec."Cash Receipt Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Cash Receipt Amount(LCY) field.';
                    ApplicationArea = All;
                }
                field(Difference; Rec.Difference)
                {
                    ToolTip = 'Specifies the value of the Difference field.';
                    ApplicationArea = All;
                }
                field("Difference(LCY)"; Rec."Difference(LCY)")
                {
                    ToolTip = 'Specifies the value of the Difference(LCY) field.';
                    ApplicationArea = All;
                }
                field("Actual Surrenderd"; Rec."Actual Surrenderd")
                {
                    ToolTip = 'Specifies the value of the Actual Surrenderd field.';
                    ApplicationArea = All;
                }
                field("Actual Advanced"; Rec."Actual Advanced")
                {
                    ToolTip = 'Specifies the value of the Actual Advanced field.';
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

                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field("Refund Amount"; Rec."Refund Amount")
                {
                    ToolTip = 'Specifies the value of the Refund Amount field.';
                    ApplicationArea = All;
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
        area(Processing)
        {
            action("Portal Document Attachments")
            {
                Image = MakeDiskette;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page PortalDocuments;
                RunPageLink = "DocumentNo." = FIELD("No.");
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals', comment = 'ENU="Approvals"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                RunObject = page "Approval Entries-Modified";
                RunPageLink = "Document No." = field("No.");
                trigger OnAction()
                begin

                end;
            }
        }
        area(Reporting)
        {
            action("Print Imprest surrender")
            {
                ApplicationArea = All;
                Caption = 'Print Imprest surrender', comment = 'ENU=Print Imprest surrender';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report2;

                trigger OnAction()
                begin
                    ImprestSurrenderHeader.RESET;
                    ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", Rec."No.");
                    IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(REPORT::"Imprest Surrender Voucher", TRUE, FALSE, ImprestSurrenderHeader);
                    END;
                end;
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                Visible = false;
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

        }

    }
    var
        FundsUserSetup: Record "Funds User Setup";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
}
