tableextension 50002 "Customers Ext" extends Customer
{
    fields
    {
        field(70000; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70001; PasswordResetToken; Text[250])
        {
            Caption = 'PasswordResetToken';
            DataClassification = ToBeClassified;
        }
        field(70002; PasswordResetTokenExpiry; DateTime)
        {
            Caption = 'PasswordResetTokenExpiry';
            DataClassification = ToBeClassified;
        }
        field(70003; "Portal Password"; Text[250])
        {
            Caption = 'Portal Password';
            DataClassification = ToBeClassified;
        }
        field(70004; "Default Portal Password"; Boolean)
        {
            Caption = 'Default Portal Password';
            DataClassification = ToBeClassified;
        }
        field(70005; "Old Account No."; Code[30])
        {
            Caption = 'Old Account No.';
            DataClassification = ToBeClassified;
        }
        field(70006; "Company Registration No."; Code[20])
        {
            Caption = 'Company Registration No.';
            DataClassification = ToBeClassified;
        }
        field(70007; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = ,Corporate,Retail,Employee;
            OptionCaption = ' ,Corporate,Retail,Employee';
        }
        field(70008; "Application No."; Code[30])
        {
            Caption = 'Application No.';
            DataClassification = ToBeClassified;
        }
        field(70020; "County Code"; Code[20])
        {
            Caption = 'County Code';
            DataClassification = ToBeClassified;
        }
        field(70021; "County Name"; Text[100])
        {
            Caption = 'County Name';
            DataClassification = ToBeClassified;
        }
        field(70022; "SubCounty Code"; Code[20])
        {
            Caption = 'SubCounty Code';
            DataClassification = ToBeClassified;
        }
        field(70023; "SubCounty Name"; Text[100])
        {
            Caption = 'SubCounty Name';
            DataClassification = ToBeClassified;
        }
        field(70024; "Customer Registration No."; Code[20])
        {
            Caption = 'Customer Registration No.';
            DataClassification = ToBeClassified;
        }
        field(70025; "TIN No."; Code[50])
        {
            Caption = 'TIN No.';
            DataClassification = ToBeClassified;
        }
        field(70028; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70030; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70031; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70032; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70033; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70034; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
        field(70035; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value"."code" where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
        }
    }
}
