unit VBBase_DM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon, Data.DB,
  System.Win.Registry, System.ImageList, Vcl.ImgList, Vcl.Controls,
  Winapi.Windows, System.IOUtils, System.Variants,

  VBProxyClass, Base_DM, CommonValues,

  Data.SqlExpr, Data.FireDACJSONReflect, DataSnap.DSCommon, IPPeerClient,

  FireDAC.Stan.StorageXML, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TShellResource = record
    RootFolder: string;
    ResourceFolder: string;
    ReportFolder: string;
    SkinName: string;
    RemoteServerName: string;
    ConnectionDefinitionFileLocation: string;
    ConnectionDefinitionFileName: string;
    ApplicationFolder: string;
    UserID: Integer;
  end;

  TUserData = record
    UserName: string; // Login name
    FirstName: string;
    LastName: string;
    UserID: Integer;
    EmailAddress: string;
    AccountEnabled: Boolean;
    PW: string;
  end;

  TVBBaseDM = class(TBaseDM)
    procedure SetConnectionProperties;
    function GetShellResource: TShellResource;
    function GetDateOrder(const DateFormat: string): TDateOrder;
    function UpdatesPending(DataSetArray: TDataSetArray): Boolean;
    function GetMasterData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName: string): TFDJSONDataSets;
    procedure GetData(ID: Integer; DataSet: TFDMemTable; DataSetName, ParameterList, FileName, Generatorname, Tablename: string);
    function GetNextID(TableName: string): Integer;
    procedure PopulateUserData;
    function CopyRecord(DataSet: TFDMemTable): OleVariant;

//    function GetDelta(DataSetArray: TDataSetArray): TFDJSONDeltas;
    procedure ApplyUpdates(DataSetArray: TDataSetArray; GeneratorName, TableName: string);
    procedure CancelUpdates(DataSetArray: TDataSetArray);
    function ExecuteSQLCommand(Request: string): string;
    function ExecuteStoredProcedure(ProcedureName, ParameterList: string): string;

    function EchoTheString(Request: string; var Response: string): string;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FResponse: string;
    FShellResource: TShellResource;
    FClient: TVBServerMethodsClient;
    FFServerErrorMsg: string;
    FCurrentPeriod: Integer;
    FCurrentMonth: Integer;
    FMadeChanges: Boolean;
    FDBAction: TDBActions;
  public
    { Public declarations }
    FDataSetArray: TDataSetArray;
    FUserData: TUserData;

    property ShellResource: TShellResource read FShellResource write FShellResource;
    property Client: TVBServerMethodsClient read FClient write FClient;
    property FServerErrorMsg: string read FFServerErrorMsg write FFServerErrorMsg;
    property CurrentPeriod: Integer read FCurrentPeriod write FCurrentPeriod;
    property CurrentMonth: Integer read FCurrentMonth write FCurrentMonth;
    property MadeChanges: Boolean read FMadeChanges write FMadeChanges;
    property DBAction: TDBActions read FDBAction write FDBAction;
  end;

var
  VBBaseDM: TVBBaseDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  VBCommonValues,
  RUtils;

{$R *.dfm}

{ TVBBaseDM }

procedure TVBBaseDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
////  FBeepFreq := 800;
////  FBeepDuration := 300;
////   GetLocaleFormatSettings is deprecated!!
////  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, FAFormatSettings);
////  FAFormatSettings := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
//  FAFormatSettings := TFormatSettings.Create('');
//  FDateOrder := GetDateOrder(FAFormatSettings.ShortDateFormat);
//
//  case FDateOrder of
//    doDMY: FDateStringFormat := 'dd/mm/yyyy';
//    doMDY: FDateStringFormat := 'mm/dd/yyyy';
//    doYMD: FDateStringFormat := 'yyyy-mm-dd';
//  end;
end;

procedure TVBBaseDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FClient);
end;

procedure TVBBaseDM.GetData(ID: Integer; DataSet: TFDMemTable; DataSetName,
  ParameterList, FileName, Generatorname, Tablename: string);
var
  DataSetList: TFDJSONDataSets;
  IDList, ParamList: string;
begin
  if DataSet.Active then
  begin
    DataSet.Close;
//    DataSet.EmptyDataSet;
  end;

  IDList := 'SQL_STATEMENT_ID=' + ID.ToString;

  if Length(Trim(ParameterList)) = 0 then
    ParamList := 'PARAMETER_LIST=' + ONE_SPACE
  else
    ParamList := 'PARAMETER_LIST=' + ParameterList;

  DataSetList := GetMasterData(IDList, ParamList, Generatorname, Tablename, DataSetName);
  if FResponse = 'NO_DATA' then
    Exit;

  DataSet.AppendData(TFDJSONDataSetsReader.GetListValueByName(DataSetList, DataSetName));
{$IFDEF DEBUG}
  DataSet.SaveToFile(FileName, sfXML);
{$ENDIF}
end;

function TVBBaseDM.GetNextID(TableName: string): Integer;
begin
  Result := StrToInt(FClient.GetNextID(Tablename));
end;

function TVBBaseDM.GetMasterData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName: string): TFDJSONDataSets;
//var
//  Response: string;
begin
//  if FClient = nil then
//    FClient := TLeaveServerMethodsClient.Create(BaseDM.sqlConnection.DBXConnection);
  FResponse := '';
  Result := FClient.GetData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName, FResponse);
end;

function TVBBaseDM.GetShellResource: TShellResource;
var
  RegKey: TRegistry;
//  SL: TStringList;
begin
//  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
//  SL := RUtils.CreateStringList(SL, COMMA);
  TDirectory.CreateDirectory('C:\Data');
  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
  RegKey.RootKey := HKEY_CURRENT_USER;
  try
    RegKey.OpenKey(KEY_RESOURCE, True);
    Result.RootFolder := ROOT_FOLDER;
//    Result.RootFolder := RUtils.AddChar(RUtils.GetShellFolderName(CSIDL_COMMON_DOCUMENTS), '\', rpEnd) + ROOT_DATA_FOLDER;
//    SL.Add(FormatDateTime('dd/MM/yyyy hh:mm:ss', Now) + 'Before writing Root Folder value to registry');
//    SL.SaveToFile('C:\Data\RegLog.txt');

    try
      RegKey.WriteString('Root Folder', Result.RootFolder);
    except
      on E: Exception do
      begin
//        SL.Add(FormatDateTime('dd/MM/yyyy hh:mm:ss', Now) + 'Exception: ' + E.Message);
//        SL.SaveToFile('C:\Data\RegLog.txt');
      end;
    end;

//    SL.Add(FormatDateTime('dd/MM/yyyy hh:mm:ss', Now) + 'After successfully writing Root Folder value to registry');
//    SL.SaveToFile('C:\Data\RegLog.txt');

//    if not RegKey.ValueExists('Resource') then
//      RegKey.WriteString('Resource', '\\VBSERVER\Apps\VB\');

    Result.ResourceFolder := RegKey.ReadString('Resource');
    Result.ReportFolder := RegKey.ReadString('Reports');

    RegKey.CloseKey;
    RegKey.OpenKey(KEY_DATABASE, True);
    Result.ConnectionDefinitionFileLocation := RegKey.ReadString('Connection Definition File Location');
    Result.ConnectionDefinitionFileName := RegKey.ReadString('Connection Definition File Name');

    RegKey.CloseKey;
    RegKey.OpenKey(KEY_USER_PREFERENCES, True);

    if not RegKey.ValueExists('Skin Name') then
      RegKey.WriteString('Skin Name', DEFAULT_SKIN_NAME);

    Result.SkinName := RegKey.ReadString('Skin Name');
    RegKey.CloseKey;
  finally
    RegKey.Free;
  end;
end;

procedure TVBBaseDM.PopulateUserData;
var
  RegKey: TRegistry;
begin
  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
  try
    RegKey.RootKey := HKEY_CURRENT_USER;
    Regkey.OpenKey(KEY_USER_DATA, True);
    FUserData.UserID := RegKey.ReadInteger('User ID');
    FUserData.UserName := RegKey.ReadString('User Name');
    FUserData.FirstName := RegKey.ReadString('First Name');
    FUserData.LastName := RegKey.ReadString('Last Name');
    FUserData.EmailAddress := RegKey.ReadString('Email Address');
    FUserData.AccountEnabled := RegKey.ReadBool('Account Enabled');
  finally
    RegKey.Free
  end;
end;

function TVBBaseDM.UpdatesPending(DataSetArray: TDataSetArray): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(DataSetArray) - 1 do
  begin
    Result := DataSetArray[I].UpdatesPending;
    if Result then
      Break
  end;
end;

//function TVBBaseDM.GetDelta(DataSetArray: TDataSetArray): TFDJSONDeltas;
//var
//  I: Integer;
//begin
//  // Create a delta list
//  Result := TFDJSONDeltas.Create;
//
//  for I := 0 to Length(DataSetArray) - 1 do
//  begin
//    // Post if edits pending
//    if DataSetArray[I].State in dsEditModes then
//      DataSetArray[I].Post;
//
//    // Add deltas
//    if DataSetArray[I].UpdatesPending then
//      TFDJSONDeltasWriter.ListAdd(Result, DataSetArray[I].Name, DataSetArray[I]);
//  end;
//end;

procedure TVBBaseDM.ApplyUpdates(DataSetArray: TDataSetArray; GeneratorName, TableName: string);
var
  DeltaList: TFDJSONDeltas;
  Response: string;
begin
//  I := fdsContactType.ChangeCount;
  Response := '';
  DeltaList := GetDelta(DataSetArray);
  try
    FServerErrorMsg := FClient.ApplyDataUpdates(DeltaList, Response, GeneratorName, TableName);
    // Do we need to do this????
//    for I := 0 to Length(DataSetArray) - 1 do
//      DataSetArray[I].CancelUpdates;

  except
    on E: TDSServiceException do
//    on E: Exception do
      raise Exception.Create('Error Applying Updates: ' + E.Message)
  end;
end;

procedure TVBBaseDM.CancelUpdates(DataSetArray: TDataSetArray);
begin
//for var
//  I := 0 to Length(DataSetArray) - 1 do
//  begin
//    if DataSetArray[I].UpdatesPending then
//      DataSetArray[I].CancelUpdates;
//  end;
end;

function TVBBaseDM.CopyRecord(DataSet: TFDMemTable): OleVariant;
var
  I: Integer;
  CDS: TFDMemTable;
  FieldName: string;
begin
  CDS := TFDMemTable.Create(nil);
  try
    CDS.FieldDefs.Assign(DataSet.FieldDefs);
    CDS.CreateDataSet;
    CDS.Open;
    CDS.Append;

    for I := 0 to DataSet.FieldCount - 1 do
    begin
      FieldName := DataSet.Fields[I].FieldName;
      if VarIsNull(DataSet.Fields[I].Value) then
        CDS.Fields[I].Value := null
      else
        CDS.FieldByName(FieldName).Value := DataSet.FieldByName(FieldName).Value;
    end;
    CDS.Post;
    Result := CDS.Data;
  finally
    CDS.Free;
  end;
end;

function TVBBaseDM.ExecuteSQLCommand(Request: string): string;
var
  Response: string;
begin
  Response := '';
  Result := FClient.ExecuteSQLCommand(Request, Response);
end;

function TVBBaseDM.ExecuteStoredProcedure(ProcedureName, ParameterList: string): string;
var
  SL: TStringList;
begin
  SL := RUtils.CreateStringList(PIPE);
  try
    SL.DelimitedText := FClient.ExecuteStoredProcedure(ProcedureName, ParameterList);
  finally
    SL.Free;
  end;
end;

function TVBBaseDM.GetDateOrder(const DateFormat: string): TDateOrder;
begin
  Result := doMDY;
var
  I := Low(string);
  while I <= High(DateFormat) do
  begin
    case Chr(Ord(DateFormat[I]) and $DF) of
      'E': Result := doYMD;
      'Y': Result := doYMD;
      'M': Result := doMDY;
      'D': Result := doDMY;
    else
      Inc(I);
      Continue;
    end;
    Exit;
  end;
end;

procedure TVBBaseDM.SetConnectionProperties;
var
  RegKey: TRegistry;
  Port: string;
begin
  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
  RegKey.RootKey := HKEY_CURRENT_USER;
  RegKey.OpenKey(KEY_DATASNAP, True);

  try
    if not RegKey.ValueExists('Host Name') then
      RegKey.WriteString('Host Name', 'localhost');

{$IFDEF DEBUG}
    if not RegKey.ValueExists(VB_SHELL_DEV_TCP_KEY_NAME) then
      RegKey.WriteString(VB_SHELL_DEV_TCP_KEY_NAME, VB_SHELL_DEV_TCP_PORT);

    if not RegKey.ValueExists(VB_SHELL_DEV_HTTP_KEY_NAME) then
      RegKey.WriteString(VB_SHELL_DEV_HTTP_KEY_NAME, VB_SHELL_DEV_HTTP_PORT);

    Port := RegKey.ReadString(VB_SHELL_DEV_TCP_KEY_NAME);
{$ELSE}
    if not RegKey.ValueExists(VB_SHELLX_TCP_KEY_NAME) then
      RegKey.WriteString(VB_SHELLX_TCP_KEY_NAME, VB_SHELLX_TCP_PORT);

    if not RegKey.ValueExists(VB_SHELLX_HTTP_KEY_NAME) then
      RegKey.WriteString(VB_SHELLX_HTTP_KEY_NAME, VB_SHELLX_HTTP_PORT);

    Port := RegKey.ReadString(VB_SHELLX_TCP_KEY_NAME);
{$ENDIF}

    VBBaseDM.sqlConnection.Params.Values['DriverName'] := 'DataSnap';
    VBBaseDM.sqlConnection.Params.Values['DatasnapContext'] := 'DataSnap/';
    VBBaseDM.sqlConnection.Params.Values['CommunicationProtocol'] := 'tcp/ip';
    VBBaseDM.sqlConnection.Params.Values['Port'] := Port;
    VBBaseDM.sqlConnection.Params.Values['HostName'] := RegKey.ReadString('Host Name');
    RegKey.CloseKey;
  finally
    RegKey.Free;
  end;

//  try
//    if not RegKey.ValueExists('Host Name') then
//      RegKey.WriteString('Host Name', 'localhost');
//
//{$IFDEF DEBUG}
//    if not RegKey.ValueExists(VB_SHELL_DEV_TCP_KEY_NAME) then
//      RegKey.WriteString(VB_SHELL_DEV_TCP_KEY_NAME, VB_SHELL_DEV_TCP_PORT);
//
//    if not RegKey.ValueExists(VB_SHELL_DEV_HTTP_KEY_NAME) then
//      RegKey.WriteString(VB_SHELL_DEV_HTTP_KEY_NAME, VB_SHELL_DEV_HTTP_PORT);
//
//    sqlConnection.Params.Values['Port'] := RegKey.ReadString(VB_SHELL_DEV_TCP_KEY_NAME);
//{$ELSE}
//    if not RegKey.ValueExists(VB_SHELLX_TCP_KEY_NAME) then
//      RegKey.WriteString(VB_SHELLX_TCP_KEY_NAME, VB_SHELLX_TCP_PORT);
//
//    if not RegKey.ValueExists(VB_SHELLX_HTTP_KEY_NAME) then
//      RegKey.WriteString(VB_SHELLX_HTTP_KEY_NAME, VB_SHELLX_HTTP_PORT);
//
//    sqlConnection.Params.Values['Port'] := RegKey.ReadString(VB_SHELLX_TCP_KEY_NAME);
//{$ENDIF}
//
//    sqlConnection.Params.Values['DatasnapContext'] := 'DataSnap/';
//    sqlConnection.Params.Values['CommunicationProtocol'] := 'tcp/ip';
////  sqlConnection.Params.Values['HostName'] := 'localhost';
//
////  if ReleaseVersion then
//    sqlConnection.Params.Values['HostName'] := RegKey.ReadString('Host Name');
//    sqlConnection.Open;
////    FClient := TVBServerMethodsClient.Create(VBBaseDM.sqlConnection.DBXConnection);
//    RegKey.CloseKey;
//  finally
//    RegKey.Free;
//  end;
end;

function TVBBaseDM.EchoTheString(Request: string; var Response: string): string;
begin
  Result := FClient.EchoString(Request, Response);
end;

end.

