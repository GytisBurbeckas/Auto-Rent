table 50102 "Auto Setup"
{
    Caption = 'Auto Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "Auto Nos"; Code[20])
        {
            Caption = 'Auto number series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(20; "Rent Card Nos"; Code[20])
        {
            Caption = 'Rent card series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(30; "Accessories place"; Code[10])
        {
            Caption = 'Accessories place';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    trigger OnInsert()
    begin
        InitDefaultValues();
    end;

    procedure InsertNotExists()
    var
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    local procedure InitDefaultValues()
    begin
    end;
}