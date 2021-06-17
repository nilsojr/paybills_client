unit PayBills.Controllers.uBillTypesController;

interface

uses
  REST.Client, REST.Types,
  REST.JSON, REST.Consts,
  System.JSON,
  System.Classes;

type
  TBillType = class
  private
    FDescription: string;
    FActive: boolean;
    FId: Integer;
  public
    property Id: Integer read FId write FId;
    property Description: string read FDescription write FDescription;
    property Active: boolean read FActive write FActive;
  end;

  TBillTypesController = class
  private
    class var FBillTypesController: TBillTypesController;
  public
    function Add(ABillType: TBillType; out AMsg: string): Boolean;
    class function Get: TBillTypesController;
  end;

implementation

uses
  PayBills.Models.uUser,
  PayBills.Controllers.uAppController;

{ TBillTypesController }

function TBillTypesController.Add(ABillType: TBillType;
  out AMsg: string): Boolean;
var
  LRequest: TRESTRequest;
  LBillTypeTemp: TBillType;
begin
  Result := False;

  LRequest := TAppController.Get.GetRestRequest(rmPOST, 'billtype/create');
  LRequest.AddAuthParameter(HTTP_HEADERFIELD_AUTH, 'Bearer ' + TUser.Get.Token,
    TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);
  LRequest.ClearBody;
  LRequest.AddBody(TJson.ObjectToJsonString(ABillType), ctAPPLICATION_JSON);
  LRequest.Execute;

  if (LRequest.Response.StatusCode = 200) then
  begin
    Result := True;
    LBillTypeTemp := TJson.JsonToObject<TBillType>(LRequest.Response.Content);
    try
      ABillType.Id := LBillTypeTemp.Id;
    finally
      LBilLTypeTemp.Free;
    end;
  end
  else
    AMsg := LRequest.Response.Content;
end;

class function TBillTypesController.Get: TBillTypesController;
begin
  if not(Assigned(FBillTypesController)) then
    FBillTypesController := TBillTypesController.Create;
  Result := FBillTypesController;
end;

initialization

finalization
  if Assigned(TBillTypesController.FBillTypesController) then
    TBillTypesController.FBillTypesController.Free;

end.
