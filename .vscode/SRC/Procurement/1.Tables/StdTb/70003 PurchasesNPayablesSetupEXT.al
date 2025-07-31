tableextension 70003 "Purchases N Payables Setup EXT" extends "Purchases & Payables Setup"
{
    fields
    {
        field(70000; "Purchase Requisition Nos."; Code[20])
        {
            Caption = 'Purchase Requisition Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70001; "Request for Quotation Nos."; Code[20])
        {
            Caption = 'Request for Quotation Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70002; "Procurement Plan Nos"; Code[20])
        {
            Caption = 'Procurement Plan Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70003; "Use Procurement Plan"; Boolean)
        {
            Caption = 'Use Procurement Plan';
            DataClassification = ToBeClassified;
        }
        field(70004; "Tender Doc No."; Code[20])
        {
            Caption = 'Tender Doc No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70005; "User to replenish Stock"; Code[50])
        {
            Caption = 'User to replenish Stock';
            DataClassification = ToBeClassified;
        }
        field(70006; "Tender Evaluation No."; Code[30])
        {
            Caption = 'Tender Evaluation No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70007; "Bid Analysis No."; Code[30])
        {
            Caption = 'Bid Analysis No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70008; "Contract Request Nos"; Code[30])
        {
            Caption = 'Contract Request Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70009; "Contract Nos"; Code[30])
        {
            Caption = 'Contract Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(70010; "PO Terms & Conditions"; Blob)
        {
            Caption = 'PO Terms & Conditions';
            DataClassification = ToBeClassified;
        }
    }
}
