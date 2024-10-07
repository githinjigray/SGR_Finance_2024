xmlport 70006 "Prequalified Vendors Upload"
{
    Caption = 'Prequalified Vendors Upload';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(PrequalifiedSuppliers; "Prequalified Suppliers")
            {
                AutoUpdate = true;
                fieldelement(SupplierName; PrequalifiedSuppliers."Supplier Name")
                {
                }
                fieldelement(ContactPerson; PrequalifiedSuppliers."Contact Person")
                {
                }
                fieldelement(EMail; PrequalifiedSuppliers."E-Mail")
                {
                }
                fieldelement(PhoneNo; PrequalifiedSuppliers."Phone No.")
                {
                }
                fieldelement(County; PrequalifiedSuppliers.County)
                {
                }
                fieldelement(CountyName; PrequalifiedSuppliers."County Name")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
