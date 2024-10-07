report 50055 "Send Funds Email Messages"
{
    ApplicationArea = All;
    ProcessingOnly=true;
    Caption = 'Send Funds Email Messages';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(FundsEmailMessages; "Funds Email Messages")
        {
            trigger OnPreDataItem()
            begin
                FundsEmailMessages.SETRANGE(FundsEmailMessages."Email Sent",FALSE); 
            end;
            trigger OnAfterGetRecord()
            begin
                IF NOT FundsEmailMessages."Email Sent" THEN BEGIN
                    CLEAR(EmailBodyInStream);
                    CLEAR(EmailBodyRequest);
                    EmailBody:='';
                    DocumentNumber:='';
                    FileName:='';

                    FundsEmailMessages.CALCFIELDS(FundsEmailMessages.Body);
                    FundsEmailMessages.Body.CREATEINSTREAM(EmailBodyInStream);
                    EmailBodyRequest.READ(EmailBodyInStream);
                    EmailBodyRequest.GETSUBTEXT(EmailBody,1);
                    DocumentNumber:=FundsEmailMessages."Document No";

                    EmailMessage.Create(FundsEmailMessages.Recipients,FundsEmailMessages.Subject,EmailBody,true);
                    IF Email.Send(EmailMessage) THEN BEGIN
                        FundsEmailMessages."Email Sent":=TRUE;
                        FundsEmailMessages."Date Sent":=TODAY;
                        FundsEmailMessages."Time Sent":=TIME;
                        FundsEmailMessages.MODIFY;
                    END;
                    END;
            end;
        }
    }
    var
        EmailBodyInStream:InStream;
        EmailBodyRequest:BigText;
        EmailBody:Text;
        FileName:Text;
        DocumentNumber:Code[20];
        EmailMessage:Codeunit "Email Message";
        Email:Codeunit Email;
}
