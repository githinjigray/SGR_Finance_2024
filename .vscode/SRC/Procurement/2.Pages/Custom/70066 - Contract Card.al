page 70066 "Contract Card."
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Actions,Budgeting,Category6_caption,Category7_caption,RequestToApprove,Category9_caption,Category10_caption';
    SourceTable = "Contract Header2";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; rec."No.")
                {
                }
                field("Document Date"; rec."Document Date")
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Account Type"; rec."Account Type")
                {
                }
                field("Account No."; rec."Account No.")
                {
                }
                field(Name; rec.Name)
                {
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                }
                field("E-Mail"; rec."E-Mail")
                {
                }
                field("Phone No."; rec."Phone No.")
                {
                }
                field("Contract Type"; rec."Contract Type")
                {
                }
                field("Responsible Person"; rec."Responsible Person")
                {
                }
                field("Commencement Date"; rec."Commencement Date")
                {
                }
                field("Expiry Date"; rec."Expiry Date")
                {
                }
                field(Duration; rec.Duration)
                {
                }
                field("Expiry Notification Period"; rec."Expiry Notification Period")
                {
                }
                field("Total Amount"; rec."Total Amount")
                {
                }
                field(Comment; rec.Comment)
                {
                }
                field("Created By"; rec."Created By")
                {
                }
                field("Created DateTime"; rec."Created DateTime")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Contract Status"; Rec."Contract Status")
                {
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
