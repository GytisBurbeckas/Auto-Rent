page 50116 "Finished Auto Rent Line LPart"
{
    AutoSplitKey = true;
    Caption = 'Rent services, items';
    PageType = ListPart;
    SourceTable = "Finished Auto Rent Line";
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