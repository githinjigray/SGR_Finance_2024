page 70045 "Pre-Qualified Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Prequalified Suppliers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
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
                    Editable = false;
                }
                field(Prequalified; Rec.Prequalified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Prequalified field';
                }
            }
            group(Communication)
            {
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the E-Mail field';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Phone No. field';
                }
                field("Principal Phone No."; Rec."Principal Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Principal Phone No. field';
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
            }
            group("Company Details")
            {
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
                field("VAT Registered"; REc."VAT Registered")
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
                RunPageLink = "Document Number" = FIELD("Document No.");
            }
            action("Supplier Required Documents")
            {
                Image = CalculateConsumption;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Vendor Required Documents";
                RunPageLink = code = field("Document No.");
            }
            action("Vendor Regions of Operations")
            {
                Image = CalculateConsumption;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Vendor Regions of Operation";
                RunPageLink = "Document No." = FIELD("Document No.");
            }
            action("Create Vendor Card")
            {
                Image = ChangeCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.TestField("Vendor No.", '');
                    if Confirm(Txt0001) then begin
                        PrequalifiedSuppliers.Reset;
                        PrequalifiedSuppliers.SetRange(PrequalifiedSuppliers."VAT Registration No.", Rec."TIN No.");
                        if PrequalifiedSuppliers.FindFirst then
                            Error(Txt_003);

                        PurchasesPayablesSetup.Get;
                        VendorNo := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Vendor Nos.", 0D, true);

                        VendorList.Init;
                        VendorList."No." := VendorNo;
                        VendorList.Validate(VendorList."No.");
                        VendorList.Name := Rec."Supplier Name";
                        VendorList."VAT Registration No." := Rec."TIN No.";
                        VendorList."E-Mail" := Rec."E-Mail";
                        VendorList."Phone No." := Rec."Phone No.";
                        VendorList."Principal Phone No." := Rec."Principal Phone No.";
                        VendorList."Primary Contact No." := Rec."Principal Phone No.";
                        VendorList.Address := Rec."Postal Address";
                        VendorList.Name := Rec."Supplier Name";
                        VendorList."Vendor Posting Group" := 'TRADE';
                        VendorList."Gen. Bus. Posting Group" := 'GENERAL';
                        if VendorList.Insert then begin
                            Rec."Vendor No." := VendorNo;
                            if Rec.Modify then begin
                                SupplierCategory2.Reset;
                                SupplierCategory2.SetRange(SupplierCategory2."Document Number", Rec."Supplier Name");
                                if SupplierCategory2.FindSet then begin
                                    repeat
                                        SupplierCategory.Init;
                                        SupplierCategory."Document Number" := VendorNo;
                                        SupplierCategory."Supplier Category" := SupplierCategory2."Supplier Category";
                                        SupplierCategory."Category Description" := SupplierCategory2."Category Description";
                                        SupplierCategory.Insert
                                    until SupplierCategory2.Next = 0;
                                end;
                            end;
                        end;
                        Message(Txt0002);
                    end;
                end;
            }
        }
    }

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Txt0001: Label 'Are you sure you want to Create the supplier?';
        ProcurementManagement: Codeunit "Procurement Management";
        PrequalifiedSuppliers: Record Vendor;
        VendorList: Record Vendor;
        VendorNo: Code[20];
        NoSeriesMgt: Codeunit "No. Series";
        Txt_003: Label 'Supplier Already Exists in the vendor list';
        Txt0002: Label 'Vendor Created Successfully!';
        SupplierCategory: Record "Supplier Category";
        SupplierCategory2: Record "Supplier Category";

    local procedure GetMandatoryFields()
    begin
        rec.TestField("Supplier Name");
        rec.TestField("Supplier Category");
        rec.TestField(AGPO);
        rec.TestField("Bank Account No.");
        rec.TestField("Bank Account Name");
        rec.TestField(City);
        rec.TestField(County);
        rec.TestField("TIN No.");
        rec.TestField(AGPO);
        rec.TestField("Incorporation Cert. No.");
        rec.TestField("Incorporation Date");
        rec.TestField("VAT Registered");
    end;
}

