object LancarPagamentoView: TLancarPagamentoView
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Lan'#231'ar Pagamento'
  ClientHeight = 204
  ClientWidth = 575
  Color = 16766378
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
    Left = 32
    Top = 16
    Width = 52
    Height = 30
    Caption = 'Valor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 96
    Width = 38
    Height = 30
    Caption = 'Obs'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtProduto: TEdit
    Left = 32
    Top = 47
    Width = 297
    Height = 40
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 32
    Top = 127
    Width = 297
    Height = 40
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btnOk: TPanel
    Left = 377
    Top = 47
    Width = 160
    Height = 41
    BevelOuter = bvNone
    Caption = 'OK'
    Color = 30186
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
  object btnFechar: TPanel
    Left = 377
    Top = 127
    Width = 160
    Height = 41
    BevelOuter = bvNone
    Caption = 'Fechar'
    Color = 30186
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    OnClick = btnFecharClick
  end
end
