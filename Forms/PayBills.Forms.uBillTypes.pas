unit PayBills.Forms.uBillTypes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  PayBills.Controllers.uBillTypesController;

type
  TBillTypes = class(TForm)
    pnlMain: TPanel;
    pnlButtons: TPanel;
    edtDescription: TLabeledEdit;
    cbActive: TCheckBox;
    edtId: TLabeledEdit;
    btnCancel: TButton;
    btnNew: TButton;
    btnSave: TButton;
    btnEdit: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
    FBillType: TBillType;
    procedure ClearFields(AClearObject: Boolean);
    procedure EnableFields(AEnable: Boolean);
    procedure SetFieldsToObject;
    procedure SetObjectToFields(ABillType: TBillType);
  public
    { Public declarations }
  end;

var
  BillTypes: TBillTypes;

implementation

{$R *.dfm}

procedure TBillTypes.FormCreate(Sender: TObject);
begin
  EnableFields(False);
  FBillType := TBillType.Create;
end;

procedure TBillTypes.FormDestroy(Sender: TObject);
begin
  FBillType.Free;
end;

procedure TBillTypes.SetFieldsToObject;
begin
  FBillType.Description := edtDescription.Text;
  FBillType.Active := cbActive.Checked;
end;

procedure TBillTypes.SetObjectToFields(ABillType: TBillType);
begin
  edtId.Text := ABillType.Id;
  edtDescription.Text := ABillType.Description;
  cbActive.Checked := ABillType.Active;
end;

procedure TBillTypes.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TBillTypes.btnEditClick(Sender: TObject);
begin
  EnableFields(True);
  edtId.Enabled := False;
end;

procedure TBillTypes.btnNewClick(Sender: TObject);
begin
  EnableFields(True);
  ClearFields(True);
  edtId.Enabled := False;
end;

procedure TBillTypes.btnSaveClick(Sender: TObject);
var
  LMsg: string;
begin
  SetFieldsToObject;
  EnableFields(False);
  if (TBillTypesController.Get.Add(FBillType, LMsg)) then
  begin
    edtId.Text := FBillType.Id.ToString;
    ShowMessage('Added bill type with id ' + edtId.Text);
  end
  else
    ShowMessage(LMsg);
end;

procedure TBillTypes.ClearFields(AClearObject: Boolean);
begin
  edtDescription.Text := string.Empty;
  edtId.Text := string.Empty;
  cbActive.Checked := False;
  if (AClearObject) then
    SetFieldsToObject;
end;

procedure TBillTypes.EnableFields(AEnable: Boolean);
begin
  edtId.Enabled := AEnable;
  edtDescription.Enabled := AEnable;
  cbActive.Enabled := AEnable;
end;

end.
