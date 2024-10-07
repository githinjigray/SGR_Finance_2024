xmlport 70007 "Item 2 Upload"
{
    Caption = 'Item 2 Upload';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(FixedAsset; Employee)
            {
                AutoUpdate = true;
                fieldelement(No; FixedAsset."No.")
                {
                }
                // fieldelement(dimensioncode; FixedAsset."HR Job Title")
                // {
                // }
                // fieldelement(DimensionDescription; FixedAsset."Sales Unit of Measure")
                // {
                // }
                // fieldelement(globaldimension; FixedAsset."Global Dimension 1 Code")
                // {
                // }
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