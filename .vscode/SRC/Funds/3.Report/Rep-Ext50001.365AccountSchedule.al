reportextension 50001 "365 Account Schedule" extends "Account Schedule"
{
    dataset
    {
        add(AccScheduleName)
        {
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebPage; CompanyInfo.Website)
            {
            }
        }
    }
    rendering
    {
        layout(LayoutNamePortrait)
        {
            Type = RDLC;
            LayoutFile = '.vscode/src/Funds/12.layout/365AccountSchedulerPotraitLayout.rdl';
            Caption = '365 Account Schedule Portrait';
            Summary = 'The 365 Account Schedule provides a detailed portrait layout.';
        }
        layout(LayoutNameLandscape)
        {
            Type = RDLC;
            LayoutFile = '.vscode/src/Funds/12.layout/365AccountScheduleLandscapeLayout.rdl';
            Caption = '365 Account Schedule Landscape';
            Summary = 'The 365 Account Schedule provides a detailed landscape layout.';
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
