table 50101 "Auto Model"
{
    DataClassification = CustomerContent;
    Caption = 'Auto models';

    fields
    {
        field(1; "Mark Code"; Code[10])
        {
            Caption = 'Mark code';
            DataClassification = CustomerContent;
        }
        field(10; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(20; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Mark Code", "Code")
        {
            Clustered = true;
        }
    }
}