xmlport 70009 "Import Purchase Lines"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Purchase Line"; "Purchase Line")
            {
                AutoUpdate = true;
                XmlName = 'JV';
                fieldelement(a; "Purchase Line"."Document No.")
                {
                }
                fieldelement(b; "Purchase Line"."Document Type")
                {
                }
                fieldelement(c; "Purchase Line".Type)
                {
                }
                fieldelement(d; "Purchase Line"."No.")
                {
                }
                fieldelement(e; "Purchase Line".Description)
                {
                }
                fieldelement(f; "Purchase Line".Amount)
                {
                }
                fieldelement(g; "Purchase Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(h; "Purchase Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(i; "Purchase Line"."Shortcut Dimension 3 Code")
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

