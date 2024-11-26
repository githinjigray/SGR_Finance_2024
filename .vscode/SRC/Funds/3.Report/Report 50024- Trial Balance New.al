report 50024 "Trial Balance New"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.vscode/src/Funds/12.layout/Trial Balance New.rdlc';
    Caption = 'Trial Balance New';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CompanyName)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(company_Picture; company.Picture)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; "G/L Account".TableCaption + ': ' + GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(Totaldebit; Totaldebitbal)
            {
            }
            column(Totalcredit; -Totalcreditbal)
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(PADSTR_____G_L_Account__Indentation___3___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___3___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(AccountType; "G/L Account"."Account Type")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___3___G_L_Account__Name; "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___No___Control25; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___3___G_L_Account__Name_Control26; PadStr('', "G/L Account".Indentation * 3) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change__Control27; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control28; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(Integer_Number; Number)
                {
                }
                column(G_L_Account___Bal_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Bal__Control22; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
            }

            trigger OnAfterGetRecord()
            begin
                Totaldebit := 0;
                Totalcreditbal := 0;
                Totalcredit := 0;
                Totaldebitbal := 0;

                CalcFields("Net Change", "Balance at Date");
                if ("Balance at Date" = 0) and ("G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting) then
                    CurrReport.Skip;
                //CurrReport.CREATETOTALS("Net Change","Balance at Date");
                if "G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting then begin
                    if "Net Change" > 0 then
                        Totaldebit := Totaldebit + "Net Change";
                    if "Net Change" < 0 then
                        Totalcredit := Totalcredit + "Net Change";
                end;

                if "G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting then begin
                    if "Balance at Date" > 0 then
                        Totaldebitbal := Totaldebitbal + "Balance at Date";
                    if "Balance at Date" < 0 then
                        Totalcreditbal := Totalcreditbal + "Balance at Date";
                end;
            end;

            trigger OnPreDataItem()
            begin
                if company.Get then
                    company.CalcFields(company.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GetFilters;
        PeriodText := "G/L Account".GetFilter("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        GLFilter: Text[250];
        PeriodText: Text[30];
        Totaldebit: Decimal;
        Totalcredit: Decimal;
        Totaldebitbal: Decimal;
        Totalcreditbal: Decimal;
        company: Record "Company Information";
        Trial_BalanceCaptionLbl: Label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Net Change';
        No_CaptionLbl: Label 'No.';
        PADSTR_____G_L_Account__Indentation___3___G_L_Account__NameCaptionLbl: Label 'Name';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
        TotalsCaptionLbl: Label 'Totals';
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Text001: Label 'Trial Balance';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';

    procedure MakeExcelInfo()
    begin
        /*ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text001),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Trial Balance",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Net Change") + ' - ' + Text003), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Net Change") + ' - ' + Text004), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Balance at Date") + ' - ' + Text003), false, '', true, false, true, '',
          ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Balance at Date") + ' - ' + Text004), false, '', true, false, true, '',
          ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PadStr(' ', MaxStrLen(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(
          "G/L Account"."No.", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
          ExcelBuf."Cell Type"::Text);
        if "G/L Account".Indentation = 0 then
            ExcelBuf.AddColumn(
              "G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
              ExcelBuf."Cell Type"::Text)
        else
            ExcelBuf.AddColumn(
              CopyStr(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name,
              false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);

        case true of
            "G/L Account"."Net Change" = 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Net Change" > 0:
                begin
                    ExcelBuf.AddColumn(
                      "G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Net Change" < 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      -"G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                end;
        end;

        case true of
            "G/L Account"."Balance at Date" = 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Balance at Date" > 0:
                begin
                    ExcelBuf.AddColumn(
                      "G/L Account"."Balance at Date", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Balance at Date" < 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      -"G/L Account"."Balance at Date", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                end;
        end;
    end;

    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBookAndOpenExcel(Text002,Text001,'Trial Balance',CompanyName,UserId);
        Error('');
    end;
}

