unit UnAplicacao;

interface

uses
  { VCL }
  Classes, ExtCtrls, Controls, StdCtrls,
  { helsonsant }
  Util, DataUtil, Configuracoes, UnModelo, Componentes, UnFabricaDeModelos;

type
  ITela = interface;
  TChamada = class;

  IListaRegistro = interface
    ['{E17BFFC4-AEBA-4928-82E3-19BFC49DD0AA}']
    procedure ExibirTelaDeRegistro(const ExecutandoAcao: AcaoDeRegistro; const Modelo: TModelo);
  end;

  IResposta = interface
    ['{950809B5-1A98-4EB7-BDDA-31B33BE089ED}']
    procedure Responder(const Chamada: TChamada);
  end;

  TChamada = class
  private
    FChamador: TObject;
    FEventoParaExecutarAntesdaChamada: TNotifyEvent;
    FEventoParaExecutarAposChamada: TNotifyEvent;
    FParametros: TMap;
  public
    function AntesDeChamar(const EventoParaExecutarAntesDaChamada: TNotifyEvent): TChamada;
    function AposChamar(const EventoParaExecutarAposChamada: TNotifyEvent): TChamada;
    function Chamador(const Chamador: TObject): TChamada;
    function ObterChamador: TObject;
    function ObterParametros: TMap;
    function Parametros(const Parametros: TMap): TChamada;
    property EventoParaExecutarAntesDeChamar: TNotifyEvent read FEventoParaExecutarAntesdaChamada;
    property EventoParaExecutarAposChamar: TNotifyEvent read FEventoParaExecutarAposChamada;
  end;

  TConfiguracaoAplicacao = class
  private
    FOrigem: TObject;
    FEventoParaExecutarAntesDeAtivar: TNotifyEvent;
    FEventoParaExecutarAposDesativar: TNotifyEvent;
    FParametros: TMap;
  public
    function AntesDeAtivar(const EventoParaExecutarAntesDeAtivar: TNotifyEvent): TConfiguracaoAplicacao;
    function AposDesativar(const EventoParaExecutarAposDesativar: TNotifyEvent): TConfiguracaoAplicacao;
    function Origem(const Origem: TObject): TConfiguracaoAplicacao;
    function ObterOrigem: TObject;
    function ObterParametros: TMap;
    function Parametros(const Parametros: TMap): TConfiguracaoAplicacao;
    property EventoParaExecutarAntesDeAtivar: TNotifyEvent read FEventoParaExecutarAntesDeAtivar;
    property EventoParaExecutarAposDesativar: TNotifyEvent read FEventoParaExecutarAposDesativar;
  end;

  ITela = interface
    ['{5FB77114-7D8A-45BC-824D-8B7B37AC34A0}']
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Descarregar: ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;       

  TAplicacaoBloco  = class(TPanel)
  private
    FAoSelecionarAplicacao: TNotifyEvent;
    FContainer: TWinControl;
    FCor: Integer;
    FLegenda: TLabel;
    FTextoDica: string;
    FTextoLegenda: string;
  public
    function AoSelecionarAplicacao(const ExecutarAoSelecionarAplicacao: TNotifyEvent): TAplicacaoBloco;
    function Aplicacao(const Aplicacao: string): TAplicacaoBloco;
    function Container(const Container: TWinControl): TAplicacaoBloco;
    function Cor(const Cor: Integer): TAplicacaoBloco;
    function Dica(const TextoDaDica: string): TAplicacaoBloco;
    function Legenda(const TextoDaLegenda: string): TAplicacaoBloco;
    function Preparar: TAplicacaoBloco;
  end;

  TAplicacao = class(TComponent)
  protected
    FChamada: TChamada;
    FConfiguracoes: TConfiguracoes;
    FControlador: IResposta;
    FDataUtil: TDataUtil;
    FFabricaDeModelos: TFabricaDeModelos;
    FUtil: TUtil;
  public
    function AtivarAplicacao: TAplicacao; overload; virtual; abstract;
    function AtivarAplicacao(const Chamada: TChamada): TAplicacao; overload; virtual;
    function Configuracoes(const Configuracoes: TConfiguracoes): TAplicacao;
    function Controlador(const Controlador: IResposta): TAplicacao;
    function DataUtil(const DataUtil: TDataUtil): TAplicacao;
    function Descarregar: TAplicacao; virtual; abstract;
    function FabricaDeModelos(const FabricaDeModelos: TFabricaDeModelos): TAplicacao;
    function Util(const Util: TUtil): TAplicacao;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao; virtual; abstract;
  end;

implementation

{ TAplicacaoBloco }

function TAplicacaoBloco.AoSelecionarAplicacao(
  const ExecutarAoSelecionarAplicacao: TNotifyEvent): TAplicacaoBloco;
begin
  Self.FAoSelecionarAplicacao := ExecutarAoSelecionarAplicacao;
  Result := Self;
end;

function TAplicacaoBloco.Aplicacao(
  const Aplicacao: string): TAplicacaoBloco;
begin
  Self.Name := Aplicacao;
  Self.Caption := '';
  Result := Self;
end;

function TAplicacaoBloco.Container(const Container: TWinControl): TAplicacaoBloco;
begin
  Self.FContainer := Container;
  Result := Self;
end;

function TAplicacaoBloco.Cor(const Cor: Integer): TAplicacaoBloco;
begin
  Self.FCor := Cor;
  Result := Self;
end;

function TAplicacaoBloco.Dica(const TextoDaDica: string): TAplicacaoBloco;
begin
  Self.FTextoDica := TextoDaDica;
  Result := Self;
end;

function TAplicacaoBloco.Legenda(const TextoDaLegenda: string): TAplicacaoBloco;
begin
  Self.FTextoLegenda := TextoDaLegenda;
  Result := Self;
end;

function TAplicacaoBloco.Preparar: TAplicacaoBloco;
begin
  Self.ParentBackground := False;
  Self.Margins.Left := 15;
  Self.Margins.Top := 15;
  Self.Margins.Right := 15;
  Self.Margins.Bottom := 15;
  Self.BevelInner := bvNone;
  Self.BevelOuter := bvNone;
  Self.Color := Self.FCor;
  Self.Height := APLICACAO_ALTURA;
  Self.Width := APLICACAO_LARGURA;
  Self.FLegenda := TLabel.Create(Self);
  Self.FLegenda.Name := Self.Name;
  Self.FLegenda.Font.Name := 'Segoe UI';
  Self.FLegenda.Font.Size := 14;
  Self.FLegenda.Font.Style := [];
  Self.FLegenda.Font.Color := $00F6EAE8;
  Self.FLegenda.Caption := Self.FTextoLegenda;
  Self.FLegenda.Hint := Self.FTextoDica;
  Self.FLegenda.Transparent := True;
  Self.FLegenda.Parent := Self;
  Self.FLegenda.Align := alClient;
  Self.FLegenda.Alignment := taCenter;
  Self.FLegenda.WordWrap := True;
  Self.Parent := Self.FContainer;
  Self.FLegenda.OnClick := Self.FAoSelecionarAplicacao;
  Result := Self;
end;

{ TAplicacao }

function TAplicacao.AtivarAplicacao(const Chamada: TChamada): TAplicacao;
begin
  Self.FChamada := Chamada;
  Result := Self;
end;

function TAplicacao.Configuracoes(const Configuracoes: TConfiguracoes): TAplicacao;
begin
  Self.FConfiguracoes := Configuracoes;
  Result := Self;
end;

function TAplicacao.Controlador(const Controlador: IResposta): TAplicacao;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TAplicacao.DataUtil(const DataUtil: TDataUtil): TAplicacao;
begin
  Self.FDataUtil := DataUtil;
  Result := Self;
end;

function TAplicacao.FabricaDeModelos(
  const FabricaDeModelos: TFabricaDeModelos): TAplicacao;
begin
  Self.FFabricaDeModelos := FabricaDeModelos;
  Result := Self;
end;

function TAplicacao.Util(const Util: TUtil): TAplicacao;
begin
  Self.FUtil := Util;
  Result := Self;
end;

{ TChamada }

function TChamada.AntesDeChamar(
  const EventoParaExecutarAntesDaChamada: TNotifyEvent): TChamada;
begin
  Self.FEventoParaExecutarAntesdaChamada := EventoParaExecutarAntesDaChamada;
  Result := Self;
end;

function TChamada.AposChamar(
  const EventoParaExecutarAposChamada: TNotifyEvent): TChamada;
begin
  Self.FEventoParaExecutarAposChamada := EventoParaExecutarAposChamada;
  Result := Self;
end;

function TChamada.Chamador(const Chamador: TObject): TChamada;
begin
  Self.FChamador := Chamador;
  Result := Self;
end;

function TChamada.ObterChamador: TObject;
begin
  Result := Self.FChamador;
end;

function TChamada.ObterParametros: TMap;
begin
  Result := Self.FParametros;
end;

function TChamada.Parametros(const Parametros: TMap): TChamada;
begin
  Self.FParametros := Parametros;
  Result := Self;  
end;

{ TConfiguracaoAplicacao }

function TConfiguracaoAplicacao.AntesDeAtivar(
  const EventoParaExecutarAntesDeAtivar: TNotifyEvent): TConfiguracaoAplicacao;
begin
  Self.FEventoParaExecutarAntesDeAtivar := EventoParaExecutarAntesDeAtivar;
  Result := Self;
end;

function TConfiguracaoAplicacao.AposDesativar(
  const EventoParaExecutarAposDesativar: TNotifyEvent): TConfiguracaoAplicacao;
begin
  Self.FEventoParaExecutarAposDesativar := EventoParaExecutarAposDesativar;
  Result := Self;
end;

function TConfiguracaoAplicacao.ObterOrigem: TObject;
begin
  Result := Self.FOrigem;
end;

function TConfiguracaoAplicacao.ObterParametros: TMap;
begin
  Result := Self.FParametros;
end;

function TConfiguracaoAplicacao.Origem(
  const Origem: TObject): TConfiguracaoAplicacao;
begin
  Self.FOrigem := Origem;
  Result := Self;
end;

function TConfiguracaoAplicacao.Parametros(
  const Parametros: TMap): TConfiguracaoAplicacao;
begin
  Self.FParametros := Parametros;
  Result := Self;
end;

end.
