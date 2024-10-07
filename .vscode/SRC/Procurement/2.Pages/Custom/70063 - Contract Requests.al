page 70063 "Contract Requests"
{
    CardPageID = "Contract Request Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Contract Request Header";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("E-Mail"; rec."E-Mail")
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
            action("Update Contract List")
            {
                Caption = 'Update Contract List';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ContractList: Record "Contract Header2";
                    UpdatedContractList: Record "Contract Header2";
                begin
                    rec.TestField(Description);
                    rec.TestField("Account Type");
                    rec.TestField("Account No.");
                    rec.TestField("Contract Type");
                    rec.TestField("Commencement Date");

                    if Confirm('Are you sure you want to update the contract request details into the contract list?') then begin
                        ContractList.Init();
                        ContractList.TransferFields(Rec);
                        if not ContractList.Insert() then ContractList.Modify();
                        UpdatedContractList.Reset();
                        UpdatedContractList.SetRange("No.", rec."No.");
                        if UpdatedContractList.FindFirst() then begin
                            UpdatedContractList.Status := UpdatedContractList.Status::Approved;
                            UpdatedContractList."Contract Status" := UpdatedContractList."Contract Status"::Active;
                            UpdatedContractList.Modify();
                        end;
                        Message('Added.Updated Successfully!');
                    end;
                end;
            }
            action("Contract Requests Report")
            {
                Caption = 'Contract Requests Report';
                Image = ContactReference;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = report "Contract Requests";
            }
        }
    }
}

