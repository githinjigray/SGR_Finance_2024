xmlport 70003 "Bank Codes"
{
    Caption = 'Bank Codes';
    Format=VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(FixedAsset; "Bank Code")
            {
                AutoUpdate = true;
                fieldelement(No; FixedAsset."Bank Code")
                {
                }
                fieldelement(Description; FixedAsset."Bank Name")
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
