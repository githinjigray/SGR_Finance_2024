report 50087 "LPO/LSO Posted"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/LPOLSO Posted.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(PaytoVendorNo_PurchaseHeader; "Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Pay-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Ship-to Address 2")
            {
            }
            // column(UserID_PurchaseHeader;"User ID")
            // {
            // }
            column(ShortcutDimension2Code_PurchaseHeader; Departments)
            {
            }
            // column(ShortcutDimension3Code_PurchaseHeader;"Shortcut Dimension 3 Code")
            // {
            // }
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
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Web; CompanyInfo.Website)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Expected Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Posting Date")
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Currency Code")
            {
            }
            column(Amount_PurchaseHeader; Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Amount Including VAT")
            {
            }
            column(TotalDiscountAmount; 0)
            {
            }
            column(PropertyNo; PropertyNo)
            {
            }
            column(propertyname; propertyname)
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(NoPrinted; "No. Printed")
            {
            }
            column(LNo; LNo)
            {
            }
            column(PaymentTermsCodesNEW; "Payment Terms Code")
            {
            }
            column(DueDate_PurchaseHeader; "Due Date")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(PhoneNumber; PhoneNumber)
            {
            }
            column(EmailAddress; EmailAddress)
            {
            }
            dataitem("Purchase Line Archive"; "Purchase Line Archive")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Version No." = FIELD("Version No.");
                column(LineNo_PurchaseLine; "Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Line Amount")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Direct Unit Cost")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(No_PurchaseLine; "No.")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(Remarks_PurchaseLine; Description)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Unit of Measure Code")
                {
                }
                column(LineDiscount_PurchaseLine; "Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Line Discount Amount")
                {
                }
                column(VAT; "VAT %")
                {
                }
                column(LocationCode; "Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;

                    /*PurchaseLine.RESET;
                    PurchaseLine.SETRANGE(PurchaseLine."Document No.","Purchase Header Archive"."No.");
                    IF PurchaseLine.FINDFIRST THEN BEGIN
                      PropertyNo:=PurchaseLine."Property Code";
                    IF Properties.GET(PropertyNo) THEN
                     propertyname:=Properties.Description;
                    END;*/

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyAddress := CompanyInfo.Address + ' ' + CompanyInfo."Address 2";

                // CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, "Amount Including VAT", '');


                GeneralLedgerSetup.Get;
                if "Currency Code" = '' then "Currency Code" := GeneralLedgerSetup."LCY Code";

                PreparedBy := '';

                Employees.Reset;
                // Employees.SetRange(Employees."User ID","Purchase Header Archive"."User ID");
                if Employees.FindFirst then begin
                    PreparedBy := Employees."First Name" + ' ' + Employees."Last Name";
                end;


                PhoneNumber := '';
                EmailAddress := '';

                Vendors.Reset;
                Vendors.SetRange(Vendors."No.", "Purchase Header Archive"."Pay-to Vendor No.");
                if Vendors.FindFirst then begin
                    // PhoneNumber:=Vendors."Vendor Phone No.";
                    // EmailAddress:=Vendors."Vendor Email";
                end;


                //if Properties.GET("Purchase Header Archive"."Shortcut Dimension 3 Code") then
                //propertyname:=Properties.Description;
                //END;


                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Purchase Header Archive"."Shortcut Dimension 2 Code");
                if DimensionValue.FindFirst then begin
                    Departments := DimensionValue.Name;
                end;
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
        PurchaseOrderCaption = 'Purchase Order';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Employees: Record Employee;
        Vendors: Record Vendor;
        CompanyAddress: Text;
        NumberText: array[2] of Text[120];
        CheckReport: Report Check;
        LNo: Integer;
        PreparedBy: Text;
        ApproverName: Text;
        EmailAddress: Text;
        PhoneNumber: Text;
        PropertyNo: Code[20];
        PurchaseLine: Record "Purchase Line";
        //  Properties: Record Table51535420;
        propertyname: Text;
        Departments: Text;
        DimensionValue: Record "Dimension Value";
}

