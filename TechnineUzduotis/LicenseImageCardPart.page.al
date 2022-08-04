page 50110 "Driver License Image"
{
    Caption = 'Driver license image';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Auto Rent Header";

    layout
    {
        area(content)
        {
            field(Image; Rec."Driver License Image")
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import photo';
                Image = Import;

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField("No.");

                    if Rec."Driver License Image".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Driver License Image");
                    Rec."Driver License Image".ImportFile(FileName, ClientFileName);
                    if not Modify(true) then
                        Rec.Insert(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete photo';
                Enabled = DeleteExportEnabled;
                Image = Delete;

                trigger OnAction()
                begin
                    Rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Driver License Image");
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        [InDataSet]
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The current photo will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete a photo?';
        SelectPictureTxt: Label 'Select picture';
        DeleteExportEnabled: Boolean;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Driver License Image".HasValue;
    end;
}

