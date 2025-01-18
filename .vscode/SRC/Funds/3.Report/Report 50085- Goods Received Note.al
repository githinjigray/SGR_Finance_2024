report 50085 "Goods Received Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Goods Received Note.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(No; "No.")
                {
                }
                column(Desc; Description)
                {
                }
                column(Supplier; "Buy-from Vendor No.")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(UOM; "Unit of Measure Code")
                {
                }
                column(Unit_Price; "Unit Cost (LCY)")
                {
                }
                column(Total; "VAT Base Amount")
                {
                }
                column(VAT_Amount; AmtVat)
                {
                }
                column(TodayFormatted; Format(Today, 0, 4))
                {
                }
                column(VAT; VAT)
                {
                }
                column(TAmt; TAmt)
                {
                }
                column(OrdNo; OrdNo)
                {
                }
                column(DocNo; "Purch. Rcpt. Line"."Document No.")
                {
                }
                column(userid; UserId)
                {
                }
                column(Date; "Posting Date")
                {
                }
                column(Ven_no; "Pay-to Vendor No.")
                {
                }
                column(PVName; PayVeName)
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
                column(CompanyEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyWebPage; CompanyInfo.Website)
                {
                }
                column(Pic; CompanyInfo.Picture)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Purchheader.Reset;
                    Purchheader.SetRange(Purchheader."No.", "Purch. Rcpt. Line"."Document No.");
                    if Purchheader.Find('-') then begin
                        PayVeName := Purchheader."Pay-to Name";
                        OrdNo := Purchheader."Order No.";
                        DocNo := Purchheader."No.";
                    end;

                    if "Purch. Rcpt. Line".Quantity = 0 then CurrReport.Skip;
                    Clear(AmtVat);
                    Clear(VAT);
                    Clear(TAmt);
                    PurchLine.Reset;
                    PurchLine.SetRange(PurchLine."Document No.", "Purch. Rcpt. Line"."Document No.");
                    PurchLine.SetRange(PurchLine."Line No.", "Purch. Rcpt. Line"."Line No.");
                    if PurchLine.Find('-') then begin
                        TAmt := PurchLine.Quantity * "Purch. Rcpt. Line"."Unit Cost (LCY)";
                        AmtVat := ((PurchLine."VAT %" / 100) * TAmt) + TAmt;

                        VAT := AmtVat - TAmt;
                    end;
                end;
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
        if CompanyInfo.Get then
            CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        PurchLine: Record "Purch. Rcpt. Line";
        AmtVat: Decimal;
        VAT: Decimal;
        TAmt: Decimal;
        OrdNo: Code[20];
        DocNo: Code[20];
        Purchheader: Record "Purch. Rcpt. Header";
        PayVeName: Text;
}

