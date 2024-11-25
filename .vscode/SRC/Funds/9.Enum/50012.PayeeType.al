enum 50012 "Payee Type"
{
    Extensible = true;

    value(0; Vendor)
    {
        Caption = 'Vendor';
    }
    value(1; Employee)
    {
        Caption = 'Employee';
    }
    value(2; Imprest)
    {
        Caption = 'Imprest';
    }
    value(3; Customer)
    {
        Caption = 'Customer';
    } 
    value(4; GL)
    {
        Caption = 'GL';
    }
    value(5; "Pre-Payment")
    {
        Caption = 'Pre-Payment';
    }
}
