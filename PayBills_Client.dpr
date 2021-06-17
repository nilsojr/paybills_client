program PayBills_Client;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  PayBills.Controllers.uAppController in 'Controllers\PayBills.Controllers.uAppController.pas',
  PayBills.Controllers.uBillsController in 'Controllers\PayBills.Controllers.uBillsController.pas',
  PayBills.Controllers.uBillTypesController in 'Controllers\PayBills.Controllers.uBillTypesController.pas',
  PayBills.Controllers.uLoginController in 'Controllers\PayBills.Controllers.uLoginController.pas',
  PayBills.Models.uUser in 'Models\PayBills.Models.uUser.pas',
  PayBills.Forms.uBillTypes in 'Forms\PayBills.Forms.uBillTypes.pas' {BillTypes},
  PayBills.Forms.uLogin in 'Forms\PayBills.Forms.uLogin.pas' {FormLogin},
  PayBills.Forms.uMain in 'Forms\PayBills.Forms.uMain.pas' {FormMain};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  if (TLoginController.Get.ShowLogin) then
    TLoginController.Get.StartApp;
  Application.CreateForm(TBillTypes, BillTypes);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
