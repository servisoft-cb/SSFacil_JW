unit uCadMovProdutos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons, Grids, SMDBGrid, uDmCadMovProdutos,
  DBGrids, ExtCtrls, StdCtrls, DB, RzTabs, DBCtrls, UCBase, Mask, NxCollection, RxDBComb, ToolEdit, CurrEdit, RXDBCtrl;

type
  TfrmCadMovProdutos = class(TForm)
    RzPageControl1: TRzPageControl;
    TS_Consulta: TRzTabSheet;
    TS_Cadastro: TRzTabSheet;
    SMDBGrid1: TSMDBGrid;
    Panel2: TPanel;
    Panel1: TPanel;
    pnlCadastro: TPanel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    StaticText1: TStaticText;
    pnlPesquisa: TPanel;
    Label6: TLabel;
    Edit1: TEdit;
    UCControls1: TUCControls;
    btnInserir: TNxButton;
    btnExcluir: TNxButton;
    btnPesquisar: TNxButton;
    btnConsultar: TNxButton;
    btnAlterar: TNxButton;
    btnConfirmar: TNxButton;
    btnCancelar: TNxButton;
    Label1: TLabel;
    RxDBComboBox2: TRxDBComboBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Edit2: TEdit;
    pnlItens: TPanel;
    SMDBGrid2: TSMDBGrid;
    Panel4: TPanel;
    btCancelar: TNxButton;
    btFinalizar: TNxButton;
    NxButton1: TNxButton;
    Label3: TLabel;
    CurrencyEdit1: TCurrencyEdit;
    Label4: TLabel;
    CurrencyEdit2: TCurrencyEdit;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label10: TLabel;
    CurrencyEdit3: TCurrencyEdit;
    Label11: TLabel;
    CurrencyEdit4: TCurrencyEdit;
    Panel5: TPanel;
    Label12: TLabel;
    DBEdit3: TDBEdit;
    Label13: TLabel;
    DBDateEdit1: TDBDateEdit;
    Label14: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit6: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure SMDBGrid1DblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btFinalizarClick(Sender: TObject);
    procedure NxButton1Click(Sender: TObject);
    procedure CurrencyEdit1Exit(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure DBEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fDmCadMovProdutos: TDmCadMovProdutos;

    procedure prc_Inserir_Registro;
    procedure prc_Excluir_Registro;
    procedure prc_Gravar_Registro;
    procedure prc_Consultar;
    procedure prc_Habilita;
    procedure prcPosicionaProd(vId: Integer);
    procedure prcPosicionaPessoa(vId: Integer);                                                                             
  public
    { Public declarations }                                                                              
  end;

var
  frmCadMovProdutos: TfrmCadMovProdutos;

implementation

uses DmdDatabase, rsDBUtils, USel_Pessoa, uUtilPadrao;

{$R *.dfm}

procedure TfrmCadMovProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmCadMovProdutos.btnExcluirClick(Sender: TObject);
begin
  if fDmCadMovProdutos.cdsMovProdutos.IsEmpty then
    exit;

  if MessageDlg('Deseja excluir este registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  prc_Excluir_Registro;
end;

procedure TfrmCadMovProdutos.prc_Excluir_Registro;
begin
  fDmCadMovProdutos.prc_Excluir;
end;

procedure TfrmCadMovProdutos.prc_Gravar_Registro;
begin
  fDmCadMovProdutos.prc_Gravar;
  if fDmCadMovProdutos.cdsMovProdutos.State in [dsEdit,dsInsert] then
  begin
    MessageDlg(fDmCadMovProdutos.vMsgErro, mtError, [mbOk], 0);
    Exit;
  end;
  prc_Habilita;
  RzPageControl1.ActivePage := TS_Consulta;
end;

procedure TfrmCadMovProdutos.prc_Inserir_Registro;
begin
  fDmCadMovProdutos.prc_Inserir;

  if fDmCadMovProdutos.cdsMovProdutos.State in [dsBrowse] then
    exit;

  RzPageControl1.ActivePage := TS_Cadastro;
  prc_Habilita;
  DBEdit1.SetFocus;
end;

procedure TfrmCadMovProdutos.FormShow(Sender: TObject);
begin
  fDmCadMovProdutos := TdmCadMovProdutos.Create(Self);
  oDBUtils.SetDataSourceProperties(Self,fDmCadMovProdutos);
end;

procedure TfrmCadMovProdutos.prc_Consultar;
begin
  fDmCadMovProdutos.cdsMovProdutos.Close;
  fDmCadMovProdutos.sdsMovProdutos.CommandText := fDmCadMovProdutos.ctMovProd + ' WHERE 0 = 0 ';
  if trim(Edit1.Text) <> '' then
    fDmCadMovProdutos.sdsMovProdutos.CommandText := fDmCadMovProdutos.sdsMovProdutos.CommandText +
                                                    ' AND NOME LIKE ''%' + QuotedStr(Edit1.Text) + '%''';
  fDmCadMovProdutos.cdsMovProdutos.Open;
end;

procedure TfrmCadMovProdutos.btnConsultarClick(Sender: TObject);
begin
  prc_Consultar;
end;

procedure TfrmCadMovProdutos.btnCancelarClick(Sender: TObject);
begin
  if (fDmCadMovProdutos.cdsMovProdutos.State in [dsBrowse]) or not(fDmCadMovProdutos.cdsMovProdutos.Active) then
  begin
    RzPageControl1.ActivePage := TS_Consulta;
    exit;
  end;

  if MessageDlg('Deseja cancelar alteração/inclusão do registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  fDmCadMovProdutos.cdsMovProdutos.CancelUpdates;
  prc_Habilita;
  RzPageControl1.ActivePage := TS_Consulta;
end;

procedure TfrmCadMovProdutos.SMDBGrid1DblClick(Sender: TObject);
begin
  RzPageControl1.ActivePage := TS_Cadastro;
end;

procedure TfrmCadMovProdutos.btnAlterarClick(Sender: TObject);
begin
  if (fDmCadMovProdutos.cdsMovProdutos.IsEmpty) or not(fDmCadMovProdutos.cdsMovProdutos.Active) or
     (fDmCadMovProdutos.cdsMovProdutosID.AsInteger < 1) then
    exit;

  fDmCadMovProdutos.cdsMovProdutos.Edit;
  prc_Habilita;
end;

procedure TfrmCadMovProdutos.btnConfirmarClick(Sender: TObject);
begin
  prc_Gravar_Registro;
end;

procedure TfrmCadMovProdutos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDmCadMovProdutos);
end;

procedure TfrmCadMovProdutos.btnInserirClick(Sender: TObject);
begin
  prc_Inserir_Registro;
end;

procedure TfrmCadMovProdutos.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then
    btnConsultarClick(Sender);
end;

procedure TfrmCadMovProdutos.btnPesquisarClick(Sender: TObject);
begin
  pnlPesquisa.Visible := not(pnlPesquisa.Visible);
  if pnlPesquisa.Visible then
    Edit1.SetFocus
  else
    Edit1.Clear;
end;

procedure TfrmCadMovProdutos.btFinalizarClick(Sender: TObject);
var
  vItem: Word;
begin
  if CurrencyEdit1.Value = 0 then
  begin
    Exit;
  end;
  if CurrencyEdit2.Value = 0 then
  begin
    Exit;
  end;
  if CurrencyEdit3.Value = 0 then
  begin
    Exit;
  end;
  fDmCadMovProdutos.cdsMovProdutosItens.Last;
  vItem := fDmCadMovProdutos.cdsMovProdutosItensID.AsInteger;
  fDmCadMovProdutos.cdsMovProdutosItens.Insert;
  fDmCadMovProdutos.cdsMovProdutosItensID.AsInteger          := fDmCadMovProdutos.cdsMovProdutosID.AsInteger;
  fDmCadMovProdutos.cdsMovProdutosItensITEM.AsInteger        := vItem + 1;
  fDmCadMovProdutos.cdsMovProdutosItensID_PRODUTO.AsInteger  := CurrencyEdit1.AsInteger;
  fDmCadMovProdutos.cdsMovProdutosItensNOME_PRODUTO.AsString := fDmCadMovProdutos.cdsJWProdutoNOME.AsString;
  fDmCadMovProdutos.cdsMovProdutosItensQTD.AsFloat           := CurrencyEdit2.Value;
  fDmCadMovProdutos.cdsMovProdutosItens.Post;
  fDmCadMovProdutos.cdsMovProdutosItens.ApplyUpdates(0);
  CurrencyEdit1.SetFocus;
end;

procedure TfrmCadMovProdutos.NxButton1Click(Sender: TObject);
begin
  if not fDmCadMovProdutos.cdsMovProdutosItens.IsEmpty then
  begin
    if MessageDlg('Deseja realmente excluir este produto?',mtConfirmation,[mbOk,mbNo],0) = mrOk then
      fDmCadMovProdutos.cdsMovProdutosItens.Delete;
  end;
end;

procedure TfrmCadMovProdutos.CurrencyEdit1Exit(Sender: TObject);
begin
  prcPosicionaProd(CurrencyEdit1.AsInteger);
end;

procedure TfrmCadMovProdutos.prcPosicionaProd(vId: Integer);
begin
  fDmCadMovProdutos.cdsJWProduto.Close;

  fDmCadMovProdutos.cdsJWProduto.Open;
end;

procedure TfrmCadMovProdutos.DBEdit2Exit(Sender: TObject);
begin
  prcPosicionaPessoa(fDmCadMovProdutos.cdsMovProdutosID_PESSOA.AsInteger);
end;

procedure TfrmCadMovProdutos.prcPosicionaPessoa(vId: Integer);
begin
  fDmCadMovProdutos.cdsPessoa.Close;
  fDmCadMovProdutos.sdsPessoa.ParamByName('C1').AsInteger := vId;
  fDmCadMovProdutos.cdsPessoa.Open;
  if fDmCadMovProdutos.cdsPessoa.IsEmpty then
  begin
    ShowMessage('Pessoa não localizada pelo ID ' + IntToStr (vId) + '!');
    Exit;
  end;

  Edit2.Text := fDmCadMovProdutos.cdsPessoaNOME.AsString;
end;

procedure TfrmCadMovProdutos.DBEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Vk_F2) then
  begin
    frmSel_Pessoa := TfrmSel_Pessoa.Create(Self);
    frmSel_Pessoa.vTipo_Pessoa := 'C';
    frmSel_Pessoa.ShowModal;
    fDmCadMovProdutos.cdsMovProdutosID_PESSOA.AsInteger := vCodPessoa_Pos;
    DBEdit2Exit(Sender);
  end;
end;

procedure TfrmCadMovProdutos.prc_Habilita;
begin
  TS_Consulta.Enabled  := not(TS_Consulta.Enabled);
  pnlCadastro.Enabled  := not(pnlCadastro.Enabled);
  btnConfirmar.Enabled := not(btnConfirmar.Enabled);
  btnAlterar.Enabled   := not(btnAlterar.Enabled);
  pnlItens.Enabled     := not(pnlItens.Enabled);
end;

end.
