unit uLoginController;

interface

uses
  REST.Client, REST.Types,
  REST.JSON,
  System.SysUtils,
  uLogin;

type

  TLoginController = class
  private
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    class var FLoginController: TLoginController;
  public
    function SendLoginRequest(AUsername, APassword: string;
      out AErrorMessage: string): Boolean;
    function ShowLogin: Boolean;
    procedure StartApp;
    class function Get: TLoginController;
  end;

const
  //TO-DO: Move to a function in a configuration class
  _BASE_URL = 'https://localhost:5001/api';

implementation

{ TLoginController }

uses uUser, VCL.Forms, uMain;

class function TLoginController.Get: TLoginController;
begin
  if not(Assigned(FLoginController)) then
    FLoginController := TLoginController.Create;
  Result := FLoginController;

end;

function TLoginController.SendLoginRequest(AUsername,
  APassword: string; out AErrorMessage: string): Boolean;
begin
  Result := False;

  FRestClient := TRESTClient.Create(_BASE_URL);
  try
    FRestRequest := TRESTRequest.Create(FRestClient);
    FRestRequest.Method := rmPost;
    FRestRequest.Resource := 'account/login';
    FRESTRequest.Body.Add('{ "username": ' + AnsiQuotedStr(AUsername, '"')
      + ', "password": ' + AnsiQuotedStr(APassword, '"') + ' }',
      TRESTContentType.ctAPPLICATION_JSON);
    FRESTRequest.Execute;

    if (FRestRequest.Response.StatusCode = 200) then
    begin
      Result := True;
      TUser.SetUser(TJson.JsonToObject<TUser>(FRestRequest.Response.Content));
    end
    else
      AErrorMessage := FRestRequest.Response.Content;
  finally
    FRestClient.Free;
  end;
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
