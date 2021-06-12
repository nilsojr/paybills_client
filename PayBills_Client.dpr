program PayBills_Client;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {FormMain},
  uUser in 'uUser.pas',
  uLogin in 'uLogin.pas' {FormLogin},
  Vcl.Themes,
  Vcl.Styles,
  uLoginController in 'uLoginController.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  if (TLoginController.Get.ShowLogin) then
    TLoginController.Get.StartApp;
  Application.Run;
end.
