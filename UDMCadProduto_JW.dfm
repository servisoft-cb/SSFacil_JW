object dmCadProduto_JW: TdmCadProduto_JW
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 248
  Top = 195
  Height = 273
  Width = 510
  object sdsProduto_JW: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT PRO.*'#13#10'FROM JW_PRODUTO PRO'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 50
    Top = 9
    object sdsProduto_JWID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sdsProduto_JWNOME: TStringField
      FieldName = 'NOME'
      Size = 70
    end
    object sdsProduto_JWID_COR: TIntegerField
      FieldName = 'ID_COR'
    end
    object sdsProduto_JWTIPO_REG: TStringField
      FieldName = 'TIPO_REG'
      FixedChar = True
      Size = 10
    end
    object sdsProduto_JWID_TIPO_MAT: TIntegerField
      FieldName = 'ID_TIPO_MAT'
    end
    object sdsProduto_JWDIAMETRO: TFloatField
      FieldName = 'DIAMETRO'
    end
    object sdsProduto_JWCOMPRIMENTO: TFloatField
      FieldName = 'COMPRIMENTO'
    end
    object sdsProduto_JWESPESSURA: TFloatField
      FieldName = 'ESPESSURA'
    end
    object sdsProduto_JWLARGURA: TFloatField
      FieldName = 'LARGURA'
    end
    object sdsProduto_JWALTURA: TFloatField
      FieldName = 'ALTURA'
    end
    object sdsProduto_JWDIAMETRO_INT: TFloatField
      FieldName = 'DIAMETRO_INT'
    end
    object sdsProduto_JWDIAMETRO_EXT: TFloatField
      FieldName = 'DIAMETRO_EXT'
    end
    object sdsProduto_JWLOCALIZACAO: TStringField
      FieldName = 'LOCALIZACAO'
      Size = 15
    end
  end
  object dspProduto_JW: TDataSetProvider
    DataSet = sdsProduto_JW
    UpdateMode = upWhereKeyOnly
    OnUpdateError = dspProduto_JWUpdateError
    Left = 82
    Top = 9
  end
  object cdsProduto_JW: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ID'
    Params = <>
    ProviderName = 'dspProduto_JW'
    OnReconcileError = cdsProduto_JWReconcileError
    Left = 114
    Top = 9
    object cdsProduto_JWID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsProduto_JWNOME: TStringField
      FieldName = 'NOME'
      Size = 70
    end
    object cdsProduto_JWID_COR: TIntegerField
      FieldName = 'ID_COR'
    end
    object cdsProduto_JWTIPO_REG: TStringField
      FieldName = 'TIPO_REG'
      FixedChar = True
      Size = 10
    end
    object cdsProduto_JWID_TIPO_MAT: TIntegerField
      FieldName = 'ID_TIPO_MAT'
    end
    object cdsProduto_JWDIAMETRO: TFloatField
      FieldName = 'DIAMETRO'
    end
    object cdsProduto_JWCOMPRIMENTO: TFloatField
      FieldName = 'COMPRIMENTO'
    end
    object cdsProduto_JWESPESSURA: TFloatField
      FieldName = 'ESPESSURA'
    end
    object cdsProduto_JWLARGURA: TFloatField
      FieldName = 'LARGURA'
    end
    object cdsProduto_JWALTURA: TFloatField
      FieldName = 'ALTURA'
    end
    object cdsProduto_JWDIAMETRO_INT: TFloatField
      FieldName = 'DIAMETRO_INT'
    end
    object cdsProduto_JWDIAMETRO_EXT: TFloatField
      FieldName = 'DIAMETRO_EXT'
    end
    object cdsProduto_JWLOCALIZACAO: TStringField
      FieldName = 'LOCALIZACAO'
      Size = 15
    end
  end
  object dsProduto_JW: TDataSource
    DataSet = cdsProduto_JW
    Left = 146
    Top = 9
  end
  object sdsConsulta: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'SELECT P.*, COMB.NOME NOME_COR, TP.NOME NOME_TIPO_MAT'#13#10'FROM JW_P' +
      'RODUTO P'#13#10'LEFT JOIN COMBINACAO COMB ON (P.ID_COR = COMB.ID)'#13#10'LEF' +
      'T JOIN JW_TIPO_MAT TP ON (P.ID_TIPO_MAT = TP.ID)'#13#10'WHERE 0 = 0 '#13#10 +
      #13#10
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 328
    Top = 16
  end
  object dspConsulta: TDataSetProvider
    DataSet = sdsConsulta
    OnUpdateError = dspProduto_JWUpdateError
    Left = 362
    Top = 16
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 392
    Top = 16
    object cdsConsultaID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsConsultaNOME: TStringField
      FieldName = 'NOME'
      Size = 70
    end
    object cdsConsultaID_COR: TIntegerField
      FieldName = 'ID_COR'
    end
    object cdsConsultaTIPO_REG: TStringField
      FieldName = 'TIPO_REG'
      FixedChar = True
      Size = 10
    end
    object cdsConsultaID_TIPO_MAT: TIntegerField
      FieldName = 'ID_TIPO_MAT'
    end
    object cdsConsultaDIAMETRO: TFloatField
      FieldName = 'DIAMETRO'
    end
    object cdsConsultaCOMPRIMENTO: TFloatField
      FieldName = 'COMPRIMENTO'
    end
    object cdsConsultaESPESSURA: TFloatField
      FieldName = 'ESPESSURA'
    end
    object cdsConsultaLARGURA: TFloatField
      FieldName = 'LARGURA'
    end
    object cdsConsultaALTURA: TFloatField
      FieldName = 'ALTURA'
    end
    object cdsConsultaDIAMETRO_INT: TFloatField
      FieldName = 'DIAMETRO_INT'
    end
    object cdsConsultaDIAMETRO_EXT: TFloatField
      FieldName = 'DIAMETRO_EXT'
    end
    object cdsConsultaLOCALIZACAO: TStringField
      FieldName = 'LOCALIZACAO'
      Size = 15
    end
    object cdsConsultaNOME_COR: TStringField
      FieldName = 'NOME_COR'
      Size = 60
    end
    object cdsConsultaNOME_TIPO_MAT: TStringField
      FieldName = 'NOME_TIPO_MAT'
      Size = 15
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 424
    Top = 16
  end
  object sdsCombinacao: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT C.ID, C.NOME'#13#10'FROM COMBINACAO C'#13#10'WHERE C.tipo_reg = '#39'C'#39#13#10
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 320
    Top = 96
  end
  object dspCombinacao: TDataSetProvider
    DataSet = sdsCombinacao
    OnUpdateError = dspProduto_JWUpdateError
    Left = 354
    Top = 96
  end
  object cdsCombinacao: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'NOME'
    Params = <>
    ProviderName = 'dspCombinacao'
    Left = 384
    Top = 96
    object cdsCombinacaoID: TFMTBCDField
      FieldName = 'ID'
      Required = True
      Precision = 15
      Size = 0
    end
    object cdsCombinacaoNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
  end
  object dsCombinacao: TDataSource
    DataSet = cdsCombinacao
    Left = 416
    Top = 96
  end
  object sdsTipo_Mat: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM JW_TIPO_MAT'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 320
    Top = 144
  end
  object dspTipo_Mat: TDataSetProvider
    DataSet = sdsTipo_Mat
    OnUpdateError = dspProduto_JWUpdateError
    Left = 354
    Top = 144
  end
  object cdsTipo_Mat: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'NOME'
    Params = <>
    ProviderName = 'dspTipo_Mat'
    Left = 384
    Top = 144
    object cdsTipo_MatID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsTipo_MatNOME: TStringField
      FieldName = 'NOME'
      Size = 15
    end
  end
  object dsTipo_Mat: TDataSource
    DataSet = cdsTipo_Mat
    Left = 416
    Top = 144
  end
end
