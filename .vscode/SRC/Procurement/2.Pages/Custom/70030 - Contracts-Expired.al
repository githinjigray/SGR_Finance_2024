page 70030 "Expired Contracts"
{
    CardPageID = "Contract Card.";
    PageType = List;
    SourceTable = "Contract Header2";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where("Contract Status" = filter(Expired | Terminated));
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Contract Status"; Rec."Contract Status")
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
            }
        }
    }

    actions
    {
        area(Processing)
        {
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

