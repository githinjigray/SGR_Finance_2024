pageextension 70012 "Purchase Order Archive EXT" extends "Purchase Order Archive"
{
    layout
    {
        addafter("Document Date")
        {
            field("Purchase Order Type"; Rec."Purchase Order Type")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Order Type';
            }
            field("Purchase Type"; Rec."Purchase Type")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Type';
            }
            field("Expense Period"; rec."Expense Period")
            {
                ApplicationArea = all;
                ToolTip = 'Bid Analysis No.';
            }
            field("PRF No."; Rec."PRF No.")
            {
                ApplicationArea = all;
                ToolTip = 'PRF No.';
            }
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = all;
                ToolTip = 'RFQ No.';
            }
            field(Comments; rec.Comments)
            {
                ApplicationArea = all;
                ToolTip = 'Comments';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 3 Code';
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 4 Code';
            }
            field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 5 Code';
            }
            field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 6 Code';
            }
        }
    }
    actions
    {
        addfirst(Reporting)
        {
            action("Print LPO Copy")
            {
                ApplicationArea = All;
                Caption = 'Print LPO Copy', comment = 'ENU=Print LPO Copy';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header Archive";
                begin
                    PurchaseHeader.Reset;
                    PurchaseHeader.SetRange(PurchaseHeader."No.", Rec."No.");
                    if PurchaseHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"LPO/LSO Archived", true, false, PurchaseHeader);
                    end;
                end;
            }

        }

    }


}

