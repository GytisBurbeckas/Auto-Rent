page 50100 "Auto Mark List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Mark";
    Caption = 'Auto marks';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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

    actions
    {
        area(Processing)
        {
            action(OpenModels)
            {
                ApplicationArea = All;
                Caption = 'Open models';
                Image = GoTo;
                RunPageMode = View;
                RunObject = page "Auto Model List";
                RunPageLink = "Mark Code" = field("Code");
            }
        }
    }
}