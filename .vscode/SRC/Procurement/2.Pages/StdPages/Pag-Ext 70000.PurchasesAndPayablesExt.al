pageextension 70000 "Purchases And Payables Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addbefore("Vendor Nos.")
        {
            field("Purchase Requisition Nos."; Rec."Purchase Requisition Nos.")
            {
                ApplicationArea = all;
            }
            field("Procurement Plan Nos"; Rec."Procurement Plan Nos")
            {
                ApplicationArea = all;
            }
            field("Request for Quotation Nos."; Rec."Request for Quotation Nos.")
            {
                ApplicationArea = all;
            }
            field("Bid Analysis No."; Rec."Bid Analysis No.")
            {
                ApplicationArea = all;
            }
            field("Tender Doc No."; Rec."Tender Doc No.")
            {
                ApplicationArea = all;
            }
            field("Tender Evaluation No."; Rec."Tender Evaluation No.")
            {
                ApplicationArea = all;
            }
            field("Contract Request Nos"; Rec."Contract Request Nos")
            {
                ApplicationArea = all;
            }
            field("Contract Nos"; Rec."Contract Nos")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("Incoming Documents Setup")
        {
            action("Procurement Documents Set-up")
            {
                ApplicationArea = All;
                Caption = 'Procurement Documents Set-up', comment = 'ENU="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Setup;
                RunObject = page "Procurement Upload Documents";
                trigger OnAction()
                begin

                end;
            }

        }
    }
}
