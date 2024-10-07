page 70065 Contracts
{
    CardPageID = "Contract Card.";
    PageType = List;
    SourceTable = "Contract Header2";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                }
                field("Contract Status"; Rec."Contract Status")
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

