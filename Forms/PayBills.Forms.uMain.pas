unit PayBills.Forms.uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, REST.JSON, Data.DB,
  Vcl.Grids, Vcl.DBGrids, RzDBGrid, Vcl.ExtCtrls, Datasnap.DBClient, System.Math,
  System.DateUtils;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    gridBills: TRzDBGrid;
    Panel3: TPanel;
    cbYear: TComboBox;
    lblYear: TLabel;
    lblMonth: TLabel;
    cbMonth: TComboBox;
    dsBills: TDataSource;
    cdsBills: TClientDataSet;
    btnLoad: TButton;
    cdsBillsId: TIntegerField;
    cdsBillsPaidValue: TFloatField;
    cdsBillsYear: TIntegerField;
    cdsBillsMonth: TIntegerField;
    cdsBillsDescription: TStringField;
    btnBillTypes: TButton;
    procedure btnLoadClick(Sender: TObject);
    procedure cbMonthChange(Sender: TObject);
    procedure cbYearChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsBillsAfterOpen(DataSet: TDataSet);
    procedure btnBillTypesClick(Sender: TObject);
  private
    { Private declarations }
    FCurrentMonth,
    FCurrentYear: Integer;
    procedure ApplyMonthFilter(AMonth: Integer);
    procedure ApplyYearFilter(AYear: Integer);
  public
    { Public declarations }
    procedure LoadBills;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  PayBills.Models.uUser,
  PayBills.Controllers.uBillsController,
  PayBills.Forms.uBillTypes;

{ TFormMain }

procedure TFormMain.ApplyMonthFilter(AMonth: Integer);
begin
  cdsBills.Filter := string.Empty;

  if (AMonth = 0) and (FCurrentYear > 0) then
      cdsBills.Filter := 'Year = ' + FCurrentYear.ToString
  else if (AMonth > 0) then
  begin
    cdsBills.Filter := 'Month = ' + AMonth.ToString;
    if (FCurrentYear > 0) then
      cdsBills.Filter := cdsBills.Filter + ' AND Year = ' + FCurrentYear.ToString;
  end;

  cdsBills.Filtered := (AMonth > 0) or (FCurrentYear > 0);
end;

procedure TFormMain.ApplyYearFilter(AYear: Integer);
begin
  cdsBills.Filter := string.Empty;
  if (AYear = 0) and (FCurrentMonth > 0) then
      cdsBills.Filter := 'Month = ' + FCurrentMonth.ToString
  else if (AYear > 0) then
  begin
    cdsBills.Filter := 'Year = ' + AYear.ToString;
    if (FCurrentMonth > 0) then
      cdsBills.Filter := cdsBills.Filter + ' AND Month = ' + FCurrentMonth.ToString;
  end;
  cdsBills.Filtered := (AYear > 0) or (FCurrentMonth > 0);
end;

procedure TFormMain.btnBillTypesClick(Sender: TObject);
begin
  BillTypes := TBillTypes.Create(Self);
  BillTypes.Show;
end;

procedure TFormMain.btnLoadClick(Sender: TObject);
begin
  LoadBills;
end;

procedure TFormMain.cbMonthChange(Sender: TObject);
begin
  ApplyMonthFilter(cbMonth.ItemIndex);
  FCurrentMonth := cbMonth.ItemIndex;
end;

procedure TFormMain.cbYearChange(Sender: TObject);
begin
  ApplyYearFilter(IfThen(cbYear.ItemIndex = 0, 0, Integer.Parse(cbYear.Items[cbYear.ItemIndex])));
  FCurrentYear := IfThen(cbYear.ItemIndex = 0, 0, Integer.Parse(cbYear.Items[cbYear.ItemIndex]));
end;

procedure TFormMain.cdsBillsAfterOpen(DataSet: TDataSet);
begin
  TNumericField(DataSet.FieldByName('PaidValue')).DisplayFormat := ',0.00';
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FCurrentYear := YearOf(Now);
  cbYear.ItemIndex := cbYear.Items.IndexOf(FCurrentYear.ToString);
  FCurrentMonth := MonthOf(Now);
  cbMonth.ItemIndex := FCurrentMonth;
end;

procedure TFormMain.LoadBills;
begin
  cdsBills.CreateDataSet;
  TBillsController.Get.GetBills(cdsBills);
end;

end.
