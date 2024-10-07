page 50063 "Funds Account Activities"
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Funds Management Cue";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Accounts Payable/ Payments")
            {
                Caption = 'Accounts Payable/ Payments';
                field("Purchase Invoices"; Rec."Purchase Invoices")
                {
                    DrillDownPageID = "Purchase Invoices";
                    ToolTip = 'Purchase Invoices';
                    ApplicationArea = all;
                }
                field("Posted Purchase Invoices"; Rec."Posted Purchase Invoices")
                {
                    DrillDownPageID = "Posted Purchase Invoices";
                    ToolTip = 'Posted Purchase Invoices';
                    ApplicationArea = all;
                }
                field("Purchase Cr. Memos"; Rec."Purchase Cr. Memos")
                {
                    DrillDownPageID = "Purchase Credit Memos";
                    ToolTip = 'Purchase Credit Memos';
                    ApplicationArea = all;
                }
                field("Posted Purchase Cr. Memos"; Rec."Posted Purchase Cr. Memos")
                {
                    DrillDownPageID = "Posted Purchase Credit Memos";
                    ToolTip = 'Posted Purchase Credit Memos';
                    ApplicationArea = all;
                }
                field("Open Payments"; Rec."Open Payments")
                {
                    DrillDownPageID = "Payment List";
                    ToolTip = 'Specifies the payments';
                    ApplicationArea = all;
                }
                field("Posted Payments"; Rec."Posted Payments")
                {
                    DrillDownPageID = "Posted Payment List";
                    ToolTip = 'Specifies the payments';
                    ApplicationArea = all;
                }
                field("Reversed Payments"; Rec."Reversed Payments")
                {
                    DrillDownPageID = "Posted Payment List";
                    ToolTip = 'Specifies the field name';
                    ApplicationArea = all;
                }
                field("Open Cash Payments"; Rec."Open Cash Payments")
                {
                    DrillDownPageID = "Cash Payment List";
                    ToolTip = 'Specifies the payments';
                    ApplicationArea = all;
                }
                field("Posted Cash Payments"; Rec."Posted Cash Payments")
                {
                    DrillDownPageID = "Posted Cash Payment List";
                    ToolTip = 'Specifies the posted payments';
                    ApplicationArea = all;
                }
            }
            cuegroup("Accounts Receivable")
            {
                Caption = 'Accounts Receivable';
                field("Sales Invoices"; Rec."Sales Invoices")
                {
                    DrillDownPageID = "Sales Invoice List";
                    ToolTip = 'Specifies the sales invoices';
                    ApplicationArea = all;
                }
                field("Posted Sales Invoices"; Rec."Posted Sales Invoices")
                {
                    DrillDownPageID = "Posted Sales Invoices";
                    ToolTip = 'Specifies the sales invoices posted';
                    ApplicationArea = all;
                }
                field("Sales Cr. Memos"; Rec."Sales Cr. Memos")
                {
                    DrillDownPageID = "Sales Credit Memos";
                    ToolTip = 'Specifies the Sales Credit Memos';
                    ApplicationArea = all;
                }
                field("Posted Sales Cr. Memos"; Rec."Posted Sales Cr. Memos")
                {
                    DrillDownPageID = "Posted Sales Credit Memos";
                    ToolTip = 'Specifies the Posted Sales Credit Memos';
                    ApplicationArea = all;
                }
            }
            cuegroup(Receipt)
            {
                Caption = 'Receipts';
                field(Receipts; Rec.Receipts)
                {
                    ApplicationArea = all;
                    Image = Cash;
                    DrillDownPageID = "Receipt List";
                }
                field("Posted Receipts"; Rec."Posted Receipts")
                {
                    ApplicationArea = all;
                    Image = Cash;
                    DrillDownPageID = "Posted Receipt List";
                }
            }
            cuegroup("Imprest and Surrenders")
            {
                Caption = 'Imprest and Surrenders';
                field(Imprests; Rec.Imprests)
                {
                    DrillDownPageID = "Imprest List";
                    ToolTip = 'Imprest List';
                    ApplicationArea = all;
                }
                field("Posted Imprests"; Rec."Posted Imprests")
                {
                    DrillDownPageID = "Posted Imprest List";
                    ToolTip = 'Posted Imprest List';
                    ApplicationArea = all;
                }
                field("Imprest Surrenders"; Rec."Imprest Surrenders")
                {
                    DrillDownPageID = "Imprest Surrender List";
                    ToolTip = 'Imprest Surrender List';
                    ApplicationArea = all;
                }
                field("Posted Imprest Surrenders"; Rec."Posted Imprest Surrenders")
                {
                    DrillDownPageID = "Posted Imprest Surrender List";
                    ToolTip = 'Posted Imprest Surrender List';
                    ApplicationArea = all;
                }
                field("Reversed Imprest Surrenders"; Rec."Reversed Imprest Surrenders")
                {
                    DrillDownPageID = "Posted Imprest Surrender List";
                    ToolTip = 'Reversed Imprest Surrender List';
                    ApplicationArea = all;
                }
            }
            cuegroup("Funds Transfers")
            {
                Caption = 'Funds Transfers';
                field("Funds Transfer"; Rec."Funds Transfer")
                {
                    DrillDownPageID = "Funds Transfer List";
                    ToolTip = 'Funds Transfer List';
                    ApplicationArea = all;
                }
                field("Posted Funds Transfer"; Rec."Posted Funds Transfer")
                {
                    DrillDownPageID = "Posted Funds Transfer List";
                    ToolTip = 'Posted Funds Transfer List';
                    ApplicationArea = all;
                }
            }
            cuegroup("Fixed Deposits")
            {
                Caption = 'Fixed Deposits';
                field("New Fixed Deposits"; Rec."New Fixed Deposits")
                {
                    DrillDownPageID = "FD Transfer Term Amount List";
                    ToolTip = 'New Fixed Deposits';
                    ApplicationArea = all;
                }
                field("Active Fixed Deposits"; Rec."Active Fixed Deposits")
                {
                    DrillDownPageID = "FD Transfer Term Amount List";
                    ToolTip = 'Active Fixed Deposits';
                    ApplicationArea = all;
                }
                field("Matured Fixed Deposits"; Rec."Matured Fixed Deposits")
                {
                    DrillDownPageID = "FD Transfer Term Amount List";
                    ToolTip = 'Matured Fixed Deposits';
                    ApplicationArea = all;
                }
            }
            cuegroup("Contract Management")
            {
                Caption = 'Contract Management';
                field("Contract Requests"; Rec."Contract Requests")
                {
                    DrillDownPageID = "Contract Requests";
                    ToolTip = 'Contract Requests';
                    ApplicationArea = all;
                }
                field("Active Contracts"; Rec."Active Contracts")
                {
                    DrillDownPageID = Contracts;
                    ToolTip = 'Active Contract List';
                    ApplicationArea = all;
                }
                field("Terminated Contracts"; Rec."In-Active Contracts")
                {
                    DrillDownPageID = Contracts;
                    ToolTip = 'Terminated Contract List';
                    ApplicationArea = all;
                }
                field("Expired Contracts"; Rec."Expired Contracts")
                {
                    DrillDownPageID = "Expired Contracts";
                    ToolTip = 'Expired Contract List';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}

