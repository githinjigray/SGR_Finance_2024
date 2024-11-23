page 70041 "Pre-Qualification Application"
{
    CardPageID = "Pre-Qualified App. Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Prequlification Application";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Document No. field';
                    Editable = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Supplier Name field';
                }
                field("Procurement Period"; rec."Procurement Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Procurement Period field';
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Vendor No. field';
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the E-mail field';
                }
                field(Prequalified; Rec.Prequalified)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the prequalified field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status field';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Phone No. field';
                }
                field("TIN No."; Rec."TIN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the TIN No. field';
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Postal Address field';
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Postal Code field';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city field';
                }
                field("Building Name"; Rec."Building Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Building Name field';
                }
                field(Street; Rec.Street)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Street field';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the County field';
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the County Name field';
                }
                field(AGPO; Rec.AGPO)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AGPO field';
                }
                field("AGPO Number"; Rec."AGPO Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AGPO No. field';
                }
                field("Incorporation Cert. No."; Rec."Incorporation Cert. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Incorporation Cert. No. field';
                }
                field("Incorporation Date"; Rec."Incorporation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Incorporation Date field';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Code field';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Name field';
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Branch Code field';
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Branch Name field';
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Account Name field';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bank Account No. field';
                }
                field("VAT Registered"; Rec."VAT Registered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT Registred field';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT Registration No. field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Approval Entries-Modified";
                RunPageLink = "Document No." = FIELD("Document No.");
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                begin
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Store Requisition Header","No.");
                end;
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("Supplier Categories")
            {
                Image = CalculateConsumption;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Supplier Category";
                RunPageLink = "Document Number" = FIELD("Supplier Name");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if rec.Prequalified = true then
            CurrPage.Editable(false);
    end;
}

