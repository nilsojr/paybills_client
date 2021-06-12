unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

uses uLoginController;

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
