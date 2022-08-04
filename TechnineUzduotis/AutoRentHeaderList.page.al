page 50108 "Auto Rent Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";
    Caption = 'Auto rents';
    CardPageId = "Auto Rent Header Document";
    Editable = false;
    RefreshOnActivate = true;

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
                field(Status; Rec.Status)
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
            action(ChangeStatusToIssued)
            {
                ApplicationArea = all;
                Caption = 'Change status to issued';
                Image = Completed;

                trigger OnAction()
                var
                    RentStatusChange: Codeunit "Auto Rent Status Change";
                begin
                    RentStatusChange.Release(Rec);
                end;
            }
            action(ReturnAuto)
            {
                ApplicationArea = all;
                Caption = 'Return auto';
                Image = Return;

                trigger OnAction()
                begin
                    Rec.ReturnAuto();
                end;
            }
            action(AddAutoRentDamage)
            {
                ApplicationArea = all;
                Caption = 'Capture rent damage';
                Image = Add;
                RunObject = page "Auto Rent Damage List";
                RunPageLink = "Document No." = field("No.");
            }
            action(CreateRentReport)
            {
                ApplicationArea = all;
                Caption = 'Create rent document';
                Image = Report;
                trigger OnAction()
                begin
                    Rec.SetRecFilter();
                    Rec.FindFirst();
                    Report.RunModal(Report::"Auto Rent Report", true, true, Rec);
                    Rec.Reset();
                end;
            }
        }
    }
}