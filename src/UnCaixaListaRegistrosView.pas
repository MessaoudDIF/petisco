unit UnCaixaListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, JvExExtCtrls, JvExtComponent, JvPanel;

type
  TCaixaListaRegistrosView = class(TForm)
    Panel1: TPanel;
    pnlDesktop: TPanel;
    pnlFiltro: TPanel;
    DBGrid1: TDBGrid;
    JvPanel1: TJvPanel;
    Image1: TImage;
  private
  public
  end;

var
  CaixaListaRegistrosView: TCaixaListaRegistrosView;

implementation

{$R *.dfm}

end.
