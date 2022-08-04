codeunit 50101 "Return Auto"
{

    TableNo = "Auto Rent Header";
    procedure ReturnAuto(var AutoRentRecord: Record "Auto Rent Header")
    var
        RentStatusError: Label 'Cannot be returned because the document has not been issued.';
        ConfirmReturnAutoLabel: Label 'Are you sure want to return auto?';
    begin
        if (AutoRentRecord.Status <> AutoRentRecord.Status::Issued) then begin
            Error(RentStatusError);
        end;

        if not Confirm(ConfirmReturnAutoLabel) then begin
            exit;
        end;

        CreateFinishedRent(AutoRentRecord);
        TransferDamage(AutoRentRecord);
    end;

    local procedure CreateFinishedRent(var AutoRentRecord: Record "Auto Rent Header")
    var
        ReturnAutoLabel: Label 'Auto returned (Document No. %1).';

        FinishedAutoRentHeader: Record "Finished Auto Rent Header";
        FinishedAutoRentLineRecord: Record "Finished Auto Rent Line";
        AutoRentLineRecord: Record "Auto Rent Line";

        exportFile: File;
        OutS: OutStream;
        InS: InStream;
    begin
        FinishedAutoRentHeader.Init();
        FinishedAutoRentHeader.TransferFields(AutoRentRecord);
        FinishedAutoRentHeader.Sum := AutoRentRecord.Sum;

        if AutoRentRecord."Driver License Image".HasValue then begin
            exportFile.CreateTempFile();
            exportFile.CreateOutStream(OutS);
            AutoRentRecord."Driver License Image".ExportStream(OutS);
            exportFile.CreateInStream(InS);
            FinishedAutoRentHeader."Driver License Image".ImportStream(InS, 'Image');
            CopyStream(OutS, InS);
        end;

        FinishedAutoRentHeader.Insert();
        FinishedAutoRentHeader.SetRange("No.", AutoRentRecord."No.");
        FinishedAutoRentHeader.FindFirst();
        FinishedAutoRentHeader.Modify();

        AutoRentLineRecord.Reset();
        AutoRentLineRecord.SetRange("Document No.", AutoRentRecord."No.");

        if (AutoRentLineRecord.IsEmpty) then begin
            exit;
        end;

        if (AutoRentLineRecord.FindSet()) then
            repeat

                if (AutoRentLineRecord.Type = AutoRentLineRecord.Type::Item) then begin
                    PostItemTransfer(AutoRentRecord, AutoRentLineRecord);
                end;

                FinishedAutoRentLineRecord.Init();
                FinishedAutoRentLineRecord.TransferFields(AutoRentLineRecord);
                FinishedAutoRentLineRecord.Insert();
                AutoRentLineRecord.Delete();
            until AutoRentLineRecord.Next() = 0;

        AutoRentRecord.Delete();
        Message(ReturnAutoLabel, FinishedAutoRentHeader."No.");
    end;

    local procedure TransferDamage(var AutoRentRecord: Record "Auto Rent Header")
    var
        LineNo: Integer;
        AutoDamageRecord: Record "Auto Damage";
        AutoRentDamageRecord: Record "Auto Rent Damage";
    begin
        AutoDamageRecord.Reset();
        AutoDamageRecord.SetRange("Auto No.", AutoRentRecord."Auto No.");

        if AutoDamageRecord.FindLast() then begin
            LineNo := AutoDamageRecord."Line No.";
        end else
            LineNo := 1;

        AutoRentDamageRecord.Reset();
        AutoRentDamageRecord.SetRange("Document No.", AutoRentRecord."No.");

        if (AutoRentDamageRecord.FindSet()) then
            repeat
                AutoDamageRecord.Init();
                AutoDamageRecord.TransferFields(AutoRentDamageRecord);
                AutoDamageRecord."Auto No." := AutoRentRecord."Auto No.";
                LineNo += 1;
                AutoDamageRecord."Line No." := LineNo;
                AutoDamageRecord.Insert();

                AutoRentDamageRecord.Delete();
            until AutoRentDamageRecord.Next() = 0;
    end;

    local procedure PostItemTransfer(var AutoRentRecord: Record "Auto Rent Header"; var AutoRentLineRecord: Record "Auto Rent Line")
    var
        AutoSetupRecord: Record "Auto Setup";
        AutoRecord: Record Auto;
        ItemPostTransferCodeunit: Codeunit "Rent Post Item Transfer";
    begin
        AutoRecord.Reset();
        AutoSetupRecord.FindFirst();
        AutoRecord.Get(AutoRentRecord."Auto No.");

        ItemPostTransferCodeunit.PostItemTransfer(AutoRentRecord."No.", AutoRentRecord.Date, AutoRentLineRecord."No.",
        AutoRecord."Place Code", AutoSetupRecord."Accessories place", AutoRentLineRecord.Amount);
    end;
}