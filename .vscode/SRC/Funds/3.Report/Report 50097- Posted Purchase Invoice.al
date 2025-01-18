report 50097 "Posted Purchase Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Posted Purchase Invoice.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
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
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(No_UserID; "Purch. Inv. Header"."User ID")
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(OrderDate_PurchInvHeader; "Purch. Inv. Header"."Order Date")
            {
            }
            column(PostingDate_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(PostingDescription_PurchInvHeader; "Purch. Inv. Header"."Posting Description")
            {
            }
            column(Amount_PurchInvHeader; "Purch. Inv. Header".Amount)
            {
            }
            column(AmountIncludingVAT_PurchInvHeader; "Purch. Inv. Header"."Amount Including VAT")
            {
            }
            column(ShortcutDimension1Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 6 Code")
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Type_PurchInvLine; "Purch. Inv. Line".Type)
                {
                }
                column(No_PurchInvLine; "Purch. Inv. Line"."No.")
                {
                }
                column(LocationCode_PurchInvLine; "Purch. Inv. Line"."Location Code")
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(Description2_PurchInvLine; "Purch. Inv. Line"."Description 2")
                {
                }
                column(UnitofMeasure_PurchInvLine; "Purch. Inv. Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(DirectUnitCost_PurchInvLine; "Purch. Inv. Line"."Direct Unit Cost")
                {
                }
                column(VAT_PurchInvLine; "Purch. Inv. Line"."VAT %")
                {
                }
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                column(AmountIncludingVAT_PurchInvLine; "Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(ShortcutDimension1Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 2 Code")
                {
                }
                column(ShortcutDimension3Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 4 Code")
                {
                }
                column(ShortcutDimension5Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 5 Code")
                {
                }
                column(ShortcutDimension6Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 6 Code")
                {
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
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        ApproverName: Text;
        IssuingOfficer: Text;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
}

