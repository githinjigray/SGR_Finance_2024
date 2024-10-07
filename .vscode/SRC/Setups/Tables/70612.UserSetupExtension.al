tableextension 70612 "User Setup Extension2" extends "User Setup"
{
    fields
    {
        field(70000; "Office Code"; Code[50])
        {
            Caption = 'Office Code';
            DataClassification = ToBeClassified;
        }
        field(70001; "Create Vendor"; Boolean)
        {
            Caption = 'Create Vendor';
            DataClassification = ToBeClassified;
        }
        field(70002; "Create Customer"; Boolean)
        {
            Caption = 'Create Customer';
            DataClassification = ToBeClassified;
        }
        field(70003; "Create Bank Accounts"; Boolean)
        {
            Caption = 'Create Bank Accounts';
            DataClassification = ToBeClassified;
        }
        field(70004; "Create G/L Accounts"; Boolean)
        {
            Caption = 'Create G/L Accounts';
            DataClassification = ToBeClassified;
        }
        field(70005; "Reverse Receipt"; Boolean)
        {
            Caption = 'Reverse Receipt';
            DataClassification = ToBeClassified;
        }
        field(70006; "Reverse Payments"; Boolean)
        {
            Caption = 'Reverse Payments';
            DataClassification = ToBeClassified;
        }
        field(70007; "Reverse Funds Transfers"; Boolean)
        {
            Caption = 'Reverse Funds Transfers';
            DataClassification = ToBeClassified;
        }
        field(70008; "Re-open Payments"; Boolean)
        {
            Caption = 'Re-open Payments';
            DataClassification = ToBeClassified;
        }
        field(70009; "Release Payments"; Boolean)
        {
            Caption = 'Release Payments';
            DataClassification = ToBeClassified;
        }
        field(70010; "Receive Invoice Notification"; Boolean)
        {
            Caption = 'Receive Invoice Notification';
            DataClassification = ToBeClassified;
        }
        field(70011; "Apply/Unapply Receipts"; Boolean)
        {
            Caption = 'Apply/Unapply Receipts';
            DataClassification = ToBeClassified;
        }
        field(70012; "Create Fixed Assets"; Boolean)
        {
            Caption = 'Create Fixed Assets';
            DataClassification = ToBeClassified;
        }
        field(70013; "Apply/Unapply Payments"; Boolean)
        {
            Caption = 'Apply/Unapply Payments';
            DataClassification = ToBeClassified;
        }
        field(70014; "Reverse Bank Entries"; Boolean)
        {
            Caption = 'Reverse Bank Entries';
            DataClassification = ToBeClassified;
        }
        field(70015; "Reverse G/L Entries"; Boolean)
        {
            Caption = 'Reverse G/L Entries';
            DataClassification = ToBeClassified;
        }
        field(70016; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
        }
        field(70017; "Re-open/Release Funds Transfer"; Boolean)
        {
            Caption = 'Re-open/Release Funds Transfer';
            DataClassification = ToBeClassified;
        }
        field(70018; "Cancel Payments"; Boolean)
        {
            Caption = 'Cancel Payments';
            DataClassification = ToBeClassified;
        }       
        field(70020; "Receive Credit Ex Notification"; Boolean)
        {
            Caption = 'Receive Credit Ex Notification';
            DataClassification = ToBeClassified;
        }
        field(70036; "Create/Edit Dimensions"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Create/Edit Dimensions';
        }
        field(70037; "Re-Open Reconciliation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Re-Open Reconciliation';
        }
    }
}
