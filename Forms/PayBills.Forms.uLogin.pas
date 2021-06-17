unit PayBills.Forms.uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, COnsts;

type
  TFormLogin = class(TForm)
    btnLogin: TButton;
    btnExit: TButton;
    edtUsername: TLabeledEdit;
    edtPassword: TLabeledEdit;
    lblInvalidPassword: TLabel;
    lblInvalidUser: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure edtUsernameChange(Sender: TObject);
    procedure edtPasswordChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  _USER_CONF_PATH = 'user.conf';

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

uses PayBills.Controllers.uLoginController;

procedure TFormLogin.FormCreate(Sender: TObject);
var
  LUserConf: TStrings;
begin
  if (FileExists(_USER_CONF_PATH)) then
  begin
    LUserConf := TStringList.Create;
    try
      LUserConf.LoadFromFile(_USER_CONF_PATH);
      if (LUserConf.IndexOfName('username') > -1) then
        edtUsername.Text := LUserConf.Values['username'];

      if (LUserConf.IndexOfName('password') > -1) then
        edtPassword.Text := LUserConf.Values['password'];

    finally
      LUserConf.Free;
    end;
  end;
end;

procedure TFormLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    btnLogin.Click;
end;

procedure TFormLogin.FormShow(Sender: TObject);
begin
  if not(edtPassword.Text = string.Empty) then
    btnLogin.SetFocus
  else if not(edtUsername.Text = string.Empty) then
    edtPassword.SetFocus;
end;

procedure TFormLogin.btnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormLogin.btnLoginClick(Sender: TObject);
var
  LErrorMsg: string;
begin
  if TLoginController.Get.SendLoginRequest(edtUsername.Text, edtPassword.Text, LErrorMsg) then
    Close
  else
  begin
    if (LErrorMsg.Contains('Invalid username')) then
      lblInvalidUser.Visible := True
    else if (LErrorMsg.Contains('Invalid password')) then
      lblInvalidPassword.Visible := True
    else
      ShowMessage(LErrorMsg);
  end;
end;

procedure TFormLogin.edtPasswordChange(Sender: TObject);
begin
  lblInvalidPassword.Visible := False;
end;

procedure TFormLogin.edtUsernameChange(Sender: TObject);
begin
  lblInvalidUser.Visible := False;
end;

end.
