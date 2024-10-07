xmlport 70002 "FA Upload"
{
    Caption = 'FA Upload';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(FixedAsset; "Item Unit of Measure")
            {
                AutoUpdate = true;
                fieldelement(No; FixedAsset."Item No.")
                {
                }
                fieldelement(dimensioncode; FixedAsset.Code)
                {
                }
                fieldelement(DimensionDescription; FixedAsset."Qty. per Unit of Measure")
                {
                }
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
