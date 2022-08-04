page 50105 "Auto Reservation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    Caption = 'Auto reservations';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                }
                field("Reservation DateTime Start"; Rec."Reservation DateTime Start")
                {
                    ApplicationArea = All;
                }
                field("Reservation DateTime End"; Rec."Reservation DateTime End")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}