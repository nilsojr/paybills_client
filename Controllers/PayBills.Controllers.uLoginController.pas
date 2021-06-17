unit PayBills.Controllers.uLoginController;

interface

uses
  VCL.Forms, REST.Client, REST.Types, REST.JSON,
  System.SysUtils,
  PayBills.Forms.uLogin;

type

  TLoginController = class
  private
    class var FLoginController: TLoginController;
  public
    function SendLoginRequest(AUsername, APassword: string;
      out AErrorMessage: string): Boolean;
    function ShowLogin: Boolean;
    procedure StartApp;
    class function Get: TLoginController;
  end;

implementation

{ TLoginController }

uses
  PayBills.Models.uUser,
  PayBills.Forms.uMain,
  PayBills.Controllers.uAppController;

class function TLoginController.Get: TLoginController;
begin
  if not(Assigned(FLoginController)) then
    FLoginController := TLoginController.Create;
  Result := FLoginController;
end;

function TLoginController.SendLoginRequest(AUsername,
  APassword: string; out AErrorMessage: string): Boolean;
var
  LRequest: TRESTRequest;
begin
  Result := False;

  LRequest := TAppController.Get.GetRestRequest(rmPost, TAppController.GetAccountLoginEndpoint);
  LRequest.Body.ClearBody;
  LRequest.Body.Add('{ "username": ' + AnsiQuotedStr(AUsername, '"')
    + ', "password": ' + AnsiQuotedStr(APassword, '"') + ' }',
    TRESTContentType.ctAPPLICATION_JSON);
  LRequest.Execute;

  if (LRequest.Response.StatusCode = 200) then
  begin
    Result := True;
    TUser.SetUser(TJson.JsonToObject<TUser>(LRequest.Response.Content));
  end
  else
    AErrorMessage := LRequest.Response.Content;
end;

function TLoginController.ShowLogin: Boolean;
begin
  Application.CreateForm(TFormLogin, FormLogin);
  try
    FormLogin.ShowModal;
    Result := TUser.Get <> nil;
  finally
    FormLogin.Free;
  end;
end;

procedure TLoginController.StartApp;
begin
  Application.CreateForm(TFormMain, FormMain);
end;

initialization

finalization
  if Assigned(TLoginController.FLoginController) then
    TLoginController.FLoginController.Free;

end.
