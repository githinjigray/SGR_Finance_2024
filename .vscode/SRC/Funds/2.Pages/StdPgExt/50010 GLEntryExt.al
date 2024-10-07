pageextension 50010 "G/L Entry Ext" extends "General Ledger Entries"
{
    layout
    {
        modify("Source Type")
        {
            Visible = true;
        }
        modify("Source No.")
        {
            Visible = true;
        }
        addafter("Source No.")
        {
            field("PAYE Name"; Rec."PAYE Name")
            {
                ApplicationArea = all;
                ToolTip = 'Source Name';
                Editable = false;
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = all;
                ToolTip = 'Currency Code';
            }
            field("Currency Amount"; Rec."Currency Amount")
            {
                ApplicationArea = all;
                ToolTip = 'Currency Amount';
            }
        }
        addafter(Description)
        {
            field(Description2; rec.Description2)
            {
                ApplicationArea = all;
                ToolTip = 'Description2';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
            }
        }

        // addafter("Dimension Set ID")
        // {
        //     field("Payroll Period"; rec."Payroll Period")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Payroll Period';
        //     }
        //     field("Payroll Group Code"; rec."Payroll Group Code")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Payroll Group Code';
        //     }
        //     field("Employee No."; rec."Employee No.")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Employee No.';
        //     }
        //     field("Customer No."; rec."Customer No.")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Customer No.';
        //     }
        //     field("Customer Name"; rec."Customer Name")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Customer Name';
        //     }
        //     field("Cheque No."; rec."Cheque No.")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Cheque No.';
        //     }
        // }

    }
}
