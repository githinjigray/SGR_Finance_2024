tableextension 70502 "365 Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(70050; "Part No."; Code[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(70051; "Alternative Part No. 1"; Code[50])
        {
            Caption = 'Alternative Part No. 1';
            DataClassification = ToBeClassified;
        }
        field(70052; "Alternative Part No. 2"; Code[50])
        {
            Caption = 'Alternative Part No. 2';
            DataClassification = ToBeClassified;
        }
        field(70053; "Alternative Part No. 3"; Code[50])
        {
            Caption = 'Alternative Part No. 3';
            DataClassification = ToBeClassified;
        }
        field(70054; "Alternative Part No. 4"; Code[50])
        {
            Caption = 'Alternative Part No. 4';
            DataClassification = ToBeClassified;
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Serial No.")
        {
        }

    }
}
