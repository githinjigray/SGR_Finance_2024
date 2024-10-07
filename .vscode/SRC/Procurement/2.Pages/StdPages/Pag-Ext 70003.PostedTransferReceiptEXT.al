pageextension 70003 "Posted Transfer Receipt EXT" extends "Posted Transfer Receipt"
{
    layout
    {

    }
    actions
    {
        addafter("&Print")
        {
            action("Print Packing List")
            {
                Caption = 'Print Packing List Received';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    TransferHeader.Reset;
                    TransferHeader.SetRange(TransferHeader."No.", rec."No.");
                    if TransferHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"Packing List Shipped", true, false, TransferHeader);
                    end;
                end;
            }
        }
    }
    var
        TransferHeader: Record "Transfer Receipt Header";
}
