unit UnDetalheComandaView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, JvExExtCtrls, JvExtComponent,
  JvPanel, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  { Fluente }
  UnModelo, Componentes, UnAplicacao;

type
  TComandaDetalheView = class(TForm, ITela)
    pnlDesktop: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    lblPagamentos: TLabel;
    gDetalhe: TDBGrid;
    pnlCommand: TJvPanel;
    btnOk: TPanel;
    procedure btnOkClick(Sender: TObject);
  private
    FControlador: IResposta;
    FModelo: TModelo;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function ExibirTela: Integer;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
  end;

var
  ComandaDetalheView: TComandaDetalheView;

implementation

{$R *.dfm}

procedure TComandaDetalheView.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

function TComandaDetalheView.Controlador(const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TComandaDetalheView.Descarregar: ITela;
begin
  Self.gDetalhe.DataSource :=  nil;
  Result := Self;
end;

function TComandaDetalheView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TComandaDetalheView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TComandaDetalheView.Preparar: ITela;
begin
  Self.gDetalhe.DataSource := Self.FModelo.DataSource(
    Self.FModelo.Parametros.Ler('datasource').ComoTexto);
  Self.lblPagamentos.Caption := FormatFloat('R$ ###,##0.00',
    Self.FModelo.Parametros.Ler('total').ComoDecimal);
  Result := Self;
end;

end.
