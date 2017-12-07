object FechamentoDeContaView: TFechamentoDeContaView
  Left = 400
  Top = 126
  BorderStyle = bsDialog
  Caption = 'Fechamento de Contas'
  ClientHeight = 637
  ClientWidth = 952
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlComandos: TJvPanel
    Left = 735
    Top = 0
    Width = 217
    Height = 637
    Align = alRight
    BevelOuter = bvNone
    Color = 8266522
    TabOrder = 1
    object btnOk: TPanel
      Left = 16
      Top = 10
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Ok'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnImprimir: TPanel
      Left = 16
      Top = 62
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Imprimir'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnLancarDebito: TPanel
      Left = 16
      Top = 114
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Lan'#231'ar D'#233'bito ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnLancarDebitoClick
    end
    object btnLancarCredito: TPanel
      Left = 16
      Top = 167
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Lan'#231'ar Cr'#233'dito ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnLancarCreditoClick
    end
    object btnLancarDinheiro: TPanel
      Left = 16
      Top = 219
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Lan'#231'ar Dinheiro ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnLancarDinheiroClick
    end
    object btnVisualizarPagamentos: TPanel
      Left = 16
      Top = 272
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Pagamentos ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnVisualizarPagamentosClick
    end
    object btnFecharConta: TPanel
      Left = 16
      Top = 325
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Fechar Conta ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnFecharContaClick
    end
    object pnlDetalheView: TPanel
      Left = 16
      Top = 512
      Width = 186
      Height = 119
      BevelOuter = bvNone
      Color = 16181992
      TabOrder = 7
      object DetalheView: TMemo
        Left = 0
        Top = 0
        Width = 186
        Height = 119
        Align = alClient
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object pnlDesktop: TPanel
    Left = 0
    Top = 0
    Width = 735
    Height = 637
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlCliente: TPanel
      Left = 0
      Top = 51
      Width = 735
      Height = 84
      Align = alTop
      BevelOuter = bvNone
      Color = 16181992
      ParentBackground = False
      TabOrder = 0
      object lblCliente: TLabel
        Left = 32
        Top = -2
        Width = 64
        Height = 30
        Caption = 'Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = 8266522
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object EdtCliente: TEdit
        Left = 32
        Top = 27
        Width = 617
        Height = 38
        HelpType = htKeyword
        HelpKeyword = 'CL_COD'
        CharCase = ecUpperCase
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
      end
      object EdtOid: TEdit
        Left = 3
        Top = 27
        Width = 11
        Height = 38
        HelpType = htKeyword
        HelpKeyword = 'pro_des'
        CharCase = ecUpperCase
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        Visible = False
      end
      object EdtCod: TEdit
        Left = 18
        Top = 27
        Width = 11
        Height = 38
        HelpType = htKeyword
        HelpKeyword = 'pro_des'
        CharCase = ecUpperCase
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Visible = False
      end
    end
    object pnlTitulo: TPanel
      Left = 0
      Top = 0
      Width = 735
      Height = 51
      Align = alTop
      Color = 8266522
      ParentBackground = False
      TabOrder = 1
      object lblIdComanda: TLabel
        Left = 11
        Top = 11
        Width = 204
        Height = 30
        Caption = 'Fechamento de Conta'
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object pnlSumario: TPanel
      Left = 0
      Top = 508
      Width = 735
      Height = 129
      Align = alBottom
      Color = 16181992
      ParentBackground = False
      TabOrder = 2
      object Panel6: TPanel
        Left = 8
        Top = 6
        Width = 719
        Height = 35
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '    Total em Aberto'
        Color = 8266522
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblTotalEmAberto: TLabel
          Left = 655
          Top = 2
          Width = 38
          Height = 30
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = 16181992
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel7: TPanel
        Left = 8
        Top = 86
        Width = 719
        Height = 35
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '    Saldo'
        Color = 8266522
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object lblSaldo: TLabel
          Left = 655
          Top = 2
          Width = 38
          Height = 30
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = 16181992
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel3: TPanel
        Left = 8
        Top = 46
        Width = 719
        Height = 35
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '    Pagamentos'
        Color = 8266522
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object lblPagamentos: TLabel
          Left = 655
          Top = 2
          Width = 38
          Height = 30
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = 16181992
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object gConta: TDBGrid
      Left = 0
      Top = 135
      Width = 735
      Height = 373
      Align = alClient
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -19
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object pnlClientePesquisa: TPanel
    Left = 38
    Top = 119
    Width = 627
    Height = 16
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    Visible = False
  end
end
