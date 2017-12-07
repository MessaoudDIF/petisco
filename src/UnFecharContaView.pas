unit UnFecharContaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DB, JvExExtCtrls, JvExtComponent,
  JvPanel,
  { Fluente }
  UnComandaModelo, UnComandaController;

type
  TFecharContaView = class(TForm)
    pnlDesktop: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    gConsumo: TDBGrid;
    JvPanel1: TJvPanel;
    pnlDetalheView: TPanel;
    DetalheView: TMemo;
    btnDividir: TPanel;
    btnLancarDebito: TPanel;
    btnLancarCredito: TPanel;
    btnLancarDinheiro: TPanel;
    btnVisualizarPagamentos: TPanel;
    btnFecharConta: TPanel;
    procedure btnDividirClick(Sender: TObject);
    procedure btnLancarDebitoClick(Sender: TObject);
    procedure btnLancarCreditoClick(Sender: TObject);
    procedure btnLancarDinheiroClick(Sender: TObject);
  private
    FComandaModelo: TComandaModelo;
    FComandaController: TComandaController;
  public
    function ComandaModelo(
      const ComandaModelo: TComandaModelo): TFecharContaView;
    function ComandaController(
      const ComandaController: TComandaController): TFecharContaView;
    function Descarregar: TFecharContaView;
    function Preparar: TFecharContaView;
    procedure AtualizarDivisaoDaConta(Sender: TObject);
    procedure AtualizarConta(Sender: TObject);
  end;

var
  FecharContaView: TFecharContaView;

implementation

{$R *.dfm}

{ TFecharContaView }

procedure TFecharContaView.AtualizarDivisaoDaConta(Sender: TObject);
begin
  Self.DetalheView.Lines.Clear();
  Self.DetalheView.Text := Self.FComandaModelo.Parametros.LerParametro('msg');
end;

procedure TFecharContaView.btnDividirClick(Sender: TObject);
begin
  Self.FComandaController.Dividir(Self, Self.AtualizarDivisaoDaConta);
end;

procedure TFecharContaView.btnLancarDinheiroClick(Sender: TObject);
begin
  Self.FComandaController.LancarDinheiro(Self, Self.AtualizarConta);
end;

procedure TFecharContaView.btnLancarCreditoClick(Sender: TObject);
begin
  Self.FComandaController.LancarCredito(Self, Self.AtualizarConta);
end;

procedure TFecharContaView.btnLancarDebitoClick(Sender: TObject);
begin
  Self.FComandaController.LancarDebito(Self, Self.AtualizarConta);
end;

function TFecharContaView.ComandaController(
  const ComandaController: TComandaController): TFecharContaView;
begin
  Self.FComandaController := ComandaController;
  Result := Self;
end;

function TFecharContaView.ComandaModelo(
  const ComandaModelo: TComandaModelo): TFecharContaView;
begin
  Self.FComandaModelo := ComandaModelo;
  Result := Self;
end;

function TFecharContaView.Preparar: TFecharContaView;
begin
  Self.gConsumo.DataSource := Self.FComandaModelo.DataSource('comai');
  Result := Self;
end;

procedure TFecharContaView.AtualizarConta(Sender: TObject);
begin

end;

function TFecharContaView.Descarregar: TFecharContaView;
begin
  Self.FComandaModelo := nil;
  Self.FComandaController := nil;
  Result := Self;
end;

end.
