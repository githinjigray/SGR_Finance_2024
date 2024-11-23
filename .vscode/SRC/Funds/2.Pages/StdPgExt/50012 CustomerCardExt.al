pageextension 50012 "Customer Card Ext" extends "Customer Card"
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
        addafter(Address)
        {
            field(" TIN No."; Rec."TIN No.")
            {
                ApplicationArea = all;
                ToolTip = ' TIN No.';
            }
            field("Account Type"; rec."Account Type")
            {
                ApplicationArea = all;
                ToolTip = 'Account Type';
            }
            field("Old Account No."; Rec."Old Account No.")
            {
                ApplicationArea = all;
                ToolTip = 'Old Account No.';
            }
            field("User ID"; rec."User ID")
            {
                ApplicationArea = all;
                ToolTip = 'User ID';
                Editable = false;
            }
            field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 3 Code';
                Editable = false;
            }
            field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 4 Code';
                Editable = false;
            }
            field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 5 Code';
                Editable = false;
            }
            field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Shortcut Dimension 6 Code';
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Report Statement")
        {
            action("Customer statment")
            {
                Caption = 'Customer Statement';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';
                ApplicationArea = All;


                trigger OnAction()
                begin
                    CustomersStatement.Reset;
                    CustomersStatement.SetRange(CustomersStatement."No.", rec."No.");
                    if CustomersStatement.FindFirst then begin
                        REPORT.RunModal(REPORT::"customers statement", true, false, CustomersStatement);
                    end;
                end;
            }
        }

    }
    var
        CustomersStatement: Record Customer;
}
