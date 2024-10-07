xmlport 70000 "item List Upload"
{
    Caption = 'item List Upload';
    Format = VariableText;

    schema
    {
        textelement(RootNodeName)

        {
            tableelement(Item; Item)
            {
                AutoUpdate = true;
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(Description; Item.Description)
                {
                }
                fieldelement(BaseUnitofMeasure; Item."Base Unit of Measure")
                {
                }
                fieldelement(InventoryPostingGroup; Item."Inventory Posting Group")
                {
                }
                fieldelement(ItemCategoryCode; Item."Item Category Code")
                {
                }
                fieldelement(GenProdPostingGroup; Item."Gen. Prod. Posting Group")
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
