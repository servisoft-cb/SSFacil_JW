unit uDmTipoMaterial;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, DBClient, Provider;

type
  TdmCadTipoMaterial = class(TDataModule)
    sdsTipoMaterial: TSQLDataSet;
    dspTipoMaterial: TDataSetProvider;
    cdsTipoMaterial: TClientDataSet;
    dsTipoMaterial: TDataSource;
    sdsTipoMaterialID: TIntegerField;
    sdsTipoMaterialNOME: TStringField;
    cdsTipoMaterialID: TIntegerField;
    cdsTipoMaterialNOME: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vMsgErro: String;
    ctTipoMat: String;
    procedure prc_Localizar(ID: Integer); //-1 = Inclusão
    procedure prc_Inserir;
    procedure prc_Gravar;
    procedure prc_Excluir;
  end;

var
  dmCadTipoMaterial: TdmCadTipoMaterial;

implementation

uses DmdDatabase;

{$R *.dfm}

{ TdmCadTipoMaterial }

procedure TdmCadTipoMaterial.prc_Excluir;
begin
  if not(cdsTipoMaterial.Active) or (cdsTipoMaterial.IsEmpty) then
    Exit;
  cdsTipoMaterial.Delete;
  cdsTipoMaterial.ApplyUpdates(0);
end;

procedure TdmCadTipoMaterial.prc_Gravar;
begin
  vMsgErro := '';
  if trim(cdsTipoMaterialNOME.AsString) = '' then
    vMsgErro := vMsgErro + '***Nome não informado!';
  if vMsgErro <> '' then
    exit;
  cdsTipoMaterial.Post;
  cdsTipoMaterial.ApplyUpdates(0);
end;

procedure TdmCadTipoMaterial.prc_Inserir;
var
  vAux: Integer;
begin
  if not cdsTipoMaterial.Active then
    prc_Localizar(-1);
  vAux := dmDatabase.ProximaSequencia('TIPO_MAT',0);

  cdsTipoMaterial.Insert;
  cdsTipoMaterialID.AsInteger := vAux;
end;

procedure TdmCadTipoMaterial.prc_Localizar(ID: Integer);
begin
  cdsTipoMaterial.Close;
  sdsTipoMaterial.CommandText := ctTipoMat;
  if ID <> 0 then
    sdsTipoMaterial.CommandText := sdsTipoMaterial.CommandText + ' WHERE ID = ' + IntToStr(ID);
  cdsTipoMaterial.Open;
end;

procedure TdmCadTipoMaterial.DataModuleCreate(Sender: TObject);
begin
  ctTipoMat := sdsTipoMaterial.CommandText;
end;

end.
