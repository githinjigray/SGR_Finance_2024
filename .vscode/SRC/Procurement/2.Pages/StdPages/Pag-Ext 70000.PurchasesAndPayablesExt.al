
pageextension 70000 "Purchases And Payables Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addbefore("Vendor Nos.")
        {
            field("Purchase Requisition Nos."; Rec."Purchase Requisition Nos.")
            {
                ApplicationArea = all;
            }
            field("Procurement Plan Nos"; Rec."Procurement Plan Nos")
            {
                ApplicationArea = all;
            }
            field("Request for Quotation Nos."; Rec."Request for Quotation Nos.")
            {
                ApplicationArea = all;
            }
            field("Bid Analysis No."; Rec."Bid Analysis No.")
            {
                ApplicationArea = all;
            }
            field("Tender Doc No."; Rec."Tender Doc No.")
            {
                ApplicationArea = all;
            }
            field("Tender Evaluation No."; Rec."Tender Evaluation No.")
            {
                ApplicationArea = all;
            }
            field("Contract Request Nos"; Rec."Contract Request Nos")
            {
                ApplicationArea = all;
            }
            field("Contract Nos"; Rec."Contract Nos")
            {
                ApplicationArea = all;
            }
        }
        addafter("Default Accounts")
        {
            group(Terms)
            {
                Caption = 'Terms & Conditions';

                // field("PO Terms & Conditions"; POTermsContents)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Terms & Conditions field.', Comment = '%';
                //     MultiLine = true;
                //     //ExtendedDatatype = RichContent;
                //     ShowCaption = false;
                //     Editable = false;

                //     trigger OnDrillDown()
                //     var
                //         TempBlob: Codeunit "Temp Blob";
                //         InStream: InStream;
                //         OutStream: OutStream;
                //         POTermsInputPage: Page "Terms & Conditions Input";
                //         InputText: Text;
                //         ExistingText: Text;
                //         TempText: Text;
                //         TermsUploadLbl: Label 'PO Terms have been updated.';
                //     begin

                //         Rec.CalcFields("PO Terms & Conditions");

                //         if Rec."PO Terms & Conditions".HasValue then begin
                //             Rec."PO Terms & Conditions".CreateInStream(InStream);

                //             ExistingText := '';
                //             while not InStream.EOS() do begin
                //                 InStream.ReadText(TempText);
                //                 ExistingText += TempText;
                //             end;


                //             POTermsInputPage.SetInputText(ExistingText);
                //         end;

                //         if POTermsInputPage.RunModal = Action::OK then begin
                //             InputText := POTermsInputPage.GetInputText();
                //             TempBlob.CreateOutStream(OutStream);
                //             OutStream.WriteText(InputText);
                //             TempBlob.CreateInStream(InStream);
                //             Rec."PO Terms & Conditions".CreateOutStream(OutStream);
                //             CopyStream(OutStream, InStream);
                //             Rec.Modify();
                //         end;
                //     end;
                // }
                field("PO Terms Conditions"; POTermsConditions)
                {
                    Caption = 'PO Terms & Conditions';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Terms & Conditions of a Purchase Order.';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    ShowCaption = false;
                    trigger OnValidate()
                    begin
                        SetBody(POTermsConditions);
                        // Rec.Modify();
                    end;
                }
            }
        }

    }
    actions
    {
        addafter("Incoming Documents Setup")
        {
            action("Procurement Documents Set-up")
            {
                ApplicationArea = All;
                Caption = 'Procurement Documents Set-up', comment = 'ENU="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Setup;
                RunObject = page "Procurement Upload Documents";
                trigger OnAction()
                begin

                end;
            }

        }
    }

    var
        POTermsContents: Text;
        POTermsConditions: text;
        RgbReplacementTok: Label 'rgb($1, $2, $3)', Locked = true;
        RbgaPatternTok: Label 'rgba\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3}),\s*1(\.0{0,2})?\)', Locked = true;
    //POTermsInputPage: page "Terms & Conditions Input";




    trigger OnAfterGetCurrRecord()
    begin
        //rec.CalcFields("PO Terms & Conditions");
        //POTermsContents := format(Rec."PO Terms & Conditions");
    end;

    procedure SetBody(BodyText: Text)
    begin
        SetBodyValue(BodyText);
        Message(BodyText);
        Rec.Modify();
    end;

    local procedure SetBodyValue(BodyText: Text)
    var
        BodyOutStream: OutStream;
    begin
        // Clear(Rec."PO Terms & Conditions");

        if BodyText = '' then
            exit;

        //ReplaceRgbaColorsWithRgb(BodyText);
        Rec."PO Terms & Conditions".CreateOutStream(BodyOutStream, TextEncoding::UTF8);
        BodyOutStream.Write(BodyText);
    end;

    // [Scope('OnPrem')]
    // procedure ReplaceRgbaColorsWithRgb(var Body: Text)
    // var
    //     RgbaRegexPattern: DotNet Regex;
    // begin
    //     Body := RgbaRegexPattern.Replace(Body, RbgaPatternTok, RgbReplacementTok);
    // end;
    trigger OnClosePage()
    begin
        SetBody(POTermsConditions);
    end;
}
