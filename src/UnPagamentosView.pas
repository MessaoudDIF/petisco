unit UnPagamentosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, Grids, DBGrids, DB,
  StdCtrls,
  { Fluente }
  UnModelo, Componentes, UnAplicacao;

type
  TPagamentosView = class(TForm, ITela)
    pnlCommand: TJvPanel;
    btnOk: TPanel;
    pnlDesktop: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    gPagamentos: TDBGrid;
    lblPagamentos: TLabel;
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
  PagamentosView: TPagamentosView;

implementation

{$R *.dfm}

procedure TPagamentosView.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

function TPagamentosView.Descarregar: ITela;
begin
  Self.gPagamentos.DataSource :=  nil;
  Result := Self;
end;

function TPagamentosView.Preparar: ITela;
begin
  Self.gPagamentos.DataSource := Self.FModelo.DataSource(
    Self.FModelo.Parametros.Ler('datasource').ComoTexto);
  Self.lblPagamentos.Caption := FormatFloat('R$ ###,##0.00',
    Self.FModelo.Parametros.Ler('total').ComoDecimal);
  Result := Self;
end;

function TPagamentosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TPagamentosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TPagamentosView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FModelo := Modelo;
  Result := Self;  
end;

end.
