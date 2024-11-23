page 70044 "Pre-Qualified Suppliers"
{
    CardPageID = "Pre-Qualified Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Prequalified Suppliers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Supplier Name field';
                }
                field("Procurement Period"; Rec."Procurement Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Procurement Period field';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Vendor No. field';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Email field';
                }
                field(Prequalified; Rec.Prequalified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Prequalified field';
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
                    ToolTip = 'Specifies the City field';
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
                field("Contact Person"; rec."Contact Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Contact Person field';
                }
                field(AGPO; Rec.AGPO)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AGPO Status field';
                }
                field("AGPO Number"; Rec."AGPO Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AGPO No. field';
                }
                field("Incorporation Cert. No."; Rec."Incorporation Cert. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Incorporation No. field';
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
                    ToolTip = 'Specifies the VAT Registred status field';
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
            action("Supplier Details - Categories")
            {
                Caption = 'Supplier Details - Categories';
                Image = Report2;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Supplier Details - Categories";
            }
        }
    }
}

