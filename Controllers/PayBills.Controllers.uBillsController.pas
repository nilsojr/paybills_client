unit PayBills.Controllers.uBillsController;

interface

uses
  REST.Client, REST.Types,
  REST.JSON, REST.Consts,
  System.SysUtils,
  Data.DB,
  System.Generics.Collections,
  System.JSON,
  PayBills.Forms.uBillTypes,
  PayBills.Controllers.uBillTypesController;

type

  TBill = class
  private
    FId: Integer;
    FValue: double;
    FMonth: Integer;
    FYear: Integer;
    FBillType: TBillType;
  public
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property BillType: TBillType read FBillType write FBillType;
    property Value: double read FValue write FValue;
    property Month: Integer read FMonth write FMonth;
    property Year: Integer read FYear write FYear;
  end;

  TBillsController = class
  private
    class var FBillsController: TBillsController;
  public
    function GetBills(ADataSet: TDataSet): boolean;
    class function Get: TBillsController;
  end;

implementation

uses
  PayBills.Models.uUser, PayBills.Controllers.uAppController;

{ TBillsController }

class function TBillsController.Get: TBillsController;
begin
  if not(Assigned(FBillsController)) then
    FBillsController := TBillsController.Create;
  Result := FBillsController;
end;

function TBillsController.GetBills(ADataSet: TDataSet): boolean;
var
  LRestRequest: TRESTRequest;
  LJSONBills: TJSONArray;
  LJSONBill: TJSONValue;
  LBill: TBill;
begin
  Result := False;

  LRestRequest := TAppController.Get.GetRestRequest(rmGET, 'bill');
  LRestRequest.Body.ClearBody;
  LRestRequest.AddAuthParameter(HTTP_HEADERFIELD_AUTH, 'Bearer ' + TUser.Get.Token,
    TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);
  LRestRequest.Execute;

  if (LRestRequest.Response.StatusCode = 200) then
  begin
    LJSONBills := LRestRequest.Response.JSONValue as TJSONArray;

    for LJSONBill in LJSONBills do
    begin
      LBill := TJson.JsonToObject<TBill>(LJSONBill.ToString);
      ADataSet.Append;
      ADataSet.FieldByName('Id').AsInteger := LBill.Id;
      ADataSet.FieldByName('PaidValue').AsFloat := LBill.Value;
      ADataSet.FieldByName('Year').AsInteger := LBill.Year;
      ADataSet.FieldByName('Month').AsInteger := LBill.Month;
      ADataSet.Post;
      LBill.Free;
    end;
  end;
end;

{ TBill }

destructor TBill.Destroy;
begin
  if Assigned(FBillType) then
    FBillType.Free;
  inherited;
end;

initialization

finalization
  if Assigned(TBillsController.FBillsController) then
    TBillsController.FBillsController.Free;

end.
