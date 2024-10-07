pageextension 50014 "Vendor Card Ext" extends "Vendor Card"
{
    layout
    {
        addafter(Name)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                Visible = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Visible = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
            }
        }
        addbefore(Address)
        {
            field("Supplier Category Code"; rec."Supplier Category Code")
            {
                ApplicationArea = all;
                ToolTip = 'Supplier category';
            }
            field("Pre-Qualified"; rec."Pre-Qualified")
            {
                ApplicationArea = all;
                ToolTip = 'Pre-Qualified';
            }
            field("Principal Phone No."; rec."Principal Phone No.")
            {
                ApplicationArea = all;
                ToolTip = 'Principal Phone No.';
            }
            field("Reason for Blacklisting"; rec."Reason for Blacklisting")
            {
                ApplicationArea = all;
                ToolTip = 'Reason for Blacklisting';
                MultiLine = true;
            }

        }
        addafter("Creditor No.")
        {
            field("Bank Code"; rec."Bank Code")
            {
                ApplicationArea = all;
                ToolTip = 'Bank Code';
            }
            field("Bank Name"; rec."Bank Name")
            {
                ApplicationArea = all;
                ToolTip = 'Bank Name';
            }
            field("Bank Branch Code"; rec."Bank Branch Code")
            {
                ApplicationArea = all;
                ToolTip = 'Bank Branch Code';
            }
            field("Bank Branch Name"; rec."Bank Branch Name")
            {
                ApplicationArea = all;
                ToolTip = 'Bank Branch Name';
            }
            field("Bank Account Name"; rec."Bank Account Name")
            {
                ApplicationArea = all;
                ToolTip = 'Bank Account Name';
            }
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = all;
                ToolTip = 'Bank Account No.';
            }

            field("Swift Code"; rec."Swift Code")
            {
                ApplicationArea = all;
                ToolTip = 'Swift Code';
            }

        }
        addafter("Disable Search by Name")
        {
            field("Vendor Creation Date"; rec."Vendor Creation Date")
            {
                ApplicationArea = all;
                ToolTip = 'Vendor Creation Date';
            }


            field("Created By"; rec."Created By")
            {
                ApplicationArea = all;
                ToolTip = 'Created By';
            }

        }

    }

    actions
    {
        addafter("Vendor - Balance to Date")
        {
            action("Print Packing List")
            {
                Caption = 'Vendor Statement';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';
                ApplicationArea = All;


                trigger OnAction()
                begin
                    VendorStatementHeader.Reset;
                    VendorStatementHeader.SetRange(VendorStatementHeader."No.", rec."No.");
                    if VendorStatementHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"Vendor Statement", true, false, VendorStatementHeader);
                    end;
                end;
            }
        }
    }
    var
        VendorStatementHeader: Record Vendor;
}
