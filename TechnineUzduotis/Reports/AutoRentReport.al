report 50100 "Auto Rent Report"
{
    Caption = 'Auto rent issue document';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Source/rdlc/AutoRentReport.rdl';

    dataset
    {
        dataitem("Auto Rent Header"; "Auto Rent Header")
        {
            RequestFilterFields = "No.";
            column(Client_No_; "Client No.")
            {
            }
            column(Rezervation_DateTime_Start; "Rezervation DateTime Start")
            {
            }
            column(Rezervation_DateTime_End; "Rezervation DateTime End")
            {
            }
            column(ReportDate; ReportDate)
            {
            }
            column(CustomerRecordName; CustomerRecord.Name)
            {
            }
            dataitem(Auto; Auto)
            {
                DataItemLink = "No." = field("Auto No.");
                column(Auto_No_; "No.")
                {
                }
                column(Mark; Mark)
                {
                }
                column(Model; Model)
                {
                }
            }
            dataitem("Auto Rent Line"; "Auto Rent Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Line_No_; "Line No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Amount; Amount)
                {
                }
                column(Price; Price)
                {
                }
                column(Sum; Sum)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if not CustomerRecord.Get("Client No.") then begin
                    CustomerRecord.Init()
                end;

                CheckStatus();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Report data';
                    field(ReportDate; ReportDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Date';
                    }
                }
            }
        }
    }

    labels
    {
        AutoNoLbl = 'Auto No.';
        MarkLbl = 'Mark';
        ModelLbl = 'Model';
        RentPeriodLbl = 'Rent period';
        CustomerNameLbl = 'Client name';
        RentLineServicesItemsLbl = 'Services and items';
        AmountLbl = 'Amount';
        RentLinePriceLbl = 'Price';
        RentLineSumLbl = 'Sum';
        RentSumLbl = 'Rent sum';
        GeneralServicesSumLbl = 'Total sum of services';
        GeneralRentServicesSumLbl = 'Total rent sum including services';
        ReportNameLbl = 'Auto rent issuance document';
        DateLbl = 'Date';
    }
    local procedure CheckStatus()
    var
        StatusError: Label 'Cannot create a report because the status of the rent (No. %1) is not issued.';
    begin
        if ("Auto Rent Header".Status = "Auto Rent Header".Status::Open) then begin
            Error(StatusError, "Auto Rent Header"."No.");
        end;
    end;

    var
        ReportDate: Date;
        CustomerRecord: Record Customer;
}