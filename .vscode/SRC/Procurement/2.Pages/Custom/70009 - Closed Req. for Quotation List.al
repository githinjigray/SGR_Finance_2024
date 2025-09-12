page 70009 "Closed Req. for Quotation List"
{
    CardPageID = "Request for Quotation Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Request for Quotation Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = CONST(Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Closing Date"; rec."Closing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field name';
                }
            }
        }
    }

    actions
    {
    }

    procedure InsertRFQLines()
    var
        Counter: Integer;
        RFQLine: Record "Purchase Requisition Codes";
        RequisitionLine: Page "Procurement Planning Sub Form";
    begin
        /*RequisitionLine.LOOKUPMODE(TRUE);
        IF RequisitionList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          RequisitionList.SetSelection(RFQLine);
          Counter :=RFQLine.COUNT;
          IF Counter > 0 THEN BEGIN
            IF RFQLine.FINDSET THEN
              REPEAT
                Lines.INIT;
                Lines.TRANSFERFIELDS(RFQLine);
                Lines."Document Type":="Document Type";
                Lines."Document No.":="No.";
                Lines."Line No.":=0;
                Lines."PRF No":=RFQLine."Document No.";
                Lines."PRF Line No.":=RFQLine."Line No.";
                Lines.INSERT(TRUE);
             UNTIL RFQLine.NEXT = 0;
          END;
        END;*/

    end;
}

