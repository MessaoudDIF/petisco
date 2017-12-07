unit UnResultadoGeralAnoRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, UnRelatorioTemplate, RLReport, RLFilters, RLXLSFilter;

type
  TResultadoGeralAnoRelatorio = class(TRelatorioTemplateView)
    txtCategoria: TRLDBText;
    txtValor: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel14: TRLLabel;
  private
  public
  published
    procedure FormatarValor(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
  end;

var
  ResultadoGeralAnoRelatorio: TResultadoGeralAnoRelatorio;

implementation

{$R *.dfm}

procedure TResultadoGeralAnoRelatorio.FormatarValor(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
var
  _campo: TField;
begin
  inherited;
  _campo := (Sender as TRLDBText)
    .DataSource.DataSet.FieldByName((Sender as TRLDBText).Field.FieldName);
  if _campo.AsFloat < 0 then
    Text := '(' + FormatFloat('#,##0.00', _campo.AsFloat * -1) + ')'
  else
    Text := FormatFloat('#,##0.00', _campo.AsFloat);
end;

end.
