page 50115 "Finished Auto Rent Header Doc"
{
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Finished Auto Rent Header";
    Caption = 'Finished auto rents';
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = false;

                Caption = 'Rent data';
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
            part("Auto rent Line ListPart"; "Finished Auto Rent Line LPart")
            {
                SubPageLink = "Document No." = FIELD("No.");
                Editable = false;
            }
        }

        area(factboxes)
        {
            part("Driver License Image"; "Finished Driver License Image")
            {
                Caption = 'Driver license image';
                SubPageLink = "No." = FIELD("No.");
                Editable = false;
            }
        }
    }
}

