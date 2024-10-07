xmlport 50500 "Petty cash Upload"
{
    Caption = 'Petty cash Upload';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(PaymentLine; "Payment Line")
            {
                AutoUpdate = true;
                fieldelement(No; PaymentLine."Document No.")
                {
                }
                fieldelement(AccountNo; PaymentLine."Account No.")
                {
                }
                fieldelement(Description; PaymentLine.Description)
                {
                }

                fieldelement(Department; PaymentLine."Global Dimension 1 Code")
                {
                }
                fieldelement(BusinessUnit; PaymentLine."Global Dimension 2 Code")
                {
                }
                fieldelement(Aircraft; PaymentLine."Shortcut Dimension 3 Code")
                {
                }
                fieldelement(Project; PaymentLine."Shortcut Dimension 4 Code")
                {
                }
                fieldelement(ReferenceNo; PaymentLine."Reference No.")
                {
                }
                fieldelement(Amount; PaymentLine."Total Amount")
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
