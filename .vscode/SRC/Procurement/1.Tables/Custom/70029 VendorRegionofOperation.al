table 70029 "Vendor Regions of Operation"
{
    Caption = 'Vendor Regions of Operation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "County Code"; Code[50])
        {
            Caption = 'County Code';
            DataClassification = ToBeClassified;
           // TableRelation = County.Code;
            trigger OnValidate()
            begin
                // "County Name" := '';
                // CountyCodes.Reset();
                // CountyCodes.SetRange(CountyCodes.Code, "County Code");
                // if CountyCodes.FindFirst() then begin
                //     "County Name" := CountyCodes.Name;
                // end;

            end;
        }
        field(3; "County Name"; Text[200])
        {
            Caption = 'County Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Document No."; Code[30])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Line No", "Document No.")
        {
            Clustered = true;
        }
    }
    var
        //CountyCodes: Record County;
}
