unit UCadProduto_JW;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons, Grids, SMDBGrid, UDMCadProduto_JW, Menus,
  UCBase, StdCtrls, DBCtrls, RxDBComb, RxLookup, RXDBCtrl, ToolEdit, CurrEdit, ExtCtrls, RzTabs, dbXPress, RzPanel, Mask, DB,
  NxCollection, DBVGrids, DBGrids, SqlExpr, DBAdvGrid, AdvDBLookupComboBox, ComCtrls, RzChkLst, RzLstBox, ExtDlgs, Variants,
  StrUtils;

type
  TfrmCadProduto_JW = class(TForm)
    RzPageControl1: TRzPageControl;
    TS_Consulta: TRzTabSheet;
    TS_Cadastro: TRzTabSheet;
    SMDBGrid1: TSMDBGrid;
    Panel2: TPanel;
    Panel1: TPanel;
    StaticText1: TStaticText;
    pnlCons_Produto: TPanel;
    Label6: TLabel;
    edtNome: TEdit;
    RzPageControl2: TRzPageControl;
    TabSheet1: TRzTabSheet;
    pnlCadastro: TPanel;
    Label1: TLabel;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    UCControls1: TUCControls;
    Label44: TLabel;
    btnInserir: TNxButton;
    btnExcluir: TNxButton;
    btnPesquisar: TNxButton;
    btnConsultar: TNxButton;
    btnAlterar: TNxButton;
    btnCancelar: TNxButton;
    btnConfirmar: TNxButton;
    StaticText2: TStaticText;
    Label108: TLabel;
    RxDBLookupCombo15: TRxDBLookupCombo;
    RxDBComboBox7: TRxDBComboBox;
    Label25: TLabel;
    Label2: TLabel;
    RxDBLookupCombo1: TRxDBLookupCombo;
    RzPageControl3: TRzPageControl;
    Tab1: TRzTabSheet;
    Tab2: TRzTabSheet;
    Tab3: TRzTabSheet;
    Tab4: TRzTabSheet;
    Label7: TLabel;
    DBEdit14: TDBEdit;
    DBEdit7: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit3: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit5: TDBEdit;
    Label11: TLabel;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    DBEdit9: TDBEdit;
    Label14: TLabel;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit12: TDBEdit;
    Label17: TLabel;
    ComboBox1: TComboBox;
    ceID: TCurrencyEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure SMDBGrid1DblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtNomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzPageControl1Change(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure RxDBComboBox7Exit(Sender: TObject);
  private
    { Private declarations }
    fDMCadProduto_JW: TDMCadProduto_JW;

    procedure prc_Inserir_Registro;
    procedure prc_Excluir_Registro;
    procedure prc_Gravar_Registro;
    procedure prc_Consultar;

    procedure prc_Posiciona_Produto;
    procedure prc_Habilita;
    procedure prc_Limpar_Edit_Consulta;
  public
    { Public declarations }
    vID_Produto_Local: Integer;
  end;

var
  frmCadProduto_JW: TfrmCadProduto_JW;

implementation

uses rsDBUtils, uUtilPadrao, DmdDatabase, VarUtils;

{$R *.dfm}

procedure TfrmCadProduto_JW.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmCadProduto_JW.btnExcluirClick(Sender: TObject);
begin
  if not(fDMCadProduto_JW.cdsConsulta.Active) or (fDMCadProduto_JW.cdsConsulta.IsEmpty) or
        (fDMCadProduto_JW.cdsConsultaID.AsInteger <= 0) then
    exit;

  prc_Posiciona_Produto;

  if fDMCadProduto_JW.cdsProduto_JW.IsEmpty then
    exit;

  if MessageDlg('Deseja excluir este registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  prc_Excluir_Registro;
  btnConsultarClick(Sender);
end;

procedure TfrmCadProduto_JW.prc_Excluir_Registro;
var
  vCodAux: Integer;
begin
  try
    vCodAux := fDMCadProduto_JW.cdsProduto_JWID.AsInteger;
    fDMCadProduto_JW.prc_Excluir;
  except
    on e: Exception do
    begin
      prc_Consultar;
      if vCodAux > 0 then
         fDMCadProduto_JW.cdsProduto_JW.Locate('ID',vCodAux,([Locaseinsensitive]));
      raise;
    end
  end;
end;

procedure TfrmCadProduto_JW.prc_Gravar_Registro;
var
  vIDAux: Integer;
  sds: TSQLDataSet;
  ID: TTransactionDesc;
  vGerar_Ref: Boolean;
  vAux: Integer;
begin
  vIDAux := fDMCadProduto_JW.cdsProduto_JWID.AsInteger;

  if fDMCadProduto_JW.fnc_Possui_Erro then
  begin
    MessageDlg(fDMCadProduto_JW.vMsgErro, mtError, [mbOk], 0);
    exit;
  end;

  sds := TSQLDataSet.Create(nil);

  ID.TransactionID  := 3;
  ID.IsolationLevel := xilREADCOMMITTED;
  dmDatabase.scoDados.StartTransaction(ID);
  try
    sds.SQLConnection := dmDatabase.scoDados;
    sds.NoMetadata    := True;
    sds.GetMetadata   := False;
    sds.CommandText   := 'UPDATE TABELALOC SET FLAG = 1 WHERE TABELA = ' + QuotedStr('PRODUTO_JW');
    sds.ExecSQL();

    fDMCadProduto_JW.prc_Gravar;

    dmDatabase.scoDados.Commit(ID);

    prc_Habilita;
    if (vIDAux > 0) then
    begin
      if fDMCadProduto_JW.cdsConsulta.IsEmpty then
        ceID.AsInteger := vIDAux;
      prc_Consultar;
      fDMCadProduto_JW.cdsConsulta.Locate('ID',vIDAux,([Locaseinsensitive]));
      ceID.Clear;
    end;
    RzPageControl2.ActivePage := TabSheet1;
    RzPageControl1.ActivePage := TS_Consulta;

  except
    on e: Exception do
      begin
        dmDatabase.scoDados.Rollback(ID);
        raise Exception.Create('Erro ao gravar a Produto: ' + #13 + e.Message);
      end;
  end;
  FreeAndNil(sds);
end;

procedure TfrmCadProduto_JW.prc_Inserir_Registro;
begin
  fDMCadProduto_JW.prc_Inserir;

  if fDMCadProduto_JW.cdsProduto_JW.State in [dsBrowse] then
    exit;

  RzPageControl1.ActivePage := TS_Cadastro;
  DBEdit2.ReadOnly := False;
  DBEdit7.ReadOnly := False;

  prc_Habilita;
  RxDBComboBox7.Enabled := True;

  RxDBComboBox7.SetFocus;
end;

procedure TfrmCadProduto_JW.FormShow(Sender: TObject);
var
  i: Integer;
  vTipo_Consulta_Produto_Padrao: String;
begin
  fDMCadProduto_JW := TDMCadProduto_JW.Create(Self);
  oDBUtils.SetDataSourceProperties(Self, fDMCadProduto_JW);
  ComboBox1.ItemIndex := 0;
end;

procedure TfrmCadProduto_JW.prc_Consultar;
begin
  SMDBGrid1.DisableScroll;
  fDMCadProduto_JW.cdsConsulta.Close;
  fDMCadProduto_JW.sdsConsulta.CommandText := fDMCadProduto_JW.ctConsulta;

  if Trim(edtNome.Text) <> '' then
    fDMCadProduto_JW.sdsConsulta.CommandText := fDMCadProduto_JW.sdsConsulta.CommandText + ' AND NOME LIKE "%' + edtNome.Text + '%"';
  if ComboBox1.ItemIndex > 0 then
  begin
    case ComboBox1.ItemIndex of
      1: fDMCadProduto_JW.sdsConsulta.CommandText := fDMCadProduto_JW.sdsConsulta.CommandText + ' AND TIPO_REG = ''R''';//REDONDO
      2: fDMCadProduto_JW.sdsConsulta.CommandText := fDMCadProduto_JW.sdsConsulta.CommandText + ' AND TIPO_REG = ''C''';//CHAPA
      3: fDMCadProduto_JW.sdsConsulta.CommandText := fDMCadProduto_JW.sdsConsulta.CommandText + ' AND TIPO_REG = ''T''';//TUBO
      4: fDMCadProduto_JW.sdsConsulta.CommandText := fDMCadProduto_JW.sdsConsulta.CommandText + ' AND TIPO_REG = ''Q''';//QUARDRADO
    end;
  end;
  fDMCadProduto_JW.cdsConsulta.Open;
  SMDBGrid1.EnableScroll;
end;

procedure TfrmCadProduto_JW.btnCancelarClick(Sender: TObject);
begin
  if (fDMCadProduto_JW.cdsProduto_JW.State in [dsBrowse]) or not(fDMCadProduto_JW.cdsProduto_JW.Active) then
  begin
    RzPageControl1.ActivePage := TS_Consulta;
    exit;
  end;

  if MessageDlg('Deseja cancelar alteração/inclusão do registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  fDMCadProduto_JW.cdsProduto_JW.CancelUpdates;
  prc_Habilita;
  RzPageControl1.ActivePage := TS_Consulta;
  RzPageControl2.ActivePage := TabSheet1;
end;

procedure TfrmCadProduto_JW.SMDBGrid1DblClick(Sender: TObject);
begin
  RzPageControl1.ActivePage := TS_Cadastro;
end;

procedure TfrmCadProduto_JW.btnAlterarClick(Sender: TObject);
begin
  if (fDMCadProduto_JW.cdsProduto_JW.IsEmpty) or not(fDMCadProduto_JW.cdsProduto_JW.Active) or (fDMCadProduto_JW.cdsProduto_JWID.AsInteger < 1) then
    exit;

  fDMCadProduto_JW.cdsProduto_JW.Edit;

  prc_Habilita;
end;

procedure TfrmCadProduto_JW.btnConfirmarClick(Sender: TObject);
begin
  prc_Gravar_Registro;
end;

procedure TfrmCadProduto_JW.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDMCadProduto_JW);
end;

procedure TfrmCadProduto_JW.btnInserirClick(Sender: TObject);
begin
  prc_Inserir_Registro;
end;

procedure TfrmCadProduto_JW.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := fnc_Encerrar_Tela(fDMCadProduto_JW.cdsProduto_JW);
end;

procedure TfrmCadProduto_JW.edtNomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then
    btnConsultarClick(Sender);
end;

procedure TfrmCadProduto_JW.RzPageControl1Change(Sender: TObject);
begin
  if not(fDMCadProduto_JW.cdsProduto_JW.State in [dsEdit, dsInsert]) then
  begin
    if RzPageControl1.ActivePage = TS_Cadastro then
    begin
      if not(fDMCadProduto_JW.cdsConsulta.Active) or (fDMCadProduto_JW.cdsConsulta.IsEmpty) or
            (fDMCadProduto_JW.cdsConsultaID.AsInteger <= 0) then
        exit;
      prc_Posiciona_Produto;
    end;
  end;
end;

procedure TfrmCadProduto_JW.prc_Posiciona_Produto;
begin
  fDMCadProduto_JW.prc_Localizar(fDMCadProduto_JW.cdsConsultaID.AsInteger);
end;

procedure TfrmCadProduto_JW.btnPesquisarClick(Sender: TObject);
begin
  pnlCons_Produto.Visible := not(pnlCons_Produto.Visible);

  if pnlCons_Produto.Visible then
    edtNome.SetFocus
  else
    prc_Limpar_Edit_Consulta;
end;

procedure TfrmCadProduto_JW.prc_Limpar_Edit_Consulta;
begin
  edtNome.Clear;
  ceID.Clear;
end;

procedure TfrmCadProduto_JW.prc_Habilita;
begin
  TS_Consulta.TabEnabled := not(TS_Consulta.TabEnabled);
  btnAlterar.Enabled     := not(btnAlterar.Enabled);
  btnConfirmar.Enabled   := not(btnConfirmar.Enabled);
  pnlCadastro.Enabled    := not(pnlCadastro.Enabled);
end;

procedure TfrmCadProduto_JW.btnConsultarClick(Sender: TObject);
begin
  prc_Consultar;
end;

procedure TfrmCadProduto_JW.RxDBComboBox7Exit(Sender: TObject);
begin
  RzPageControl3.ActivePageIndex := AnsiIndexStr(fDMCadProduto_JW.cdsProduto_JWTIPO_REG.AsString,['R','C','T','Q']);
 
end;

end.

