tableextension 70610 "HR Employee F" extends Employee
{
    // fields
    // {
    //     field(70000; "Probation Period"; DateFormula)
    //     {
    //         Caption = 'Probation Period';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin
    //             if Format("Probation Period") = ' ' then begin
    //                 "Probation End date" := 0D
    //             end else begin
    //                 TestField("Probation Start Date");
    //                 "Probation End date" := (CalcDate("Probation Period", "Probation Start Date") - 1);
    //             end;
    //         end;
    //     }
    //     field(70001; "Marital Status"; Option)
    //     {

    //         Caption = 'Marital Status';
    //         DataClassification = ToBeClassified;
    //         OptionMembers = " ",Married,Single,Widow;
    //         OptionCaption = ',Married,Single,Widow';
    //     }
    //     field(70002; "Birth Certificate No."; Code[20])
    //     {
    //         Caption = 'Birth Certificate No.';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70003; "National ID No."; Code[20])
    //     {
    //         Caption = 'National ID No.';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin
    //             Employee.RESET;
    //             Employee.SETRANGE(Employee."National ID No.", "National ID No.");
    //             Employee.SETRANGE(Employee.Status, Employee.Status::Active);
    //             IF Employee.FINDFIRST THEN BEGIN
    //                 if (Employee."Emplymt. Contract Code" = "Emplymt. Contract Code") and (Employee."No." <> "No.") then
    //                     ERROR(ErrorUsedIDNumber, Employee."No.");
    //             end;

    //         end;

    //     }
    //     field(70004; "PIN No."; Code[20])
    //     {
    //         Caption = 'PIN No.';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin

    //             Employee.RESET;
    //             Employee.SETRANGE(Employee."PIN No.", "PIN No.");
    //             Employee.SETRANGE(Employee.Status, Employee.Status::Active);
    //             IF Employee.FINDFIRST THEN BEGIN
    //                 ERROR(ErrorUsedKRAPINNumber, Employee."No.");
    //             end;

    //         end;
    //     }
    //     field(70005; "NSSF No."; Code[20])
    //     {
    //         Caption = 'NSSF No.';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin

    //             Employee.RESET;
    //             Employee.SETRANGE(Employee."NSSF No.", "NSSF No.");
    //             Employee.SETRANGE(Employee.Status, Employee.Status::Active);
    //             IF Employee.FINDFIRST THEN BEGIN
    //                 if Employee."Emplymt. Contract Code" = "Emplymt. Contract Code" then
    //                     ERROR(ErrorUsedNSSFNumber, Employee."No.");
    //             end;
    //         end;
    //     }
    //     field(70006; "NHIF No."; Code[20])
    //     {
    //         Caption = 'NHIF No.';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin
    //             Employee.RESET;
    //             Employee.SETRANGE(Employee."NHIF No.", "NHIF No.");
    //             Employee.SETRANGE(Employee.Status, Employee.Status::Active);
    //             IF Employee.FINDFIRST THEN BEGIN
    //                 if Employee."Emplymt. Contract Code" = "Emplymt. Contract Code" then
    //                     ERROR(ErrorUsedNHIFNumber, Employee."No.");
    //             end;
    //         end;
    //     }
    //     field(70007; "Passport No."; Code[20])
    //     {
    //         Caption = 'Passport No.';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin
    //             Employee.RESET;
    //             Employee.SETRANGE(Employee."Passport No.", "Passport No.");
    //             Employee.SETRANGE(Employee.Status, Employee.Status::Active);
    //             IF Employee.FINDFIRST THEN BEGIN
    //                 if Employee."Emplymt. Contract Code" = "Emplymt. Contract Code" then
    //                     ERROR(ErrorUsedPassportNumber, Employee."No.");
    //             end;
    //         end;
    //     }
    //     field(70008; "Driving Licence No."; Code[20])
    //     {
    //         Caption = 'Driving Licence No.';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70009; "Job No."; Code[20])
    //     {
    //         Caption = 'Job No.';
    //         DataClassification = ToBeClassified;
    //         //TableRelation = "HR Jobs"."No.";
    //         trigger OnValidate()
    //         begin

    //             "Supervisor Job No." := '';
    //             "HR Job Title" := '';
    //             "Job Grade" := '';
    //             "Supervisor Job Title" := '';

    //             // HRJobs.Reset();
    //             // HRJobs.SetRange(HRJobs."No.", "Job No.");
    //             // If HRJobs.FindFirst then begin
    //             //     "HR Job Title" := HRJobs."Job Title";
    //             //     "Job Grade" := HRJobs."Job Grade";
    //             //     "Supervisor Job No." := HRJobs."Supervisor Job No.";
    //             //     HRJobs.Validate("Supervisor Job No.");
    //             //end;
    //         end;
    //     }
    //     field(70010; "HR Job Title"; Code[60])
    //     {
    //         Caption = 'HR Job Title';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70011; "Job Grade"; Code[50])
    //     {
    //         Caption = 'Job Grade';
    //         DataClassification = ToBeClassified;
    //         //TableRelation = "HR Job Lookup Value".Code where(Option = const("Job Grade"));

    //     }
    //     field(70012; "Bank Code"; Code[20])
    //     {
    //         Caption = 'Bank Code';
    //         DataClassification = ToBeClassified;
    //         TableRelation = "Bank Code"."Bank Code";
    //         trigger OnValidate()
    //         begin
    //             "Bank Name" := '';
    //             BankCodes.RESET;
    //             BankCodes.SETRANGE(BankCodes."Bank Code", "Bank Code");
    //             IF BankCodes.FINDFIRST THEN BEGIN
    //                 BankCodes.TESTFIELD(BankCodes."Bank Name");
    //                 "Bank Name" := BankCodes."Bank Name";
    //             END;
    //         end;
    //     }
    //     field(70013; "Bank Name"; Text[100])
    //     {
    //         Caption = 'Bank Name';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //     }
    //     field(70014; "Bank Branch Code"; Code[20])
    //     {
    //         Caption = 'Bank Branch Code';
    //         DataClassification = ToBeClassified;
    //         TableRelation = "Bank Branch"."Bank Branch Code";
    //         trigger OnValidate()
    //         begin
    //             "Bank Branch Name" := '';
    //             BankBranches.RESET;
    //             BankBranches.SETRANGE(BankBranches."Bank Code", "Bank Code");
    //             BankBranches.SETRANGE(BankBranches."Bank Branch Code", "Bank Branch Code");
    //             IF BankBranches.FINDFIRST THEN BEGIN
    //                 BankBranches.TESTFIELD(BankBranches."Bank Branch Name");
    //                 "Bank Branch Name" := BankBranches."Bank Branch Name";
    //             END;
    //         end;
    //     }
    //     field(70015; "Bank Branch Name"; Text[100])
    //     {
    //         Caption = 'Bank Branch Name';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //     }
    //     field(70016; Citizenship; Code[50])
    //     {
    //         Caption = 'Citizenship';
    //         DataClassification = ToBeClassified;
    //         // TableRelation = "HR Lookup Values".Code where(Option = const(Nationality));
    //     }
    //     field(70017; Religion; Code[50])
    //     {
    //         Caption = 'Religion';
    //         DataClassification = ToBeClassified;
    //         //  TableRelation = "HR Lookup Values".Code where(Option = const(Religion));
    //     }
    //     field(70018; "County Code"; Code[10])
    //     {
    //         Caption = 'County Code';
    //         DataClassification = ToBeClassified;
    //         //TableRelation = County.Code;
    //         trigger OnValidate()
    //         begin
    //             // "County Name" := '';
    //             // IF Counties.GET("County Code") THEN
    //             //     "County Name" := Counties.Name;
    //         end;
    //     }
    //     field(70019; "County Name"; Text[100])
    //     {
    //         Caption = 'County Name';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //     }
    //     field(70020; "SubCounty Code"; Code[50])
    //     {
    //         Caption = 'SubCounty Code';
    //         DataClassification = ToBeClassified;
    //         //TableRelation = "Sub-County"."Sub-County Code";
    //         trigger OnValidate()
    //         begin
    //             "SubCounty Name" := '';

    //             // SubCounties.RESET;
    //             // SubCounties.SETRANGE("Sub-County Code", "SubCounty Code");
    //             // IF SubCounties.FINDFIRST THEN
    //             //     "SubCounty Name" := SubCounties."Sub-County Name";

    //         end;
    //     }
    //     field(70021; "SubCounty Name"; Text[100])
    //     {
    //         Caption = 'SubCounty Name';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //     }
    //     field(70022; "Leave Status"; Option)
    //     {
    //         Caption = 'Leave Status';
    //         DataClassification = ToBeClassified;
    //         OptionMembers = " ","On Leave";
    //         OptionCaption = ',On Leave';
    //     }
    //     field(70023; "Portal Password"; Text[250])
    //     {
    //         Caption = 'Portal Password';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70024; "Default Portal Password"; Boolean)
    //     {
    //         Caption = 'Default Portal Password';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70025; "Employement Date"; Date)
    //     {
    //         Caption = 'Employement Date';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin
    //             // "Employement Years of Service" := dates.DetermineAge("Employement Date", Today);

    //         end;
    //     }
    //     field(70026; "Contract Expiry Date"; Date)
    //     {
    //         Caption = 'Contract Expiry Date';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //     }
    //     field(70027; "Employee Signature"; Media)
    //     {
    //         Caption = 'Employee Signature';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70028; "User ID"; Code[50])
    //     {
    //         Caption = 'User ID';
    //         DataClassification = ToBeClassified;
    //         TableRelation = "User Setup";
    //     }
    //     field(70029; "Imprest Posting Group"; Code[50])
    //     {
    //         Caption = 'Imprest Posting Group';
    //         DataClassification = ToBeClassified;
    //         TableRelation = "Employee Posting Group";
    //     }
    //     field(70030; Department; Code[50])
    //     {
    //         Caption = 'Department';
    //         //TableRelation = Departments.Code;
    //         DataClassification = ToBeClassified;

    //     }
    //     field(70031; Location; Code[50])
    //     {
    //         Caption = 'Location';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70032; "Retirement Age"; DateFormula)
    //     {
    //         Caption = 'Retirement Age';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin
    //             "Retirement Date" := (CALCDATE("Retirement Age", "Birth Date"));

    //         end;
    //     }
    //     field(70033; "Retirement Date"; Date)
    //     {
    //         Caption = 'Retirement Date';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //     }
    //     field(70034; "Employee Reporting date"; Date)
    //     {
    //         Caption = 'Employee Reporting Date';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70035; "Shortcut Dimension 3 Code"; Code[20])
    //     {
    //         Caption = 'Shortcut Dimension 3 Code';
    //         TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
    //         DataClassification = ToBeClassified;
    //         CaptionClass = '1,2,3';
    //     }
    //     field(70036; "Shortcut Dimension 4 Code"; Code[20])
    //     {
    //         Caption = 'Shortcut Dimension 4 Code';
    //         TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
    //         DataClassification = ToBeClassified;
    //         CaptionClass = '1,2,4';
    //     }
    //     field(70037; "Shortcut Dimension 5 Code"; Code[20])
    //     {
    //         Caption = 'Shortcut Dimension 5 Code';
    //         TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
    //         DataClassification = ToBeClassified;
    //         CaptionClass = '1,2,5';
    //     }
    //     field(70038; "Shortcut Dimension 6 Code"; Code[20])
    //     {
    //         Caption = 'Shortcut Dimension 6 Code';
    //         TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
    //         DataClassification = ToBeClassified;
    //         CaptionClass = '1,2,6';
    //     }
    //     field(70039; "Shortcut Dimension 7 Code"; Code[20])
    //     {
    //         Caption = 'Shortcut Dimension 7 Code';
    //         TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
    //         DataClassification = ToBeClassified;
    //         CaptionClass = '1,2,7';
    //     }
    //     field(70040; "Shortcut Dimension 8 Code"; Code[20])
    //     {
    //         Caption = 'Shortcut Dimension 8 Code';
    //         TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
    //         DataClassification = ToBeClassified;
    //         CaptionClass = '1,2,8';
    //     }
    //     field(70041; "Responsibility Center"; Code[20])
    //     {
    //         Caption = 'Responsibility Center';
    //         DataClassification = ToBeClassified;
    //         TableRelation = "Responsibility Center";
    //     }
    //     field(70042; "Annual Leave Group"; Code[50])
    //     {
    //         Caption = 'Annual Leave Group';
    //         DataClassification = ToBeClassified;
    //         // TableRelation = "HR Leave Types".Code;
    //     }
    //     field(70043; "Leave Calendar"; Code[10])
    //     {
    //         Caption = 'Leave Calendar';
    //         DataClassification = ToBeClassified;
    //         TableRelation = "Base Calendar";

    //     }
    //     field(70044; "Supervisor Job Title"; Code[50])
    //     {
    //         Caption = 'Supervisor Job Title';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70045; "Supervisor Job No."; Code[20])
    //     {
    //         Caption = 'Supervisor Job No.';
    //         DataClassification = ToBeClassified;
    //         //  TableRelation = "HR Jobs"."No.";
    //         trigger OnValidate()
    //         begin
    //             // HRJobs.Reset();
    //             // HRJobs.SetRange(HRJobs."No.", "Supervisor Job No.");
    //             // if HRJobs.FindFirst then begin
    //             //     "Supervisor Job Title" := HRJobs."Job Title";

    //             // end;
    //         end;
    //     }
    //     // field(70046; "Appraisal Level"; Enum "Appraisal Levels")
    //     // {
    //     //     Caption = 'Appraisal Level';
    //     //     DataClassification = ToBeClassified;

    //     // }
    //     field(70047; "Person Living with Disability"; Option)
    //     {
    //         Caption = 'Person Living with Disability';
    //         DataClassification = ToBeClassified;
    //         OptionMembers = No,Yes;
    //         OptionCaption = 'No,Yes';
    //     }
    //     field(70048; "Type of Disability"; Text[150])
    //     {
    //         Caption = 'Type of Disability';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70049; "HR Salary Notch"; Code[20])
    //     {
    //         Caption = 'HR Salary Notch';
    //         DataClassification = ToBeClassified;
    //         //  TableRelation = "HR Grade Levels"."Job Grade Level" WHERE("Job Grade" = FIELD("Job Grade"));
    //     }
    //     field(70050; "Huduma No."; Code[20])
    //     {
    //         Caption = 'Huduma No.';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70051; "Ethnic Group"; Code[20])
    //     {
    //         Caption = 'Ethnic Group';
    //         DataClassification = ToBeClassified;
    //         //  TableRelation = "HR Lookup Values".Code where(Option = const(Ethnicity));
    //     }
    //     field(70052; "On Probation"; Boolean)
    //     {
    //         Caption = 'On Probation';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70053; "Contract Start Date"; Date)
    //     {
    //         Caption = 'Contract Start Date';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70054; "Probation Start Date"; Date)
    //     {
    //         Caption = 'Probation Start Date';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70055; "Probation End date"; Date)
    //     {
    //         Caption = 'Probation End date';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //     }
    //     field(70056; PasswordResetToken; Text[250])
    //     {
    //         Caption = 'PasswordResetToken';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70057; PasswordResetTokenExpiry; DateTime)
    //     {
    //         Caption = 'PasswordResetTokenExpiry';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70058; "Employment Anniversary Date"; Date)
    //     {
    //         Caption = 'Employment Anniversary Date';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70059; "Employement Years of Service"; Text[50])

    //     {
    //         Caption = 'Employement Years of Service';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70060; Age; Text[50])
    //     {
    //         Caption = 'Age';
    //         DataClassification = ToBeClassified;
    //         Editable = false;
    //         trigger OnValidate()
    //         begin

    //             // Age := Dates.DetermineAge("Birth Date", TODAY);
    //         end;
    //     }
    //     field(70061; "Total Leave Taken"; Decimal)
    //     {
    //         Caption = 'Total Leave Taken';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70062; "Leave Balance"; Decimal)
    //     {
    //         Caption = 'Leave Balance';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70063; "Leave Period Filter"; Code[20])
    //     {
    //         Caption = 'Leave Period Filter';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70064; "Allocated Leave Days"; Decimal)
    //     {
    //         Caption = 'Allocated Leave Days';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70065; "Reason For Leaving (Other)"; Text[150])
    //     {
    //         Caption = 'Reason For Leaving (Other)';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70066; "Date of Leaving"; Date)
    //     {
    //         Caption = 'Date of Leaving';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70067; "Contract Period"; DateFormula)
    //     {
    //         Caption = 'Contract Period';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin
    //             if Format("Contract Period") = '' then begin
    //                 "Contract Expiry Date" := 0D
    //             end else begin
    //                 TestField("Contract Start Date");
    //                 "Contract Expiry Date" := (CalcDate("Contract Period", "Contract Start Date") - 1);
    //             end;
    //         end;
    //     }
    //     field(70068; "Driving License Expiry Date"; Date)
    //     {
    //         Caption = 'Driving License Expiry Date';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70069; "Payroll Group Code"; Code[50])
    //     {
    //         Caption = 'Payroll Group Code';
    //         DataClassification = ToBeClassified;
    //     }
    //     field(70070; "Employment Status"; Option)
    //     {
    //         DataClassification = ToBeClassified;
    //         OptionMembers = Active,Inactive,Terminated;
    //         OptionCaption = 'Active,Inactive,Terminated';
    //         Editable = false;
    //     }
    //     field(70071; "Employment Active Date"; Date)
    //     {
    //         Caption = 'Employment Active Date';
    //         DataClassification = ToBeClassified;
    //     }

    //     field(70072; "Professional License No."; Code[20])
    //     {
    //         Caption = 'Professional License No.';
    //         DataClassification = ToBeClassified;

    //     }
    //     field(70073; "Prof License Exipiry Date"; Date)
    //     {
    //         Caption = 'Professional License Expiry Date';
    //         DataClassification = ToBeClassified;

    //     }
    //     field(70074; "Full Name"; Text[150])
    //     {
    //         Caption = 'Full Name';
    //         DataClassification = ToBeClassified;
    //         trigger OnValidate()
    //         begin

    //             "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
    //         end;

    //     }
    //     field(70075; "M-PESA No."; Text[30])
    //     {
    //         Caption = 'M-PESA Phone No.';
    //         DataClassification = ToBeClassified;
    //         ExtendedDatatype = PhoneNo;
    //     }
    //     field(70076; "Secondary No."; code[50])
    //     {
    //         Caption = 'Employee Secondary No.';
    //         DataClassification = ToBeClassified;

    //     }
    //     field(70077; "Created By"; code[50])
    //     {
    //         Caption = 'Created By';
    //         DataClassification = ToBeClassified;
    //         Editable = false;

    //     }
    //     field(70078; "Document Date"; Date)
    //     {
    //         Caption = 'Document Date';
    //         DataClassification = ToBeClassified;
    //         Editable = false;

    //     }
    //     field(70079; "Timesheet Group Code"; Code[50])
    //     {
    //         Caption = 'Timesheet Group Code';
    //         DataClassification = ToBeClassified;
    //         //TableRelation = "Payroll Group".Code;
    //     }

    //     field(70080; "Alternative Phone No."; Text[30])

    //     {
    //         Caption = 'Alternative Phone No.';
    //         DataClassification = ToBeClassified;
    //         ExtendedDatatype = PhoneNo;

    //     }


    // }
    // keys
    // {
    //     key(PK; "User ID")
    //     {

    //     }
    // }
    // var
    //     HRSetup: Record "Human Resources Setup";
    //     //NoSeriesMgt: Codeunit NoSeriesManagement;
    //     // Counties: Record County;
    //     //SubCounties: Record "Sub-County";
    //     // Dates: Codeunit Dates;
    //     PostCode: Record "Post Code";
    //     BankCodes: Record "Bank Code";
    //     BankBranches: Record "Bank Branch";
    //     // HRJobs: Record "HR Jobs";
    //     Employee: Record Employee;
    //     ErrorUsedIDNumber: TextConst ENU = 'The ID Number has been used for Employee No:%1, Please deactivate the Employee No:%1 to Enable you to use it!';
    //     ErrorUsedPassportNumber: TextConst ENU = 'The Passport Number has been used for Employee No:%1, Please deactivate the Employee No:%1 to Enable you to use it!';
    //     ErrorUsedNHIFNumber: TextConst ENU = 'The NHIF Number has been used for Employee No:%1, Please deactivate the Employee No:%1 to Enable you to use it!';
    //     ErrorUsedNSSFNumber: TextConst ENU = 'The NSSF Number has been used for Employee No:%1, Please deactivate the Employee No:%1 to Enable you to use it!';
    //     ErrorUsedKRAPINNumber: TextConst ENU = 'The KRA PIN Number has been used for Employee No:%1, Please deactivate the Employee No:%1 to Enable you to use it!';

    // trigger OnInsert()
    // begin

    //     "Created By" := UserId;
    //     "Document Date" := Today;

    // end;

}
