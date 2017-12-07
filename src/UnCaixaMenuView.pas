unit UnCaixaMenuView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  { Fluente }
  DataUtil, UnModelo, UnCaixaModelo, Componentes, UnAplicacao, CaixaAplicacao,
  JvExControls, JvButton, JvTransparentButton;

type
  TCaixaMenuView = class(TForm, ITela)
    pnlDesktop: TPanel;
    btnAbertura: TPanel;
    btnTroco: TPanel;
    btnSaida: TPanel;
    btnSuprimento: TPanel;
    btnSangria: TPanel;
    btnFechamento: TPanel;
    pnlTitle: TPanel;
    btnFechar: TJvTransparentButton;
    btnExtrato: TPanel;
    procedure btnAberturaClick(Sender: TObject);
    procedure btnTrocoClick(Sender: TObject);
    procedure btnSaidaClick(Sender: TObject);
    procedure btnSuprimentoClick(Sender: TObject);
    procedure btnSangriaClick(Sender: TObject);
    procedure btnFechamentoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnExtratoClick(Sender: TObject);
  private
    FCaixaModelo: TCaixaModelo;
    FControlador: IResposta;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function ExibirTela: Integer;
    function ExecutarAcao(const Acao: AcaoDeRegistro;
      const Modelo: TModelo): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
  end;

implementation

{$R *.dfm}

uses Util;

{ TCaixaMenuView }

function TCaixaMenuView.Controlador(const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TCaixaMenuView.Descarregar: ITela;
begin
  Self.FCaixaModelo := nil;
  Self.FControlador := nil;
  Result := Self;
end;

function TCaixaMenuView.ExecutarAcao(const Acao: AcaoDeRegistro;
  const Modelo: TModelo): ITela;
begin
  Result := Self;
end;

function TCaixaMenuView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TCaixaMenuView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FCaixaModelo := (Modelo as TCaixaModelo);
  Result := Self;
end;

function TCaixaMenuView.Preparar: ITela;
begin
  Result := Self;
end;

procedure TCaixaMenuView.btnAberturaClick(Sender: TObject);
var
  _parametros: TMap;
  _chamada: TChamada;
begin
  _parametros := Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(odcAbertura));
  _chamada := TChamada.Create
    .Parametros(_parametros);
  try
    Self.FControlador.Responder(_chamada);
  finally
    FreeAndNil(_chamada);
  end;
end;

procedure TCaixaMenuView.btnTrocoClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(odcTroco));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TCaixaMenuView.btnSaidaClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(odcSaida));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TCaixaMenuView.btnSuprimentoClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(odcSuprimento));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TCaixaMenuView.btnSangriaClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(odcSangria));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TCaixaMenuView.btnFechamentoClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(odcFechamento));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TCaixaMenuView.btnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TCaixaMenuView.btnExtratoClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(odcExtrato));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

end.
