table 50103 "Auto"
{
    DataClassification = CustomerContent;
    Caption = 'Autos';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(20; Mark; Code[20])
        {
            Caption = 'Mark';
            DataClassification = CustomerContent;
            TableRelation = "Auto Mark";
        }
        field(30; Model; Code[20])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
            TableRelation = "Auto Model".Code where("Mark Code" = field(Mark));
        }
        field(40; "Manufacture Year"; Integer)
        {
            Caption = 'Manufacture year';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                YearError: Label 'Wrong year input (%1). Maximum year value - %2';
            begin
                if "Manufacture Year" > Date2DMY(Today, 3) then begin
                    Error(YearError, "Manufacture Year", Date2DMY(Today, 3));
                end;
            end;
        }
        field(50; "Civil Insurance End"; Date)
        {
            Caption = 'Civil insurance validity to';
            DataClassification = CustomerContent;
        }
        field(60; "Technical Inspection End"; Date)
        {
            Caption = 'TI validity to';
            DataClassification = CustomerContent;
        }
        field(70; "Place Code"; Code[10])
        {
            Caption = 'Place code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(80; "Rent Service"; Code[20])
        {
            Caption = 'Rent service';
            DataClassification = CustomerContent;
            TableRelation = Resource;

            trigger OnValidate()
            begin
                CalcFields(Rec."Rent Price");
            end;
        }
        field(90; "Rent Price"; Decimal)
        {
            Caption = 'Rent price';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("Rent Service")));
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
            AutoSetup.TestField("Auto Nos");
            "No." := NoSeriesManagement.GetNextNo(AutoSetup."Auto Nos", WorkDate(), true);
        end;
    end;
}