unit UnMovimentoDeContaCorrenteGeralReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TMovimentoContaCorrenteGeralReport = class(TQuickRep)
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
  private
  public
  end;

var
  MovimentoContaCorrenteGeralReport: TMovimentoContaCorrenteGeralReport;

implementation

{$R *.DFM}

end.
