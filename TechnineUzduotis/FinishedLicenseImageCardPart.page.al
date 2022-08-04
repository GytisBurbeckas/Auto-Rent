page 50118 "Finished Driver License Image"
{
    Caption = 'Driver license image';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Finished Auto Rent Header";

    layout
    {
        area(content)
        {
            field(Image; Rec."Driver License Image")
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }
}

