pageextension 70005 "Purchase Order Subform EXT" extends "Purchase Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = all;
                ToolTip = 'Description 2';
            }
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = all;
            }
        }
        addbefore(Description)
        {
            field("Service Date"; Rec."Service Date")
            {
                ApplicationArea = all;
                ToolTip = 'Service Date';
                ShowMandatory = true;
            }
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = all;
                ToolTip = 'Shows the Part No. of an item';
                ShowMandatory = true;
            }            
            field("Purchase Requisition No."; Rec."Purchase Requisition No.")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Requisition No.';
            }
            field("Purchase Requisition Line"; Rec."Purchase Requisition Line")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Requisition Line';
            }
            //     field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            //     {
            //         ApplicationArea = all;
            //         ToolTip = 'Global Dimension 2 Code';
            //     }
            //     field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            //     {
            //         ApplicationArea = all;
            //         Visible = false;
            //         ToolTip = 'Shortcut Dimension 3 Code';
            //     }
            //     field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            //     {
            //         ApplicationArea = all;
            //         Visible = false;
            //         ToolTip = 'Shortcut Dimension 4 Code';
            //     }
            //     field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            //     {
            //         ApplicationArea = all;
            //         Visible = false;
            //         ToolTip = 'Shortcut Dimension 5 Code';
            //     }
            //     field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            //     {
            //         ApplicationArea = all;
            //         Visible = false;
            //         ToolTip = 'Shortcut Dimension 6 Code';
            //     }
        }
        // modify("Depreciation Book Code")
        // {
        //     visible = true;
        //ApplicationArea = all;
        // }
    }
}
