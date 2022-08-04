table 50104 "Auto Reservation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            DataClassification = CustomerContent;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(20; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }

        field(30; "Reservation DateTime Start"; DateTime)
        {
            Caption = 'Reserved from date time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckDates();
                CheckReservationDates();
            end;
        }
        field(40; "Reservation DateTime End"; DateTime)
        {
            Caption = 'Reserved until date time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckDates();
                CheckReservationDates();
            end;
        }
    }

    keys
    {
        key(Key1; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
        Rec.TestField("Auto No.");
        Rec.TestField("Line No.");
    end;

    local procedure CheckDates()
    var
        DateTimeEror: Label '%1 (%3) must be yearlier than %2 (%4).';
    begin
        if ("Reservation DateTime Start" = 0DT) or ("Reservation DateTime End" = 0DT) then
            exit;

        if "Reservation DateTime Start" > "Reservation DateTime End" then begin
            Error(DateTimeEror,
            FieldCaption("Reservation DateTime Start"),
            FieldCaption("Reservation DateTime End"),
            "Reservation DateTime Start",
            "Reservation DateTime End");
        end;
    end;

    local procedure CheckReservationDates()
    var
        ReservationError: Label 'This reservation time is taken (Line No. - %2)';
        AutoReservationRecord: Record "Auto Reservation";
        ShowReservationError: Boolean;
    begin
        if ("Reservation DateTime Start" = 0DT) or ("Reservation DateTime End" = 0DT) then
            exit;

        if AutoReservationRecord.FindSet() then
            repeat
                ShowReservationError := false;

                if (AutoReservationRecord."Auto No." = "Auto No.") and (AutoReservationRecord."Line No." <> "Line No.") then begin

                    if ("Reservation DateTime Start" < AutoReservationRecord."Reservation DateTime Start")
                    and ("Reservation DateTime End" > AutoReservationRecord."Reservation DateTime Start") then begin
                        ShowReservationError := true;
                    end;

                    if ("Reservation DateTime Start" < AutoReservationRecord."Reservation DateTime End")
                   and ("Reservation DateTime End" > AutoReservationRecord."Reservation DateTime End") then begin
                        ShowReservationError := true;
                    end;

                    if ("Reservation DateTime Start" > AutoReservationRecord."Reservation DateTime Start")
                   and ("Reservation DateTime End" < AutoReservationRecord."Reservation DateTime End") then begin
                        ShowReservationError := true;
                    end;

                    if ("Reservation DateTime Start" < AutoReservationRecord."Reservation DateTime Start")
                   and ("Reservation DateTime End" > AutoReservationRecord."Reservation DateTime End") then begin
                        ShowReservationError := true;
                    end;

                    if ("Reservation DateTime Start" = AutoReservationRecord."Reservation DateTime Start")
                    or ("Reservation DateTime End" = AutoReservationRecord."Reservation DateTime End") then begin
                        ShowReservationError := true;
                    end;

                    if (ShowReservationError = true) then begin
                        Error(ReservationError, "Auto No.", AutoReservationRecord."Line No.");
                    end;
                end;
            until AutoReservationRecord.Next() = 0;
    end;
}