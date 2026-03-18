table 50032 "Cheque Register Lines"
{
    Caption = 'Cheque Register Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[30])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Leaf no"; Integer)
        {
            Caption = 'Leaf no';
            DataClassification = ToBeClassified;
        }
        field(5; "Cheque No."; Code[10])
        {
            Caption = 'Cheque No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Payee No"; Code[30])
        {
            Caption = 'Payee No';
            DataClassification = ToBeClassified;
        }
        field(7; Payee; Text[100])
        {
            Caption = 'Payee';
            DataClassification = ToBeClassified;
        }
        field(8; "PV No"; Code[30])
        {
            Caption = 'PV No';
            DataClassification = ToBeClassified;
        }
        field(9; "PV Description"; Text[150])
        {
            Caption = 'PV Description';
            DataClassification = ToBeClassified;
        }
        field(10; "PV Prepared By"; Code[30])
        {
            Caption = 'PV Prepared By';
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
            OptionCaption = ',Open,Pending Approval,Approved,Rejected,Posted,Reversed';
        }
        field(12; "Cheque Cancelled"; Boolean)
        {
            Caption = 'Cheque Cancelled';
            DataClassification = ToBeClassified;
        }
        field(13; "Cancelled By"; Code[30])
        {
            Caption = 'Cancelled By';
            DataClassification = ToBeClassified;
        }
        field(14; "Bank  Account No."; Code[30])
        {
            Caption = 'Bank  Account No.';
            DataClassification = ToBeClassified;
        }
        field(15; "Assigned to PV"; Boolean)
        {
            Caption = 'Assigned to PV';
            DataClassification = ToBeClassified;
        }
        field(16; "PV Posted with Cheque"; Boolean)
        {
            Caption = 'PV Posted with Cheque';
            DataClassification = ToBeClassified;
        }
        field(50; "Denomination"; Code[50])
        {
            Caption = 'Denomination';
            DataClassification = ToBeClassified;
            TableRelation = "Denomination Types".Denomintaion;
            trigger OnValidate()
            var
                DenominationRec: Record "Denomination Types";
            begin
                if Denomination <> '' then begin
                    if DenominationRec.Get(Denomination) then begin
                        Rec."Denomination Description" := DenominationRec."Denomination Description";
                        Rec."Denomination Amount" := DenominationRec."Denomination Amount";
                    end else begin
                        Rec."Denomination Description" := '';
                        Rec."Denomination Amount" := 0;
                    end;
                end;
            end;
        }
        field(51; "Denomination Description"; Text[250])
        {
            Caption = 'Denomination Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Denomination Amount"; Decimal)
        {
            Caption = 'Denomination Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                rec.TestField(Denomination);
                Rec.TestField("Denomination Amount");

                if Denomination <> '' then
                    rec."Total Amount" := rec.Quantity * "Denomination Amount";
            end;
        }
        field(54; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Line No.", "Document No.")
        {
            Clustered = true;
        }
    }
}
