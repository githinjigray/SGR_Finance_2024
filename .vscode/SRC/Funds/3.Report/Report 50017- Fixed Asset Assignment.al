report 50017 "Fixed Asset Assignment"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Fixed Asset Assignment.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo.Website)
            {
            }
            column(No_FixedAsset; "Fixed Asset"."No.")
            {
            }
            column(Description_FixedAsset; "Fixed Asset".Description)
            {
            }
            column(SearchDescription_FixedAsset; "Fixed Asset"."Search Description")
            {
            }
            column(Description2_FixedAsset; "Fixed Asset"."Description 2")
            {
            }
            column(FAClassCode_FixedAsset; "Fixed Asset"."FA Class Code")
            {
            }
            column(FASubclassCode_FixedAsset; "Fixed Asset"."FA Subclass Code")
            {
            }
            column(GlobalDimension1Code_FixedAsset; "Fixed Asset"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_FixedAsset; "Fixed Asset"."Global Dimension 2 Code")
            {
            }
            column(LocationCode_FixedAsset; "Fixed Asset"."Location Code")
            {
            }
            column(FALocationCode_FixedAsset; "Fixed Asset"."FA Location Code")
            {
            }
            column(VendorNo_FixedAsset; "Fixed Asset"."Vendor No.")
            {
            }
            column(MainAssetComponent_FixedAsset; "Fixed Asset"."Main Asset/Component")
            {
            }
            column(ComponentofMainAsset_FixedAsset; "Fixed Asset"."Component of Main Asset")
            {
            }
            column(BudgetedAsset_FixedAsset; "Fixed Asset"."Budgeted Asset")
            {
            }
            column(WarrantyDate_FixedAsset; "Fixed Asset"."Warranty Date")
            {
            }
            column(ResponsibleEmployee_FixedAsset; "Fixed Asset"."Responsible Employee")
            {
            }
            column(SerialNo_FixedAsset; "Fixed Asset"."Serial No.")
            {
            }
            column(LastDateModified_FixedAsset; "Fixed Asset"."Last Date Modified")
            {
            }
            column(Insured_FixedAsset; "Fixed Asset".Insured)
            {
            }
            column(Comment_FixedAsset; "Fixed Asset".Comment)
            {
            }
            column(Blocked_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(Picture_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(MaintenanceVendorNo_FixedAsset; "Fixed Asset"."Maintenance Vendor No.")
            {
            }
            column(UnderMaintenance_FixedAsset; "Fixed Asset"."Under Maintenance")
            {
            }
            column(NextServiceDate_FixedAsset; "Fixed Asset"."Next Service Date")
            {
            }
            column(Inactive_FixedAsset; "Fixed Asset".Inactive)
            {
            }
            column(FAPostingDateFilter_FixedAsset; "Fixed Asset"."FA Posting Date Filter")
            {
            }
            column(NoSeries_FixedAsset; "Fixed Asset"."No. Series")
            {
            }
            column(FAPostingGroup_FixedAsset; "Fixed Asset"."FA Posting Group")
            {
            }
            column(Acquired_FixedAsset; "Fixed Asset".Acquired)
            {
            }
            column(Image_FixedAsset; "Fixed Asset".Image)
            {
            }
            column(FATagNo_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(EmployeeName_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(ShortcutDimension3Code_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(ShortcutDimension4Code_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(ShortcutDimension5Code_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(ShortcutDimension6Code_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(ShortcutDimension7Code_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(ShortcutDimension8Code_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(FAStatus_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(FAStatusComment_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(UserID_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(Model_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            column(ModelNo_FixedAsset; "Fixed Asset".Blocked)
            {
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                dataitem(Employee; Employee)
                {
                    // DataItemLink = "Employee User ID" = FIELD("Approver ID");
                    // column(EmployeeFirstName; Employee."First Name")
                    // {
                    // }
                    // column(EmployeeMiddleName; Employee."Middle Name")
                    // {
                    // }
                    // column(EmployeeLastName; Employee."Last Name")
                    // {
                    // }
                    // column(EmployeeSignature; Employee."Signature")
                    // {
                    // }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
}

