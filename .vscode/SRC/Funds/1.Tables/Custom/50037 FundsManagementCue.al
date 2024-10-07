table 50037 "Funds Management Cue"
{
    Caption = 'Funds Manager Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "User Id Filter"; text[64])
        {
            CalcFormula = Lookup(Session."User ID" WHERE("My Session" = CONST(true)));
            FieldClass = FlowField;
        }
        field(10; "Open Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = FILTER(<> Posted),
                                                        "Payment Type" = CONST("Cheque Payment")));
            Caption = 'Open Payments';
            FieldClass = FlowField;
        }
        field(11; "Payments Pending Approval"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = CONST("Pending Approval"),
                                                        "Payment Type" = CONST("Cheque Payment")));
            Caption = 'Payments Pending Approval';
            FieldClass = FlowField;
        }
        field(12; "Approved Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = CONST(Approved),
                                                        "Payment Type" = CONST("Cheque Payment")));
            Caption = 'Approved Payments';
            FieldClass = FlowField;
        }
        field(13; "Rejected Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = CONST(Rejected),
                                                        "Payment Type" = CONST("Cheque Payment")));
            Caption = 'Rejected Payments';
            FieldClass = FlowField;
        }
        field(14; "Posted Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = CONST(Posted),
                                                        "Payment Type" = CONST("Cheque Payment")));
            Caption = 'Posted Payments';
            FieldClass = FlowField;
        }
        field(15; "Reversed Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = CONST(Reversed),
                                                        "Payment Type" = CONST("Cheque Payment")));
            Caption = 'Reversed Payments';
            FieldClass = FlowField;
        }
        field(16; "Open Cash Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = FILTER(<> Posted),
                                                        "Payment Type" = CONST("Cash Payment")));
            Caption = 'Cash Payments';
            FieldClass = FlowField;
        }
        field(20; "Posted Cash Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = CONST(Posted),
                                                        "Payment Type" = CONST("Cash Payment")));
            Caption = 'Posted Cash Payments';
            FieldClass = FlowField;
        }
        field(21; "Reversed Cash Payments"; Integer)
        {
            CalcFormula = Count("Payment Header" WHERE(Status = CONST(Reversed),
                                                        "Payment Type" = CONST("Cash Payment")));
            Caption = 'Reversed Cash Payments';
            FieldClass = FlowField;
        }
        field(29; "Payment Codes"; Integer)
        {
            CalcFormula = Count("Funds Transaction Code" WHERE("Transaction Type" = CONST(Payment)));
            Caption = 'Payment Codes';
            FieldClass = FlowField;
        }
        field(30; Receipts; Integer)
        {
            CalcFormula = Count("Receipt Header" WHERE(Status = FILTER(<> Posted)));
            Caption = 'Receipts';
            FieldClass = FlowField;
        }
        field(34; "Posted Receipts"; Integer)
        {
            CalcFormula = Count("Receipt Header" WHERE(Status = CONST(Posted)));
            Caption = 'Posted Receipts';
            FieldClass = FlowField;
        }
        field(39; "Receipt Codes"; Integer)
        {
            CalcFormula = Count("Funds Transaction Code" WHERE("Transaction Type" = CONST(Receipt)));
            Caption = 'Receipt Codes';
            FieldClass = FlowField;
        }
        field(40; Imprests; Integer)
        {
            CalcFormula = Count("Imprest Header" WHERE(Status = FILTER(<> Posted)));
            Caption = 'Imprests';
            FieldClass = FlowField;
        }
        field(44; "Posted Imprests"; Integer)
        {
            CalcFormula = Count("Imprest Header" WHERE(Status = CONST(Posted)));
            Caption = 'Posted Imprests';
            FieldClass = FlowField;
        }
        field(45; "Reversed Imprests"; Integer)
        {
            CalcFormula = Count("Imprest Header" WHERE(Status = CONST(Reversed)));
            Caption = 'Reversed Imprests';
            FieldClass = FlowField;
        }
        field(46; "Imprest Surrenders"; Integer)
        {
            CalcFormula = Count("Imprest Surrender Header" WHERE(Status = FILTER(<> Posted)));
            Caption = 'Imprest Surrenders';
            FieldClass = FlowField;
        }
        field(50; "Posted Imprest Surrenders"; Integer)
        {
            CalcFormula = Count("Imprest Surrender Header" WHERE(Status = CONST(Posted)));
            Caption = 'Posted Imprest Surrenders';
            FieldClass = FlowField;
        }
        field(51; "Reversed Imprest Surrenders"; Integer)
        {
            CalcFormula = Count("Imprest Surrender Header" WHERE(Status = CONST(Reversed)));
            Caption = 'Reversed Imprest Surrenders';
            FieldClass = FlowField;
        }
        field(59; "Imprest Codes"; Integer)
        {
            CalcFormula = Count("Funds Transaction Code" WHERE("Transaction Type" = CONST(Imprest)));
            Caption = 'Imprest Codes';
            FieldClass = FlowField;
        }
        field(60; "Funds Transfer"; Integer)
        {
            CalcFormula = Count("Funds Transfer Header" WHERE(Status = FILTER(<> Posted)));
            Caption = 'Funds Transfer';
            FieldClass = FlowField;
        }
        field(64; "Posted Funds Transfer"; Integer)
        {
            CalcFormula = Count("Funds Transfer Header" WHERE(Status = CONST(Posted)));
            Caption = 'Posted Funds Transfer';
            FieldClass = FlowField;
        }
        field(100; "New Fixed Deposits"; Integer)
        {
            CalcFormula = Count("FD Processing1" WHERE("Fixed Deposit Status" = CONST("Open ")));
            Caption = 'New Fixed Deposits';
            FieldClass = FlowField;
        }
        field(101; "Active Fixed Deposits"; Integer)
        {
            CalcFormula = Count("FD Processing1" WHERE("Fixed Deposit Status" = CONST(Active)));
            Caption = 'Active Fixed Deposits';
            FieldClass = FlowField;
        }
        field(102; "Matured Fixed Deposits"; Integer)
        {
            CalcFormula = Count("FD Processing1" WHERE("Fixed Deposit Status" = CONST(Matured)));
            Caption = 'Matured Fixed Deposits';
            FieldClass = FlowField;
        }
        field(5000; "Purchase Invoices"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice)));
            FieldClass = FlowField;
        }
        field(5004; "Posted Purchase Invoices"; Integer)
        {
            CalcFormula = Count("Purch. Inv. Header");
            FieldClass = FlowField;
        }
        field(5006; "Purchase Cr. Memos"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Credit Memo")));
            FieldClass = FlowField;
        }
        field(5020; "Posted Purchase Cr. Memos"; Integer)
        {
            CalcFormula = Count("Purch. Cr. Memo Hdr.");
            FieldClass = FlowField;
        }
        field(6000; "Sales Invoices"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Invoice)));
            FieldClass = FlowField;
        }
        field(6004; "Posted Sales Invoices"; Integer)
        {
            CalcFormula = Count("Sales Invoice Header");
            FieldClass = FlowField;
        }
        field(6006; "Sales Cr. Memos"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Credit Memo")));
            FieldClass = FlowField;
        }
        field(6020; "Posted Sales Cr. Memos"; Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header");
            FieldClass = FlowField;
        }
        field(6500; "Contract Requests"; Integer)
        {
            CalcFormula = Count("Contract Request Header");
            FieldClass = FlowField;
        }
        field(6501; "Active Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2");
            FieldClass = FlowField;
        }
        field(6502; "In-Active Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2" where("Contract Status" = const(Terminated)));
            FieldClass = FlowField;
        }
        field(6503; "Expired Contracts"; Integer)
        {
            CalcFormula = Count("Contract Header2" where("Contract Status" = const(Expired)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

