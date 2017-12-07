unit Aplicacao;

interface

uses Classes, ExtCtrls, Controls, StdCtrls,
  { Fluente }
  Util, DataUtil, Configuracoes, Componentes;

type
  TAplicacaoBloco  = class(TPanel)
  private
    FAoSelecionarAplicacao: TNotifyEvent;
    FContainer: TWinControl;
    FCor: Integer;
    FLegenda: TLabel;
    FTextoDica: string;
    FTextoLegenda: string;
  public
    function AoSelecionarAplicacao(
      const ExecutarAoSelecionarAplicacao: TNotifyEvent): TAplicacaoBloco;
    function Container(const Container: TWinControl): TAplicacaoBloco;
    function Cor(const Cor: Integer): TAplicacaoBloco;
    function Dica(const TextoDaDica: string): TAplicacaoBloco;
    function Legenda(const TextoDaLegenda: string): TAplicacaoBloco;
    function Preparar: TAplicacaoBloco;
  end;

  TAplicacao = class
  private
    FConfiguracoes: TConfiguracoes;
    FDataUtil: TDataUtil;
    FModelo: string;
    FTelaPrincipal: string;
    FUtil: TUtil;
  public
    function Configuracoes(const Configuracoes: TConfiguracoes): TAplicacao;
    function DataUtil(const DataUtil: TDataUtil): TAplicacao;
    function Modelo(const Modelo: string): TAplicacao;
    function TelaPrincipal(const TelaPrincipal: string): TAplicacao;
    function Util(const Util: TUtil): TAplicacao;
    function Preparar: TAplicacao; virtual; abstract;
  end;

implementation

{ TAplicacaoBloco }

function TAplicacaoBloco.AoSelecionarAplicacao(
  const ExecutarAoSelecionarAplicacao: TNotifyEvent): TAplicacaoBloco;
begin
  Self.FAoSelecionarAplicacao := ExecutarAoSelecionarAplicacao;
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
  Self.BevelInner := bvNone;
  Self.BevelOuter := bvNone;
  Self.Color := Self.FCor;
  Self.Height := APLICACAO_ALTURA;
  Self.Width := APLICACAO_LARGURA;
  Self.FLegenda := TLabel.Create(Self);
  Self.FLegenda.Font.Name := 'Segoe UI';
  Self.FLegenda.Font.Size := 14;
  Self.FLegenda.Font.Style := [];
  if (Self.FCor = VERDE) or (Self.FCor = AMARELO) then
    Self.FLegenda.Font.Color := $007E231A
  else
    Self.FLegenda.Font.Color := $00F6EAE8;
  Self.FLegenda.Caption := Self.FTextoLegenda;
  Self.FLegenda.Hint := Self.FTextoDica;
  Self.FLegenda.Transparent := True;
  Self.FLegenda.Parent := Self;
  Self.FLegenda.Align := alClient;
  Self.FLegenda.Alignment := taCenter;
  Self.FLegenda.WordWrap := True;
  Self.Parent := Self.FContainer;
  Result := Self;
end;

{ TAplicacao }

function TAplicacao.Configuracoes(const Configuracoes: TConfiguracoes): TAplicacao;
begin
  Self.FConfiguracoes := Configuracoes;
  Result := Self;
end;

function TAplicacao.DataUtil(const DataUtil: TDataUtil): TAplicacao;
begin
  Self.FDataUtil := DataUtil;
  Result := Self;
end;

function TAplicacao.Modelo(const Modelo: string): TAplicacao;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TAplicacao.TelaPrincipal(const TelaPrincipal: string): TAplicacao;
begin
  Self.FTelaPrincipal := TelaPrincipal;
  Result := Self;
end;

function TAplicacao.Util(const Util: TUtil): TAplicacao;
begin
  Self.FUtil := Util;
  Result := Self;
end;

end.
