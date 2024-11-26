report 50510 "Contracts Reports"
{
    ApplicationArea = All;
    Caption = 'Contracts Reports';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.vscode/src/Funds/12.layout/Contracts Reports.rdl';
    dataset
    {
        dataitem(ContractHeader2; "Contract Header2")
        {
            RequestFilterFields = "Contract Status";
            column(AccountNo; "Account No.")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; "Address 2")
            {
            }
            column(ApprovalComment; "Approval Comment")
            {
            }
            column(ChangeStatus; "Change Status")
            {
            }
            column(City; City)
            {
            }
            column(CommencementDate; "Commencement Date")
            {
            }
            column(Comment; Comment)
            {
            }
            column(ContactName; "Contact Name")
            {
            }
            column(ContractStatus; "Contract Status")
            {
            }
            column(ContractType; "Contract Type")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(CreatedDateTime; "Created DateTime")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(Description; Description)
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(Duration; "Duration")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(ExpiryNotificationPeriod; "Expiry Notification Period")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension1Name; "Global Dimension 1 Name")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(GlobalDimension2Name; "Global Dimension 2 Name")
            {
            }
            column(IncomingDocumentEntryNo; "Incoming Document Entry No.")
            {
            }
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(RejectedBy; "Rejected By")
            {
            }
            column(RejectedDateTime; "Rejected DateTime")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(ResponsiblePerson; "Responsible Person")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TotalAmount; "Total Amount")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
