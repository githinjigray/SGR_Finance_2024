xmlport 70004 "Bank Branches"
{
    Caption = 'Bank Branches';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(FixedAsset; "Bank Branch")
            {
                AutoUpdate = true;
                fieldelement(No; FixedAsset."Bank Code")
                {
                }
                fieldelement(Description; FixedAsset."Bank Name")
                {
                }
                fieldelement(FAClassCode; FixedAsset."Bank Branch Code")
                {
                }
                fieldelement(FASubclassCode; FixedAsset."Bank Branch Name")
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
