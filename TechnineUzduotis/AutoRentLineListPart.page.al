page 50112 "Auto Rent Line ListPart"
{
    AutoSplitKey = true;
    Caption = 'Rent services, items';
    PageType = ListPart;
    SourceTable = "Auto Rent Line";

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
                    NotBlank = true;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = all;
                }
                field(Sum; Rec.Sum)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}