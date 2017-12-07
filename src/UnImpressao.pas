unit UnImpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Vcl.ExtCtrls, Printers;

type
  TImpressaoView = class(TForm)
    Impressao: TRichEdit;
    pnlCommandBar: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  public
    function Descarregar: TImpressaoView;
    function Preparar: TImpressaoView;
  end;

var
  ImpressaoView: TImpressaoView;

implementation

{$R *.dfm}

{ TImpressaoView }

procedure TImpressaoView.Button1Click(Sender: TObject);
var
  _arquivoTexto : TextFile;
  _i: Integer;
begin
  AssignPrn(_arquivoTexto);
  Rewrite(_arquivoTexto);
  for _i := 0 to Self.Impressao.Lines.Count-1 do
    Writeln(_arquivoTexto, Self.Impressao.Lines[_i]);
  CloseFile(_arquivoTexto);
end;

function TImpressaoView.Descarregar: TImpressaoView;
begin
  Result := Self;
end;

function TImpressaoView.Preparar: TImpressaoView;
begin
  Result := Self;
end;

end.
