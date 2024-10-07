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
    value(4; "Salary Advance")
    {
        Caption = 'Salary Advance';
    }
    value(5; "Funds Claim")
    {
        Caption = 'Funds Claim';
    }
    value(6; "Activity Request")
    {
        Caption = 'Activity Request';
    }
    value(7; GL)
    {
        Caption = 'GL';
    }
    value(8; "Pre-Payment")
    {
        Caption = 'Pre-Payment';
    }
}
