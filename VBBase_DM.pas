unit VBBase_DM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon, Vcl.Forms,
  Vcl.Controls, System.Win.Registry, System.ImageList, Vcl.ImgList, Winapi.Windows,
  System.IOUtils, System.Variants, System.DateUtils,

  VBProxyClass, Base_DM, CommonValues, VBCommonValues,

  Data.DB, Data.SqlExpr, Data.FireDACJSONReflect, DataSnap.DSCommon, IPPeerClient,

  FireDAC.Stan.StorageXML, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Phys.DSDef, FireDAC.Phys, FireDAC.Phys.TDBXBase, FireDAC.Phys.DS,
  FireDAC.Comp.UI;

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
    cdsRepository: TFDMemTable;
    dtsRepository: TDataSource;
    cdsRepositoryID: TIntegerField;
    cdsRepositoryAPP_ID: TIntegerField;
    cdsRepositorySOURCE_FOLDER: TStringField;
    cdsRepositoryDEST_FOLDER: TStringField;
    cdsRepositoryFILE_NAME: TStringField;
    cdsRepositoryUPDATE_FILE: TIntegerField;
    cdsRepositoryDELETE_FILE: TIntegerField;
    procedure SetConnectionProperties;
    function GetShellResource: TShellResource;
    function GetDateOrder(const DateFormat: string): TDateOrder;
    function UpdatesPending(DataSetArray: TDataSetArray): Boolean;
    function GetMasterData(DataRequestList, ParameterList, Generatorname, Tablename, DataSetName: string): TFDJSONDataSets;
    procedure GetData(ID: Integer; DataSet: TFDMemTable; DataSetName, ParameterList, FileName, Generatorname, Tablename: string);
    function GetNextID(TableName: string): Integer;
    procedure PopulateUserData;
    function CopyRecord(DataSet: TFDMemTable): OleVariant;
    function GetuseCount(Request: string): Integer;

//    function GetDelta(DataSetArray: TDataSetArray): TFDJSONDeltas;
    procedure PostData(DataSet: TFDMemTable);
    procedure ApplyUpdates(DataSetArray: TDataSetArray; GeneratorName, TableName: string; ScriptID: Integer);
    procedure CancelUpdates(DataSetArray: TDataSetArray);
    function ExecuteSQLCommand(Request: string): string;
    function ExecuteStoredProcedure(ProcedureName, ParameterList: string): string;
    function EchoTheString(Request: string; var Response: string): string;
    function InsertRecord(Request: string; var Response: string): string;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FResponse: string;
    FShellResource: TShellResource;
    FClient: TVBServerMethodsClient;
    FServerErrorMsg: string;
    FCurrentYear: Integer;
    FCurrentPeriod: Integer;
    FCurrentMonth: Integer;
    FMadeChanges: Boolean;
    FDBAction: TDBActions;
    FQueryRequest: string;
    FItemToCount: string;
    FSourceFolder: string;
    FDestFolder: string;
    FFileName: string;
    FFullFileName: string;
    FAppID: Integer;
    FAppName: string;
    FCounter: Integer;
    FCurrentFileTimeStamp: TDateTime;
    FNewFileTimeStamp: TDateTime;
    FNewFileTimeStampString: string;
    FFilesToUpdate: Integer;

    FMyDataSet: TFDMemTable;
    FMyDataSource: TDataSource;
    FPostError: Boolean;
  public
    { Public declarations }
    DataSetArray: TDataSetArray;
    UserData: TUserData;

    property ShellResource: TShellResource read FShellResource write FShellResource;
    property Client: TVBServerMethodsClient read FClient write FClient;
    property ServerErrorMsg: string read FServerErrorMsg write FServerErrorMsg;
    property CurrentYear: Integer read FCurrentYear write FCurrentYear;
    property CurrentPeriod: Integer read FCurrentPeriod write FCurrentPeriod;
    property CurrentMonth: Integer read FCurrentMonth write FCurrentMonth;
    property MadeChanges: Boolean read FMadeChanges write FMadeChanges;
    property DBAction: TDBActions read FDBAction write FDBAction;
    property QueryRequest: string read FQueryRequest write FQueryRequest;
    property ItemToCount: string read FItemToCount write FItemToCount;
    property MyDataSet: TFDMemTable read FMyDataSet write FMyDataSet;
    property MyDataSource: TDataSource read FMyDataSource write FMyDataSource;
    property PostError: Boolean read FPostError write FPostError;
//    property DataSetArray: TDataSetArray read FDataSetArray write FDataSetArray;
//    property UserData: TUserData read FUserData write FUserData;

    function FoundNewVersion: Boolean;
    function CheckForUpdates(AppID: Integer; AppName: string): Boolean;
    procedure DownLoadFile;
    procedure ResetFileTimeStatmp;
    procedure CalculateFieldValues(DataSet: TFDMemTable);
    procedure BuildInsertStatement(TagValue: Integer; var FieldList, FieldValues: string; DataSet: TFDMemTable);
    procedure BuildUpdateStatement(TagValue: Integer; var FieldListValues, WhereClause: string; DataSet: TFDMemTable);
  end;

var
  VBBaseDM: TVBBaseDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  RUtils,
  Progress_Frm;

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

  // Note to developer...
  // If you have any Calcculated or InternalCalc fields you MUST open the
  // dataset BEFORE populating it with data. If you don't do this you will get
  // the following FireDAC error:
  // Cannot change table [DataSetname] table structure when table has rows
  // The Open action prepares the dataset and resolves calculated and/or
  // InternalCalc fields.
  DataSet.Open;
  DataSet.AppendData(TFDJSONDataSetsReader.GetListValueByName(DataSetList, DataSetName));
  {$IFDEF DEBUG}
  DataSet.SaveToFile(FileName, sfXML);
  {$ENDIF}
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

function TVBBaseDM.GetNextID(TableName: string): Integer;
begin
  Result := StrToInt(FClient.GetNextID(Tablename));
end;

function TVBBaseDM.GetuseCount(Request: string): Integer;
begin
  Result := StrToInt(FClient.GetUseCount(Request));
end;

function TVBBaseDM.InsertRecord(Request: string; var Response: string): string;
begin
  Result := FClient.InsertRecord(Request, Response);
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
    UserData.UserID := RegKey.ReadInteger('User ID');
    UserData.UserName := RegKey.ReadString('Login Name');
    UserData.FirstName := RegKey.ReadString('First Name');
    UserData.LastName := RegKey.ReadString('Last Name');
    UserData.EmailAddress := RegKey.ReadString('Email Address');
    UserData.AccountEnabled := RegKey.ReadBool('Account Enabled');
  finally
    RegKey.Free
  end;
end;

procedure TVBBaseDM.PostData(DataSet: TFDMemTable);
begin
  SetLength(DataSetArray, 1);
  DataSetArray[0] := TFDMemTable(DataSet);

  ApplyUpdates(DataSetArray, TFDMemTable(DataSet).UpdateOptions.Generatorname,
    TFDMemTable(DataSet).UpdateOptions.UpdateTableName,
    TFDMemTable(DataSet).Tag);

  TFDMemTable(DataSet).CommitUpdates;
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

procedure TVBBaseDM.ApplyUpdates(DataSetArray: TDataSetArray; GeneratorName, TableName: string; ScriptID: Integer);
const
  ERROR_MESSAGE = 'One or more erors occurred in posting data to table %s with error message.';

var
  DeltaList: TFDJSONDeltas;
  Response: TStringList;
  ReplyMessage: string;
begin
  Response := RUtils.CreateStringList(PIPE, DOUBLE_QUOTE);
  ReplyMessage := '';
  DeltaList := GetDelta(DataSetArray);

  try
    Response.DelimitedText := FClient.ApplyDataUpdates(DeltaList, ReplyMessage, GeneratorName, TableName, ScriptID);

    if Sametext(Response.Values['RESPONSE'], 'ERROR') then
    begin
      FServerErrorMsg := Format(ERROR_MESSAGE, [TableName]) + CRLF + CRLF +
        Response.Values['ERROR_MESSAGE'];

      raise EServerError.Create(FServerErrorMsg);

//      Beep;
//      DisplayMsg(
//        Application.Title,
//        'VB Remote Server Error',
//        'One or more errors occurred when trying to update the VB database.' + CRLF + CRLF +
//        'Error message from server' + CRLF +
//        Response.Values['ERROR_MESSAGE'],
//        mtError,
//        [mbOK]
//        );

    end;
  finally
    Response.Free;
  end;
end;

procedure TVBBaseDM.CalculateFieldValues(DataSet: TFDMemTable);
begin
  // Time in hours
  DataSet.FieldByName('TIME_HOURS').AsFloat :=
    DataSet.FieldByName('TIME_SPENT').AsFloat / 60;

  // Item value
  if DataSet.FieldByName('BILLABLE').AsInteger = 1 then
  begin
    if DataSet.FieldByName('RATE_UNIT_ID').AsInteger = 1 then
      DataSet.FieldByName('ITEM_VALUE').AsFloat :=
        DataSet.FieldByName('TIME_SPENT').AsFloat / 60 *
        DataSet.FieldByName('ACTUAL_RATE').AsFloat
    else
      DataSet.FieldByName('ITEM_VALUE').AsFloat :=
        DataSet.FieldByName('ACTUAL_RATE').AsFloat;
  end
  else
    DataSet.FieldByName('ITEM_VALUE').AsFloat := 0;

  // Period
  DataSet.FieldByName('THE_PERIOD').AsInteger :=
    GetCurrentPeriod(DataSet.FieldByName('ACTIVITY_DATE').AsDateTime);

  // Period Name
  DataSet.FieldByName('PERIOD_NAME').AsString :=
    ShortMonths[MonthInt(DataSet.FieldByName('ACTIVITY_DATE').AsDateTime)] +
    ' ' + YearStr(DataSet.FieldByName('ACTIVITY_DATE').AsDateTime);

  // Locked status
  if (DataSet.FieldByName('APPROVED').AsInteger = 1) or (DataSet.FieldByName('INVOICE_ID').AsInteger > 0) then
    DataSet.FieldByName('LOCKED').AsInteger := 1
  else
    DataSet.FieldByName('LOCKED').AsInteger := 0;

  if DataSet.FindField('FULL_NAME') <> nil then
    DataSet.FieldByName('FULL_NAME').AsString :=
      DataSet.FieldByName('FIRST_NAME').AsString + '' +
      DataSet.FieldByName('LAST_NAME').AsString;
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
//var
//  Response: string;
begin
//  Response := '';
  Result := FClient.ExecuteSQLCommand(Request);
end;

function TVBBaseDM.ExecuteStoredProcedure(ProcedureName, ParameterList: string): string;
begin
  Result := FClient.ExecuteStoredProcedure(ProcedureName, ParameterList);
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

function TVBBaseDM.FoundNewVersion: Boolean;
var
  VersionInfo: TStringList;
  Request, Response: string;
begin
  VersionInfo := RUtils.CreateStringList(PIPE, DOUBLE_QUOTE);
  FileAge(FDestFolder + FFileName, FCurrentFileTimeStamp);

  Request :=
    'FILE_NAME=' + FFileName + PIPE +
    'TARGET_FILE_TIMESTAMP=' + FormatDateTime('yyyy-MM-dd hh:mm:ss',
    FCurrentFileTimeStamp); // DateTimeToStr(CurrentAppFileTimestamp);

  try
    VersionInfo.DelimitedText := VBBaseDM.Client.GetFileVersion(Request, Response);
    Result := VersionInfo.Values['RESPONSE'] = 'FOUND_NEW_VERSION';

    if Result then
    begin
      if Length(Trim(FNewFileTimeStampString)) = 0 then
        FNewFileTimeStampString := VersionInfo.Values['FILE_TIMESTAMP'];
    end
    else
      FNewFileTimeStampString := FormatDateTime('yyyy-MM-dd hh:mm:ss', Now);
  finally
    VersionInfo.Free;
  end;
end;

function TVBBaseDM.CheckForUpdates(AppID: Integer; AppName: string): Boolean;
var
  VersionInfo: TStringList;
  Request, Response: string;
//  CurrentAppFileTimestamp: TDateTime;
  UpdateFile: Boolean;
//  Iteration: Extended;
begin
  FAppID := AppID;
  FAppName := AppName;
  VersionInfo := RUtils.CreateStringList(PIPE, DOUBLE_QUOTE);
  Result := False;
  Response := '';

  if AppID > 0 then
    GetData(82, cdsRepository, cdsRepository.Name, ' WHERE R.APP_ID = ' + FAppID.ToString + ' ORDER BY R.ID',
      'C:\Data\Xml\Repository.xml', cdsRepository.UpdateOptions.Generatorname,
      cdsRepository.UpdateOptions.UpdateTableName)
  else
    GetData(82, cdsRepository, cdsRepository.Name, ' WHERE R.FILE_NAME = ' + AnsiQuotedStr(FAppName, ''''),
      'C:\Data\Xml\Repository.xml', cdsRepository.UpdateOptions.Generatorname,
      cdsRepository.UpdateOptions.UpdateTableName);

  if cdsRepository.IsEmpty then
    Exit;

  if ProgressFrm = nil then
    ProgressFrm := TProgressFrm.Create(nil);
  ProgressFrm.FormStyle := fsStayOnTop;
//  ProgressFrm.prgDownload.Style.LookAndFeel.NativeStyle := True;
//  ProgressFrm.prgDownload.Properties.BeginColor := $F0CAA6; //clSkyBlue;
  ProgressFrm.Update;
  ProgressFrm.Show;

  FCounter := 0;
  FFilesToUpdate := cdsRepository.RecordCount;

  try
    cdsRepository.First;
    while not cdsRepository.EOF do
    begin
      SendMessage(ProgressFrm.Handle, WM_DOWNLOAD_CAPTION, DWORD(PChar('Preparing downloads. Please wait...')), 0);

      Inc(FCounter);
//      Iteration := FCounter / FFilesToUpdate * 100;
      FSourceFolder := RUtils.AddChar(cdsRepository.FieldByName('SOURCE_FOLDER').AsString, '\', rpEnd);
      FDestFolder := RUtils.AddChar(cdsRepository.FieldByName('DEST_FOLDER').AsString, '\', rpEnd);
      FFileName := cdsRepository.FieldByName('FILE_NAME').AsString;
      FFullFileName := FDestFolder + FFileName;

      if TFile.Exists(FFullFileName) then
        FileAge(FFullFileName, FNewFileTimeStamp)
      else
        FNewFileTimeStamp := Now;

      UpdateFile := IntegerToBoolean(cdsRepository.FieldByName('UPDATE_FILE').AsInteger);

      if TFile.Exists(FFullFileName) then
      begin
        // If this file has been marked as NOT updateable AND has been marked
        // for deletion, then delete the file.
        if not (UpdateFile)
          and (IntegerToBoolean(cdsRepository.FieldByName('DELETE_FILE').AsInteger)) then
          TFile.Delete(FFullFileName)
        // If this file has been marked as updateable then download and replace it.
        else if IntegerToBoolean(cdsRepository.FieldByName('UPDATE_FILE').AsInteger) then
          UpdateFile := FoundNewVersion
        else
          UpdateFile := False;
      end;
      // Download a new version of the file if a new one is found or if the file
      // is missing and updateable.
//      else
//        UpdateFile := True;

      if UpdateFile then
        DownLoadFile;

      cdsRepository.Next;
    end;

    VersionInfo.DelimitedText := VBBaseDM.Client.GetFileVersion(Request, Response);
  finally
    VersionInfo.Free;
    FreeAndNil(ProgressFrm);
  end;
end;

procedure TVBBaseDM.DownLoadFile;
var
  TheFileStream: TStream;
  Buffer: PByte;
  MemStream: TMemoryStream;
  BufSize, BytesRead, TotalBytesRead: Integer;
  StreamSize: Int64;
  Response: string;
  ResponseList: TStringList;
  Progress: Extended;
begin
  SendMessage(ProgressFrm.Handle, WM_DOWNLOAD_CAPTION, DWORD(PChar('Downloading: ' +
    FFileName + ' (' + FCounter.ToString + ' of ' + FFilesToUpdate.ToString + ')')), 0);

  BufSize := 1024;
  MemStream := TMemoryStream.Create;
//  TheFileStream :=  TStream.Create;
  GetMem(Buffer, BufSize);
  Response := '';
  StreamSize := 0;
  ResponseList := RUtils.CreateStringList(PIPE, DOUBLE_QUOTE);
  TotalBytesRead := 0;

  try
    TheFileStream := FClient.DownloadFile(FFileName, Response, StreamSize);
    ResponseList.DelimitedText := Response;

    if ResponseList.Values['RESPONSE'] = 'FILE_NOT_FOUND' then
      Exit;

    TheFileStream.Position := 0;

    if (StreamSize <> 0) then
    begin
//        filename := 'download.fil';

      repeat
        BytesRead := TheFileStream.Read(Pointer(Buffer)^, BufSize);

        if (BytesRead > 0) then
        begin
          TotalBytesRead := TotalBytesRead + BytesRead;
          MemStream.WriteBuffer(Pointer(Buffer)^, BytesRead);
          Progress := StrToFloat(TotalBytesRead.ToString) / StrToFloat(StreamSize.ToString) * 100;
          SendMessage(ProgressFrm.Handle, WM_DOWNLOAD_PROGRESS, DWORD(PChar(FloatToStr(Progress))), 0);
          Application.ProcessMessages;
//          SendMessage(ProgressFrm.Handle, WM_DOWNLOAD_CAPTION, DWORD(PChar('CAPTION=Downloading: ' +
//            FFileName + ' (' + FCounter.ToString + ' of ' + FFilesToUpdate.ToString + ')' + '|PROGRESS=' + FloatToStr(Progress))), 0);
        end;
      until (BytesRead < BufSize);

      if (StreamSize <> MemStream.Size) then
      begin
        raise Exception.Create('Error downloading file...');
      end
      else
      begin
        MemStream.SaveToFile(FDestFolder + FFileName);
        ResetFileTimeStatmp;
      end;
    end
  finally
    ResponseList.Free;
    FreeMem(Buffer, BufSize);
    FreeAndNil(MemStream);
    // Note to developer:
    // DO NOT FREE THE TheFileStream STREAM HERE!!!
    // The DBXConnection unit takes care of this. If you free it here you will
    // get an AV error the next time you try to free it.
  end;
end;

procedure TVBBaseDM.ResetFileTimeStatmp;
var
  TargetFileHandle: Integer;
  aYear, aMonth, aDay, aHour, aMin, aSec, aMSec: Word;
  TheDate: Double;
begin
//  FileAge(FFullFileName, FNewFileTimeStamp);
//  FNewFileTimestamp := VarToDateTime(FNewFileTimeStampString);
  // Get the handle of the file.
  TargetFileHandle := FileOpen(FDestFolder + FFileName, fmOpenReadWrite);
  // Decode timestamp and resolve to its constituent parts.
  DecodeDateTime(FNewFileTimeStamp, aYear, aMonth, aDay, aHour, aMin, aSec, aMSec);
  TheDate := EncodeDate(aYear, aMonth, aDay);

  if (aSec = 59) and (aMin = 59) then
    Inc(aHour)
  else if aSec mod 2 <> 0 then
    Inc(aSec);

  if aSec = 59 then
    aSec := 0;

  if aMin = 59 then
    aMin := 0;

        // If handle was successfully generated then reset the timestamp
  if TargetFileHandle > 0 then
  begin
    FileSetDate(TargetFileHandle, DateTimeToFileDate(TheDate + (aHour / 24) + (aMin / (24 * 60)) + (aSec / 24 / 60 / 60)));
  end;
  // Close the file
  FileClose(TargetFileHandle);

//  // Copy the newly downloaded app to its actual location.
//  TFile.Copy(TempFolder + APP_NAME, AppFileName);
//  while not TFile.Exists(AppFileName) do
//    Application.ProcessMessages;
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

    sqlConnection.Params.Values['DriverName'] := 'DataSnap';
    sqlConnection.Params.Values['DatasnapContext'] := 'DataSnap/';
    sqlConnection.Params.Values['CommunicationProtocol'] := 'tcp/ip';
    sqlConnection.Params.Values['Port'] := Port;
    sqlConnection.Params.Values['HostName'] := RegKey.ReadString('Host Name');
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

procedure TVBBaseDM.BuildInsertStatement(TagValue: Integer; var FieldList,
  FieldValues: string; DataSet: TFDMemTable);
begin
  case TagValue of
    // All of these tables have the same structure with only one updateable
    // field named NAME.
    5, 6, 11, 13, 14, 15, 19, 20, 23, 25, 39, 48, 52, 56:
      begin
        FieldList := '"NAME"';
        FieldValues := AnsiQuotedStr(DataSet.FieldByName('NAME').AsString, '''');
      end;

    3: // Customer
      begin
        FieldList :=
          'CUSTOMER_TYPE_ID, ' +
          'YEAR_END_MONTH_ID, ' +
          'TAX_OFFICE_ID, ' +
          'VAT_MONTH_ID, ' +
          'VAT_COUNTRY_ID, ' +
          'VAT_OFFICE_ID, ' +
          'AR_MONTH_ID, ' +
          'STATUS_ID, ' +
          'NAME, ' +
          'FIRST_NAME, ' +
          'LAST_NAME, ' +
          'INITIALS, ' +
          'TRADING_AS, ' +
          'BILL_TO, ' +
          'CO_NO, ' +
          'TAX_NO, ' +
          'VAT_NO, ' +
          'VAT_CUSTOMS_CODE, ' +
          'PAYE_NO, ' +
          'SDL_NO, ' +
          'WC_NO, ' +
          'PASTEL_ACC_CODE, ' +
          'VB_TAX_ACC_CODE, ' +
          'IS_PROV_TAX_PAYER, ' +
          'HAS_LIVING_WILL, ' +
          'IS_ORGAN_DONOR, ' +
          'IS_ACTIVE, ' +
          'EFILING, ' +
          'EF_USER_NAME, ' +
          'EF_PASSWORD, ' +
          'CUSTOMER_GROUP_ID, ' +
          'UIF_NO';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('YEAR_END_MONTH_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('TAX_OFFICE_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('VAT_MONTH_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('VAT_COUNTRY_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('VAT_OFFICE_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('AR_MONTH_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('STATUS_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('INITIALS').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('TRADING_AS').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BILL_TO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('CO_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('TAX_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('VAT_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('VAT_CUSTOMS_CODE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PAYE_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('SDL_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('WC_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PASTEL_ACC_CODE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('VB_TAX_ACC_CODE').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('IS_PROV_TAX_PAYER').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('HAS_LIVING_WILL').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('IS_ORGAN_DONOR').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('IS_ACTIVE').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('EFILING').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('EF_USER_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('EF_PASSWORD').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('CUSTOMER_GROUP_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('UIF_NO').AsString, '''');

        if FormatDateTime('yyyy-MM-dd', DataSet.FieldByName('AR_COMPLETION_DATE').AsDateTime) <> '1899-12-30' then
        begin
          FieldList := FieldList + ', AR_COMPLETION_DATE';

          FieldValues := FieldValues + ', ' +
            AnsiQuotedStr(FormatDateTime('yyyy-MM-dd', DataSet.FieldByName('AR_COMPLETION_DATE').AsDateTime), '''');
        end;
      end;

    4: // Address
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'PHYSICAL1, ' +
          'PHYSICAL2, ' +
          'PHYSICAL3, ' +
          'PHYSICAL4, ' +
          'PHYSICAL_CODE, ' +
          'POSTAL1, ' +
          'POSTAL2, ' +
          'POSTAL3, ' +
          'POSTAL4, ' +
          'POSTAL_CODE, ' +
          'BILLING1, ' +
          'BILLING2, ' +
          'BILLING3, ' +
          'BILLING4, ' +
          'BILLING_CODE';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL1').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL2').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL3').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL4').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL_CODE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL1').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL2').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL3').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL4').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL_CODE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BILLING1').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BILLING2').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BILLING3').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BILLING4').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BILLING_CODE').AsString, '''');
      end;

    7: // Banking details
      begin
        FieldList :=
          'BANK_ID, ' +
          'CUSTOMER_ID, ' +
          'BRANCH_CODE, ' +
          'ACCOUNT_TYPE_ID, ' +
          'ACCOUNT_NO, ' +
          'FIRST_NAME, ' +
          'LAST_NAME';

        FieldValues :=
          IntToStr(DataSet.FieldByName('BANK_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BRANCH_CODE').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('ACCOUNT_TYPE_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ACCOUNT_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''');
      end;

    8: // Beneficiary
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'FIRST_NAME, ' +
          'LAST_NAME, ' +
          'MOBILE_PHONE, ' +
          'EMAIL_ADDRESS, ' +
          'SALUTATION_ID';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('MOBILE_PHONE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('EMAIL_ADDRESS').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('SALUTATION_ID').AsInteger);
      end;

    9: // Company contact details
      begin
        FieldList :=
          'CONTACT_TYPE_ID, ' +
          'CUSTOMER_ID, ' +
          'CONTACT_PERSON_ID, ' +
          '"VALUE", ' +
          'COMMENT';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CONTACT_TYPE_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('CONTACT_PERSON_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('VALUE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('COMMENT').AsString, '''');
      end;

    10: // Contact person
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'SALUTATION_ID, ' +
          'FIRST_NAME, ' +
          'LAST_NAME, ' +
          'INITIALS, ' +
          'OTHER_NAME, ' +
          'DOB, ' +
          'ID_NUMBER, ' +
          'PASSPORT_NUMBER, ' +
          'IS_PRIMARY_CONTACT, ' +
          'JOB_FUNCTION_ID';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('SALUTATION_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('INITIALS').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('OTHER_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('DOB').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ID_NUMBER').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PASSPORT_NUMBER').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('IS_PRIMARY_CONTACT').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('JOB_FUNCTION_ID').AsInteger);
      end;

    12: // Country
      begin
        FieldList :=
          'NAME, ' +
          'DIALING_CODE';

        FieldValues :=
          AnsiQuotedStr(DataSet.FieldByName('NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('DIALING_CODE').AsString, '''');
      end;

    16: // Director
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'SALUTATION_ID, ' +
          'FIRST_NAME, ' +
          'LAST_NAME, ' +
          'MIDDLE_NAME, ' +
          'TAX_NO, ' +
          'MOBILE_PHONE, ' +
          'EMAIL_ADDRESS';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('SALUTATION_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('MIDDLE_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('TAX_NO').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('MOBILE_PHONE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('EMAIL_ADDRESS').AsString, '''');
      end;

    22: // Price list
      begin
        FieldList :=
          'RATE_UNIT_ID, ' +
          'NAME, ' +
          'RATE, ' +
          'INVOICE_DESCRIPTION, ' +
          'DESCRIPTION';

        FieldValues :=
          IntToStr(DataSet.FieldByName('RATE_UNIT_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('NAME').AsString, '''') + ', ' +
          FloatToStr(DataSet.FieldByName('RATE').AsFloat) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('INVOICE_DESCRIPTION').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('DESCRIPTION').AsString, '''');
      end;

    37: // Contact detail for pserons
      begin
        FieldList :=
          'CONTACT_TYPE_ID, ' +
          'CUSTOMER_ID, ' +
          'CONTACT_PERSON_ID, ' +
          '"VALUE", ' +
          'COMMENT';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CONTACT_TYPE_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('CONTACT_PERSON_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('VALUE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('COMMENT').AsString, '''');
      end;

    38: // Rate uint
      begin
        FieldList := '"NAME", ABBREVIATION';
        FieldValues :=
          AnsiQuotedStr(DataSet.FieldByName('NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ABBREVIATION').AsString, '''');
      end;

    49: // Vehicle
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'THE_YEAR, ' +
          'VEHICLE_MAKE_ID, ' +
          'VEHICLE_MODEL, ' +
          'REG_NO, ' +
          'RENEWAL_DATE, ' +
          'MAINTENANCE_PLAN, ' +
          'COMMENT';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('THE_YEAR').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('VEHICLE_MAKE_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('VEHICLE_MODEL').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('REG_NO').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('MAINTENANCE_PLAN').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('COMMENT').AsString, '''');

        if FormatDateTime('yyyy-MM-dd', DataSet.FieldByName('RENEWAL_DATE').AsDateTime) <> '1899-12-30' then
        begin
          FieldList := FieldList + ', RENEWAL_DATE';
          FieldValues := FieldValues + ', ' +
            AnsiQuotedStr(FormatDateTime('yyyy-MM-dd', DataSet.FieldByName('RENEWAL_DATE').AsDateTime), '''');
        end;
      end;

    50: // Trustee
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'FIRST_NAME, ' +
          'LAST_NAME, ' +
          'SALUTATION_ID, ' +
          'MOBILE_PHONE, ' +
          'EMAIL_ADDRESS';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('SALUTATION_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('MOBILE_PHONE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('EMAIL_ADDRESS').AsString, '''');
      end;

    74: // Director of company
      begin
        FieldList :=
          'DIRECTOR_ID, ' +
          'CUSTOMER_ID';

        FieldValues :=
          IntToStr(DataSet.FieldByName('DIRECTOR_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger);
      end;

    76: // Shareholder
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'SALUTATION_ID, ' +
          'FIRST_NAME, ' +
          'LAST_NAME, ' +
          'MOBILE_PHONE, ' +
          'EMAIL_ADDRESS, ' +
          'PERCENT_SHARE';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('SALUTATION_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('MOBILE_PHONE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('EMAIL_ADDRESS').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PERCENT_SHARE').AsString, '''');
      end;

    77: // Heir
      begin
        FieldList :=
          'CUSTOMER_ID, ' +
          'SALUTATION_ID, ' +
          'FIRST_NAME, ' +
          'LAST_NAME, ' +
          'ID_NUMBER, ' +
          'PHYSICAL1, ' +
          'PHYSICAL2, ' +
          'PHYSICAL3, ' +
          'PHYSICAL4, ' +
          'PHYSICAL_CODE, ' +
          'POSTAL1, ' +
          'POSTAL2, ' +
          'POSTAL3, ' +
          'POSTAL4, ' +
          'POSTAL_CODE, ' +
          'ACC_HOLDER_SALUTATION_ID, ' +
          'ACC_HOLDER_FIRST_NAME, ' +
          'ACC_HOLDER_LAST_NAME, ' +
          'BANK_ID, ' +
          'BRANCH_CODE, ' +
          'ACCOUNT_TYPE_ID, ' +
          'ACCOUNT_NO';

        FieldValues :=
          IntToStr(DataSet.FieldByName('CUSTOMER_ID').AsInteger) + ', ' +
          IntToStr(DataSet.FieldByName('SALUTATION_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('LAST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ID_NUMBER').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL1').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL2').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL3').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL4').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('PHYSICAL_CODE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL1').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL2').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL3').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL4').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('POSTAL_CODE').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ACC_HOLDER_SALUTATION_ID').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ACC_HOLDER_FIRST_NAME').AsString, '''') + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ACC_HOLDER_LAST_NAME').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('BANK_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('BRANCH_CODE').AsString, '''') + ', ' +
          IntToStr(DataSet.FieldByName('ACCOUNT_TYPE_ID').AsInteger) + ', ' +
          AnsiQuotedStr(DataSet.FieldByName('ACCOUNT_NO').AsString, '''');
      end;
  end;
end;

procedure TVBBaseDM.BuildUpdateStatement(TagValue: Integer; var FieldListValues,
  WhereClause: string; DataSet: TFDMemTable);
begin
//
end;

end.

