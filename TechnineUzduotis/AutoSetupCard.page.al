page 50102 "Auto Setup"
{
    Caption = 'Auto setup';
    PageType = Card;
    SourceTable = "Auto Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Auto setup data';
                field("Auto Nos"; Rec."Auto Nos")
                {
                    ApplicationArea = All;
                }
                field("Rent Card Nos"; Rec."Rent Card Nos")
                {
                    ApplicationArea = All;
                }
                field("Accessories place"; Rec."Accessories place")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertNotExists();
    end;
}