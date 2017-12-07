program Petisco;

uses
  Forms,
  UnFood in 'UnFood.pas' {FoodApp},
  Settings in 'Settings.pas',
  DataUtil in 'DataUtil.pas',
  SearchUtil in 'SearchUtil.pas',
  UnAbrirComandaView in 'UnAbrirComandaView.pas' {AbrirComandaView},
  UnAlterarIngredientesView in 'UnAlterarIngredientesView.pas' {Form6},
  UnCartaoDebitoSearchModel in 'UnCartaoDebitoSearchModel.pas',
  UnClienteLookUp in 'UnClienteLookUp.pas',
  UnClienteModelSearch in 'UnClienteModelSearch.pas',
  UnComandaController in 'UnComandaController.pas',
  UnComandaModel in 'UnComandaModel.pas' {ComandaModel: TDataModule},
  UnDividirView in 'UnDividirView.pas' {DividirView},
  UnFecharContaView in 'UnFecharContaView.pas' {FecharContaView},
  UnFoodModel in 'UnFoodModel.pas' {FoodModel: TDataModule},
  UnItemsView in 'UnItemsView.pas' {ItemsView},
  UnLancarCreditoView in 'UnLancarCreditoView.pas' {LancarCreditoView},
  UnLancarDebitoView in 'UnLancarDebitoView.pas' {LancarDebitoView},
  UnLancarDinheiroView in 'UnLancarDinheiroView.pas' {LancarDinheiroView},
  UnLancarPagamentoView in 'UnLancarPagamentoView.pas' {LancarPagamentoView},
  UnModel in 'UnModel.pas' {Model: TDataModule},
  UnProduto in 'UnProduto.pas',
  UnProdutoSearch in 'UnProdutoSearch.pas',
  UnProdutoSearchModel in 'UnProdutoSearchModel.pas' {ProdutoSearchModel: TDataModule},
  UnWidgets in 'UnWidgets.pas',
  Util in 'Util.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFoodApp, FoodApp);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TComandaModel, ComandaModel);
  Application.CreateForm(TDividirView, DividirView);
  Application.CreateForm(TFecharContaView, FecharContaView);
  Application.CreateForm(TFoodModel, FoodModel);
  Application.CreateForm(TItemsView, ItemsView);
  Application.CreateForm(TLancarCreditoView, LancarCreditoView);
  Application.CreateForm(TLancarDebitoView, LancarDebitoView);
  Application.CreateForm(TLancarDinheiroView, LancarDinheiroView);
  Application.CreateForm(TLancarPagamentoView, LancarPagamentoView);
  Application.CreateForm(TProdutoSearchModel, ProdutoSearchModel);
  Application.Run;
end.
