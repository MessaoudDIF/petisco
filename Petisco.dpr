program Petisco;

uses
  Forms,
  UnPetiscoView in 'UnPetiscoView.pas' {PetiscoView},
  DataUtil in 'src\DataUtil.pas',
  SearchUtil in 'src\SearchUtil.pas',
  Configuracoes in 'src\Configuracoes.pas',
  Componentes in 'src\Componentes.pas',
  Util in 'src\Util.pas',
  UnModelo in 'src\UnModelo.pas' {Modelo: TDataModule},
  UnProduto in 'src\UnProduto.pas',
  UnPetiscoModel in 'src\UnPetiscoModel.pas' {PetiscoModel: TDataModule},
  UnAbrirComandaView in 'src\UnAbrirComandaView.pas' {AbrirComandaView},
  UnClientePesquisaModelo in 'src\UnClientePesquisaModelo.pas' {ClientePesquisaModelo: TDataModule},
  UnComandaView in 'src\UnComandaView.pas' {ComandaView},
  ComandaAplicacao in 'src\ComandaAplicacao.pas',
  UnClienteLookUp in 'src\UnClienteLookUp.pas',
  UnDividirView in 'src\UnDividirView.pas' {DividirView},
  UnLancarCreditoView in 'src\UnLancarCreditoView.pas' {LancarCreditoView},
  UnLancarDebitoView in 'src\UnLancarDebitoView.pas' {LancarDebitoView},
  UnLancarDinheiroView in 'src\UnLancarDinheiroView.pas' {LancarDinheiroView},
  UnCartaoDebitoModeloPesquisa in 'src\UnCartaoDebitoModeloPesquisa.pas' {CartaoDebitoModeloPesquisa: TDataModule},
  UnFabricaDeModelos in 'src\UnFabricaDeModelos.pas',
  UnComandaModelo in 'src\UnComandaModelo.pas' {ComandaModelo: TDataModule},
  UnCartaoCreditoModeloPesquisa in 'src\UnCartaoCreditoModeloPesquisa.pas' {CartaoCreditoModeloPesquisa: TDataModule},
  UnPagamentosView in 'src\UnPagamentosView.pas' {PagamentosView},
  UnComandaPrint in 'src\UnComandaPrint.pas',
  UnImpressao in 'src\UnImpressao.pas' {ImpressaoView},
  UnFechamentoDeContaView in 'src\UnFechamentoDeContaView.pas' {FechamentoDeContaView},
  UnFechamentoDeContaModelo in 'src\UnFechamentoDeContaModelo.pas' {FechamentoDeContaModelo: TDataModule},
  Pagamentos in 'src\Pagamentos.pas',
  UnCaixaListaRegistrosView in 'src\UnCaixaListaRegistrosView.pas' {CaixaListaRegistrosView},
  UnCaixaRegistroView in 'src\UnCaixaRegistroView.pas' {CaixaRegistroView},
  UnCaixaMenuView in 'src\UnCaixaMenuView.pas' {CaixaMenuView},
  UnCaixaModelo in 'src\UnCaixaModelo.pas' {CaixaModelo: TDataModule},
  UnProdutoListaRegistrosView in 'src\UnProdutoListaRegistrosView.pas' {ProdutoListaRegistrosView},
  UnProdutoRegistroView in 'src\UnProdutoRegistroView.pas' {ProdutoRegistroView},
  UnProdutoListaRegistrosModelo in 'src\UnProdutoListaRegistrosModelo.pas' {ProdutoListaRegistrosModelo: TDataModule},
  UnProdutoRegistroModelo in 'src\UnProdutoRegistroModelo.pas' {ProdutoRegistroModelo: TDataModule},
  UnAplicacao in 'src\UnAplicacao.pas',
  UnFabricaDeAplicacoes in 'src\UnFabricaDeAplicacoes.pas',
  ProdutoAplicacao in 'src\ProdutoAplicacao.pas',
  ConectorDeControles in 'src\ConectorDeControles.pas',
  CaixaAplicacao in 'src\CaixaAplicacao.pas',
  FechamentoDeContaAplicacao in 'src\FechamentoDeContaAplicacao.pas',
  UnRemocaoInclusaoIngredientesView in 'src\UnRemocaoInclusaoIngredientesView.pas' {RemocaoInclusaoIngredientesView},
  UnMensagemView in 'src\UnMensagemView.pas' {MensagemView},
  UnMenuView in 'src\UnMenuView.pas' {MenuView},
  VendaRapidaAplicacao in 'src\VendaRapidaAplicacao.pas',
  UnVendaRapidaRegistroModelo in 'src\UnVendaRapidaRegistroModelo.pas' {VendaRapidaRegistroModelo: TDataModule},
  UnVendaRapidaRegistroView in 'src\UnVendaRapidaRegistroView.pas' {VendaRapidaRegistroView},
  UnTeclado in 'src\UnTeclado.pas' {Teclado: TFrame},
  Dominio in 'src\Dominio.pas',
  UnFabricaDeDominios in 'src\UnFabricaDeDominios.pas' {FabricaDeDominio: TDataModule},
  UnProdutoPesquisaModelo in 'src\UnProdutoPesquisaModelo.pas' {ProdutoPesquisaModelo: TDataModule},
  UnDetalheComandaView in 'src\UnDetalheComandaView.pas' {ComandaDetalheView};

{$R *.res}

var
  Main: TPetiscoView;

begin
  Application.Initialize;
  Application.Title := 'Petisco - Sistema de Gerenciamento de Lanchonetes e Restaurantes';
//  GlobalContainer.Build;
  Application.CreateForm(TPetiscoView, Main);
  Application.Run;
//  Main := Spring.Services.ServiceLocator.GetService<TPetiscoView>;
//  Main.ShowModal;
end.
