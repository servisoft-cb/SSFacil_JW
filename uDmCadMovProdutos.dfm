object dmCadMovProdutos: TdmCadMovProdutos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 403
  Top = 113
  Height = 397
  Width = 389
  object sdsMovProdutos: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT ES.*'#13#10'FROM JW_ENTSAI ES'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 48
    Top = 32
    object sdsMovProdutosID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object sdsMovProdutosDATA: TDateField
      FieldName = 'DATA'
    end
    object sdsMovProdutosID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
    end
    object sdsMovProdutosVLR_TOTAL: TFloatField
      FieldName = 'VLR_TOTAL'
    end
    object sdsMovProdutosQTD_PECA: TIntegerField
      FieldName = 'QTD_PECA'
    end
    object sdsMovProdutosTIPO_ES: TStringField
      FieldName = 'TIPO_ES'
      FixedChar = True
      Size = 1
    end
    object sdsMovProdutosNUM_DOC: TIntegerField
      FieldName = 'NUM_DOC'
    end
    object sdsMovProdutosNUM_NOTA: TIntegerField
      FieldName = 'NUM_NOTA'
    end
    object sdsMovProdutosSERIE: TStringField
      FieldName = 'SERIE'
      Size = 3
    end
  end
  object dspMovProdutos: TDataSetProvider
    DataSet = sdsMovProdutos
    Left = 80
    Top = 32
  end
  object cdsMovProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMovProdutos'
    Left = 112
    Top = 32
    object cdsMovProdutosID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsMovProdutosDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsMovProdutosID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
    end
    object cdsMovProdutosVLR_TOTAL: TFloatField
      FieldName = 'VLR_TOTAL'
    end
    object cdsMovProdutosQTD_PECA: TIntegerField
      FieldName = 'QTD_PECA'
    end
    object cdsMovProdutosTIPO_ES: TStringField
      FieldName = 'TIPO_ES'
      FixedChar = True
      Size = 1
    end
    object cdsMovProdutosNUM_DOC: TIntegerField
      FieldName = 'NUM_DOC'
    end
    object cdsMovProdutosNUM_NOTA: TIntegerField
      FieldName = 'NUM_NOTA'
    end
    object cdsMovProdutosSERIE: TStringField
      FieldName = 'SERIE'
      Size = 3
    end
    object cdsMovProdutossdsMovProdutosItens: TDataSetField
      FieldName = 'sdsMovProdutosItens'
    end
  end
  object dsMovProdutos: TDataSource
    DataSet = cdsMovProdutos
    Left = 144
    Top = 32
  end
  object sdsMovProdutosItens: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT ESI.*'#13#10'FROM JW_ENTSAI_ITENS ESI'#13#10'WHERE ID = :ID'
    DataSource = mdsMovProdutos
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
        Size = 4
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 48
    Top = 80
    object sdsMovProdutosItensID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object sdsMovProdutosItensITEM: TIntegerField
      FieldName = 'ITEM'
      Required = True
    end
    object sdsMovProdutosItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object sdsMovProdutosItensNOME_PRODUTO: TStringField
      FieldName = 'NOME_PRODUTO'
      Size = 70
    end
    object sdsMovProdutosItensQTD: TIntegerField
      FieldName = 'QTD'
    end
    object sdsMovProdutosItensCODBARRA: TFMTBCDField
      FieldName = 'CODBARRA'
      Precision = 15
      Size = 0
    end
    object sdsMovProdutosItensCODBARRA_SEQ: TIntegerField
      FieldName = 'CODBARRA_SEQ'
    end
    object sdsMovProdutosItensETIQUETA_IMP: TStringField
      FieldName = 'ETIQUETA_IMP'
      FixedChar = True
      Size = 1
    end
  end
  object cdsMovProdutosItens: TClientDataSet
    Aggregates = <>
    DataSetField = cdsMovProdutossdsMovProdutosItens
    Params = <>
    Left = 112
    Top = 80
    object cdsMovProdutosItensID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsMovProdutosItensITEM: TIntegerField
      FieldName = 'ITEM'
      Required = True
    end
    object cdsMovProdutosItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object cdsMovProdutosItensNOME_PRODUTO: TStringField
      FieldName = 'NOME_PRODUTO'
      Size = 70
    end
    object cdsMovProdutosItensQTD: TIntegerField
      FieldName = 'QTD'
    end
    object cdsMovProdutosItensCODBARRA: TFMTBCDField
      FieldName = 'CODBARRA'
      Precision = 15
      Size = 0
    end
    object cdsMovProdutosItensCODBARRA_SEQ: TIntegerField
      FieldName = 'CODBARRA_SEQ'
    end
    object cdsMovProdutosItensETIQUETA_IMP: TStringField
      FieldName = 'ETIQUETA_IMP'
      FixedChar = True
      Size = 1
    end
  end
  object dsMovProdutosItens: TDataSource
    DataSet = cdsMovProdutosItens
    Left = 144
    Top = 80
  end
  object mdsMovProdutos: TDataSource
    DataSet = sdsMovProdutos
    Left = 176
    Top = 32
  end
  object sdsPessoa: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT P.CODIGO, P.NOME'#13#10'FROM PESSOA P'#13#10'WHERE P.CODIGO = :C1'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'C1'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 48
    Top = 128
  end
  object dspPessoa: TDataSetProvider
    DataSet = sdsPessoa
    Left = 80
    Top = 128
  end
  object cdsPessoa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPessoa'
    Left = 112
    Top = 128
    object cdsPessoaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsPessoaNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
  end
  object dsPessoa: TDataSource
    DataSet = cdsPessoa
    Left = 144
    Top = 128
  end
  object sdsJWProduto: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM JW_PRODUTO'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 48
    Top = 176
  end
  object dspJWProduto: TDataSetProvider
    DataSet = sdsJWProduto
    Left = 80
    Top = 176
  end
  object cdsJWProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspJWProduto'
    Left = 112
    Top = 176
    object cdsJWProdutoID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsJWProdutoNOME: TStringField
      FieldName = 'NOME'
      Size = 70
    end
    object cdsJWProdutoID_COR: TIntegerField
      FieldName = 'ID_COR'
    end
    object cdsJWProdutoTIPO_REG: TStringField
      FieldName = 'TIPO_REG'
      FixedChar = True
      Size = 10
    end
    object cdsJWProdutoID_TIPO_MAT: TIntegerField
      FieldName = 'ID_TIPO_MAT'
    end
    object cdsJWProdutoDIAMETRO: TFloatField
      FieldName = 'DIAMETRO'
    end
    object cdsJWProdutoCOMPRIMENTO: TFloatField
      FieldName = 'COMPRIMENTO'
    end
    object cdsJWProdutoESPESSURA: TFloatField
      FieldName = 'ESPESSURA'
    end
    object cdsJWProdutoLARGURA: TFloatField
      FieldName = 'LARGURA'
    end
    object cdsJWProdutoALTURA: TFloatField
      FieldName = 'ALTURA'
    end
    object cdsJWProdutoDIAMETRO_INT: TFloatField
      FieldName = 'DIAMETRO_INT'
    end
    object cdsJWProdutoDIAMETRO_EXT: TFloatField
      FieldName = 'DIAMETRO_EXT'
    end
    object cdsJWProdutoLOCALIZACAO: TStringField
      FieldName = 'LOCALIZACAO'
      Size = 15
    end
    object cdsJWProdutoINATIVO: TStringField
      FieldName = 'INATIVO'
      Size = 1
    end
  end
  object dsJWProduto: TDataSource
    DataSet = cdsJWProduto
    Left = 144
    Top = 176
  end
end
