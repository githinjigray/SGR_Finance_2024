report 50039 "Tenant Receipts Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Tenant Receipts Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Receipt Line"; "Receipt Line")
        {
            //DataItemTableView = WHERE(Posted=CONST(true),Reversed=CONST(false),"Receipt Code"=FILTER('TENANTS_FINANCE'|'TENANTS_UCHUMI'));
            // RequestFilterFields = "Posting Date","Account No.",Field52137865;
            column(DocumentNo_ReceiptLine; "Receipt Line"."Document No.")
            {
            }
            column(AccountNo_ReceiptLine; "Receipt Line"."Account No.")
            {
            }
            column(AccountName_ReceiptLine; "Receipt Line"."Account Name")
            {
            }
            column(PostingGroup_ReceiptLine; "Receipt Line"."Posting Group")
            {
            }
            column(Description_ReceiptLine; "Receipt Line".Description)
            {
            }
            column(PostingDate_ReceiptLine; "Receipt Line"."Posting Date")
            {
            }
            column(CurrencyCode_ReceiptLine; "Receipt Line"."Currency Code")
            {
            }
            column(CurrencyFactor_ReceiptLine; "Receipt Line"."Currency Factor")
            {
            }
            column(Amount_ReceiptLine; "Receipt Line".Amount)
            {
            }
            column(AmountLCY_ReceiptLine; "Receipt Line"."Amount(LCY)")
            {
            }
            column(VATCode_ReceiptLine; "Receipt Line"."VAT Code")
            {
            }
            column(VATAmount_ReceiptLine; "Receipt Line"."VAT Amount")
            {
            }
            column(VATAmountLCY_ReceiptLine; "Receipt Line"."VAT Amount(LCY)")
            {
            }
            column(WithholdingTaxCode_ReceiptLine; "Receipt Line"."Withholding Tax Code")
            {
            }
            column(WithholdingTaxAmount_ReceiptLine; "Receipt Line"."Withholding Tax Amount")
            {
            }
            column(WithholdingTaxAmountLCY_ReceiptLine; "Receipt Line"."Withholding Tax Amount(LCY)")
            {
            }
            column(WithholdingVATCode_ReceiptLine; "Receipt Line"."Withholding VAT Code")
            {
            }
            column(WithholdingVATAmount_ReceiptLine; "Receipt Line"."Withholding VAT Amount")
            {
            }
            column(WithholdingVATAmountLCY_ReceiptLine; "Receipt Line"."Withholding VAT Amount(LCY)")
            {
            }
            column(NetAmount_ReceiptLine; "Receipt Line"."Net Amount")
            {
            }
            column(NetAmountLCY_ReceiptLine; "Receipt Line"."Net Amount(LCY)")
            {
            }
            column(AppliestoDocType_ReceiptLine; "Receipt Line"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_ReceiptLine; "Receipt Line"."Applies-to Doc. No.")
            {
            }
            column(AppliestoID_ReceiptLine; "Receipt Line"."Applies-to ID")
            {
            }
            column(Committed_ReceiptLine; "Receipt Line".Committed)
            {
            }
            column(BudgetCode_ReceiptLine; "Receipt Line"."Budget Code")
            {
            }
            column(GlobalDimension1Code_ReceiptLine; "Receipt Line"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ReceiptLine; "Receipt Line"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 8 Code")
            {
            }
            column(ResponsibilityCenter_ReceiptLine; "Receipt Line"."Responsibility Center")
            {
            }
            column(Status_ReceiptLine; "Receipt Line".Status)
            {
            }
            column(Posted_ReceiptLine; "Receipt Line".Posted)
            {
            }
            column(PostedBy_ReceiptLine; "Receipt Line"."Posted By")
            {
            }
            column(DatePosted_ReceiptLine; "Receipt Line"."Date Posted")
            {
            }
            column(TimePosted_ReceiptLine; "Receipt Line"."Time Posted")
            {
            }
            column(Reversed_ReceiptLine; "Receipt Line".Reversed)
            {
            }
            column(ReversedBy_ReceiptLine; "Receipt Line"."Reversed By")
            {
            }
            column(ReversalDate_ReceiptLine; "Receipt Line"."Reversal Date")
            {
            }
            column(ReversalTime_ReceiptLine; "Receipt Line"."Reversal Time")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ReceiptHeader.Reset;
                ReceiptHeader.SetRange(ReceiptHeader."No.", "Receipt Line"."Document No.");
                ReceiptHeader.SetRange(ReceiptHeader.Reversed, true);
                if ReceiptHeader.FindFirst then begin
                    "Receipt Line".Reversed := true;
                    "Receipt Line".Modify;
                end;
            end;
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

    labels
    {
    }

    var
        ReceiptHeader: Record "Receipt Header";
}

