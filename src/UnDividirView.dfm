object DividirView: TDividirView
  Left = 583
  Top = 270
  BorderStyle = bsDialog
  Caption = 'Dividir Conta'
  ClientHeight = 480
  ClientWidth = 900
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 380
    Top = 24
    Width = 94
    Height = 30
    Caption = 'Dividir em'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 104
    Top = 24
    Width = 100
    Height = 30
    Caption = 'Valor Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtDivisao: TJvValidateEdit
    Left = 380
    Top = 60
    Width = 240
    Height = 38
    Flat = True
    ParentFlat = False
    CriticalPoints.MaxValueIncluded = False
    CriticalPoints.MinValueIncluded = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ZeroEmpty = True
    OnEnter = edtDivisaoEnter
    OnExit = edtDivisaoExit
  end
  object btnOk: TPanel
    Left = 651
    Top = 60
    Width = 160
    Height = 41
    BevelOuter = bvNone
    Caption = 'OK'
    Color = 8562945
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = btnOkClick
  end
  object edtTotal: TJvValidateEdit
    Left = 106
    Top = 60
    Width = 240
    Height = 38
    Flat = True
    ParentFlat = False
    CriticalPoints.MaxValueIncluded = False
    CriticalPoints.MinValueIncluded = False
    DisplayFormat = dfFloat
    DecimalPlaces = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
end
