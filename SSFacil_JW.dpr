program SSFacil_JW;

uses
  Forms,
  UMenu in 'UMenu.pas' {fMenu},
  DmdDatabase in '..\ssfacil\DmdDatabase.pas' {dmDatabase: TDataModule},
  rsDBUtils in '..\rslib\nova\rsDBUtils.pas',
  LogProvider in '..\logs\src\LogProvider.pas',
  LogTypes in '..\logs\src\LogTypes.pas',
  uNFeComandos in '..\ssfacil\uNFeComandos.pas',
  uNFeConsts in '..\NFe 3.10\NFESrv\uNFeConsts.pas',
  USel_Pessoa in '..\ssfacil\USel_Pessoa.pas' {frmSel_Pessoa},
  uUtilPadrao in '..\ssfacil\uUtilPadrao.pas',
  UEscolhe_Filial in '..\ssfacil\UEscolhe_Filial.pas' {frmEscolhe_Filial},
  UCadProduto_JW in 'UCadProduto_JW.pas' {frmCadProduto_JW},
  UDMCadProduto_JW in 'UDMCadProduto_JW.pas' {dmCadProduto_JW: TDataModule},
  uCadTipoMaterial in 'uCadTipoMaterial.pas' {frmCadTipoMaterial},
  uDmTipoMaterial in 'uDmTipoMaterial.pas' {dmCadTipoMaterial: TDataModule},
  UDMCadCor in '..\ssfacil\UDMCadCor.pas' {DMCadCor: TDataModule},
  UCadCor in '..\ssfacil\UCadCor.pas' {frmCadCor},
  uCadMovProdutos in 'uCadMovProdutos.pas' {frmCadMovProdutos},
  uDmCadMovProdutos in 'uDmCadMovProdutos.pas' {dmCadMovProdutos: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Entrada/Saída Produtos';
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfMenu, fMenu);
  Application.Run;
end.
