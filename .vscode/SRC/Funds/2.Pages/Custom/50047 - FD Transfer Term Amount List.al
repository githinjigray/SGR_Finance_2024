page 50047 "FD Transfer Term Amount List"
{
    CardPageID = "FD Transfer Term Amount Card";
    PageType = List;
    SourceTable = "FD Processing1";
    SourceTableView = WHERE("Fixed Deposit Status" = FILTER(<> Closed));
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                }
                field("FD Type"; Rec."FD Type")
                {
                }
                field("FD Account"; Rec."FD Account")
                {
                }
                field("FD Account Name"; Rec."FD Account Name")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    Editable = false;
                }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date")
                {
                }
                field("Fixed Duration"; Rec."Fixed Duration")
                {
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    Visible = false;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    Editable = false;
                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                }
                field("Untranfered Interest"; Rec."Untranfered Interest")
                {
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("FD Amount"; Rec."FD Amount")
                {
                }
                field("FD Amount(LCY)"; Rec."FD Amount(LCY)")
                {
                }

                field("Last Interest Earned Date"; Rec."Last Interest Earned Date")
                {
                    Editable = false;
                }
                field("Expected Interest On Term Dep"; Rec."Expected Interest On Term Dep")
                {
                    Editable = false;
                }
                field("On Term Deposit Maturity"; Rec."On Term Deposit Maturity")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Accrue FD Interest")
            {
                Image = Report2;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Accrue FD Interest1";
            }
        }
    }
}

