page 50106 "Valid Reservation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    Caption = 'Valid reservations';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
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

    trigger OnOpenPage()
    var
        FilterText: text;
    begin
        FilterText := Format(CurrentDateTime, 0, 0) + '..';
        Rec.SetFilter("Reservation DateTime Start", FilterText);
    end;
}