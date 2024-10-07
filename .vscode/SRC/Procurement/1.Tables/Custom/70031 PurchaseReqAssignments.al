table 70031 "Purchase Req. Assignments"
{
    Caption = 'Purchase Req. Assignments';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement=true;
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation=Employee;
            trigger OnValidate()
            var
                Employees: Record Employee;
                PurchaserRequisition: Record "Purchase Requisitions";
                ProcurementManagement: Codeunit "Procurement Management";
            begin
                "Employee Name":='';
                Employees.Reset();
                Employees.setrange("No.","Employee No.");
                if Employees.FindFirst() then begin
                    "Employee Name":=Employees."First Name"+' '+Employees."Middle Name"+' '+Employees."Last Name";
                    //modify header
                    PurchaserRequisition.Reset();
                    PurchaserRequisition.setrange("No.","Document No.");
                    if PurchaserRequisition.FindFirst() then begin
                      //  PurchaserRequisition."Assigned User ID":=Employees."User ID";
                        PurchaserRequisition.Modify;
                    end;
                end;
                //send email    
              //  ProcurementManagement.CreatePurchaseRequisitionEmailAssigned("Document No.");
                "Assigned DateTime":=CreateDateTime(Today,Time);
                "Assigned By":=UserId;
            end;
        }
        field(4; "Employee Name"; Text[200])
        {
            Caption = 'Employee Name';
            Editable=false;
            DataClassification = ToBeClassified;
        }
        field(5; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
            Editable=false;
            DataClassification = ToBeClassified;
        }
         field(6; "Assigned DateTime"; DateTime)
        {
            Caption = 'Assigned DateTime';
            Editable=false;
            DataClassification = ToBeClassified;
        }
        field(7; "Assigned By"; Code[20])
        {
            Caption = 'Assigned By';
            Editable=false;
            TableRelation="User Setup";
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No.","Document No.")
        {
            Clustered = true;
        }
    }
}
