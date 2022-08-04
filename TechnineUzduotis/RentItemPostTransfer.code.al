codeunit 50102 "Rent Post Item Transfer"
{
    procedure PostItemTransfer(DocumentNo: Code[20]; DocumentDate: Date; ItemNo: Code[20]; Location: Code[10]; NewLocation: Code[10]; Quantity: Integer)
    var
        ItemJnLineRecord: Record "Item Journal Line" temporary;
        ItemJnPostLineCodeunit: Codeunit "Item Jnl.-Post Line";
    begin
        ItemJnLineRecord.Init();
        ItemJnLineRecord."Document No." := DocumentNo;
        ItemJnLineRecord.Validate("Posting Date", DocumentDate);
        ItemJnLineRecord."Entry Type" := ItemJnLineRecord."Entry Type"::Transfer;
        ItemJnLineRecord.Validate("Item No.", ItemNo);
        ItemJnLineRecord."Location Code" := Location;
        ItemJnLineRecord."New Location Code" := NewLocation;
        ItemJnLineRecord.Validate(Quantity, Quantity);

        ItemJnPostLineCodeunit.Run(ItemJnLineRecord);
    end;
}