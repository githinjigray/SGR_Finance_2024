query 50008 "Funds Claim Transaction Code"
{

    elements
    {
        dataitem(Funds_Transaction_Code; "Funds Transaction Code")
        {
            DataItemTableFilter = "Transaction Type" = FILTER(Payment), "Funds Claim Code" = FILTER(true);
            column(Transaction_Code; "Transaction Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Transaction_Type; "Transaction Type")
            {
            }
            column(Account_Type; "Account Type")
            {
            }
            column(Account_No; "Account No.")
            {
            }
            column(Account_Name; "Account Name")
            {
            }
            column(Posting_Group; "Posting Group")
            {
            }
            column(Include_VAT; "Include VAT")
            {
            }
            column(VAT_Code; "VAT Code")
            {
            }
            column(Include_Withholding_Tax; "Include Withholding Tax")
            {
            }
            column(Withholding_Tax_Code; "Withholding Tax Code")
            {
            }
            column(Include_Withholding_VAT; "Include Withholding VAT")
            {
            }
            column(Withholding_VAT_Code; "Withholding VAT Code")
            {
            }
            column(Funds_Claim_Code; "Funds Claim Code")
            {
            }
            column(Employee_Transaction_Type; "Employee Transaction Type")
            {
            }
            column(Payroll_Taxable; "Payroll Taxable")
            {
            }
            column(Payroll_Allowance_Code; "Payroll Allowance Code")
            {
            }
            column(Payroll_Deduction_Code; "Payroll Deduction Code")
            {
            }
        }
    }
}

