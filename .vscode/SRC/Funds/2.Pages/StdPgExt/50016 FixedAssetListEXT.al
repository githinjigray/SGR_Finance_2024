pageextension 50016 "Fixed Asset List EXT" extends "Fixed Asset List"
{
    layout
    {
        addafter("FA Location Code")
        {
            field("FA Tag No."; rec."FA Tag No.")
            {
                ApplicationArea = all;
            }

            field("Book Value"; rec."Book Value")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = all;
            }
            field("FA Status"; rec."FA Status")
            {
                ApplicationArea = all;
            }
            field("FA Status Comment"; rec."FA Status Comment")
            {
                ApplicationArea = all;
            }
            field("User ID"; rec."User ID")
            {
                ApplicationArea = all;
            }
        }
    }
}
