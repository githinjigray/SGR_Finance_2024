page 70066 "Contract Card."
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Actions,Budgeting,Category6_caption,Category7_caption,RequestToApprove,Category9_caption,Category10_caption';
    SourceTable = "Contract Header2";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field("Commencement Date"; rec."Commencement Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field(Duration; rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Expiry Notification Period"; rec."Expiry Notification Period")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created DateTime"; rec."Created DateTime")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Contract Status"; Rec."Contract Status")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {

            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control30; Notes)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Terminate Contract")
            {
                Caption = 'Terminate Contract-Terminated';
                Image = ConfidentialOverview;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to terminate this contract? Its status will change to Terminated. Continue?') then begin
                        Rec."Contract Status" := Rec."Contract Status"::Terminated;
                        if Rec.Modify() then
                            Message('Contract Terminated');
                    end;
                end;
            }
            action("Terminate Contract Ex")
            {
                Caption = 'Terminate Contract - Expired';
                Image = ConfidentialOverview;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to terminate this contract? Its status will change to Expired. Continue?') then begin
                        Rec."Contract Status" := Rec."Contract Status"::Expired;
                        if Rec.Modify() then
                            Message('Contract Expired');
                    end;
                end;
            }
            action("Contract Report")
            {
                Caption = 'Contract Report';
                Image = FileContract;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = report "Contracts Reports";
            }
        }
    }
}
