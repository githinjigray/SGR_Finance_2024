page 50069 "Cheque Register Lines"
{
    Caption = 'Cheque Register Lines';
    PageType = ListPart;
    SourceTable = "Cheque Register Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                }
                field("Leaf no"; Rec."Leaf no")
                {
                    ToolTip = 'Specifies the value of the Leaf no field.';
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                    ApplicationArea = All;
                }
                field("Payee No"; Rec."Payee No")
                {
                    ToolTip = 'Specifies the value of the Payee No field.';
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.';
                    ApplicationArea = All;
                }
                field("PV No"; Rec."PV No")
                {
                    ToolTip = 'Specifies the value of the PV No field.';
                    ApplicationArea = All;
                }
                field("PV Description"; Rec."PV Description")
                {
                    ToolTip = 'Specifies the value of the PV Description field.';
                    ApplicationArea = All;
                }
                field("PV Prepared By"; Rec."PV Prepared By")
                {
                    ToolTip = 'Specifies the value of the PV Prepared By field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Cheque Cancelled"; Rec."Cheque Cancelled")
                {
                    ToolTip = 'Specifies the value of the Cheque Cancelled field.';
                    ApplicationArea = All;
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ToolTip = 'Specifies the value of the Cancelled By field.';
                    ApplicationArea = All;
                }
                field("Bank  Account No."; Rec."Bank  Account No.")
                {
                    ToolTip = 'Specifies the value of the Bank  Account No. field.';
                    ApplicationArea = All;
                }
                field("Assigned to PV"; Rec."Assigned to PV")
                {
                    ToolTip = 'Specifies the value of the Assigned to PV field.';
                    ApplicationArea = All;
                }
                field("PV Posted with Cheque"; Rec."PV Posted with Cheque")
                {
                    ToolTip = 'Specifies the value of the PV Posted with Cheque field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
