report 50076 "Send Procurement Emails"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    dataset
    {
        dataitem("Procurement Email Messages"; "Procurement Email Messages")
        {

            trigger OnAfterGetRecord()
            begin
                if not "Procurement Email Messages"."Email Sent" then begin
                    Clear(EmailBodyInStream);
                    Clear(EmailBodyRequest);
                    EmailBody := '';
                    FileName := '';
                    DocumentName := '';

                    "Procurement Email Messages".CalcFields("Procurement Email Messages".Body);
                    "Procurement Email Messages".Body.CreateInStream(EmailBodyInStream);
                    EmailBodyRequest.Read(EmailBodyInStream);
                    EmailBodyRequest.GetSubText(EmailBody, 1);

                    CompanyInfo.Get;
                    // CompanyInfo.TestField("Path to Save Documents");

                    //RFQ
                    RequestforQuotationHeader.Reset;
                    RequestforQuotationHeader.SetRange("No.", "Procurement Email Messages"."Document No.");
                    if RequestforQuotationHeader.FindFirst then begin
                        FileName := CompanyInfo."Path to Save Documents" + Format(RequestforQuotationHeader."No.") + '.pdf';
                        // REPORT.SaveAsPdf(REPORT::"Request for Quotation", FileName, RequestforQuotationHeader);
                        DocumentName := RequestforQuotationHeader."No." + '.pdf';
                    end;

                    //Purchase Requisition
                    PurchaseRequisition.Reset;
                    PurchaseRequisition.SetRange("No.", "Procurement Email Messages"."Document No.");
                    if PurchaseRequisition.FindFirst then begin
                        FileName := CompanyInfo."Path to Save Documents" + Format(PurchaseRequisition."No.") + ' PurchaseRequisition.pdf';
                        //REPORT.SaveAsPdf(REPORT::"purchase requisition", FileName, PurchaseRequisition);
                        DocumentName := PurchaseRequisition."No." + '.pdf';
                    end;

                    SMTPMail.Create("Procurement Email Messages".Recipients, "Procurement Email Messages".Subject, EmailBody, true);
                    if FileName <> '' then begin
                        //  FileMgt.BLOBImportFromServerFile(TempBlob,FileName);
                        //TempBlob.CreateInStream(ReportIns);
                        SMTPMail.AddAttachment(DocumentName, 'application/pdf', ReportIns);
                    end;
                    if Email.Send(SMTPMail) then begin
                        "Procurement Email Messages"."Email Sent" := true;
                        "Procurement Email Messages"."Date Sent" := Today;
                        "Procurement Email Messages"."Time Sent" := Time;
                        "Procurement Email Messages".Modify;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Procurement Email Messages".SetRange("Procurement Email Messages"."Email Sent", false);
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

    var
        //SMTPMailSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "Email Message";
        CompanyInfo: Record "General Ledger Setup";
        FileMgt: Codeunit "File Management";
        Email: Codeunit Email;
        RequestforQuotationHeader: Record "Request for Quotation Header";
        EmailBodyInStream: InStream;
        EmailBodyRequest: BigText;
        EmailBody: Text;
        FileName: Text;
        RFQAttachment: Text;
        ImprestHeader: Record "Imprest Header";
        PurchaseRequisition: Record "Purchase Requisitions";
        ReportIns: InStream;
        TempBlob: Codeunit "Temp Blob";
        DocumentName: code[20];
}

