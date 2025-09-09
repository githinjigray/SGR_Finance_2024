table 50049 "FD Processing1"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                IF "Document No." <> xRec."Document No." THEN BEGIN

                    FundsManage.GET;
                    NoSeriesMgt.TestManual(FundsManage."FD Account Nos.");
                    "Fixed Deposit Nos" := '';
                END;
            end;
        }
        field(2; Name; Text[70])
        {
            Caption = 'Name';
            Editable = false;

            trigger OnValidate()
            begin
                //IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
                //"Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Code[70])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';


            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnValidate()
            begin
                // IF RMSetup.GET THEN
                //   IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN
                //     IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                //       MODIFY;
                //       UpdateContFromVend.OnModify(Rec);
                //       UpdateContFromVend.InsertNewContactPerson(Rec,FALSE);
                //       MODIFY(TRUE);
                //     END
            end;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                CurrExchRate: Record "Currency Exchange Rate";
            begin

                "Currency Factor" := 0;
                TESTFIELD("Document No.");
                TESTFIELD("Fixed Deposit Start Date");
                IF "Currency Code" <> '' THEN BEGIN
                    "Currency Factor" := CurrExchRate.ExchangeRate("Fixed Deposit Start Date", "Currency Code");
                    Validate("Currency Factor");
                END;
            END;
        }
        field(14; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                Text002: Label 'cannot be specified without %1';
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                Validate("FD Amount");

            end;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(68001; "Personal No."; Code[20])
        {
            Editable = false;
        }
        field(68002; "Reference No."; Code[50])
        {

        }
        field(68007; "Fixed Deposit Status"; Option)
        {
            OptionCaption = 'Open ,Active,Matured,Closed,Not Matured';
            OptionMembers = "Open ",Active,Matured,Closed,"Not Matured";
        }
        field(68008; "Call Deposit"; Boolean)
        {

            trigger OnValidate()
            begin
                // IF AccountTypes.GET("Account Type") THEN BEGIN
                // IF AccountTypes."Fixed Deposit" = FALSE THEN
                // ERROR('Call deposit only applicable for Fixed Deposits.');
                // END;
                // IF "Call Deposit"=FALSE THEN
                //   ObjGroup:=TRUE;
            end;
        }
        field(68009; "Mobile Phone No"; Code[30])
        {

            trigger OnValidate()
            begin

                /*Vend.RESET;
                Vend.SETRANGE(Vend."Personal No.","Personal No.");
                IF Vend.FIND('-') THEN
                Vend.MODIFYALL(Vend."Mobile Phone No","Mobile Phone No");*/

                /*Cust.RESET;
                Cust.SETRANGE(Cust."Staff No","Staff No");
                IF Cust.FIND('-') THEN
                Cust.MODIFYALL(Cust."Mobile Phone No","Mobile Phone No");*/

            end;
        }
        field(68012; "BOSA Account No"; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                /*ObjMembReg.RESET;
                ObjMembReg.SETRANGE(ObjMembReg."No.","BOSA Account No");
                IF ObjMembReg.FIND('-') THEN BEGIN
                  "Transaction Date":=ObjMembReg.Name;
                  "Savings Account No.":=ObjMembReg."FOSA Account No.";
                  "ID No.":=ObjMembReg."ID No.";
                  "Personal No.":=ObjMembReg."Personal No";
                  "Mobile Phone No":=ObjMembReg."Phone No.";
                  ObjMembReg.MODIFY;
                  END;
                  */

            end;
        }
        field(68013; Signature; BLOB)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(68015; "Employer Code"; Code[20])
        {
        }
        field(68016; Status; Option)
        {
            OptionCaption = 'New,Open,Pending Approval,Rejected,Cancelled,Approved,Closed';
            OptionMembers = New,Open,"Pending Approval",Rejected,Cancelled,Approved,Closed;

            trigger OnValidate()
            begin
                // IF (Status = Status::Active) OR (Status = Status::New) THEN
                // Blocked:=Blocked::" "
                // ELSE
                // Blocked:=Blocked::All
            end;
        }
        field(68017; "Account Type"; Code[20])
        {

            trigger OnValidate()
            begin
                // IF AccountTypes.GET("Account Type") THEN BEGIN
                // AccountTypes.TESTFIELD(AccountTypes."Posting Group");
                // "Vendor Posting Group":=AccountTypes."Posting Group";
                // "Call Deposit" := FALSE;
                // END;
            end;
        }
        field(68018; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department,Staff';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff;
        }
        field(68019; "FD Marked for Closure"; Boolean)
        {
        }
        field(68027; "Expected Maturity Date"; Date)
        {
        }
        field(68032; "E-Mail (Personal)"; Text[20])
        {
        }
        field(68041; "Fixed Deposit Type"; Code[20])
        {
            TableRelation = "Fixed Deposit Type1".Code;

            trigger OnValidate()
            begin
                "FD Maturity Date" := CALCDATE("Fixed Duration", "Fixed Deposit Start Date");

                IF "Account Type" = 'FIXED' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc.Duration, "Fixed Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("FD Amount" * "Interest rate" / 100) / 365) * FDDuration, 0.01, '=');

                    END;
                END;
            end;
        }
        field(68042; "Interest Earned"; Decimal)
        {
            CalcFormula = Sum("Interest Buffer1"."Interest Amount" WHERE("Document No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043; "Untranfered Interest"; Decimal)
        {
            CalcFormula = Sum("Interest Buffer1"."Interest Amount" WHERE("Document No." = FIELD("Document No."), Transferred = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "FD Maturity Date"; Date)
        {

            trigger OnValidate()
            begin
                /*"FD Duration":="FD Maturity Date"-"Registration Date";
                 "FD Duration":=ROUND("FD Duration"/30,1);
                MODIFY;
                */

            end;
        }
        field(68045; "Savings Account No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                Vend.RESET;
                Vend.SETRANGE(Vend."No.", "Savings Account No.");
                IF Vend.FIND('-') THEN BEGIN
                    Vend.CALCFIELDS(Vend.Balance, Vend."Balance (LCY)");
                    Name := Vend.Name;
                    /*  "BOSA Account No":=Vend."BOSA Account No";
                      "Personal No.":=Vend."Personal No.";
                      "ID No.":="ID No.";
                      "Mobile Phone No":="Mobile Phone No";*/
                    "Current Account Balance" := Vend.Balance;
                    "Global Dimension 2 Code" := Vend."Global Dimension 2 Code";
                END;

            end;
        }
        field(68048; "FD Amount"; Decimal)
        {

            trigger OnValidate()
            var
                CurrExchRate: Record "Currency Exchange Rate";
            begin
                TestField("Interest rate");

                "Expected Interest On Term Dep" := ROUND((("FD Amount" * "Interest rate" / 100) / 365) * FDDuration, 0.01, '=');

                IF "Currency Code" <> '' THEN BEGIN
                    "FD Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Fixed Deposit Start Date", "Currency Code", "FD Amount", "Currency Factor"));
                    "Expected Int. On Term Dep(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Fixed Deposit Start Date", "Currency Code", "Expected Interest On Term Dep", "Currency Factor"));
                END ELSE BEGIN
                    "FD Amount(LCY)" := "FD Amount";
                    "Expected Int. On Term Dep(LCY)" := "Expected Interest On Term Dep";
                END;
            end;
        }
        field(68049; "FD Amount(LCY)"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            begin


            end;
        }
        field(68055; "Fixed Duration"; DateFormula)
        {

            trigger OnValidate()
            begin
                "FD Maturity Date" := CALCDATE("Fixed Duration", "Fixed Deposit Start Date");

                FDDuration := ("FD Maturity Date" - "Fixed Deposit Start Date");
                "Expected Interest On Term Dep" := ROUND(((("FD Amount" * "Interest rate" / 100) / 365) * FDDuration), 0.01, '=');

            end;
        }
        field(68067; "Neg. Interest Rate"; Decimal)
        {
        }
        field(68068; "Date Renewed"; Date)
        {
        }
        field(68069; "Last Interest Date"; Date)
        {
            CalcFormula = Max("Interest Buffer1"."Interest Date" WHERE("Document No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(68070; "Don't Transfer to Savings"; Boolean)
        {
        }
        field(68073; "S-Mobile No"; Code[20])
        {
        }
        field(69009; "FD Duration"; Integer)
        {

            trigger OnValidate()
            begin

                TESTFIELD("FD Type");

                IF "Account Type" = 'FIXED' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("FD Amount" * interestCalc."Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;

                IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."On Call Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*interestCalc."On Call Interest Rate"/100)/12)*interestCalc."No of Months",1);
                    END;
                END;
            end;
        }
        field(69037; "Transfer Amount to Savings"; Decimal)
        {
        }
        field(69040; "Interest rate"; Decimal)
        {
        }
        field(69042; "FDR Deposit Status Type"; Option)
        {
            Editable = false;
            OptionCaption = 'New,Running,Terminated';
            OptionMembers = New,Running,Terminated;
        }
        field(69153; "On Term Deposit Maturity"; Option)
        {
            OptionCaption = 'Pay to Current_ Principle+Interest,Roll Over Principle+Interest,Roll Over Principle Only ';
            OptionMembers = "Pay to Current_ Principle+Interest","Roll Over Principle+Interest","Roll Over Principle Only ";
        }
        field(69179; "Expected Interest On Term Dep"; Decimal)
        {
        }
        field(69180; "Expected Int. On Term Dep(LCY)"; Decimal)
        {

            Caption = 'Expected Interest On Term Dep(LCY)';
        }
        field(69188; "Fixed Deposit Start Date"; Date)
        {
        }
        field(69189; "Prevous Fixed Deposit Type"; Code[20])
        {
        }
        field(69190; "Prevous FD Start Date"; Date)
        {
        }
        field(69191; "Prevous Fixed Duration"; DateFormula)
        {
        }
        field(69192; "Prevous Expected Int On FD"; Decimal)
        {
        }
        field(69193; "Prevous FD Maturity Date"; Date)
        {
        }
        field(69194; "Prevous FD Deposit Status Type"; Option)
        {
            OptionMembers = Matured;
        }
        field(69195; "Prevous Interest Rate FD"; Decimal)
        {
        }
        field(69196; "Last Interest Earned Date"; Date)
        {
            CalcFormula = Max("Interest Buffer1"."Interest Date" WHERE("Document No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(69197; "Fixed Deposit Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(69198; "FD Account"; Code[50])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                Vend.RESET;
                Vend.SETRANGE(Vend."No.", "FD Account");
                IF Vend.FIND('-') THEN BEGIN
                    Vend.CALCFIELDS(Vend.Balance, Vend."Balance (LCY)");
                    "FD Account Name" := Vend.Name;
                END;

            end;
        }
        field(69199; "User ID"; Code[70])
        {
            Editable = false;
        }
        field(69200; "Application Date"; Date)
        {
            Editable = false;
        }
        field(69201; "Current Account Balance"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("Savings Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69202; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(69203; Posted; Boolean)
        {
            Editable = false;
        }
        field(69204; "FD Account Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69205; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(69206; "FD Account Balance"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("FD Account")));
            FieldClass = FlowField;
        }
        field(69207; "FD Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fixed Deposit,Call Deposit';
            OptionMembers = " ","Fixed Deposit","Call Deposit";
        }
        field(69208; "Call Deposit Interest Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69209; "FD W/Tax Rate"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Funds Tax Code"."Tax Code" WHERE(Type = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Document No." = '' THEN BEGIN
            FundsManage.GET;
            FundsManage.TESTFIELD(FundsManage."FD Account Nos.");
            NoSeriesMgt.GetNextNo(FundsManage."FD Account Nos.", Today, false);
        END;
    end;



    procedure AssistEdit(OldVend: Record Vendor): Boolean
    var
        Vend: Record Vendor;
    begin
        // WITH Vend DO BEGIN
        //   Vend := Rec;
        //   ObjFDProcessing.GET;
        //   ObjFDProcessing.TESTFIELD("Fixed Deposit Nos");
        //   IF NoSeriesMgt.SelectSeries(ObjFDProcessing."Fixed Deposit Nos",OldVend."Fixed Deposit Nos","Fixed Deposit Nos") THEN BEGIN
        //     ObjFDProcessing.GET;
        //    ObjFDProcessing.TESTFIELD("Fixed Deposit Nos");
        //     NoSeriesMgt.SetSeries("Fixed Deposit Nos");
        //     Rec := Vend;
        //     EXIT(TRUE);
        //   END;
        // END;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        // DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        // DimMgt.SaveDefaultDim(DATABASE::Vendor,"No.",FieldNumber,ShortcutDimCode);
        // MODIFY;
    end;

    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        // IF "No." = '' THEN
        //   EXIT;
        //
        // ContBusRel.SETCURRENTKEY("Link to Table","No.");
        // ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
        // ContBusRel.SETRANGE("No.","No.");
        // IF NOT ContBusRel.FINDFIRST THEN BEGIN
        //   IF NOT CONFIRM(Text003,FALSE,TABLECAPTION,"No.") THEN
        //     EXIT;
        //   UpdateContFromVend.InsertNewContact(Rec,FALSE);
        //   ContBusRel.FINDFIRST;
        // END;
        // COMMIT;
        //
        // Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
        // Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
        // PAGE.RUN(PAGE::"Contact List",Cont);
    end;

    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;

    // procedure CheckBlockedVendOnDocs(Vend2: Record Vendor;Transaction: Boolean)
    // begin
    //     IF Vend2.Blocked = Vend2.Blocked::All THEN
    //       VendBlockedErrorMessage(Vend2,Transaction);
    // end; 
    var
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PurchOrderLine: Record "Purchase Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit "No. Series";
        InsertFromContact: Boolean;
        FDType: Record "Fixed Deposit Type1";
        ReplCharge: Decimal;
        Vends: Record Vendor;
        gnljnlLine: Record "Gen. Journal Line";
        FOSAAccount: Record Vendor;
        Member: Record Customer;
        Vend: Record "Bank Account";
        interestCalc: Record "FD Interest Calculation Crit1";
        GenSetUp: Record "Funds General Setup";
        FDDuration: Integer;
        ObjVendor: Record Vendor;
        ObjFDProcessing: Record "FD Processing1";
        // ObjSaccoSetup: Record Table52136982;
        ObjMembReg: Record Customer;
        FundsManage: Record "Funds General Setup";

}

