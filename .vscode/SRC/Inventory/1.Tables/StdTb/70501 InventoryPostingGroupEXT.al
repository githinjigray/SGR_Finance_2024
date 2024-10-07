tableextension 70501 "Inventory Posting Group EXT" extends "Inventory Posting Group"
{
    fields
    {
        field(70000; "Budget G/L Account"; Code[20])
        {
            Caption = 'Budget G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = filter(true), "Account Type" = filter(Posting));
        }
    }
}
