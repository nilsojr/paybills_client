unit uUser;

interface

type

  TUser = class
  private
    FUsername: string;
    FToken: string;
    class var FUser: TUser;
  public
    class function Get: TUser;
    class procedure SetUser(AUser: TUser);
    property Username: string read FUsername write FUsername;
    property Token: string read FToken write FToken;
  end;

implementation

{ TUser }

class function TUser.Get: TUser;
begin
  Result := FUser;
end;

class procedure TUser.SetUser(AUser: TUser);
begin
  FUser := AUser;
end;

initialization

finalization
  if Assigned(TUser.FUser) then
    TUser.FUser.Free;

end.
