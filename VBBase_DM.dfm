inherited VBBaseDM: TVBBaseDM
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  inherited sqlConnection: TSQLConnection
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=20220'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
  end
  object cdsRepository: TFDMemTable
    Tag = 82
    ActiveStoredUsage = [auDesignTime]
    FilterOptions = [foCaseInsensitive]
    CachedUpdates = True
    ConstraintsEnabled = True
    FetchOptions.AssignedValues = [evMode, evRecordCountMode]
    FetchOptions.Mode = fmAll
    FetchOptions.RecordCountMode = cmTotal
    FormatOptions.AssignedValues = [fvDataSnapCompatibility]
    FormatOptions.DataSnapCompatibility = True
    ResourceOptions.AssignedValues = [rvSilentMode, rvStorePrettyPrint]
    ResourceOptions.StorePrettyPrint = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvGeneratorName, uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.GeneratorName = 'REPOSITORY_ID_GEN'
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'REPOSITORY'
    Left = 35
    Top = 70
    object cdsRepositoryID: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsRepositoryAPP_ID: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'APP_ID'
      Origin = 'APP_ID'
      Required = True
    end
    object cdsRepositorySOURCE_FOLDER: TStringField
      DisplayLabel = 'Source Folder'
      FieldName = 'SOURCE_FOLDER'
      Origin = 'SOURCE_FOLDER'
      Required = True
      Size = 255
    end
    object cdsRepositoryDEST_FOLDER: TStringField
      DisplayLabel = 'Destination Folder'
      FieldName = 'DEST_FOLDER'
      Origin = 'DEST_FOLDER'
      Size = 255
    end
    object cdsRepositoryFILE_NAME: TStringField
      DisplayLabel = 'File Name'
      FieldName = 'FILE_NAME'
      Origin = 'FILE_NAME'
      Required = True
      Size = 100
    end
    object cdsRepositoryUPDATE_FILE: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Update'
      FieldName = 'UPDATE_FILE'
    end
    object cdsRepositoryDELETE_FILE: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Delete'
      FieldName = 'DELETE_FILE'
    end
  end
  object dtsRepository: TDataSource
    Left = 35
    Top = 120
  end
end
