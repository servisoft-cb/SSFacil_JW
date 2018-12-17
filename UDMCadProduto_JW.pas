unit UDMCadProduto_JW;

interface

uses
  SysUtils, Classes, FMTBcd, DB, DBClient, Provider, SqlExpr, dbXPress, LogTypes, dialogs;

type
  TdmCadProduto_JW = class(TDataModule)
    sdsProduto_JW: TSQLDataSet;
    dspProduto_JW: TDataSetProvider;
    cdsProduto_JW: TClientDataSet;
    dsProduto_JW: TDataSource;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    cdsConsultaID: TIntegerField;
    cdsConsultaNOME: TStringField;
    cdsConsultaID_COR: TIntegerField;
    cdsConsultaTIPO_REG: TStringField;
    cdsConsultaID_TIPO_MAT: TIntegerField;
    cdsConsultaDIAMETRO: TFloatField;
    cdsConsultaCOMPRIMENTO: TFloatField;
    cdsConsultaESPESSURA: TFloatField;
    cdsConsultaLARGURA: TFloatField;
    cdsConsultaALTURA: TFloatField;
    cdsConsultaDIAMETRO_INT: TFloatField;
    cdsConsultaDIAMETRO_EXT: TFloatField;
    cdsConsultaLOCALIZACAO: TStringField;
    cdsConsultaNOME_COR: TStringField;
    cdsConsultaNOME_TIPO_MAT: TStringField;
    sdsProduto_JWID: TIntegerField;
    sdsProduto_JWNOME: TStringField;
    sdsProduto_JWID_COR: TIntegerField;
    sdsProduto_JWTIPO_REG: TStringField;
    sdsProduto_JWID_TIPO_MAT: TIntegerField;
    sdsProduto_JWDIAMETRO: TFloatField;
    sdsProduto_JWCOMPRIMENTO: TFloatField;
    sdsProduto_JWESPESSURA: TFloatField;
    sdsProduto_JWLARGURA: TFloatField;
    sdsProduto_JWALTURA: TFloatField;
    sdsProduto_JWDIAMETRO_INT: TFloatField;
    sdsProduto_JWDIAMETRO_EXT: TFloatField;
    sdsProduto_JWLOCALIZACAO: TStringField;
    cdsProduto_JWID: TIntegerField;
    cdsProduto_JWNOME: TStringField;
    cdsProduto_JWID_COR: TIntegerField;
    cdsProduto_JWTIPO_REG: TStringField;
    cdsProduto_JWID_TIPO_MAT: TIntegerField;
    cdsProduto_JWDIAMETRO: TFloatField;
    cdsProduto_JWCOMPRIMENTO: TFloatField;
    cdsProduto_JWESPESSURA: TFloatField;
    cdsProduto_JWLARGURA: TFloatField;
    cdsProduto_JWALTURA: TFloatField;
    cdsProduto_JWDIAMETRO_INT: TFloatField;
    cdsProduto_JWDIAMETRO_EXT: TFloatField;
    cdsProduto_JWLOCALIZACAO: TStringField;
    sdsCombinacao: TSQLDataSet;
    dspCombinacao: TDataSetProvider;
    cdsCombinacao: TClientDataSet;
    dsCombinacao: TDataSource;
    cdsCombinacaoID: TFMTBCDField;
    cdsCombinacaoNOME: TStringField;
    sdsTipo_Mat: TSQLDataSet;
    dspTipo_Mat: TDataSetProvider;
    cdsTipo_Mat: TClientDataSet;
    dsTipo_Mat: TDataSource;
    cdsTipo_MatID: TIntegerField;
    cdsTipo_MatNOME: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dspProduto_JWUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError;
      UpdateKind: TUpdateKind; var Response: TResolverResponse);
    procedure cdsProduto_JWReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    vID_Produto_Forn : Integer;
    procedure DoLogAdditionalValues(ATableName: string; var AValues: TArrayLogData; var UserName: string);
  public
    { Public declarations }
    vMsgErro: String;
    ctCommand: String;
    ctConsulta: String;

    procedure prc_Localizar(ID: Integer); //-1 = Inclusão
    procedure prc_Inserir;
    procedure prc_Gravar;
    procedure prc_Excluir;

    function fnc_Possui_Erro: Boolean;
  end;

var
  dmCadProduto_JW: TdmCadProduto_JW;

implementation

uses DmdDatabase, LogProvider, uUtilPadrao;

{$R *.dfm}

{ TDMCadPais }

procedure TdmCadProduto_JW.prc_Inserir;
var
  vAux: Integer;
begin
  if not cdsProduto_JW.Active then
    prc_Localizar(-1);
  vAux := dmDatabase.ProximaSequencia('PRODUTO_JW',0);

  cdsProduto_JW.Insert;
  cdsProduto_JWID.AsInteger := vAux;
end;

procedure TdmCadProduto_JW.prc_Excluir;
begin
  vMsgErro := '';
  if not(cdsProduto_JW.Active) or (cdsProduto_JW.IsEmpty) then
    exit;
  cdsProduto_JW.Delete;
  cdsProduto_JW.ApplyUpdates(0);
end;

procedure TdmCadProduto_JW.prc_Gravar;
begin
  cdsProduto_JW.Post;
  cdsProduto_JW.ApplyUpdates(0);
end;

procedure TdmCadProduto_JW.prc_Localizar(ID: Integer);
begin
  cdsProduto_JW.Close;
  sdsProduto_JW.CommandText := ctCommand;
  if ID <> 0 then
    sdsProduto_JW.CommandText := sdsProduto_JW.CommandText + ' WHERE PRO.ID = ' + IntToStr(ID);
  cdsProduto_JW.Open;
end;

procedure TdmCadProduto_JW.DataModuleCreate(Sender: TObject);
var
  i, x: Integer;
  vIndices: string;
  aIndices: array of string;
begin
  ctCommand  := sdsProduto_JW.CommandText;
  ctConsulta := sdsConsulta.CommandText;
  cdsCombinacao.Open;
  cdsTipo_Mat.Open;

  LogProviderList.OnAdditionalValues := DoLogAdditionalValues;
  for i := 0 to (Self.ComponentCount - 1) do
  begin
    if (Self.Components[i] is TClientDataSet) then
    begin
      SetLength(aIndices, 0);
      vIndices := TClientDataSet(Components[i]).IndexFieldNames;
      while (vIndices <> EmptyStr) do
      begin
        SetLength(aIndices, Length(aIndices) + 1);
        x := Pos(';', vIndices);
        if (x = 0) then
        begin
          aIndices[Length(aIndices) - 1] := vIndices;
          vIndices := EmptyStr;
        end
        else
        begin
          aIndices[Length(aIndices) - 1] := Copy(vIndices, 1, x - 1);
          vIndices := Copy(vIndices, x + 1, MaxInt);
        end;
      end;
      LogProviderList.AddProvider(TClientDataSet(Self.Components[i]), TClientDataSet(Self.Components[i]).Name, aIndices);
    end;
  end;
end;

procedure TdmCadProduto_JW.dspProduto_JWUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  dmDatabase.prc_UpdateError(DataSet.Name,UpdateKind,E);
end;

procedure TdmCadProduto_JW.DoLogAdditionalValues(ATableName: string;
  var AValues: TArrayLogData; var UserName: string);
begin
  UserName := vUsuario;
end;

function TdmCadProduto_JW.fnc_Possui_Erro: Boolean;
begin
  Result   := True;
  vMsgErro := '';
  if trim(cdsProduto_JWNOME.AsString) = '' then
    vMsgErro := vMsgErro + #13 + '*** Nome não informado!';
  if vMsgErro <> '' then
    exit;
  Result := False;
end;

procedure TdmCadProduto_JW.cdsProduto_JWReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  if trim(e.Message) <> '' then
    MessageDlg(e.Message + #13 + '*** Produto não gravado!', mtError, [mbOk], 0);
end;

end.


