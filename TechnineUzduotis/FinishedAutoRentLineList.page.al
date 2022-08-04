page 50117 "Finished Auto Rent Line List"
{
    PageType = List;
    SourceTable = "Finished Auto Rent Line";
    Caption = 'Finished auto rent services, items';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Sum; Rec.Sum)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
}