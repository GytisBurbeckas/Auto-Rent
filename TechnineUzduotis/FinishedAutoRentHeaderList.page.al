page 50114 "Finished Auto Rent Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Finished Auto Rent Header";
    Caption = 'Finished auto rents';
    CardPageId = "Finished Auto Rent Header Doc";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                }
                field("Driver License"; Rec."Driver License Image")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                }
                field("Rezervation DateTime From"; Rec."Rezervation DateTime Start")
                {
                    ApplicationArea = All;
                }
                field("Rezervation DateTime To"; Rec."Rezervation DateTime End")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Sum)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}