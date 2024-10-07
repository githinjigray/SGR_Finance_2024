page 70506 "Inventory User Setup"
{
    ApplicationArea = All;
    Caption = 'Inventory User Setup';
    PageType = List;
    SourceTable = "Inventory User Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UserID field.';
                    TableRelation = User."User Name";

                    trigger OnValidate()
                    begin
                        //UserManager.ValidateUserID(UserID);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //  UserManager.LookupUserID(UserID);
                    end;
                }
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                    ApplicationArea = All;
                    TableRelation = "Item Journal Template".Name;
                    ToolTip = 'Specifies the value of the Item Journal Template field.';
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                    ApplicationArea = All;
                    TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Item Journal Template"));
                    ToolTip = 'Specifies the value of the Item Journal Batch field.';
                }
            }
        }
    }
    var
        UserManager: Codeunit "User Management";
}
