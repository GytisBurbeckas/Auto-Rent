page 50104 "Auto Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Auto";
    Caption = 'Auto card';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'Auto data';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Manufacture Year"; Rec."Manufacture Year")
                {
                    ApplicationArea = All;
                }
                field("Civil Insurance End"; Rec."Civil Insurance End")
                {
                    ApplicationArea = All;
                }
                field("Technical Inspection End"; Rec."Technical Inspection End")
                {
                    ApplicationArea = All;
                }
                field("Place Code"; Rec."Place Code")
                {
                    ApplicationArea = All;
                }
                field("Rent Service"; Rec."Rent Service")
                {
                    ApplicationArea = All;
                }
                field("Rent Price"; "Rent Price")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenAutoReservations)
            {
                ApplicationArea = All;
                Caption = 'Open reservations';
                Image = ReservationLedger;
                RunPageMode = View;
                RunObject = page "Auto Reservation List";
                RunPageLink = "Auto No." = field("No.");
            }

            action(OpenAutoDamage)
            {
                ApplicationArea = All;
                Caption = 'Open damage';
                Image = GoTo;
                RunPageMode = View;
                RunObject = page "Auto Damage List";
                RunPageLink = "Auto No." = field("No.");
            }
            action(CreateRentHistoryReport)
            {
                ApplicationArea = All;
                Caption = 'Create rent history report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    FinishedRentRecord: Record "Finished Auto Rent Header";
                begin
                    FinishedRentRecord.Reset();
                    FinishedRentRecord.SetRange("Auto No.", Rec."No.");
                    Report.RunModal(Report::"Auto Rent History Report", true, true, FinishedRentRecord);
                    FinishedRentRecord.Reset();
                end;
            }
        }
    }
}