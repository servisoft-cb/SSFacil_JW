unit uDmCadMovProdutos;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, DBClient, Provider;

type
  TdmCadMovProdutos = class(TDataModule)
    sdsMovProdutos: TSQLDataSet;
    dspMovProdutos: TDataSetProvider;
    cdsMovProdutos: TClientDataSet;
    dsMovProdutos: TDataSource;
    sdsMovProdutosItens: TSQLDataSet;
    cdsMovProdutosItens: TClientDataSet;
    dsMovProdutosItens: TDataSource;
    sdsMovProdutosID: TIntegerField;
    sdsMovProdutosDATA: TDateField;
    sdsMovProdutosID_PESSOA: TIntegerField;
    sdsMovProdutosVLR_TOTAL: TFloatField;
    sdsMovProdutosQTD_PECA: TIntegerField;
    sdsMovProdutosTIPO_ES: TStringField;
    sdsMovProdutosNUM_DOC: TIntegerField;
    sdsMovProdutosNUM_NOTA: TIntegerField;
    sdsMovProdutosSERIE: TStringField;
    cdsMovProdutosID: TIntegerField;
    cdsMovProdutosDATA: TDateField;
    cdsMovProdutosID_PESSOA: TIntegerField;
    cdsMovProdutosVLR_TOTAL: TFloatField;
    cdsMovProdutosQTD_PECA: TIntegerField;
    cdsMovProdutosTIPO_ES: TStringField;
    cdsMovProdutosNUM_DOC: TIntegerField;
    cdsMovProdutosNUM_NOTA: TIntegerField;
    cdsMovProdutosSERIE: TStringField;
    mdsMovProdutos: TDataSource;
    cdsMovProdutossdsMovProdutosItens: TDataSetField;
    sdsMovProdutosItensID: TIntegerField;
    sdsMovProdutosItensITEM: TIntegerField;
    sdsMovProdutosItensID_PRODUTO: TIntegerField;
    sdsMovProdutosItensNOME_PRODUTO: TStringField;
    sdsMovProdutosItensQTD: TIntegerField;
    sdsMovProdutosItensCODBARRA: TFMTBCDField;
    sdsMovProdutosItensCODBARRA_SEQ: TIntegerField;
    sdsMovProdutosItensETIQUETA_IMP: TStringField;
    cdsMovProdutosItensID: TIntegerField;
    cdsMovProdutosItensITEM: TIntegerField;
    cdsMovProdutosItensID_PRODUTO: TIntegerField;
    cdsMovProdutosItensNOME_PRODUTO: TStringField;
    cdsMovProdutosItensQTD: TIntegerField;
    cdsMovProdutosItensCODBARRA: TFMTBCDField;
    cdsMovProdutosItensCODBARRA_SEQ: TIntegerField;
    cdsMovProdutosItensETIQUETA_IMP: TStringField;
    sdsPessoa: TSQLDataSet;
    dspPessoa: TDataSetProvider;
    cdsPessoa: TClientDataSet;
    dsPessoa: TDataSource;
    cdsPessoaCODIGO: TIntegerField;
    cdsPessoaNOME: TStringField;
    sdsJWProduto: TSQLDataSet;
    dspJWProduto: TDataSetProvider;
    cdsJWProduto: TClientDataSet;
    dsJWProduto: TDataSource;
    cdsJWProdutoID: TIntegerField;
    cdsJWProdutoNOME: TStringField;
    cdsJWProdutoID_COR: TIntegerField;
    cdsJWProdutoTIPO_REG: TStringField;
    cdsJWProdutoID_TIPO_MAT: TIntegerField;
    cdsJWProdutoDIAMETRO: TFloatField;
    cdsJWProdutoCOMPRIMENTO: TFloatField;
    cdsJWProdutoESPESSURA: TFloatField;
    cdsJWProdutoLARGURA: TFloatField;
    cdsJWProdutoALTURA: TFloatField;
    cdsJWProdutoDIAMETRO_INT: TFloatField;
    cdsJWProdutoDIAMETRO_EXT: TFloatField;
    cdsJWProdutoLOCALIZACAO: TStringField;
    cdsJWProdutoINATIVO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vMsgErro: String;
    ctMovProd: String;
    ctJWProd: String;
    ctPessoa: String;
    procedure prc_Localizar(vId: Integer);
    procedure prc_Inserir;
    procedure prc_Gravar;
    procedure prc_Excluir;
  end;

var
  dmCadMovProdutos: TdmCadMovProdutos;

implementation

uses DmdDatabase;

{$R *.dfm}

{ TdmCadMovProdutos }

procedure TdmCadMovProdutos.prc_Excluir;
begin

end;

procedure TdmCadMovProdutos.prc_Gravar;
begin
  vMsgErro := '';
  if trim(cdsMovProdutosID_PESSOA.AsString) = '' then
    vMsgErro := vMsgErro + '***Pessoa não informada!';
  if vMsgErro <> '' then
    exit;
  cdsMovProdutos.Post;
  cdsMovProdutos.ApplyUpdates(0);
end;

procedure TdmCadMovProdutos.prc_Inserir;
var
  vAux: Integer;
begin
  if not cdsMovProdutos.Active then
    prc_Localizar(-1);
  vAux := dmDatabase.ProximaSequencia('JW_ENTSAI',0);

  cdsMovProdutos.Insert;
  cdsMovProdutosID.AsInteger     := vAux;
  cdsMovProdutosTIPO_ES.AsString := 'S';
  cdsMovProdutosDATA.AsDateTime  := Date;
end;

procedure TdmCadMovProdutos.DataModuleCreate(Sender: TObject);
begin
  ctMovProd := sdsMovProdutos.CommandText;
  ctJWProd  := sdsJWProduto.CommandText;
end;

procedure TdmCadMovProdutos.prc_Localizar(vId: Integer);
begin
  cdsMovProdutos.Close;
  sdsMovProdutos.CommandText := ctMovProd;
  if vId <> 0 then
    sdsMovProdutos.CommandText := sdsMovProdutos.CommandText + ' WHERE ID = ' + IntToStr(vId);
  cdsMovProdutos.Open;
end;

end.
