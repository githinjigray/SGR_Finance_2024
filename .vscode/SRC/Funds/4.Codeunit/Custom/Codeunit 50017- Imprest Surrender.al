codeunit 50017 "Imprest Surrender"
{
    procedure SendImprestSurrenderEmail(var DocumentNo: Code[20])
    begin
        ImprestHeader.get(DocumentNo);
        ImprestHeader.CalcFields(Amount);
        Employee.get(ImprestHeader."Employee No.");
        GeneralLedgerSetup.get;
        if ImprestHeader."Currency Code" = '' then
            CurrencyCode := GeneralLedgerSetup."LCY Code"
        else
            CurrencyCode := ImprestHeader."Currency Code";
        Subject := 'Imprest Surrender of Imprest No: ' + ImprestHeader."No.";

        EmailBody := '';
        EmailBody := EmailBody + 'Dear ' + Employee."First Name" + ' ' + Employee."Last Name" + '<br><br>';
        EmailBody := EmailBody + 'You are reminded to surrender your imprest No. ' + ImprestHeader."No." + ' of amount ' + CurrencyCode + ' ' + format(ImprestHeader.Amount) + ' today.' + '<br>';
        EmailBody := EmailBody + 'Kind Regards,' + '<br>';
        EmailBody := EmailBody + CompanyInformation.Name + '<br><br>';
        EmailBody := EmailBody + 'This is a system generated email, do not reply to this email.' + '<br>';

        InsertFundsEmailMessage(CompanyInformation.Name, '', Subject, Employee."Company E-Mail", '', '', EmailBody);
    end;

    local procedure InsertFundsEmailMessage("Sender Name": Text[100]; "Sender Address": Text[80]; Subject: Text[100]; Recipients: Text[250]; "Recipients CC": Text[250]; "Recipients BCC": Text[250]; Body: Text) EmailMessageInserted: Boolean
    begin
        FundsEmailMessages.INIT;
        FundsEmailMessages."Entry No." := 0;
        FundsEmailMessages."Sender Name" := "Sender Name";
        FundsEmailMessages."Sender Address" := '';
        FundsEmailMessages.Subject := Subject;
        FundsEmailMessages.Recipients := Recipients;
        FundsEmailMessages."Recipients CC" := "Recipients CC";
        FundsEmailMessages."Recipients BCC" := "Recipients BCC";
        EmailBodyText.ADDTEXT(Body);
        FundsEmailMessages.Body.CREATEOUTSTREAM(EmailBodyOutStream);
        EmailBodyText.WRITE(EmailBodyOutStream);
        FundsEmailMessages.HtmlFormatted := TRUE;
        FundsEmailMessages."Created By" := USERID;
        FundsEmailMessages."Date Created" := TODAY;
        FundsEmailMessages."Time Created" := TIME;
        IF FundsEmailMessages.INSERT THEN
            EmailMessageInserted := TRUE;
    end;

    procedure ReopenImprestSurrender(VAR "Imprest Surrender Header": Record "Imprest Surrender Header")
    begin

        ImprestSurrenderHeader.RESET;
        ImprestSurrenderHeader.SETRANGE(ImprestSurrenderHeader."No.", "Imprest Surrender Header"."No.");
        IF ImprestSurrenderHeader.FINDFIRST THEN BEGIN
            ImprestSurrenderHeader.Status := ImprestSurrenderHeader.Status::Open;
            ImprestSurrenderHeader.VALIDATE(ImprestSurrenderHeader.Status);
            ImprestSurrenderHeader.MODIFY;
        END;

    end;

    var
        EmailMesasage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recepients: Text[250];
        Subject: Text;
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        Employee: Record Employee;
        EmailBody: Text;
        CompanyInformation: Record "Company Information";
        FundsEmailMessages: Record "Funds Email Messages";
        EmailBodyText: BigText;
        EmailBodyOutStream: OutStream;
        GeneralLedgerSetup: Record "General Ledger Setup";
        CurrencyCode: Code[10];

}
