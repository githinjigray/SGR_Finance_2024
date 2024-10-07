pageextension 70614 "User Setup Extension2" extends "User Setup"
{
    layout
    {
        addafter("Service Resp. Ctr. Filter")
        {
            field("Office Code"; Rec."Office Code")
            {
                ToolTip = 'Specifies the value of the Office Code field.';
                ApplicationArea = All;
            }
            field("Create Vendor"; Rec."Create Vendor")
            {
                ToolTip = 'Specifies the value of the Create Vendor field.';
                ApplicationArea = All;
            }
            field("Create Bank Accounts"; Rec."Create Bank Accounts")
            {
                ToolTip = 'Specifies the value of the Create Bank Accounts field.';
                ApplicationArea = All;
            }
            field("Create Customer"; Rec."Create Customer")
            {
                ToolTip = 'Specifies the value of the Create Customer field.';
                ApplicationArea = All;
            }
            field("Create G/L Accounts"; Rec."Create G/L Accounts")
            {
                ToolTip = 'Specifies the value of the Create G/L Accounts field.';
                ApplicationArea = All;
            }
            field("Reverse Receipt"; Rec."Reverse Receipt")
            {
                ToolTip = 'Specifies the value of the Create Reverse Receipt field.';
                ApplicationArea = All;
            }
            field("Reverse Payments"; Rec."Reverse Payments")
            {
                ToolTip = 'Specifies the value of the Create Reverse Payments field.';
                ApplicationArea = All;
            }
            field("Reverse Funds Transfers"; Rec."Reverse Funds Transfers")
            {
                ToolTip = 'Specifies the value of the Reverse Funds Transfers field.';
                ApplicationArea = All;
            }
            field("Re-open Payments"; Rec."Re-open Payments")
            {
                ToolTip = 'Specifies the value of the Re-open Payments field.';
                ApplicationArea = All;
            }
            field("Release Payments"; Rec."Release Payments")
            {
                ToolTip = 'Specifies the value of the Release Payments field.';
                ApplicationArea = All;
            }

            field("Receive Invoice Notification"; Rec."Receive Invoice Notification")
            {
                ToolTip = 'Specifies the value of the Receive Invoice Notification field.';
                ApplicationArea = All;
            }
            field("Apply/Unapply Receipts"; Rec."Apply/Unapply Receipts")
            {
                ToolTip = 'Specifies the value of the Apply/Unapply Receipts field.';
                ApplicationArea = All;
            }
            field("Apply/Unapply Payments"; Rec."Apply/Unapply Payments")
            {
                ToolTip = 'Specifies the value of the Apply/Unapply Payments field.';
                ApplicationArea = All;
            }
            field("Create Fixed Assets"; Rec."Create Fixed Assets")
            {
                ToolTip = 'Specifies the value of the Create Fixed Assets field.';
                ApplicationArea = All;
            }
            field("Reverse Bank Entries"; Rec."Reverse Bank Entries")
            {
                ToolTip = 'Specifies the value of the Reverse Bank Entries field.';
                ApplicationArea = All;
            }
            field("Reverse G/L Entries"; Rec."Reverse G/L Entries")
            {
                ToolTip = 'Specifies the value of the Reverse G/L Entries field.';
                ApplicationArea = All;
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ToolTip = 'Specifies the value of the Employee Name field.';
                ApplicationArea = All;
            }
            field("Re-open/Release Funds Transfer"; Rec."Re-open/Release Funds Transfer")
            {
                ToolTip = 'Specifies the value of the Re-open/Release Funds Transfer field.';
                ApplicationArea = All;
            }
            field("Cancel Payments"; Rec."Cancel Payments")
            {
                ToolTip = 'Specifies the value of the Cancel Payments field.';
                ApplicationArea = All;
            }
            field("Create/Edit Dimensions"; Rec."Create/Edit Dimensions")
            {
                ToolTip = 'Specifies who Create/Edit Dimensions';
                ApplicationArea = All;
            }
            field("Re-Open Reconciliation"; rec."Re-Open Reconciliation")
            {
                ToolTip = 'Specifies the value of Re-Open Reconciliation';
                ApplicationArea = All;
            }
        }

    }
}
