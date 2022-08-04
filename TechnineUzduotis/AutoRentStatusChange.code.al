codeunit 50100 "Auto Rent Status Change"
{
    TableNo = "Auto Rent Header";

    procedure Release(var AutoRentRecord: Record "Auto Rent Header")
    var
    begin
        AutoRentRecord.TestField(Status, AutoRentRecord.Status::Open);
        AutoRentRecord.TestField("Client No.");
        AutoRentRecord.TestField("Driver License Image");
        AutoRentRecord.TestField(Date);
        AutoRentRecord.TestField("Auto No.");
        AutoRentRecord.TestField("Rezervation DateTime Start");
        AutoRentRecord.TestField("Rezervation DateTime End");
        AutoRentRecord.TestField(Sum);
        PostItemTransfer(AutoRentRecord);
        AutoRentRecord.Status := "Auto Rent Status"::Issued;
        AutoRentRecord.Modify();

        Message(StatusChangeIssued, AutoRentRecord."No.");
    end;

    procedure Open(var AutoRentRecord: Record "Auto Rent Header")
    begin
        AutoRentRecord.Status := "Auto Rent Status"::Open;
        AutoRentRecord.Modify();
        Message(StatusChangeOpen, AutoRentRecord."No.");
    end;

    local procedure PostItemTransfer(var AutoRentRecord: Record "Auto Rent Header")
    var
        AutoSetupRecord: Record "Auto Setup";
        AutoRentLineRecord: Record "Auto Rent Line";
        AutoRecord: Record Auto;
        PostItemTransferCodeunit: Codeunit "Rent Post Item Transfer";
    begin
        AutoRentLineRecord.Reset();
        AutoRecord.Reset();
        AutoSetupRecord.FindFirst();
        AutoRentLineRecord.SetRange("Document No.", AutoRentRecord."No.");
        AutoRecord.Get(AutoRentRecord."Auto No.");

        if (AutoRentLineRecord.FindSet()) then
            repeat
                if (AutoRentLineRecord.Type = AutoRentLineRecord.Type::Item) then begin
                    if (AutoRentLineRecord.Amount > 0) then begin

                        PostItemTransferCodeunit.PostItemTransfer(AutoRentRecord."No.", AutoRentRecord.Date, AutoRentLineRecord."No.",
                        AutoSetupRecord."Accessories place", AutoRecord."Place Code", AutoRentLineRecord.Amount);
                    end;
                end;
            until AutoRentLineRecord.Next() = 0;
    end;

    var
        StatusChangeIssued: label 'Status (Document No. %1) changed to issued.';
        StatusChangeOpen: label 'Status (Document No. %1) changed to open.';
}