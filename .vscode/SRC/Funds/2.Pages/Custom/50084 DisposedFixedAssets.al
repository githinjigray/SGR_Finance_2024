page 50084 "Disposed Fixed Assets"
{
    ApplicationArea = All;
    Caption = 'Disposed Fixed Assets';
    PageType = List;
    SourceTable = "FA Depreciation Book";
    UsageCategory = History;
    Editable = false;
    SourceTableView = where("Disposal Date" = filter(<> 0D));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the related fixed asset. ';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
                }
                field("Depreciation Method"; Rec."Depreciation Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how depreciation is calculated for the depreciation book.';
                }
                field("Depreciation Starting Date"; Rec."Depreciation Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on which depreciation of the fixed asset starts.';
                }
                field("Straight-Line %"; Rec."Straight-Line %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage to depreciate the fixed asset by the straight-line principle, but with a fixed yearly percentage.';
                }
                field("No. of Depreciation Years"; Rec."No. of Depreciation Years")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the length of the depreciation period, expressed in years.';
                }
                field("No. of Depreciation Months"; Rec."No. of Depreciation Months")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the length of the depreciation period, expressed in months.';
                }
                field("Fixed Depr. Amount"; Rec."Fixed Depr. Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an amount to depreciate the fixed asset, by a fixed yearly amount.';
                }
                field("Declining-Balance %"; Rec."Declining-Balance %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage to depreciate the fixed asset by the declining-balance principle, but with a fixed yearly percentage.';
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which posting group is used for the depreciation book when posting fixed asset transactions.';
                }
                field("Depreciation Ending Date"; Rec."Depreciation Ending Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on which depreciation of the fixed asset ends.';
                }
                field("Acquisition Cost"; Rec."Acquisition Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total acquisition cost for the fixed asset.';
                }
                field(Depreciation; Rec.Depreciation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total depreciation for the fixed asset.';
                }
                field("Book Value"; Rec."Book Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the book value for the fixed asset.';
                }
                field("Proceeds on Disposal"; Rec."Proceeds on Disposal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total proceeds on disposal for the fixed asset.';
                }
                field("Gain/Loss"; Rec."Gain/Loss")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total gain (credit) or loss (debit) for the fixed asset.';
                }
                field("Acquisition Date"; Rec."Acquisition Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the FA posting date of the first posted acquisition cost.';
                }
                field("Disposal Date"; Rec."Disposal Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the FA posting date of the first posted disposal amount.';
                }
                field("Last Acquisition Cost Date"; Rec."Last Acquisition Cost Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total percentage of acquisition cost that can be allocated when acquisition cost is posted.';
                }
                field("Last Depreciation Date"; Rec."Last Depreciation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the FA posting date of the last posted depreciation.';
                }
            }
        }
    }
}
