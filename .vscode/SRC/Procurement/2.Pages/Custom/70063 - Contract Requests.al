page 70063 "Contract Requests"
{
    CardPageID = "Contract Request Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Contract Request Header";
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
                field("E-Mail"; rec."E-Mail")
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

