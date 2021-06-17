object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Pay Bills v1'
  ClientHeight = 461
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 426
    Width = 784
    Height = 35
    Align = alBottom
    TabOrder = 0
    object btnLoad: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 27
      Align = alLeft
      Caption = 'Load'
      TabOrder = 0
      OnClick = btnLoadClick
      ExplicitLeft = 45
      ExplicitTop = 6
      ExplicitHeight = 25
    end
    object btnBillTypes: TButton
      AlignWithMargins = True
      Left = 85
      Top = 4
      Width = 75
      Height = 27
      Align = alLeft
      Caption = 'Bill types'
      TabOrder = 1
      OnClick = btnBillTypesClick
      ExplicitLeft = 180
      ExplicitTop = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 784
    Height = 385
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 379
    object gridBills: TRzDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 776
      Height = 377
      Align = alClient
      DataSource = dsBills
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Description'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Id'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PaidValue'
          Title.Caption = 'Paid value'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Year'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'Month'
          Visible = False
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 41
    Align = alTop
    TabOrder = 2
    object lblYear: TLabel
      Left = 17
      Top = 16
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'Year'
    end
    object lblMonth: TLabel
      Left = 121
      Top = 14
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Month'
    end
    object cbYear: TComboBox
      Left = 45
      Top = 11
      Width = 60
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'All'
      OnChange = cbYearChange
      Items.Strings = (
        'All'
        '2020'
        '2021'
        '2022')
    end
    object cbMonth: TComboBox
      Left = 157
      Top = 11
      Width = 84
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'All'
      OnChange = cbMonthChange
      Items.Strings = (
        'All'
        'January'
        'February'
        'March'
        'April'
        'May'
        'June'
        'July'
        'August'
        'September'
        'October'
        'November'
        'December')
    end
  end
  object dsBills: TDataSource
    DataSet = cdsBills
    Left = 208
    Top = 185
  end
  object cdsBills: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cdsBillsAfterOpen
    Left = 288
    Top = 185
    object cdsBillsId: TIntegerField
      FieldName = 'Id'
    end
    object cdsBillsPaidValue: TFloatField
      FieldName = 'PaidValue'
    end
    object cdsBillsYear: TIntegerField
      FieldName = 'Year'
    end
    object cdsBillsMonth: TIntegerField
      FieldName = 'Month'
    end
    object cdsBillsDescription: TStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 255
    end
  end
end
