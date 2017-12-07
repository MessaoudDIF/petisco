unit UnRelatorioTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, RLFilters, RLXLSXFilter, 
  { helsonsant }
  UnModelo, Relatorios, RLXLSFilter;

type
  TRelatorioTemplateView = class(TForm, IReport)
    RelatorioTemplate: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    lblTitulo: TRLLabel;
    lblSubtitulo: TRLLabel;
    RLLabel3: TRLLabel;
    RLImage1: TRLImage;
    RLLabel5: TRLLabel;
    NumeroDaUltimaPagina: TRLSystemInfo;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    NumeroDaPagina: TRLSystemInfo;
    FiltroExcel: TRLXLSFilter;
    procedure RLLabel4BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure NumeracaoDaPaginaBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure NumeroDaUltimaPaginaBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
  private
    FModelo: TModelo;
  public
    function Dados(const Dados: TDataSource): IReport;
    function Modelo(const Modelo: TModelo): IReport;
    function ObterRelatorio: TRLReport;
    function Subtitulo(const Subtitulo: string): IReport;
    function Titulo(const Titulo: string): IReport;
  end;

var
  RelatorioTemplateView: TRelatorioTemplateView;

implementation


{$R *.dfm}

procedure TRelatorioTemplateView.RLLabel4BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := Self.NumeroDaPagina.Text + Self.NumeroDaUltimaPagina.Text;
end;

procedure TRelatorioTemplateView.NumeracaoDaPaginaBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
  ShowMessage(Self.NumeroDaPagina.Text + '/' + Self.NumeroDaUltimaPagina.Text);
  Text := Self.NumeroDaPagina.Text + '/' + Self.NumeroDaUltimaPagina.Text;
end;

function TRelatorioTemplateView.Dados(const Dados: TDataSource): IReport;
var
  _i: Integer;
begin
  Result := Self;
  Self.RelatorioTemplate.DataSource := Dados;
  for _i := 0 to Self.ComponentCount-1 do
    if Self.Components[_i].Tag > 0 then
      TRLDBText(Self.Components[_i]).DataSource := Dados;
end;

function TRelatorioTemplateView.Modelo(const Modelo: TModelo): IReport;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TRelatorioTemplateView.ObterRelatorio: TRLReport;
begin
  Result := Self.RelatorioTemplate;
end;

function TRelatorioTemplateView.Subtitulo(const Subtitulo: string): IReport;
begin
  Self.lblSubtitulo.Caption := Subtitulo;
  Result := Self;
end;

function TRelatorioTemplateView.Titulo(const Titulo: string): IReport;
begin
  Self.lblTitulo.Caption := Titulo;
  Result := Self;
end;

procedure TRelatorioTemplateView.NumeroDaUltimaPaginaBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
  Text := Trim(Text);
end;

end.
