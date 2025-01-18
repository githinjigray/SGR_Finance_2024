report 50100 "Packing List"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Packing List.rdlc';
    Caption = 'Packing List';
    ApplicationArea = All;
    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            RequestFilterFields = "No.";
            column(No_TransferHeader; "Transfer Header"."No.")
            {
            }
            column(TransferfromCode_TransferHeader; "Transfer Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TransferHeader; "Transfer Header"."Transfer-from Name")
            {
            }
            column(TransfertoCode_TransferHeader; "Transfer Header"."Transfer-to Code")
            {
            }
            column(PostingDate_TransferHeader; "Transfer Header"."Posting Date")
            {
            }
            column(Status_TransferHeader; "Transfer Header".Status)
            {
            }
            column(UserID_TransferHeader; "Transfer Header"."User ID")
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
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(> 0));
                column(QuantityShipped_TransferLine; "Transfer Line"."Quantity Shipped")
                {
                }
                column(QuantityReceived_TransferLine; "Transfer Line"."Quantity Received")
                {
                }
                column(DocumentNo_TransferLine; "Transfer Line"."Document No.")
                {
                }
                column(ItemNo_TransferLine; "Transfer Line"."Item No.")
                {
                }
                column(Quantity_TransferLine; "Transfer Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferLine; "Transfer Line"."Unit of Measure")
                {
                }
                column(ShortcutDimension1Code_TransferLine; "Transfer Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_TransferLine; "Transfer Line"."Shortcut Dimension 2 Code")
                {
                }
                column(Description_TransferLine; "Transfer Line".Description)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                // HREmployee.Reset;
                // HREmployee.SetRange(HREmployee."User ID", "Transfer Header"."User ID");
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
}

