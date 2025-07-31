page 70068 "Terms & Conditions Input"

{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'PO Terms & Conditions';
    layout
    {
        area(content)
        {
            field("PO Terms & Conditions"; InputText)
            {
                ApplicationArea = All;
                ToolTip = 'Enter the PO Terms and Conditions.';
                MultiLine = true;
                ExtendedDatatype = RichContent;
                ShowCaption = false;
            }
        }
    }


    var
        InputText: Text;

    procedure GetInputText(): Text;
    begin
        exit(InputText);
    end;

    procedure SetInputText(Value: Text);
    begin
        InputText := Value;
    end;

    trigger OnAfterGetRecord()
    begin
        ShowPOTermsContents();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ShowPOTermsContents();
    end;

    local procedure ShowPOTermsContents()
    var
        Istream: InStream;
        TypeHelper: Codeunit "Type Helper";
        LineSeparator: Text;
        PurchPayableSetup: Record "Purchases & Payables Setup";
    begin
        PurchPayableSetup.get;
        PurchPayableSetup.calcfields("PO Terms & Conditions");
        PurchPayableSetup."PO Terms & Conditions".CreateInstream(Istream);
        InputText := TypeHelper.ReadAsTextWithSeparator(Istream, '<br>');
    end;

}
