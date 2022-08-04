page 50111 "Issued Auto Rent List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";
    Caption = 'Issued auto rents';
    CardPageId = "Auto Rent Header Document";
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
            action(ReturnAuto)
            {
                ApplicationArea = all;
                Caption = 'Return auto';
                Image = Return;

                trigger OnAction()
                var
                    RentDamage: Record "Auto Rent Damage";
                    RentDamagePage: Page "Auto Rent Damage List";
                    RentNoFilter: Code[20];
                    ReturnAutoCodeunit: Codeunit "Return Auto";
                begin
                    RentNoFilter := Rec."No.";
                    RentDamage.SetRange("Document No.", RentNoFilter);
                    RentDamagePage.SetTableView(RentDamage);
                    RentDamagePage.RunModal();

                    ReturnAutoCodeunit.ReturnAuto(Rec);
                end;
            }
            action(AddAutoRentDamage)
            {
                ApplicationArea = all;
                Caption = 'Capture rental damage';
                Image = Add;
                RunObject = page "Auto Rent Damage List";
                RunPageLink = "Document No." = field("No.");
            }
            action(CreateRentReport)
            {
                ApplicationArea = all;
                Caption = 'Create rent report';
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

    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Issued);
    end;
}