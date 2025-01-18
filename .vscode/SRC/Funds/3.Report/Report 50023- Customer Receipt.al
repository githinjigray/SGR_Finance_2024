report 50023 "Customer Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Customer Receipt.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Receipt Header"; "Receipt Header")
        {
            column(BalnceAmount_ReceiptHeader; "Receipt Header"."Total Line Amount")
            {
            }
            column(No_ReceiptHeader; "Receipt Header"."No.")
            {
            }
            column(DocumentType_ReceiptHeader; "Receipt Header"."Document Type")
            {
            }
            column(DocumentDate_ReceiptHeader; "Receipt Header"."Document Date")
            {
            }
            column(PostingDate_ReceiptHeader; "Receipt Header"."Posting Date")
            {
            }
            column(PaymentMode_ReceiptHeader; "Receipt Header"."Payment Mode")
            {
            }
            column(ReceiptType_ReceiptHeader; "Receipt Header"."Receipt Type")
            {
            }
            column(AccountNo_ReceiptHeader; "Receipt Header"."Account No.")
            {
            }
            column(AccountName_ReceiptHeader; "Receipt Header"."Account Name")
            {
            }
            column(AccountBalance_ReceiptHeader; "Receipt Header"."Account Balance")
            {
            }
            column(ReferenceNo_ReceiptHeader; "Receipt Header"."Reference No.")
            {
            }
            column(ReceivedFrom_ReceiptHeader; "Receipt Header"."Received From")
            {
            }
            column(OnBehalfof_ReceiptHeader; "Receipt Header"."On Behalf of")
            {
            }
            column(CurrencyCode_ReceiptHeader; "Receipt Header"."Currency Code")
            {
            }
            column(CurrencyFactor_ReceiptHeader; "Receipt Header"."Currency Factor")
            {
            }
            column(AmountReceived_ReceiptHeader; "Receipt Header"."Amount Received")
            {
            }
            column(AmountReceivedLCY_ReceiptHeader; "Receipt Header"."Amount Received(LCY)")
            {
            }
            column(TotalLineAmount_ReceiptHeader; "Receipt Header"."Total Line Amount")
            {
            }
            column(TotalLineAmountLCY_ReceiptHeader; "Receipt Header"."Total Line Amount(LCY)")
            {
            }
            column(Description_ReceiptHeader; "Receipt Header".Description)
            {
            }
            column(ClientNo_ReceiptHeader; "Receipt Header"."Received From")
            {
            }
            column(ClientName_ReceiptHeader; "Receipt Header"."Received From")
            {
            }
            column(ClientBalance_ReceiptHeader; "Receipt Header"."Received From")
            {
            }
            column(UserID_ReceiptHeader; "Receipt Header"."User ID")
            {
            }
            column(ReceiptAmount; ReceiptAmount)
            {
            }
            column(TotalAmountText; TotalAmountText[1])
            {
            }
            column(HrEmployeeName; HrEmployeeName)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebPage; CompanyInfo.Website)
            {
            }
            column(IssuingOfficer; IssuingOfficer)
            {
            }
            column(DATETIME; CurrentDateTime)
            {
            }
            dataitem("Receipt Line"; "Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(PropertyName; PropertyName)
                {
                }
                column(ExTNo; ExTNo)
                {
                }
                column(LineNo_ReceiptLine; "Receipt Line"."Line No.")
                {
                }
                column(DocumentNo_ReceiptLine; "Receipt Line"."Document No.")
                {
                }
                column(DocumentType_ReceiptLine; "Receipt Line"."Document Type")
                {
                }
                column(ReceiptCode_ReceiptLine; "Receipt Line"."Receipt Code")
                {
                }
                column(ReceiptCodeDescription_ReceiptLine; "Receipt Line"."Receipt Code Description")
                {
                }
                column(AccountType_ReceiptLine; "Receipt Line"."Account Type")
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
                column(AppliestoDocNo_ReceiptLine; "Receipt Line"."Applies-to Doc. No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange(CustLedgerEntry."Document No.", "Receipt Line"."Applies-to Doc. No.");
                    if CustLedgerEntry.FindFirst then begin
                        ExTNo := CustLedgerEntry."External Document No.";
                    end;

                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverName; ApproverName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // HREmployee.Reset;
                    // HREmployee.SetRange(HREmployee."User ID", "Approval Entry"."Approver ID");
                    // if HREmployee.FindFirst then begin
                    //     ApproverName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                    // end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //CALCFIELDS("Receipt Header"."Total Line Amount");
                EnglishLanguageCode := 1033;
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(TotalAmountText, ("Receipt Header"."Amount Received"), "Receipt Header"."Currency Code");


                HrEmployeeName := "Receipt Header"."User ID";

                /*
                HREmployee.RESET;
                HREmployee.SETRANGE(HREmployee."User ID","Receipt Header"."User ID");
                IF HREmployee.FINDFIRST THEN BEGIN
                
                  HrEmployeeName:=HREmployee."First Name"+' '+HREmployee."Middle Name"+' '+HREmployee."Last Name";
                END;*/

                if "Receipt Header"."Currency Code" = '' then
                    "Receipt Header"."Currency Code" := GeneralLedgerSetup."LCY Code";


                ReceiptAmount := 'Amount';

                // if "Receipt Header"."Payment Mode"="Receipt Header"."Payment Mode"::"Withholding Rental Income" then
                //  ReceiptAmount:=Format("Receipt Header"."Payment Mode")+' Amount';
                //  if "Receipt Header"."Payment Mode"="Receipt Header"."Payment Mode"::"Withholding Tax" then
                //  ReceiptAmount:=Format("Receipt Header"."Payment Mode")+' Amount';
                //  if "Receipt Header"."Payment Mode"="Receipt Header"."Payment Mode"::"Withholding VAT" then
                //  ReceiptAmount:=Format("Receipt Header"."Payment Mode")+' Amount';

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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        GeneralLedgerSetup.Get;
    end;

    var
        CompanyInfo: Record "Company Information";
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        ApproverName: Text;
        IssuingOfficer: Text;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        TotalAmountText: array[2] of Text[200];
        CheckReport: Report Check;
        EnglishLanguageCode: Integer;
        PropertyName: Text;
        GeneralLedgerSetup: Record "General Ledger Setup";
        ReceiptAmount: Text;
        ExTNo: Code[50];
        CustLedgerEntry: Record "Cust. Ledger Entry";
}

