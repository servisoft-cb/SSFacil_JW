unit uCadTipoMaterial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons, Grids, SMDBGrid, UdmTipoMaterial,
  DBGrids, ExtCtrls, StdCtrls, DB, RzTabs, DBCtrls, UCBase, Mask, NxCollection;

type
  TfrmCadTipoMaterial = class(TForm)
    RzPageControl1: TRzPageControl;
    TS_Consulta: TRzTabSheet;
    TS_Cadastro: TRzTabSheet;
    SMDBGrid1: TSMDBGrid;
    Panel2: TPanel;
    Panel1: TPanel;
    pnlCadastro: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    StaticText1: TStaticText;
    pnlPesquisa: TPanel;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    Edit1: TEdit;
    UCControls1: TUCControls;
    btnInserir: TNxButton;
    btnExcluir: TNxButton;
    btnPesquisar: TNxButton;
    btnConsultar: TNxButton;
    btnAlterar: TNxButton;
    btnConfirmar: TNxButton;
    btnCancelar: TNxButton;
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
  private
    { Private declarations }
    fDmCadTipoMaterial: TDmCadTipoMaterial;

    procedure prc_Inserir_Registro;
    procedure prc_Excluir_Registro;
    procedure prc_Gravar_Registro;
    procedure prc_Consultar;                                                                             
  public
    { Public declarations }                                                                              
  end;

var
  frmCadTipoMaterial: TfrmCadTipoMaterial;

implementation

uses DmdDatabase, rsDBUtils, UMenu;

{$R *.dfm}

procedure TfrmCadTipoMaterial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  Action := Cafree;
end;

procedure TfrmCadTipoMaterial.btnExcluirClick(Sender: TObject);
begin
  if fDmCadTipoMaterial.cdsTipoMaterial.IsEmpty then
    exit;

  if MessageDlg('Deseja excluir este registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  prc_Excluir_Registro;
end;

procedure TfrmCadTipoMaterial.prc_Excluir_Registro;
begin
  fDmCadTipoMaterial.prc_Excluir;
end;

procedure TfrmCadTipoMaterial.prc_Gravar_Registro;
begin
  fDmCadTipoMaterial.prc_Gravar;
  if fDmCadTipoMaterial.cdsTipoMaterial.State in [dsEdit,dsInsert] then
  begin
    MessageDlg(fDmCadTipoMaterial.vMsgErro, mtError, [mbOk], 0);
    exit;
  end;
  TS_Consulta.TabEnabled    := not(TS_Consulta.TabEnabled);
  RzPageControl1.ActivePage := TS_Consulta;
  pnlCadastro.Enabled       := not(pnlCadastro.Enabled);
  btnConfirmar.Enabled      := not(btnConfirmar.Enabled);
  btnAlterar.Enabled        := not(btnAlterar.Enabled);
end;

procedure TfrmCadTipoMaterial.prc_Inserir_Registro;
begin
  fDmCadTipoMaterial.prc_Inserir;

  if fDmCadTipoMaterial.cdsTipoMaterial.State in [dsBrowse] then
    exit;

  RzPageControl1.ActivePage := TS_Cadastro;

  TS_Consulta.TabEnabled := False;
  btnAlterar.Enabled     := False;
  btnConfirmar.Enabled   := True;
  pnlCadastro.Enabled    := True;
  DBEdit1.SetFocus;
end;

procedure TfrmCadTipoMaterial.FormShow(Sender: TObject);
begin
  fDmCadTipoMaterial := TdmCadTipoMaterial.Create(Self);
  oDBUtils.SetDataSourceProperties(Self, fDmCadTipoMaterial);
end;

procedure TfrmCadTipoMaterial.prc_Consultar;
begin
  fDmCadTipoMaterial.cdsTipoMaterial.Close;
  fDmCadTipoMaterial.sdsTipoMaterial.CommandText := fDmCadTipoMaterial.ctTipoMat + ' WHERE 0 = 0 ';
  if trim(Edit1.Text) <> '' then
    fDmCadTipoMaterial.sdsTipoMaterial.CommandText := fDmCadTipoMaterial.sdsTipoMaterial.CommandText +
                                                      ' AND NOME LIKE ''%' + QuotedStr(Edit1.Text) + '%''';
  fDmCadTipoMaterial.cdsTipoMaterial.Open;
end;

procedure TfrmCadTipoMaterial.btnConsultarClick(Sender: TObject);
begin
  prc_Consultar;
end;

procedure TfrmCadTipoMaterial.btnCancelarClick(Sender: TObject);
begin
  if (fDmCadTipoMaterial.cdsTipoMaterial.State in [dsBrowse]) or not(fDmCadTipoMaterial.cdsTipoMaterial.Active) then
  begin
    RzPageControl1.ActivePage := TS_Consulta;
    exit;
  end;

  if MessageDlg('Deseja cancelar alteração/inclusão do registro?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  fDmCadTipoMaterial.cdsTipoMaterial.CancelUpdates;
  TS_Consulta.TabEnabled    := True;
  RzPageControl1.ActivePage := TS_Consulta;
  pnlCadastro.Enabled       := not(pnlCadastro.Enabled);
  btnConfirmar.Enabled      := not(btnConfirmar.Enabled);
  btnAlterar.Enabled        := not(btnAlterar.Enabled);
end;

procedure TfrmCadTipoMaterial.SMDBGrid1DblClick(Sender: TObject);
begin
  RzPageControl1.ActivePage := TS_Cadastro;
end;

procedure TfrmCadTipoMaterial.btnAlterarClick(Sender: TObject);
begin
  if (fDmCadTipoMaterial.cdsTipoMaterial.IsEmpty) or not(fDmCadTipoMaterial.cdsTipoMaterial.Active) or
     (fDmCadTipoMaterial.cdsTipoMaterialID.AsInteger < 1) then
    exit;

  fDmCadTipoMaterial.cdsTipoMaterial.Edit;

  TS_Consulta.TabEnabled := False;
  btnAlterar.Enabled     := False;
  btnConfirmar.Enabled   := True;
  pnlCadastro.Enabled    := True;
end;

procedure TfrmCadTipoMaterial.btnConfirmarClick(Sender: TObject);
begin
  prc_Gravar_Registro;
end;

procedure TfrmCadTipoMaterial.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDmCadTipoMaterial);
end;

procedure TfrmCadTipoMaterial.btnInserirClick(Sender: TObject);
begin
  prc_Inserir_Registro;
end;

procedure TfrmCadTipoMaterial.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then
    btnConsultarClick(Sender);
end;

procedure TfrmCadTipoMaterial.btnPesquisarClick(Sender: TObject);
begin
  pnlPesquisa.Visible := not(pnlPesquisa.Visible);
  if pnlPesquisa.Visible then
    Edit1.SetFocus
  else
    Edit1.Clear;
end;

end.
