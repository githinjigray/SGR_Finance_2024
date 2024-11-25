enum 50014 "Payment Modes"
{
    Extensible = true;

    value(0; "")
    {
        Caption = '';
    }
    value(1; Cheque)
    {
        Caption = 'Cheque';
    }
    value(2; EFT)
    {
        Caption = 'EFT';
    }
    value(3; RTGS)
    {
        Caption = 'RTGS';
    }    
    value(4; Cash)
    {
        Caption = 'Cash';
    }
    value(5; "Bank Transfer")
    {
        Caption = 'Bank Transfer';
    }      
    value(6; SWIFT)
    {
        Caption = 'SWIFT';
    }
}
