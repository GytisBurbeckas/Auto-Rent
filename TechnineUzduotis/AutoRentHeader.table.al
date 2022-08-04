table 50106 "Auto Rent Header"
{
    DataClassification = CustomerContent;
    Caption = 'Auto rents';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;
        }
        field(20; "Client No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Client No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CheckBlocked();
                CheckDebt();
                CheckReservation();
            end;
        }
        field(30; "Driver License Image"; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Driver license';
        }
        field(40; "Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(50; "Auto No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Auto No.';
            TableRelation = Auto;

            trigger OnValidate()
            begin
                CheckReservation();
                Rec.Modify();
                CreateFirstLine();
            end;
        }
        field(60; "Rezervation DateTime Start"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Reserved from date time';
            trigger OnValidate()
            begin
                CheckReservation();
            end;
        }
        field(70; "Rezervation DateTime End"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Reserved until date time';

            trigger OnValidate()
            begin
                CheckReservation();
            end;
        }
        field(80; "Sum"; Decimal)
        {
            Caption = 'Sum';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Auto Rent Line".Sum where("Document No." = field("No.")));
        }
        field(90; "Status"; Enum "Auto Rent Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            AutoSetup.Get();
            AutoSetup.TestField("Rent Card Nos");
            "No." := NoSeriesManagement.GetNextNo(AutoSetup."Rent Card Nos", WorkDate(), true);
        end;
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::Open);
    end;

    local procedure CheckDebt()
    var
        CustomerLedgerEntryRecord: Record "Cust. Ledger Entry";
        CustomerDeptError: Label 'This client has debts.';
        CustomerAmountSum: Decimal;
    begin
        CustomerLedgerEntryRecord.Reset();
        CustomerLedgerEntryRecord.SetRange("Customer No.", Rec."Client No.");

        if (CustomerLedgerEntryRecord.FindSet()) then
            repeat
                CustomerLedgerEntryRecord.CalcFields(Amount);
                CustomerAmountSum += CustomerLedgerEntryRecord.Amount;
            until CustomerLedgerEntryRecord.Next() = 0;

        if (CustomerAmountSum > 0) then begin
            Error(CustomerDeptError);
        end;

    end;

    trigger OnDelete()
    begin
        DeleteLine();
    end;

    local procedure CheckBlocked()
    var
        CustomerRecord: Record Customer;
        CustomerBlockedEnum: Enum "Customer Blocked";
        CustomerBlockedError: Label 'This client is blocked.';
    begin
        CustomerRecord.Get(Rec."Client No.");
        CustomerRecord.TestField("No.");
        if (CustomerRecord.Blocked = CustomerBlockedEnum::" ") then begin
            exit;
        end else begin
            Error(CustomerBlockedError);
        end;
    end;

    local procedure CheckReservation()
    var
        AutoReservationRecord: Record "Auto Reservation";
        ReservationEqualsError: Label 'The reservation details do not match.';
    begin

        if ("Rezervation DateTime Start" = 0DT) or ("Rezervation DateTime End" = 0DT) then begin
            exit;
        end;

        AutoReservationRecord.Reset();
        AutoReservationRecord.SetRange("Reservation DateTime Start", Rec."Rezervation DateTime Start");
        AutoReservationRecord.SetRange("Reservation DateTime End", Rec."Rezervation DateTime End");
        AutoReservationRecord.SetRange("Auto No.", Rec."Auto No.");
        AutoReservationRecord.SetRange("Client No.", Rec."Client No.");

        if (not AutoReservationRecord.FindFirst()) then begin
            Error(ReservationEqualsError);
        end;
    end;

    local procedure CreateFirstLine()
    var
        ResourceRecord: Record Resource;
        AutoRentLineRecord: Record "Auto Rent Line";
        NewAutoRentLineRecord: Record "Auto Rent Line";
        AutoRecord: Record Auto;
    begin

        NewAutoRentLineRecord.Init();
        NewAutoRentLineRecord."Document No." := Rec."No.";
        NewAutoRentLineRecord."Line No." := 1;
        NewAutoRentLineRecord.Type := NewAutoRentLineRecord.Type::Resource;

        if (AutoRecord.Get("Auto No.")) then
            NewAutoRentLineRecord."No." := AutoRecord."Rent Service";

        NewAutoRentLineRecord.Amount := 1;
        NewAutoRentLineRecord.GetDescription();
        NewAutoRentLineRecord.GetPrice();

        NewAutoRentLineRecord.SetRange("Document No.", "No.");
        NewAutoRentLineRecord.SetRange("Line No.", 1);

        AutoRentLineRecord.SetRange("Document No.", "No.");
        AutoRentLineRecord.SetRange("Line No.", 1);

        if (NewAutoRentLineRecord.IsEmpty) then begin
            NewAutoRentLineRecord.Insert(true);
            NewAutoRentLineRecord.FindFirst();
            NewAutoRentLineRecord.CalculateSum();
            NewAutoRentLineRecord.Modify();
        end else begin
            AutoRentLineRecord.FindFirst();
            AutoRentLineRecord.TransferFields(NewAutoRentLineRecord);
            AutoRentLineRecord.CalculateSum();
            AutoRentLineRecord.Modify();
        end;
    end;

    local procedure DeleteLine()
    var
        AutoRentLineRecord: Record "Auto Rent Line";
    begin
        AutoRentLineRecord.Reset();
        AutoRentLineRecord.SetRange("Document No.", "No.");
        if (AutoRentLineRecord.FindSet()) then begin
            AutoRentLineRecord.DeleteAll();
        end;
    end;

    procedure ReturnAuto()
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