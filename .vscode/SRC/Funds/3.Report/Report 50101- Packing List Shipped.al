report 50101 "Packing List Shipped"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Packing List Shipped.rdlc';
    Caption = 'Packing List Shipped';
    ApplicationArea = All;
    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            RequestFilterFields = "No.";
            column(No_TransferHeader; "No.")
            {
            }
            column(TransferOrderNo_TransferReceiptHeader; "Transfer Receipt Header"."Transfer Order No.")
            {
            }
            column(TransferfromCode_TransferHeader; "Transfer-from Code")
            {
            }
            column(TransferfromName_TransferHeader; "Transfer-from Name")
            {
            }
            column(TransfertoCode_TransferHeader; "Transfer-to Code")
            {
            }
            column(PostingDate_TransferHeader; "Posting Date")
            {
            }
            column(TransferOrderDate_TransferReceiptHeader; "Transfer Receipt Header"."Transfer Order Date")
            {
            }
            column(Status_TransferHeader; Status)
            {
            }
            column(UserID_TransferHeader; UserIDName)
            {
            }
            column(HrEmployeeName; HrEmployeeName)
            {
            }
            column(CBankName; CompanyInfo."Bank Name")
            {
            }
            column(CBankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebPage; CompanyInfo.Website)
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            column(IssuingOfficer; IssuingOfficer)
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(> 0));
                column(QuantityShipped_TransferLine; "Transfer Receipt Line".Quantity)
                {
                }
                column(QuantityReceived_TransferLine; "Transfer Receipt Line".Quantity)
                {
                }
                column(DocumentNo_TransferLine; "Document No.")
                {
                }
                column(ItemNo_TransferLine; "Item No.")
                {
                }
                column(Quantity_TransferLine; Quantity)
                {
                }
                column(UnitofMeasure_TransferLine; "Unit of Measure")
                {
                }
                column(ShortcutDimension1Code_TransferLine; "Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_TransferLine; "Shortcut Dimension 2 Code")
                {
                }
                column(Description_TransferLine; Description)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                // HREmployee.Reset;
                // HREmployee.SetRange(HREmployee."User ID", UserIDName);
                // if HREmployee.FindFirst then begin
                //     HrEmployeeName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                // end;


                // PurchasesPayablesSetup.Get;

                // HREmployee.Reset;
                // HREmployee.SetRange(HREmployee."User ID", PurchasesPayablesSetup."User to replenish Stock");
                // if HREmployee.FindFirst then begin
                //     IssuingOfficer := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                // end;
            end;
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
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        ApproverName: Text;
        IssuingOfficer: Text;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserIDName: Code[20];
        Status: Code[20];
}

