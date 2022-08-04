report 50101 "Auto Rent History Report"
{
    Caption = 'Auto rent history report';
    DefaultLayout = RDLC;
    RDLCLayout = './Source/rdlc/AutoRentHistoryReport.rdl';

    dataset
    {
        dataItem("Finished Auto Rent Header"; "Finished Auto Rent Header")
        {
            column(Rezervation_DateTime_Start; "Rezervation DateTime Start")
            {
            }
            column(Rezervation_DateTime_End; "Rezervation DateTime End")
            {
            }
            column(Sum; Sum)
            {
            }
            column(CustomerRecordName; CustomerRecord.Name)
            {
            }
            column(DateFilterStart; DateFilterStart)
            {
            }
            column(DateFilterEnd; DateFilterEnd)
            {
            }
            dataitem(Auto; Auto)
            {
                DataItemLink = "No." = field("Auto No.");
                column(No_; "No.")
                {
                }
                column(Mark; Mark)
                {
                }
                column(Model; Model)
                {
                }
            }

            trigger OnPreDataItem()
            begin
                SetDateFilter();
            end;

            trigger OnAfterGetRecord()
            begin
                if not CustomerRecord.Get("Client No.") then begin
                    CustomerRecord.Init()
                end;
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
                    Caption = 'Auto rent history filter data time';
                    field(DateFilterStart; DateFilterStart)
                    {
                        Caption = 'Filtration date time from';
                        ApplicationArea = All;
                    }
                    field(DateFilterEnd; DateFilterEnd)
                    {
                        Caption = 'Filtration date time to';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    labels
    {
        ReportNameLbl = 'Auto rent history';
        AutoNoLbl = 'Auto No.';
        MarkLbl = 'Mark';
        ModelLbl = 'Model';
        AutoRentLbl = 'Rents';
        DateStartLbl = 'Date time from';
        DateEndLbl = 'Date time to';
        CustomerRecordNameLbl = 'Client name';
        RentSumLbl = 'Total rent sum including services';
        AllRentSumLbl = 'Total sum of all rents';
        AutoDataLbl = 'Auto data';
        PeriodLbl = 'Period';
    }

    local procedure SetDateFilter()
    begin
        if (DateFilterStart <> 0DT) and (DateFilterEnd <> 0DT) then begin
            FilterText := Format(DateFilterStart, 0, 0) + '..' + Format(DateFilterEnd, 0, 0);
            "Finished Auto Rent Header".SetFilter("Rezervation DateTime Start", FilterText);
        end;

        if (DateFilterStart <> 0DT) and (DateFilterEnd = 0DT) then begin
            FilterText := Format(DateFilterStart, 0, 0) + '..';
            "Finished Auto Rent Header".SetFilter("Rezervation DateTime Start", FilterText);
        end;

        if (DateFilterStart = 0DT) and (DateFilterEnd <> 0DT) then begin
            FilterText := '..' + Format(DateFilterEnd, 0, 0);
            "Finished Auto Rent Header".SetFilter("Rezervation DateTime Start", FilterText);
        end;
    end;

    var
        CustomerRecord: Record Customer;
        DateFilterStart: DateTime;
        DateFilterEnd: DateTime;
        FilterText: text;
}