xmlport 70005 "Vendors Upload"
{
    Caption = 'Vendors Upload';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Vendor; Vendor)
            {
                AutoUpdate = true;
                fieldelement(No; Vendor."No.")
                {
                }
                fieldelement(Name; Vendor.Name)
                {
                }
                fieldelement(VendorPostingGroup; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(GenBusPostingGroup; Vendor."Gen. Bus. Posting Group")
                {
                }
                fieldelement(Address; Vendor.Address)
                {
                }
                fieldelement(Address2; Vendor."Address 2")
                {
                }
                fieldelement(PhoneNo; Vendor."Phone No.")
                {
                }
                fieldelement(TINNo; Vendor." TIN No.")
                {
                }
                fieldelement(City; Vendor.City)
                {
                }
                fieldelement(BankCode; Vendor."Bank Code")
                {
                }
                fieldelement(BankName; Vendor."Bank Name")
                {
                }
                fieldelement(BankBranchCode; Vendor."Bank Branch Code")
                {
                }
                fieldelement(BankBranchName; Vendor."Bank Branch Name")
                {
                }
                fieldelement(BankAccountName; Vendor."Bank Account Name")
                {
                }
                fieldelement(BankAccountNo; Vendor."Bank Account No.")
                {
                }
                fieldelement(PrincipalPhoneNo; Vendor."Principal Phone No.")
                {
                }
                fieldelement(EMail; Vendor."E-Mail")
                {
                }
                fieldelement(Contact; Vendor.Contact)
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
