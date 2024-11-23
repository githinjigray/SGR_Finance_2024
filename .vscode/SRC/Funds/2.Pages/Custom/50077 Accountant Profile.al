page 50077 "Accountant Role Center3"
{
    Caption = 'Accountant', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;
    ApplicationArea = all;

    layout
    {
        area(rolecenter)
        {
            part(Control130; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(FundsActivities; "Funds Account Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
            }
        }
        area(embedding)
        {
            action("Upload Dimension Values")
            {
                ApplicationArea = all;
                Caption = 'Upload Dimension Values';
                //RunObject = xmlport "Upload Dimension Values";
                ToolTip = 'Upload Dimension Values';
                Visible = false;
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
            }
            action(Budgets)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
                ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
            }

            action("Bank Accounts")
            {

                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Bank Account Reconciliation")
            {
                RunObject = Page "Bank Acc. Reconciliation List";
            }
            action("Purchase Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                Image = Invoice;
                RunObject = Page "Purchase Invoices";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }

            action(VendorsBalance)
            {
                ApplicationArea = Advanced;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Purchase Orders")
            {
                ApplicationArea = Advanced;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(CustomersBalance)
            {
                ApplicationArea = Advanced;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Incoming Documents")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
            }
            action("Purchase Credit Memos")
            {
                RunObject = Page "Purchase Credit Memos";
            }
            action("Salesperson List")
            {
                Image = Accounts;
                RunObject = Page "Salespersons/Purchasers";
            }
            action("Funds Transaction Codes")
            {
                RunObject = Page "Payment Codes";
            }
            action("Fixed deposit Types")
            {
                RunObject = page "Fixed deposit Types list";
            }
            action("Fixed Deposit Criteria")
            {
                RunObject = page "Fixed Deposit Criteria";
            }
        }
        area(sections)
        {
            group(Assets)
            {
                Caption = 'Assets';
                Image = Journals;
                ToolTip = 'View different types of journals.';
                action("Fixed Assets")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Disposed Fixed Assets List")
                {
                    RunObject = Page "Disposed Fixed Assets";
                }
                action(Insurance)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action("Insurance Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
            }
            group("Funds Management")
            {
                Caption = 'Funds Management';
                Image = ReferenceData;
                ToolTip = 'Monitor your cash flow and set up cash flow forecasts.';
                action("Account Schedule Names")
                {
                    RunObject = Page "Account Schedule Names";
                }
                action("Payment Vouchers")
                {
                    RunObject = Page "Payment List";
                    RunPageView = WHERE(Status = FILTER(<> Approved));
                }
                action("Cash Vouchers")
                {
                    RunObject = Page "Cash Payment List";
                    RunPageView = WHERE(Status = FILTER(<> Approved));
                }
                action(Receipts)
                {
                    RunObject = Page "Receipt List";
                }
                action("Imprest List-Applied")
                {
                    RunObject = Page "Imprest List";
                }
                action("Imprest Surrender List")
                {
                    RunObject = Page "Imprest Surrender List";
                }
                action("Funds Transfer")
                {
                    RunObject = Page "Funds Transfer List";
                }
                action("Funds Claim")
                {
                    RunObject = Page "Funds Claim List";
                    RunPageView = WHERE(Status = FILTER(<> Posted));
                }
                action("New Fixed Deposits")
                {
                    RunObject = Page "FD Transfer Term Amount List";
                    RunPageView = WHERE("Fixed Deposit Status" = FILTER("Open "));
                }
                action("Active Fixed Deposits")
                {
                    RunObject = Page "FD Transfer Term Amount List";
                    RunPageView = WHERE("Fixed Deposit Status" = FILTER(Active));
                }
                action("Matured Fixed Deposits")
                {
                    RunObject = Page "FD Transfer Term Amount List";
                    RunPageView = WHERE("Fixed Deposit Status" = FILTER(Matured));
                }

            }
            group("Approved Funds Transactions")
            {
                Caption = 'Approved Funds Transactions';
                Image = ReferenceData;
                ToolTip = 'Approved Funds Transactions';

                action("Approved Payment Vouchers")
                {
                    RunObject = Page "Payment List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action("Approved Cash Vouchers")
                {
                    RunObject = Page "Cash Payment List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action("Approved Imprest List")
                {
                    RunObject = Page "Imprest List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action("Approved Activity Requests")
                {
                    RunObject = Page "Travel Requests";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action(" Approved Imprest Surrenders")
                {
                    RunObject = Page "Imprest Surrender List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action("Approved Funds Transfer")
                {
                    RunObject = Page "Funds Transfer List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action("Approved Funds Claim")
                {
                    RunObject = Page "Funds Claim List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }

            }
            group("Posted Documents")

            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.';

                action("Posted Payment Vouchers")
                {
                    RunObject = Page "Posted Payment List";
                }
                action("Posted Cash Vouchers")
                {
                    RunObject = Page "Posted Cash Payment List";
                }
                action("Posted Receipts")
                {
                    RunObject = Page "Posted Receipt List";
                }
                action("Posted Staff Imprest")
                {
                    RunObject = Page "Posted Imprest List";
                }
                action("Posted Staff Imprest Surrender")
                {
                    RunObject = Page "Posted Imprest Surrender List";
                }
                action("Posted Funds Transfer")
                {
                    RunObject = Page "Posted Funds Transfer List";
                }
                action("Posted Funds Claim")
                {
                    RunObject = Page "Posted Fund Claim List";
                }

                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("G/L Registers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ToolTip = 'View posted G/L entries.';
                }
            }
            group("Procurement Management")
            {
                action("Purchase Requisitions")
                {
                    Caption = 'All Purchase Requisitions';
                    RunObject = Page "Purchase Requisition List";
                }
                action("Pending Purchase Requisitions")
                {
                    Caption = 'Pending Purchase Requisitions';
                    RunObject = Page "Purchase Req.List-Pending";
                }
                action("Approved Purchase Requisitions")
                {
                    Caption = 'Approved Purchase Requisitions';
                    RunObject = Page "Approved Purchase Requisitions";
                }
                action("Closed Purchase Requisitions")
                {
                    Caption = 'Closed Purchase Requisitions';
                    RunObject = Page "Closed Purchase Req. List";
                }
                action("All Purchase Requisition Lines")
                {
                    RunObject = Page "All Purchase Requisition Lines";
                }
            }
            group("Contract management")
            {
                action("Contract Requests")
                {
                    RunObject = Page "Contract Requests";
                    Caption = 'Contract Requests';

                }
                action("All Contracts")
                {
                    RunObject = Page "Contracts";
                    Caption = 'ALL Contracts';
                }
                action("Expired Contracts")
                {
                    RunObject = Page "Expired Contracts";
                    Caption = 'Expired Contracts';
                    RunPageView = where("Contract Status" = filter(Expired));
                }
                action("Terminated Contracts")
                {
                    RunObject = Page "Expired Contracts";
                    Caption = 'Terminated Contracts';
                    RunPageView = where("Contract Status" = filter(Terminated));
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;
                ToolTip = 'Set up accounting periods, payments terms, and other core financial areas.';
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }
                action(Action86)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    RunObject = Page "Employee List";
                    ToolTip = 'Manage employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. KeeTINg up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                    Visible = false;
                }
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.';
                }
                action("Number Series")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ToolTip = 'View or edit the number series that are used to organize transactions';
                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                    Image = Payment;
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select from customer cards or sales documents to define when the customer must pay, such as within 14 days.';
                }
                action("Analysis Views")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapTINg general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouTINg shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("Bank Account Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
                action("Customer Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Posting Group';
                    RunObject = Page "Customer Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
                action("Vendor Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Posting Groups';
                    RunObject = Page "Vendor Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
                action("FA Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FA Posting Groups';
                    RunObject = Page "FA Posting Groups";
                    ToolTip = 'FA Posting Groups';
                }
            }
            group("Self-Service")
            {
                Caption = 'Self-Service';
                Image = HumanResources;
                ToolTip = 'Manage your time sheets and assignments.';
                action("Staff Imprests")
                {
                    RunObject = Page "Imprest List";
                }
                action("Staff Imprest Surrenders")
                {
                    RunObject = Page "Imprest Surrender List";
                }
                action("Purchase Requisition")
                {
                    RunObject = Page "Purchase Requisition List";
                }
                action("Store Requisition")
                {
                    RunObject = Page "Store Requisitions List";
                }
                action("Selfservice Documents")
                {
                    RunObject = Page SelfServiceDocumentList;
                }
            }

            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                action("<Action3>")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                    ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                }
            }
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                // Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }
            action("P&urchase Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&urchase Credit Memo';
                Image = CreditMemo;
                // Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase credit memo so you can manage returned items to a vendor.';
            }
        }
        area(processing)
        {
            group(Analysis)
            {
                Caption = 'Analysis';

                action("Analysis &Views")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Analysis &Views';
                    Image = AnalysisView;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Analysis by &Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by &Dimensions';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Analysis by Dimensions";
                    ToolTip = 'Analyze activities using dimensions information.';
                }
            }
            group(ActionGroup26)
            {
                Caption = 'Reports';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = "Report";
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        //Promoted = true;
                        //  PromotedCategory = "Report";
                        // PromotedIsBig = true;
                        RunObject = Codeunit "Run Acc. Sched. Balance Sheet";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        //Promoted = true;
                        // PromotedCategory = "Report";
                        // PromotedIsBig = true;
                        RunObject = Codeunit "Run Acc. Sched. Income Stmt.";
                        ToolTip = 'View a report that shows your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                        //Promoted = true;
                        // PromotedCategory = "Report";
                        // PromotedIsBig = true;
                        RunObject = Codeunit "Run Acc. Sched. CashFlow Stmt.";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                        // Promoted = true;
                        // PromotedCategory = "Report";
                        // PromotedIsBig = true;
                        RunObject = Codeunit "Run Acc. Sched. Retained Earn.";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                }
                group("Finance Reports")
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action("&G/L Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&G/L Trial Balance';
                        Image = "Report";
                        RunObject = Report "Trial Balance";
                        ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                    }
                    action("Trial Balance New")
                    {
                        Image = "Report";
                        RunObject = Report "Trial Balance New";
                    }
                    action("&Bank Detail Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Bank Detail Trial Balance';
                        Image = "Report";
                        RunObject = Report "Bank Acc. - Detail Trial Bal.";
                        ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
                    }
                    action("&Account Schedule")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Account Schedule';
                        Image = "Report";
                        RunObject = Report "Account Schedule";
                        ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
                    }
                    action("Bu&dget")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Bu&dget';
                        Image = "Report";
                        RunObject = Report Budget;
                        ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                    }
                    action("Trial Bala&nce/Budget")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Trial Bala&nce/Budget';
                        Image = "Report";
                        RunObject = Report "Trial Balance/Budget";
                        ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
                    }
                    action("Trial Balance by &Period")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance by &Period';
                        Image = "Report";
                        RunObject = Report "Trial Balance by Period";
                        ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                    }
                    action("&Fiscal Year Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Fiscal Year Balance';
                        Image = "Report";
                        RunObject = Report "Fiscal Year Balance";
                        ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
                    }
                    action("Balance Comp. - Prev. Y&ear")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Comp. - Prev. Y&ear';
                        Image = "Report";
                        RunObject = Report "Balance Comp. - Prev. Year";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
                    }
                    action("&Closing Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Closing Trial Balance';
                        Image = "Report";
                        RunObject = Report "Closing Trial Balance";
                        ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
                    }
                    action("Dimensions - Total")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Dimensions - Total';
                        Image = "Report";
                        RunObject = Report "Dimensions - Total";
                        ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
                    }
                    action("Daily Summary")
                    {
                        Caption = 'Daily Summary';
                        Image = "Report";
                        RunObject = Report "Daily Summary";
                    }
                    action("Bank Transactions Report")
                    {
                        Image = Voucher;
                        RunObject = Report "Bank Transactions Report";
                    }
                }
                // group("Payroll Reports")
                // {
                //     Caption = 'Payroll Reports';
                //     Image = "Report";
                //     action("Payroll processing List")
                //     {
                //         Caption = 'Payroll processing List';
                //         Image = Payment;
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Page "Payroll Processing List";
                //     }
                //     action("Payroll Changes Report")
                //     {
                //         Caption = 'Payroll Changes Report';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll Variance";
                //         Visible = false;
                //     }
                //     action("Company Payroll Summary")
                //     {
                //         Caption = 'Company Payroll Summary';
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Company Payroll Summary";
                //     }
                //     action("Payroll Detailed Ledger")
                //     {
                //         Caption = 'Payroll Detailed Ledger';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll Detailed Ledger";
                //         ToolTip = 'Payroll Detailed Ledger';
                //     }
                //     action("HR Employee Payroll Summary")
                //     {
                //         Caption = 'Payroll Summary';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll Summary Ledger";
                //         ToolTip = 'HR Employee Payroll Summary';
                //     }
                //     action("HR Employee  Payroll NHIF Remitance")
                //     {
                //         Caption = 'Payroll NHIF Remitance';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll NHIF Remitance";
                //         ToolTip = 'HR Employee  Payroll NHIF Remitance';
                //     }
                //     action("HR Employee Payroll NSSF Remitance")
                //     {
                //         Caption = 'Payroll NSSF Remitance';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll NSSF Remitance";
                //         ToolTip = 'HR Employee Payroll NSSF Remitance';
                //     }
                //     action("HR Employee  Payroll PAYE Remitance")
                //     {
                //         Caption = 'Payroll PAYE Remitance';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll PAYE Remitance";
                //         ToolTip = 'HR Employee  Payroll PAYE Remitance';
                //     }
                //     action("HR Employee Payroll Bank Remitance")
                //     {
                //         Caption = 'Payroll Bank Remitance';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll Bank Remitance";
                //         ToolTip = 'HR Employee Payroll Bank Remitance';
                //     }
                //     action("Employee Payroll Transactions Report.")
                //     {
                //         Caption = 'Payroll Transactions Reports';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll Transactions Reports";
                //         ToolTip = 'HR Employee Payroll Transactions Reports';
                //     }
                //     action("HR Employee PayRoll Master Report")
                //     {
                //         Caption = 'HR Employee PayRoll Master Report';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "PayRoll Master Report";
                //         ToolTip = 'HR Employee PayRoll Master Report';
                //     }
                //     action("Payroll Summary Ledger")
                //     {
                //         Caption = 'Payroll Summary Ledger';
                //         Image = "Report";
                //         Promoted = true;
                //         PromotedCategory = "Report";
                //         PromotedIsBig = true;
                //         RunObject = Report "Payroll Summary";
                //     }
                //     action(Pension)
                //     {
                //         Caption = 'Pension';
                //         Image = "Report";
                //         RunObject = Report Pension;
                //     }
                //     action("Employee P9")
                //     {
                //         Caption = 'Employee P9';
                //         Image = "Report";
                //         RunObject = Report "Employee P9";
                //     }
                //     action("Employee Gratuity")
                //     {
                //         Caption = 'Employee Gratuity';
                //         Image = "Report";
                //         RunObject = Report "Employee Gratuity";
                //     }

                // }
                group("Customers and Vendors")
                {
                    Caption = 'Customers and Vendors';
                    Image = "Report";
                    action("Aged Accounts &Receivable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts &Receivable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Receivable";
                        ToolTip = 'View an overview of when your receivables from customers are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action("Aged Accounts Pa&yable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Pa&yable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Payable";
                        ToolTip = 'View an overview of when your payables to vendors are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action("Reconcile Cus&t. and Vend. Accs")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reconcile Cus&t. and Vend. Accs';
                        Image = "Report";
                        RunObject = Report "Reconcile Cust. and Vend. Accs";
                        ToolTip = 'View if a certain general ledger account reconciles the balance on a certain date for the corresponding posting group. The report shows the accounts that are included in the reconciliation with the general ledger balance and the customer or the vendor ledger balance for each account and shows any differences between the general ledger balance and the customer or vendor ledger balance.';
                    }
                    action("Account Payable Ageing")
                    {
                        Image = "Report";
                        RunObject = Report "Account Payable Ageing";
                    }
                }
                group("Other Reports")
                {
                    Caption = 'Other Reports';
                    Image = "Report";
                    action("Withholding VAT Report")
                    {
                        Caption = 'Withholding VAT Report';
                        RunObject = Report "Withholding VAT Report";
                        // ToolTip = 'Payroll Detailed Ledger';
                    }
                    action("Withholding Tax Report")
                    {
                        Caption = 'Withholding Tax Report';
                        RunObject = Report "Withholding Tax Report";
                        // ToolTip = 'Payroll Detailed Ledger';
                    }
                    action("VAT Report Analysis Summarized")
                    {
                        Caption = 'VAT Report Analysis Summarized';
                        RunObject = Report "Office VAT Report";
                        // ToolTip = 'Payroll Detailed Ledger';
                    }
                    action("Payment Upload Template")
                    {
                        Image = Report2;
                        RunObject = Report "Payment Upload Template";
                    }
                    // action("Customer Balances Report")
                    // {
                    //     RunObject = Report "Customer Balances Report";
                    // }
                    action("Account Schedule Name")
                    {
                        RunObject = Page "Account Schedule Names";
                    }
                }
                group("Excel Reports")
                {
                    Caption = 'Excel Reports';
                    Image = Excel;
                    action(ExcelTemplatesBalanceSheet)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Balance Sheet";
                        ToolTip = 'Open a spreadsheet that shows assets, liabilities, and equity.';
                    }
                    action(ExcelTemplateIncomeStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Income Stmt.";
                        ToolTip = 'Open a spreadsheet that shows the company income and expenses.';
                    }
                    action(ExcelTemplateCashFlowStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template CashFlow Stmt.";
                        ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                    }
                    action(ExcelTemplateRetainedEarn)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Retained Earnings Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Retained Earn.";
                        ToolTip = 'Open a spreadsheet that shows changes in retained earnings based on net income from the other financial statements.';
                    }
                    // action(ExcelTemplateTrialBalance)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Trial Balance';
                    //     Image = "Report";
                    //     RunObject = Codeunit "Run Template Trial Balance";
                    //     ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                    // }
                    // action(ExcelTemplateAgedAccPay)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Aged Accounts Payable';
                    //     Image = "Report";
                    //     RunObject = Codeunit "Run Template Aged Acc. Pay.";
                    //     ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                    // }
                    // action(ExcelTemplateAgedAccRec)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Aged Accounts Receivable';
                    //     Image = "Report";
                    //     RunObject = Codeunit "Run Template Aged Acc. Rec.";
                    //     ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    // }
                    // action("Run Consolidation")
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Run Consolidation';
                    //     Ellipsis = true;
                    //     Image = ImportDatabase;
                    //     RunObject = Report "Import Consolidation from DB";
                    //     ToolTip = 'Run the Consolidation report.';
                    // }
                }
                group(Setup)
                {
                    Caption = 'Setup';
                    Image = ExecuteBatch;
                    action("Funds General Setup")
                    {
                        Image = Setup;
                        RunObject = Page "Funds General Setup";
                    }
                    action("Funds Tax Codes")
                    {
                        Image = Setup;
                        RunObject = Page "Funds Tax Codes";
                    }
                    action("Payment codes")
                    {
                        Image = Setup;
                        RunObject = Page "Payment Codes";
                    }
                    action("Service Codes")
                    {
                        Image = Setup;
                        RunObject = Page "Service Codes";
                    }
                    action("Imprest Codes")
                    {
                        Image = Setup;
                        RunObject = Page "Imprest Codes";
                    }
                    action("Payroll Posting Group")
                    {
                        Image = Setup;
                        //RunObject = Page "Payroll Posting Group";
                    }
                    action("Company Information")
                    {
                        Image = Setup;
                        RunObject = Page "Company Information";
                    }
                    action("VAT Posting Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Posting Setup';
                        Image = Setup;
                        RunObject = Page "VAT Posting Setup";
                        ToolTip = 'VAT posting setup with different rates and the accounts they should post against in the general ledger';
                    }
                    action("General &Ledger Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General &Ledger Setup';
                        Image = Setup;
                        RunObject = Page "General Ledger Setup";
                        ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                    }
                    action("&Sales && Receivables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Sales && Receivables Setup';
                        Image = Setup;
                        RunObject = Page "Sales & Receivables Setup";
                        ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    }
                    action("&Purchases && Payables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Purchases && Payables Setup';
                        Image = Setup;
                        RunObject = Page "Purchases & Payables Setup";
                        ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    }
                    action("&Fixed Asset Setup")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = '&Fixed Asset Setup';
                        Image = Setup;
                        RunObject = Page "Fixed Asset Setup";
                        ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    }
                    action("Cash Flow Setup")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Cash Flow Setup';
                        Image = CashFlowSetup;
                        RunObject = Page "Cash Flow Setup";
                        ToolTip = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.';
                        Visible = false;
                    }
                    action("Cost Accounting Setup")
                    {
                        ApplicationArea = CostAccounting;
                        Caption = 'Cost Accounting Setup';
                        Image = CostAccountingSetup;
                        RunObject = Page "Cost Accounting Setup";
                        ToolTip = 'Specify how you transfer general ledger entries to cost accounting, how you link dimensions to cost centers and cost objects, and how you handle the allocation ID and allocation document number.';
                        Visible = false;
                    }
                    action("Assisted Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Assisted Setup';
                        Image = QuestionaireSetup;
                        RunObject = Page "Assisted Setup";
                        ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                        Visible = false;
                    }
                }
            }
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }
        }
    }

    //Accountant Profile
}

