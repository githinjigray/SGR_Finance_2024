page 70049 "Procurement Role Center"
{
    Caption = 'Procurement Role Center', Comment = '{Dependency=Match,"ProfileDescription_PURCHASINGAGENT"}';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Approvals; "Team Member Activities")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                }
                part(Control1907662708; "Purchase Agent Activities")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control45; "Report Inbox Part")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = Basic, Suite;
                }
                systempart(Control43; MyNotes)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("General Reports")
            {
                Caption = 'General Reports';
                Image = "Report";
                group("Procurement Reports")
                {
                    Caption = 'Procurement Reports';
                    Image = "Report";
                    action("Purchase Reqsitions-Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Reqsitions-Report';
                        Image = "Report";
                        RunObject = Report "Purchase Reqsitions-Report";
                        ToolTip = 'Purchase Reqsitions-Report';
                    }
                    action("RFQ - Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'RFQ - Report';
                        Image = "Report";
                        RunObject = Report "RFQ - Report";
                        ToolTip = 'RFQ - Report';
                    }
                    action("Bid Analysis - Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bid Analysis - Report';
                        Image = "Report";
                        RunObject = Report "Bid Analysis - Report";
                        ToolTip = 'Bid Analysis - Report';
                    }
                    action("LPO - Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'LPO - Report';
                        Image = "Report";
                        RunObject = Report "LPO - Report";
                        ToolTip = 'LPO - Reports-Report';
                    }
                }
            }
            action("Vendor - T&op 10 List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor - T&op 10 List';
                Image = "Report";
                //RunObject = Report "Top __ Vendor List";
                ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
            }
            action(Action5)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor - T&op 10 List';
                Image = "Report";
                // RunObject = Report "Top __ Vendor List";
                ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
            }
            action("Vendor/&Item Purchases")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor/&Item Purchases';
                Image = "Report";
                //RunObject = Report "Purchase Order Status";
                ToolTip = 'View a list of item entries for each vendor in a selected period.';
            }
            separator(Separator28)
            {
            }
            action("Inventory - &Availability Plan")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory - &Availability Plan';
                Image = ItemAvailability;
                RunObject = Report "Inventory - Availability Plan";
                ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
            }
            action("Inventory &Purchase Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory &Purchase Orders';
                Image = "Report";
                RunObject = Report "Inventory - Reorders";
                ToolTip = 'View a list of items on order from vendors. The report also shows the expected receipt date and the quantity and amount on back orders. The report can be used, for example, to see when items should be received and whether a reminder of a back order should be issued.';
            }
            action("Inventory - &Vendor Purchases")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory - &Vendor Purchases';
                Image = "Report";
                RunObject = Report "Inventory - Reorders";
                ToolTip = 'View a list of the vendors that your company has purchased items from within a selected period. It shows invoiced quantity, amount and discount. The report can be used to analyze a company''s item purchases.';
            }
            action("Inventory Valuation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory Valuation';
                Image = "Report";
                RunObject = Report "Inventory Valuation";
                ToolTip = 'View Inventory Valuation';
            }
        }
        area(embedding)
        {
            action(PurchaseOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                RunPageView = where(Archive = filter(false));
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Confirmation';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(released),
                                    Receive = FILTER(true),
                                    "Completely Received" = FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action(Action76)
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Quotes';
                RunObject = Page "Purchase Quotes";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action(Action82)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Return Orders")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase Return Orders';
                RunObject = Page "Purchase Return Order List";
                ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action("Purchase Credit Memos")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memos';
                RunObject = Page "Purchase Credit Memos";
                ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
        }
        area(sections)
        {
            group("Purchasing & Planning")
            {
                Caption = 'Purchasing & Planning';
                Image = CashFlow;
                action("Items List")
                {
                    Caption = 'Item List';
                    RunObject = Page "Item List";
                }
                action("Vendor List")
                {
                    Caption = 'Vendor List';
                    RunObject = Page "Vendor List";
                }
                action("Services List")
                {
                    Caption = 'Services List';
                    RunObject = Page "Purchase Requisition Codes";
                }
                action("Fixed Assets List")
                {
                    Caption = 'Fixed Asset List';
                    RunObject = Page "Fixed Asset List";
                }
                // action("Disposed Fixed Assets List")
                // {
                //     Caption = 'Disposed Fixed Asset List';
                //     RunObject = Page "Disposed Fixed Assets";
                // }
                action("Pre-Qualification Application")
                {
                    Caption = 'Pre-Qualification Application';
                    RunObject = Page "Pre-Qualification Application";
                }
                action("Pre-Qualified Suppliers")
                {
                    Caption = 'Pre-Qualified Suppliers';
                    RunObject = Page "Pre-Qualified Suppliers";
                }
                action("Procurement Planning")
                {
                    Caption = 'Procurement Planning';
                    RunObject = Page "Procurement Planning List";
                }
                action("Procurement Email Messages")
                {
                    Caption = 'Procurement Email Messages';
                    RunObject = Page "Procurement Email Messages";
                }
            }
            group("Purchase Requisition")
            {
                Caption = 'Purchase Requisitions';
                Image = CashFlow;
                action("Purchase Requisitions")
                {
                    Caption = 'Purchase Requisitions';
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
                action("Assigned Purchase Requisitions")
                {
                    Caption = 'Assigned Purchase Requisitions';
                    RunObject = Page "Assigned Purchase Requisitions";
                }
                action("Closed Requisitions")
                {
                    Caption = 'Closed Purchase Requisitions';
                    RunObject = Page "Closed Purchase Req. List";
                }
            }
            group("RFQ, Bid Analysis & Tenders")
            {
                Caption = 'RFQ, Bid Analysis & Tenders';
                Image = CashFlow;
                action("Request for Quotations")
                {
                    RunObject = Page "Request for Quotation List";
                    RunPageView = WHERE(Status = FILTER(<> Closed));
                }
                action("Bid Analysis List")
                {
                    Caption = 'Bid Analysis List';
                    RunObject = Page "Bid Analysis List";
                }
            }
            group("Quotes, Invoices & Orders")
            {
                Caption = 'Quotes, Invoices & Orders';
                Image = CashFlow;
                action("Purchase Quotes")
                {
                    RunObject = Page "Purchase Quotes";
                }
                action("Purchase Orders")
                {
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE("Document Type" = CONST(Order), Status = filter(<> Released));
                }
                action("Approved Purchase Orders")
                {
                    RunObject = Page "Approved Purchase Orders";
                    RunPageView = where(Archive = filter(false));
                }
                action("Archived Purchase Orders")
                {
                    RunObject = Page "Archived Purchase Orders";
                }
                action("Purchase Invoices")
                {
                    RunObject = Page "Purchase Invoices";
                }
                action("Transfer Orders")
                {
                    Caption = 'Transfer Orders';
                    RunObject = Page "Transfer Orders";
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("All Purchase Requisition Lines")
                {
                    RunObject = Page "All Purchase Requisition Lines";
                }
                action("Closed Purchase Requisitions")
                {
                    Caption = 'Closed Purchase Requisitions';
                    RunObject = Page "Closed Purchase Req. List";
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Closed Request for Quotations")
                {
                    RunObject = Page "Request for Quotation List";
                    RunPageView = WHERE(Status = CONST(Closed));
                }
                action("Closed Bid Analysis List")
                {
                    RunObject = Page "Released Bid Analysis List";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Open the list of posted return shipments.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Store Requisitions")
                {
                    RunObject = Page "Posted Store Requisitions List";
                }
                action(Action20)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Posted Store Requisitions ';
                    RunObject = Page "Posted Store Requisitions List";
                    ToolTip = 'Open the list of posted store requisitions';
                }
                action("Purchase Order Archives")
                {
                    Caption = 'Posted Purchase Order';
                    RunObject = Page "Purchase Order Archives";
                }
                action("Posted Transfer Receipts")
                {
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page "Posted Transfer Receipt";
                }
                action("Posted Transfer Shipments")
                {
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page "Posted Transfer Shipments";
                }
            }
            group("Contract Management")
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
        }
        area(creation)
        {
            action("Request for Quotation")
            {
                Caption = 'Request for Quotation';
                RunObject = Page "Request for Quotation List";
            }
            action(Action12)
            {
                Caption = 'Purchase Requisition';
                RunObject = Page "Purchase Requisition List";
            }
            action("Bid Analysis")
            {
                Caption = 'Bid Analysis';
                RunObject = Page "Bid Analysis List";
            }
            action("Purchase &Quote")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Quote';
                Image = Quote;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote, for example to reflect a request for quote.';
            }
            action("Purchase &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase &Invoice';
                Image = NewPurchaseInvoice;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase invoice.';
            }
            action("Purchase &Order")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Order';
                Image = Document;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase Credit Memo")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase Credit Memo';
                Image = ReturnOrder;
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase return order to return received items.';
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Closed Requisition Lines")
            {
                Image = ReceivablesPayables;
                RunObject = Page "All Purchase Requisition Lines";
                RunPageView = WHERE(Closed = CONST(true));
            }
            action("Procurement Periods")
            {
                Caption = 'Procurement Periods';
                RunObject = Page "Procurement Periods";
                ToolTip = 'Procurement Periods';
            }
            action("Upload Items")
            {
                Caption = 'Upload Items';
                RunObject = xmlport "Item Upload";
                ToolTip = 'Upload Items';
            }

            action("Upload Prequalified Suppliers")
            {
                Caption = 'Upload Prequalified Suppliers';
                RunObject = xmlport "Prequalified Vendors Upload";
                ToolTip = 'Upload Prequalified Suppliers';
            }
            action("Upload Vendors")
            {
                Caption = 'Upload Vendors';
                RunObject = xmlport "Vendors Upload";
                ToolTip = 'Upload Vendors';
            }
            action("Upload items 2")
            {
                Caption = 'Upload items 2';
                RunObject = xmlport "Item 2 Upload";
                ToolTip = 'Upload Dimension Values';
            }
            action("Dummy upload")
            {
                Caption = 'Upload transactions';
                RunObject = xmlport "FA Upload";
                ToolTip = 'Upload transactions';
            }
            action("Item &Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page "Item Journal";
                ToolTip = 'Adjust the physical quantity of items on inventory.';
            }
            action("Phys. Inventory Journal ")
            {
                Image = Journals;
                RunObject = Page "Phys. Inventory Journal";
            }
            separator(Separator38)
            {
            }
            action("Pur&chase Prices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pur&chase Prices';
                Image = Price;
                //RunObject = Page "Purchase Prices";
                ToolTip = 'View or set up different prices for items that you buy from the vendor. An item price is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
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

