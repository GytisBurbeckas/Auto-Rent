table 50110 "Finished Auto Rent Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            Editable = false;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Type"; Enum "Auto Rent Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            Editable = false;
        }
        field(30; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;
        }
        field(40; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(50; "Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            Editable = false;
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
}