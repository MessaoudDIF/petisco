object LancarDebitoView: TLancarDebitoView
  Left = 329
  Top = 203
  BorderStyle = bsDialog
  Caption = 'Lan'#231'ar Pagamento com Cart'#227'o de D'#233'bito'
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
    Left = 372
    Top = 19
    Width = 46
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
    Left = 24
    Top = 19
    Width = 158
    Height = 30
    Caption = 'Cart'#227'o de D'#233'bito'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object EdtValor: TJvValidateEdit
    Left = 372
    Top = 54
    Width = 250
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
    MaxValue = 10000.000000000000000000
    ParentFont = False
    TabOrder = 1
    ZeroEmpty = True
    OnEnter = EdtValorEnter
    OnExit = EdtValorExit
  end
  object btnOk: TPanel
    Left = 645
    Top = 54
    Width = 160
    Height = 41
    BevelOuter = bvNone
    Caption = 'OK'
    Color = 8562945
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = btnOkClick
  end
  object edtCartaoDebito: TEdit
    Left = 24
    Top = 55
    Width = 321
    Height = 38
    HelpType = htKeyword
    HelpKeyword = 'cart_cod'
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object pnlCartaoDebitoPesquisa: TPanel
    Left = 29
    Top = 94
    Width = 468
    Height = 16
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 3
    Visible = False
  end
end
