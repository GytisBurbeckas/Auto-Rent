table 50107 "Auto Rent Line"
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
        field(20; "Type"; Enum "Auto Rent Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(30; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

            TableRelation =
                if ("Type" = const(Item)) Item where("Item Category Code" = filter('RENT'))
            else
            if ("Type" = const(Resource)) Resource where("Resource Group No." = filter('RENT'));

            trigger OnValidate()
            var
            begin
                GetDescription();
                GetPrice();
                CalculateSum();
                CheckFirstLine();
            end;
        }
        field(40; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(50; "Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';

            trigger OnValidate()
            var
            begin
                CalculateSum();
                CheckFirstLine();
            end;
        }
        field(60; "Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Price';
            Editable = false;
        }
        field(70; "Sum"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sum';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        CheckStatus();
        CheckAutoNo();
    end;

    trigger OnModify()
    var
    begin
        CheckStatus();
        CheckAutoNo();
        CheckFirstLine();
    end;

    trigger OnDelete()
    var
    begin
        CheckStatus();
        CheckFirstLine();
    end;

    trigger OnRename()
    begin
    end;

    procedure GetDescription()
    var
        ItemRecord: Record Item;
        ResourcesRecord: Record Resource;
    begin
        if (Rec.Type = Type::Item) then begin
            ItemRecord.Get("No.");
            Rec.Description := ItemRecord.Description;
        end else begin
            ResourcesRecord.Get("No.");
            Rec.Description := ResourcesRecord.Name;
        end;
    end;

    procedure GetPrice()
    var
        ItemRecord: Record Item;
        ResourcesRecord: Record Resource;
    begin
        if (Rec.Type = Type::Item) then begin
            ItemRecord.Get("No.");
            Rec.Price := ItemRecord."Unit Price";
        end else begin
            ResourcesRecord.Get("No.");
            Rec.Price := ResourcesRecord."Unit Price";
        end;
    end;

    procedure CalculateSum()
    var
        AutoRentHeaderRecord: Record "Auto Rent Header";
    begin
        Rec.Sum := Amount * Price;
        Rec.Modify();
        AutoRentHeaderRecord.Get("Document No.");
        AutoRentHeaderRecord.CalcFields(Sum);
    end;

    local procedure CheckStatus()
    var
        AutoRentHeaderRecord: Record "Auto Rent Header";
    begin
        AutoRentHeaderRecord.Get("Document No.");
        AutoRentHeaderRecord.TestField(Status, AutoRentHeaderRecord.Status::Open);
    end;

    local procedure CheckFirstLine()
    var
        DeleteError: Label 'This line cannot be edited or deleted';
    begin
        if (Rec."Line No." = 1) then
            Error(DeleteError);
    end;

    local procedure CheckAutoNo()
    var
        AutoRentHeaderRecord: Record "Auto Rent Header";
        EmptyAutoNoError: Label 'Select Auto No.';
    begin
        AutoRentHeaderRecord.Get("Document No.");
        if (AutoRentHeaderRecord."Auto No." = '') then begin
            Error(EmptyAutoNoError);
        end;
    end;

}