unit PayBills.Controllers.uAppController;

interface

uses
  REST.Client,
  REST.Types;

type

  TAppController = class
  private
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    class var FAppController: TAppController;
  public
    constructor Create;
    destructor Destroy; override;

    function GetRestRequest(AMethod: TRESTRequestMethod; AResource: string): TRESTRequest;

    class function GetApiUrl: string;
    class function GetAccountLoginEndpoint: string;
    class function Get: TAppController;
  end;


implementation

{ TAppController }

constructor TAppController.Create;
begin
  FRestClient := TRESTClient.Create(TAppController.GetApiUrl);
  FRestRequest := TRESTRequest.Create(FRestClient);
end;

destructor TAppController.Destroy;
begin
  FRestRequest.Free;
  FRestClient.Free;
  inherited;
end;

class function TAppController.Get: TAppController;
begin
  if not(Assigned(FAppController)) then
    FAppController := TAppController.Create;
  Result := FAppController;
end;

function TAppController.GetRestRequest(AMethod: TRESTRequestMethod; AResource: string): TRESTRequest;
begin
  FRestRequest.Method := AMethod;
  FRestRequest.Resource := AResource;
  Result := FRestRequest;
end;

class function TAppController.GetAccountLoginEndpoint: string;
begin
  Result := 'account/login';
end;

class function TAppController.GetApiUrl: string;
begin
//  Result := 'https://localhost:5001/api';
  Result := 'https://pay-bills.herokuapp.com/api';
end;

initialization

finalization
  if Assigned(TAppController.FAppController) then
    TAppController.FAppController.Free;

end.
