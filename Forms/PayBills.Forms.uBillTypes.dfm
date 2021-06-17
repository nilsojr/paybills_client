object BillTypes: TBillTypes
  Left = 0
  Top = 0
  Caption = 'Bill Types'
  ClientHeight = 261
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 226
    Align = alClient
    TabOrder = 0
    object edtDescription: TLabeledEdit
      Left = 8
      Top = 80
      Width = 361
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = 'Description'
      TabOrder = 0
    end
    object cbActive: TCheckBox
      Left = 8
      Top = 120
      Width = 97
      Height = 17
      Caption = 'Active'
      TabOrder = 1
    end
    object edtId: TLabeledEdit
      Left = 8
      Top = 24
      Width = 121
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'Id'
      TabOrder = 2
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 226
    Width = 384
    Height = 35
    Align = alBottom
    TabOrder = 1
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 305
      Top = 4
      Width = 75
      Height = 27
      Align = alRight
      Caption = '&Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnNew: TButton
      AlignWithMargins = True
      Left = 62
      Top = 4
      Width = 75
      Height = 27
      Align = alRight
      Caption = '&New'
      TabOrder = 1
      OnClick = btnNewClick
      ExplicitLeft = 143
    end
    object btnSave: TButton
      AlignWithMargins = True
      Left = 224
      Top = 4
      Width = 75
      Height = 27
      Align = alRight
      Caption = '&Save'
      TabOrder = 2
      OnClick = btnSaveClick
    end
    object btnEdit: TButton
      AlignWithMargins = True
      Left = 143
      Top = 4
      Width = 75
      Height = 27
      Align = alRight
      Caption = '&Edit'
      TabOrder = 3
      OnClick = btnEditClick
      ExplicitLeft = 224
    end
  end
end
