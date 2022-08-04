page 50101 "Auto Model List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Model";
    Caption = 'Auto models';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Mark Code"; Rec."Mark Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}