table 50109 "Finished Auto Rent Header"
{
    DataClassification = CustomerContent;

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
            Editable = false;
        }
        field(30; "Driver License Image"; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Driver license';
            Editable = false;
        }
        field(40; "Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
            Editable = false;
        }
        field(50; "Auto No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Auto No.';
            Editable = false;
        }
        field(60; "Rezervation DateTime Start"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Reserved from date';
            Editable = false;
        }
        field(70; "Rezervation DateTime End"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Reserved until date';
            Editable = false;
        }

        field(80; "Sum"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sum';
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
    trigger OnDelete()
    begin
        DeleteLine();
    end;

    local procedure DeleteLine()
    var
        FinishedAutoRentLineRecord: Record "Finished Auto Rent Line";
    begin
        FinishedAutoRentLineRecord.Reset();
        FinishedAutoRentLineRecord.SetRange("Document No.", "No.");
        if (FinishedAutoRentLineRecord.FindSet()) then begin
            FinishedAutoRentLineRecord.DeleteAll();
        end;
    end;

}