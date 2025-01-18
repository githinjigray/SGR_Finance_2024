pageextension 70612 "Company Information Ext2" extends "General Ledger Setup"
{
    layout
    {
        addafter("App. Dimension Posting")
        {
            group("Data Directory Path Configurations")
            {
                field("Company Data Directory Path"; Rec."Company Data Directory Path")
                {
                    ToolTip = 'Specifies the value of the Company Data Directory Path field.';
                    ApplicationArea = All;
                }
                field("Staff Data URL"; Rec."Staff Data URL")
                {
                    ToolTip = 'Specifies the value of the Staff Data URL field.';
                    ApplicationArea = All;
                }
                field("Recruitment Data URL"; Rec."Recruitment Data URL")
                {
                    ToolTip = 'Specifies the value of the Recruitment Data URL field.';
                    ApplicationArea = All;
                }
                field("Path to Save Documents"; Rec."Path to Save Documents")
                {
                    ToolTip = 'Specifies the value of the Path to Save Documents.';
                    ApplicationArea = All;
                }
            }
            group("Company Statutory Numbers")
            {

                field("NSSF No."; Rec."NSSF No.")
                {
                    ToolTip = 'Specifies the value of the NSSF No. field.';
                    ApplicationArea = All;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ToolTip = 'Specifies the value of the NHIF No. field.';
                    ApplicationArea = All;
                }
                field("Company TIN"; Rec."Company TIN")
                {
                    ToolTip = 'Specifies the value of the Company TIN field.';
                    ApplicationArea = All;
                }
                field("VAT No."; Rec."VAT No.")
                {
                    ToolTip = 'Specifies the value of the Company VAT No. field.';
                    ApplicationArea = All;
                }
            }
            group("Company Messages")
            {
                field("Company Letter Head"; Rec."Company Letter Head")
                {
                    ToolTip = 'Specifies the value of the Company Letter Head field.';
                    ApplicationArea = All;
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ToolTip = 'Specifies the value of the Payslip Message field.';
                    ApplicationArea = All;
                }

            }

            group(Emails)
            {
                field("Human Resource Email"; Rec."Human Resource Email")
                {
                    ToolTip = 'Specifies the value of the Human Resource Email field.';
                    ApplicationArea = All;
                }
                field("Procurement Email"; Rec."Procurement Email")
                {
                    ToolTip = 'Specifies the value of the Procurement Email field.';
                    ApplicationArea = All;
                }
                field("Stores Email"; Rec."Stores Email")
                {
                    ToolTip = 'Specifies the value of the Stores Email field.';
                    ApplicationArea = All;
                }
                field("Human Resource Sender Name"; Rec."Human Resource Sender Name")
                {
                    ToolTip = 'Specifies the value of the Human Resource Sender Name field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
