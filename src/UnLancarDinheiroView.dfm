object LancarDinheiroView: TLancarDinheiroView
  Left = 551
  Top = 306
  BorderStyle = bsDialog
  Caption = 'Lan'#231'ar Pagamento em Dinheiro'
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
    Left = 40
    Top = 24
    Width = 48
    Height = 30
    Caption = 'Valor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 251
    Top = 24
    Width = 79
    Height = 30
    Caption = 'Dinheiro'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 458
    Top = 24
    Width = 52
    Height = 30
    Caption = 'Troco'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object EdtValor: TJvValidateEdit
    Left = 40
    Top = 55
    Width = 200
    Height = 38
    Flat = True
    ParentFlat = False
    CriticalPoints.MaxValueIncluded = False
    CriticalPoints.MinValueIncluded = False
    DisplayFormat = dfFloat
    DecimalPlaces = 2
    EditText = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    HasMaxValue = True
    HasMinValue = True
    MaxValue = 10000.000000000000000000
    ParentFont = False
    TabOrder = 0
    ZeroEmpty = True
    OnEnter = EdtValorEnter
    OnExit = EdtValorExit
  end
  object btnOk: TPanel
    Left = 689
    Top = 55
    Width = 160
    Height = 41
    BevelOuter = bvNone
    Caption = 'OK'
    Color = 8562945
    Font.Charset = ANSI_CHARSET
    Font.Color = 16181992
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    OnClick = btnOkClick
  end
  object EdtDinheiro: TJvValidateEdit
    Left = 252
    Top = 55
    Width = 200
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
    TabOrder = 1
    ZeroEmpty = True
    OnEnter = EdtDinheiroEnter
    OnExit = EdtDinheiroExit
  end
  object EdtTroco: TJvValidateEdit
    Left = 458
    Top = 55
    Width = 200
    Height = 38
    TabStop = False
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
    ReadOnly = True
    TabOrder = 2
    ZeroEmpty = True
  end
end
