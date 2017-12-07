unit UnResultadoGeralMesRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnRelatorioTemplate, RLReport, RLFilters, RLXLSXFilter,
  RLXLSFilter;

type
  TResultadoGeralMesRelatorio = class(TRelatorioTemplateView)
    txtCategoria: TRLDBText;
    txtValor: TRLDBText;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    procedure txtValorBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TResultadoGeralMesRelatorio.txtValorBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FormatFloat('#,##0.00',
    Self.RelatorioTemplate.DataSource.DataSet.FieldByName('JAN_').AsFloat);
end;

end.
