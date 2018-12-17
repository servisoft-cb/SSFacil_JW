object dmCadTipoMaterial: TdmCadTipoMaterial
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 403
  Top = 113
  Height = 285
  Width = 445
  object sdsTipoMaterial: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT * FROM JW_TIPO_MAT'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 56
    Top = 32
    object sdsTipoMaterialID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object sdsTipoMaterialNOME: TStringField
      FieldName = 'NOME'
      Size = 15
    end
  end
  object dspTipoMaterial: TDataSetProvider
    DataSet = sdsTipoMaterial
    Left = 88
    Top = 32
  end
  object cdsTipoMaterial: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTipoMaterial'
    Left = 120
    Top = 32
    object cdsTipoMaterialID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsTipoMaterialNOME: TStringField
      FieldName = 'NOME'
      Size = 15
    end
  end
  object dsTipoMaterial: TDataSource
    DataSet = cdsTipoMaterial
    Left = 152
    Top = 32
  end
end
