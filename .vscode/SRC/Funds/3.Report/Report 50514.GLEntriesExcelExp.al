report 50514 "GL Entries-Excel Export"
{
    Caption = 'GL Entries-Excel Export';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {

        dataitem("Company Information"; "Company Information")
        {


            trigger OnAfterGetRecord()
            var
                GLTEntries: Record "G/L Entry";
                SourceNameNameLbl: Label 'Source Name.';
                SourceName: Text[250];
                RowNo: Integer;
                HeaderRowNo: Integer;
                FooterRowNo: Integer;
                i: Integer;
                GlAccount: Record "G/L Account";
                BankAccount: Record "Bank Account";
                Vendors: Record Vendor;
                Customers: Record Customer;
            begin

                //Insert Header
                GLTEntries.Reset();
                GLTEntries.SetRange("Posting Date", StartDate, EndDate);
                GLTEntries.SetRange(Reversed, false);
                if GLTEntries.FindFirst() then begin
                    Window.Open(
                      WindowDialog1 +
                      '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
                    Window.Update(1, 0);
                    RecCount := 1;
                    TotalRecCount := GLTEntries.Count;

                    RowNo := 1;
                    EnterCell(RowNo, 1, ExportLabelTxt, false, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(RowNo, 2, '', false, true, '', ExcelBuf."Cell Type"::Text);
                    EnterFilterInCell(Name, FieldCaption(Name), RowNo);
                    EnterFilterInCell(Address, FieldCaption(Address), RowNo);

                    RowNo := RowNo + 2;
                    HeaderRowNo := RowNo;

                    EnterCell(HeaderRowNo, 1, GLTEntries.FieldCaption("Posting Date"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 2, GLTEntries.FieldCaption("Document No."), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 3, GLTEntries.FieldCaption("Document Type"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 4, GLTEntries.FieldCaption("External Document No."), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 5, GLTEntries.FieldCaption("G/L Account No."), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 6, GLTEntries.FieldCaption("G/L Account Name"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 7, GLTEntries.FieldCaption(Description), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 8, GLTEntries.FieldCaption(Amount), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 9, GLTEntries.FieldCaption("Additional-Currency Amount"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 10, GLTEntries.FieldCaption("Source Type"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 11, GLTEntries.FieldCaption("Source No."), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 12, SourceNameNameLbl, true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 13, GLTEntries.FieldCaption("Currency Code"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 14, GLTEntries.FieldCaption("Currency Amount"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 15, GLTEntries.FieldCaption("Global Dimension 1 Code"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 16, GLTEntries.FieldCaption("Global Dimension 2 Code"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 17, GLTEntries.FieldCaption("Shortcut Dimension 3 Code"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 18, GLTEntries.FieldCaption("Shortcut Dimension 4 Code"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 19, GLTEntries.FieldCaption("Shortcut Dimension 5 Code"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 20, GLTEntries.FieldCaption("Shortcut Dimension 6 Code"), true, true, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(HeaderRowNo, 21, GLTEntries.FieldCaption("User ID"), true, true, '', ExcelBuf."Cell Type"::Text);





                    GLTEntries.FindFirst();
                    repeat
                        Window.Update(1, Round((RecCount / TotalRecCount) * 10000, 1, '>'));
                        RecCount += 1;

                        RowNo += 1;
                        SourceName := '';
                        if GLTEntries."Source Type" = GLTEntries."Source Type"::Vendor then
                            if Vendors.get(GLTEntries."Source No.") then
                                SourceName := Vendors.Name;

                        if GLTEntries."Source Type" = GLTEntries."Source Type"::Customer then
                            if Customers.get(GLTEntries."Source No.") then
                                SourceName := Customers.Name;

                        if GLTEntries."Source Type" = GLTEntries."Source Type"::"Bank Account" then
                            if BankAccount.get(GLTEntries."Source No.") then
                                SourceName := BankAccount.Name;

                        GLTEntries.CalcFields("Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code");
                        EnterCell(RowNo, 1, Format(GLTEntries."Posting Date"), false, false, '', ExcelBuf."Cell Type"::Date);
                        EnterCell(RowNo, 2, GLTEntries."Document No.", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 3, Format(GLTEntries."Document Type"), false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 4, GLTEntries."External Document No.", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 5, GLTEntries."G/L Account No.", false, false, '', ExcelBuf."Cell Type"::Text);
                        if GLTEntries."G/L Account Name" = '' then begin
                            if GlAccount.Get(GLTEntries."G/L Account No.") then
                                EnterCell(RowNo, 6, GlAccount.Name, false, false, '', ExcelBuf."Cell Type"::Text);
                        end else begin
                            EnterCell(RowNo, 6, GLTEntries."G/L Account Name", false, false, '', ExcelBuf."Cell Type"::Text);
                        end;
                        EnterCell(RowNo, 7, GLTEntries.Description, false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 8, Format(GLTEntries.Amount), false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                        EnterCell(RowNo, 9, Format(GLTEntries."Additional-Currency Amount"), false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                        EnterCell(RowNo, 10, Format(GLTEntries."Source Type"), false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 11, GLTEntries."Source No.", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 12, SourceName, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                        EnterCell(RowNo, 13, GLTEntries."Currency Code", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 14, Format(GLTEntries."Currency Amount"), false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                        EnterCell(RowNo, 15, GLTEntries."Global Dimension 1 Code", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 16, GLTEntries."Global Dimension 2 Code", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 17, GLTEntries."Shortcut Dimension 3 Code", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 18, GLTEntries."Shortcut Dimension 4 Code", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 19, GLTEntries."Shortcut Dimension 5 Code", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 20, GLTEntries."Shortcut Dimension 6 Code", false, false, '', ExcelBuf."Cell Type"::Text);
                        EnterCell(RowNo, 21, GLTEntries."User ID", false, false, '', ExcelBuf."Cell Type"::Text);



                    until GLTEntries.Next() = 0;
                    Window.Close();

                    ExcelBuf.CreateNewBook(DelChr(ExportLabelTxt, '=', ' '));
                    ExcelBuf.WriteSheet(
                      PADSTR(STRSUBSTNO('%1 %2', DelChr(ExportLabelTxt, '=', ' '), DelChr(Format(Today), '=', '/')), 30),
                      COMPANYNAME,
                      USERID);
                    ExcelBuf.CloseBook;
                    ExcelBuf.SetFriendlyFilename(DelChr(ExportLabelTxt, '=', ' '));
                    ExcelBuf.OpenExcel;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        ExcelBuf.Reset();
        ExcelBuf.DeleteAll();
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        GLSetup: Record "General Ledger Setup";
        RecCount: Integer;
        TotalRecCount: Integer;
        Window: Dialog;
        WindowDialog1: Label 'Analysing Data';
        ExportLabelTxt: Label 'GL Entries';
        StartDate: Date;
        EndDate: Date;
        StartDateLbl: Label 'Start Date';
        EndDateLbl: Label 'End Date';



    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option);
    begin
        ExcelBuf.Init();
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf."Cell Type" := CellType;
        ExcelBuf.Insert();
    end;

    local procedure EnterFilterInCell("Filter": Text[250]; FieldName: Text[100]; var RowNo: Integer);
    begin
        IF Filter <> '' THEN BEGIN
            RowNo := RowNo + 1;
            EnterCell(RowNo, 1, FieldName, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            EnterCell(RowNo, 2, Filter, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        end;
    end;

    local procedure EnterFormula(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]);
    begin
        ExcelBuf.Init();
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := '';
        ExcelBuf.Formula := CellValue; // is converted to formula later.
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf.Insert();
    end;


}
