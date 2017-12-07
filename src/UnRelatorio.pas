unit UnRelatorio;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, RLReport, DB,
  { helsonsant }
  Util, DataUtil, UnModelo, Relatorios, QRCtrls, QuickRpt;

type
  TRelatorio = class(TRLReport, IReport)
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    lblNumeroDePagina: TQRLabel;
    lblTitulo: TQRLabel;
    lblSubtitulo: TQRLabel;
    QRImage1: TQRImage;
    QRLabel3: TQRLabel;
    procedure lblNumeroDePaginaPrint(sender: TObject; var Value: String);
  private
    FModelo: TModelo;
    FTotalDePaginas: Integer;
  public
    function Dados(const Dados: TDataSet): IReport;
    function Modelo(const Modelo: TModelo): IReport;
    function ObterRelatorio: TRLReport;
    function Subtitulo(const Subtitulo: string): IReport;
    function Titulo(const Titulo: string): IReport;
    function TotalDePaginas(const TotalDePaginas: Integer): IReport;
  end;

var
  Relatorio: TRelatorio;

implementation

{$R *.DFM}

{ TRelatorio }

function TRelatorio.Dados(const Dados: TDataSet): IReport;
var
  _i: Integer;
begin
  Self.DataSet := Dados;
  for _i := 0 to Self.ComponentCount-1 do
    if Self.Components[_i].Tag > 0 then
      TQRDBText(Self.Components[_i]).DataSet := Self.DataSet;
end;

function TRelatorio.Modelo(const Modelo: TModelo): IReport;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TRelatorio.ObterRelatorio: TRLReport;
begin
  Result := Self;
end;

function TRelatorio.Subtitulo(const Subtitulo: string): IReport;
begin
  Self.lblSubtitulo.Caption := Subtitulo;
  Result := Self;
end;

function TRelatorio.Titulo(const Titulo: string): IReport;
begin
  Self.lblTitulo.Caption := Titulo;
  Result := Self;
end;

function TRelatorio.TotalDePaginas(const TotalDePaginas: Integer): IReport;
begin
  Self.FTotalDePaginas := TotalDePaginas;
  Result := Self;
end;

procedure TRelatorio.lblNumeroDePaginaPrint(sender: TObject; var Value: String);
begin
  Value := IntToStr(Self.PageNumber) + '/' + IntToStr(Self.FTotalDePaginas);
end;

end.
 