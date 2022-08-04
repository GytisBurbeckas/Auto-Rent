table 50108 "Auto Rent Damage"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(20; "Date"; Date)
        {

            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(30; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        CheckAutoHeaderStatus();
    end;

    trigger OnModify()
    begin
        CheckAutoHeaderStatus();
        TestField(Rec."Line No.");
    end;

    local procedure CheckAutoHeaderStatus()
    var
        AutoRentHeaderRecord: Record "Auto Rent Header";
        StatusError: Label 'Add or edit is not possible because rent status is not Issued.';
    begin
        AutoRentHeaderRecord.Get("Document No.");
        AutoRentHeaderRecord.TestField("No.");
        TestField("Document No.", AutoRentHeaderRecord."No.");

        If (AutoRentHeaderRecord.Status <> AutoRentHeaderRecord.Status::Issued) then begin
            Error(StatusError);
        end;
    end;


}