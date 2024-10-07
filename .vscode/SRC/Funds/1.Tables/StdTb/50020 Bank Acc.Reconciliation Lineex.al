tableextension 50020 "Bank Acc.Reconciliation Lineex" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(70000; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                IF Reconciled = TRUE THEN BEGIN
                    "Reconciling Date" := TODAY;
                    "Applied Amount" := "Statement Amount";
                    Difference := 0;
                END ELSE BEGIN
                    Difference := "Statement Amount";
                    "Applied Amount" := 0;
                    "Reconciling Date" := 0D;
                END;


                BankAccRecon.RESET;
                BankAccRecon.SETRANGE(BankAccRecon."Bank Account No.", "Bank Account No.");
                BankAccRecon.SETRANGE(BankAccRecon."Statement No.", "Statement No.");
                IF BankAccRecon.FINDFIRST THEN BEGIN
                    BankAccRecon.VALIDATE(BankAccRecon."Difference Btw Statements");
                    BankAccRecon.MODIFY;
                END;
            end;
        }
        field(70001; "Open Type"; Option)
        {
            Caption = 'Open Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Unpresented,Uncredited;
            OptionCaption = ' ,Unpresented,Uncredited';
        }
        field(70002; "Bank Ledger Entry Line No"; Integer)
        {
            Caption = 'Bank Ledger Entry Line No';
            DataClassification = ToBeClassified;
        }
        field(70003; "Bank Statement Entry Line No"; Integer)
        {
            Caption = 'Bank Statement Entry Line No';
            DataClassification = ToBeClassified;
        }
        field(70004; Reversed; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
        }
        field(70005; "Reconciling Date"; Date)
        {
            Caption = 'Reconciling Date';
            DataClassification = ToBeClassified;
        }
        field(70006; "Parent Line No 2."; Integer)
        {
            Caption = 'Parent Line No 2.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Transaction ID 2"; Text[50])
        {
            Caption = 'Transaction ID 2';
            DataClassification = ToBeClassified;
        }
        field(70008; "Payee Name/Received From"; Text[250])
        {
            Caption = 'Payee Name/Received From';
            DataClassification = ToBeClassified;
        }
    }
    var
        BankAccRecon: Record "Bank Acc. Reconciliation";
}
